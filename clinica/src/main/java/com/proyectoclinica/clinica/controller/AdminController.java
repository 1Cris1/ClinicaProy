package com.proyectoclinica.clinica.controller;

import com.proyectoclinica.clinica.modules.seguridad.models.Usuario;
import com.proyectoclinica.clinica.modules.seguridad.models.Rol;
import com.proyectoclinica.clinica.modules.recursos.models.Especialidad;
import com.proyectoclinica.clinica.modules.recursos.models.Medico;
import com.proyectoclinica.clinica.modules.recursos.models.Sede;
import com.proyectoclinica.clinica.modules.recursos.models.Servicio;
import com.proyectoclinica.clinica.modules.recursos.models.Promocion;
import com.proyectoclinica.clinica.modules.citas.repository.CitaRepository;
import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import com.proyectoclinica.clinica.modules.paciente.repository.PacienteRepository;
import com.proyectoclinica.clinica.modules.farmacia.models.Producto;
import com.proyectoclinica.clinica.modules.farmacia.repository.ProductoRepository;
import com.proyectoclinica.clinica.modules.seguridad.repository.UsuarioRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.MedicoRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.EspecialidadRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.SedeRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.ServicioRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.PromocionRepository;
import com.proyectoclinica.clinica.config.PowerBiProperties;
import com.proyectoclinica.clinica.modules.seguridad.models.AuditoriaUsuario;
import com.proyectoclinica.clinica.modules.seguridad.repository.AuditoriaUsuarioRepository;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

    private static final Logger log = LoggerFactory.getLogger(AdminController.class);
    private static final String LAYOUT = "layout-admin";

    private final UsuarioRepository usuarioRepository;
    private final MedicoRepository medicoRepository;
    private final PacienteRepository pacienteRepository;
    private final CitaRepository citaRepository;
    private final EspecialidadRepository especialidadRepository;
    private final SedeRepository sedeRepository;
    private final ServicioRepository servicioRepository;
    private final ProductoRepository productoRepository;
    private final PromocionRepository promocionRepository;
    private final PasswordEncoder passwordEncoder;
    private final PowerBiProperties powerBiProperties;
    private final AuditoriaUsuarioRepository auditoriaUsuarioRepository;

    //  - INICIO CÓDIGO BACKEND DASHBOARD (Métricas en tiempo real e inyección de URL de Power BI)
    @GetMapping({"", "/", "/dashboard", "/inicio"})
    public String dashboard(Model model) {
        log.info("[Admin] Acceso al Dashboard");
        
        long totalPacientes = pacienteRepository.count();
        long totalMedicos = medicoRepository.count();
        long citasHoy = citaRepository.countByFechaCita(LocalDate.now());
        long citasPendientes = citaRepository.countByEstado("Pendiente");

        model.addAttribute("totalPacientes", totalPacientes);
        model.addAttribute("totalMedicos", totalMedicos);
        model.addAttribute("citasHoy", citasHoy);
        model.addAttribute("citasPendientes", citasPendientes);

        // EXPOSICIÓN CRISTIAN: Inyección de URL para reportes desde application.properties (Power BI)
        String powerBiUrl = powerBiProperties.getBase().getUrl() + "&pageName=" + powerBiProperties.getPage().getAdmin();
        model.addAttribute("powerBiUrl", powerBiUrl);
        model.addAttribute("powerBiPageName", "Dashboard Administrador");
        model.addAttribute("pageTitle", "Panel");
        model.addAttribute("view", "admin/dashboard");
        return LAYOUT;
    }
    // EXPOSICIÓN CRISTIAN (US-15)
    @GetMapping("/susalud")
    public String susalud(Model model) {
        log.info("[Admin] Acceso a validaciones SUSALUD");
        model.addAttribute("pageTitle", "Validaciones SUSALUD");
        model.addAttribute("view", "admin/susalud");
        return LAYOUT;
    }

    // ========== GESTIÓN DE PACIENTES ==========
    @GetMapping("/pacientes")
    public String listarPacientes(Model model) {
        log.info("[Admin] Acceso a Gestión de Pacientes");
        List<Usuario> usuariosPacientes = usuarioRepository.findAll().stream()
            .filter(u -> u.getIdRol() == 3)
            .collect(Collectors.toList());
        
        model.addAttribute("usuarios", usuariosPacientes);
        model.addAttribute("totalPacientes", usuariosPacientes.size());
        model.addAttribute("pageTitle", "Pacientes");
        model.addAttribute("view", "admin/pacientes-lista");
        return LAYOUT;
    }

    @PostMapping("/pacientes/nuevo")
    public String registrarPaciente(@RequestParam String nombres,
                                   @RequestParam String apellidos,
                                   @RequestParam String dni,
                                   @RequestParam String password,
                                   @RequestParam(required = false) String email,
                                   @RequestParam(required = false) String telefono) {
        log.info("Creando nuevo paciente: {}", dni);
        Usuario nuevoUsuario = Usuario.builder()
                .username(dni)
                .password(passwordEncoder.encode(password))
                .email(email != null && !email.isBlank() ? email : dni + "@paciente.com")
                .idRol(3)
                .rol(Rol.ROLE_PACIENTE)
                .build();
        try {
            usuarioRepository.save(nuevoUsuario);
            
            Paciente nuevoPaciente = Paciente.builder()
                    .usuario(nuevoUsuario)
                    .nombres(nombres)
                    .apellidos(apellidos)
                    .dni(dni)
                    .email(email)
                    .telefono(telefono)
                    .estado("Activo")
                    .build();
            pacienteRepository.save(nuevoPaciente);
            return "redirect:/admin/pacientes?exito";
        } catch (DataIntegrityViolationException e) {
            log.error("Error al registrar paciente: {}", e.getMessage());
            return "redirect:/admin/pacientes?error=duplicado";
        }
    }

    @PostMapping("/pacientes/editar")
    public String editarPaciente(@RequestParam Integer id_usuario,
                                @RequestParam String username,
                                @RequestParam(required = false) String nueva_password,
                                @RequestParam(required = false) String email) {
        log.info("Editando paciente ID: {}", id_usuario);
        try {
            Usuario usuario = usuarioRepository.findById(id_usuario).orElse(null);
            if (usuario != null) {
                usuario.setUsername(username);
                if (email != null && !email.isBlank()) {
                    usuario.setEmail(email);
                }
                if (nueva_password != null && !nueva_password.isBlank()) {
                    usuario.setPassword(passwordEncoder.encode(nueva_password));
                }
                usuarioRepository.save(usuario);
                return "redirect:/admin/pacientes?editado";
            }
        } catch (Exception e) {
            log.error("Error editando paciente", e);
        }
        return "redirect:/admin/pacientes?error";
    }

    @GetMapping("/pacientes/eliminar")
    public String eliminarPaciente(@RequestParam Integer id) {
        try {
            usuarioRepository.deleteById(id);
            return "redirect:/admin/pacientes?eliminado";
        } catch (Exception e) {
            log.error("Error eliminando paciente", e);
            return "redirect:/admin/pacientes?error";
        }
    }

    // ========== RECEPCIONISTAS ==========
    @GetMapping("/recepcionistas")
    public String listarRecepcionistas(Model model) {
        log.info("[Admin] Acceso a Gestión de Recepcionistas");
        List<Usuario> usuariosRecep = usuarioRepository.findAll().stream()
            .filter(u -> u.getIdRol() == 4)
            .collect(Collectors.toList());
        
        model.addAttribute("usuarios", usuariosRecep);
        model.addAttribute("totalRecepcionistas", usuariosRecep.size());
        model.addAttribute("pageTitle", "Recepcionistas");
        model.addAttribute("view", "admin/recepcionistas");
        return LAYOUT;
    }

    @PostMapping("/recepcionistas/nuevo")
    public String crearRecepcionista(@RequestParam String dni,
                                     @RequestParam String email,
                                     @RequestParam String password) {
        try {
            if (usuarioRepository.findByUsername(dni).isPresent()) {
                return "redirect:/admin/recepcionistas?nuevoError";
            }
            Usuario nuevoUsuario = Usuario.builder()
                .username(dni)
                .password(passwordEncoder.encode(password))
                .email(email)
                .idRol(4)
                .build();
            usuarioRepository.save(nuevoUsuario);
            return "redirect:/admin/recepcionistas?exito";
        } catch (Exception e) {
            log.error("Error creando recepcionista", e);
            return "redirect:/admin/recepcionistas?error";
        }
    }

    @PostMapping("/recepcionistas/editar")
    public String editarRecepcionista(@RequestParam Integer id_usuario,
                                @RequestParam String username,
                                @RequestParam(required = false) String nueva_password,
                                @RequestParam(required = false) String email) {
        log.info("Editando recepcionista ID: {}", id_usuario);
        try {
            Usuario usuario = usuarioRepository.findById(id_usuario).orElse(null);
            if (usuario != null) {
                usuario.setUsername(username);
                if (email != null && !email.isBlank()) {
                    usuario.setEmail(email);
                }
                if (nueva_password != null && !nueva_password.isBlank()) {
                    usuario.setPassword(passwordEncoder.encode(nueva_password));
                }
                usuarioRepository.save(usuario);
                return "redirect:/admin/recepcionistas?editado";
            }
        } catch (Exception e) {
            log.error("Error editando recepcionista", e);
        }
        return "redirect:/admin/recepcionistas?error";
    }

    @GetMapping("/recepcionistas/eliminar")
    public String eliminarRecepcionista(@RequestParam Integer id) {
        try {
            usuarioRepository.deleteById(id);
            return "redirect:/admin/recepcionistas?eliminado";
        } catch (Exception e) {
            log.error("Error eliminando recepcionista", e);
            return "redirect:/admin/recepcionistas?error";
        }
    }

    // ========== MEDICOS ==========
    @GetMapping("/medicos")
    public String listarMedicos(Model model) {
        log.info("[Admin] Acceso a Gestión de Médicos");
        List<Usuario> usuariosMedicos = usuarioRepository.findAll().stream()
            .filter(u -> u.getIdRol() == 2)
            .collect(Collectors.toList());
        
        model.addAttribute("usuarios", usuariosMedicos);
        model.addAttribute("totalMedicos", usuariosMedicos.size());
        model.addAttribute("medicos", medicoRepository.findAll());
        model.addAttribute("especialidades", especialidadRepository.findAll());
        model.addAttribute("sedes", sedeRepository.findAll());
        model.addAttribute("pageTitle", "Médicos");
        model.addAttribute("view", "admin/medicos");
        return LAYOUT;
    }

    @PostMapping("/medicos/editar")
    @Transactional
    public String editarMedico(@RequestParam Integer id_usuario,
                                @RequestParam String username,
                                @RequestParam(required = false) String nueva_password,
                                @RequestParam(required = false) String email,
                                @RequestParam(required = false) String nombres,
                                @RequestParam(required = false) String apellidos,
                                @RequestParam(required = false) String cmp,
                                @RequestParam(required = false) Integer especialidadId,
                                @RequestParam(required = false) Integer sedeId,
                                @RequestParam(required = false) String telefono,
                                @RequestParam(required = false) String consultorio,
                                @RequestParam(required = false) String estado,
                                @RequestParam(required = false) String horarioLv,
                                @RequestParam(required = false) String horarioSabado,
                                @RequestParam(required = false) Integer duracionCita) {
        
        try {
            Usuario usuario = usuarioRepository.findById(id_usuario).orElse(null);
            if (usuario != null) {
                usuario.setUsername(username);
                if (email != null && !email.isBlank()) {
                    usuario.setEmail(email);
                }
                if (nueva_password != null && !nueva_password.isBlank()) {
                    usuario.setPassword(passwordEncoder.encode(nueva_password));
                }
                usuarioRepository.save(usuario);

                Medico medico = medicoRepository.findByUsuarioId(usuario.getId()).orElse(null);
                if (medico != null) {
                    if (nombres != null) medico.setNombres(nombres);
                    if (apellidos != null) medico.setApellidos(apellidos);
                    if (cmp != null) medico.setCmp(cmp);
                    if (especialidadId != null) {
                        medico.setEspecialidad(especialidadRepository.findById(especialidadId).orElse(null));
                    }
                    if (sedeId != null) {
                        medico.setSede(sedeRepository.findById(sedeId).orElse(null));
                    }
                    if (telefono != null) medico.setTelefono(telefono);
                    if (consultorio != null) medico.setConsultorio(consultorio);
                    if (estado != null) medico.setEstado(estado);
                    if (horarioLv != null) medico.setHorarioLv(horarioLv);
                    if (horarioSabado != null) medico.setHorarioSabado(horarioSabado);
                    if (duracionCita != null) medico.setDuracionCita(duracionCita);
                    medicoRepository.save(medico);
                }
                return "redirect:/admin/medicos?editado";
            }
        } catch (Exception e) {
            log.error("Error editando medico", e);
        }
        return "redirect:/admin/medicos?error";
    }

    /**  *HISTORIA DE USUARIO: Registro de Nuevo Personal Médico*/
    
     
    @PostMapping("/medicos/nuevo")
    public String registrarMedico(@RequestParam String nombres,
                                  @RequestParam String apellidos,
                                  @RequestParam String dni,
                                  @RequestParam String password,
                                  @RequestParam(required = false) String cmp,
                                  @RequestParam(required = false) Integer especialidadId,
                                  @RequestParam(required = false) Integer sedeId,
                                  @RequestParam(required = false) String telefono,
                                  @RequestParam(required = false) String email,
                                  @RequestParam(required = false) String consultorio,
                                  @RequestParam(required = false) String horarioLv,
                                  @RequestParam(required = false) String horarioSabado,
                                  @RequestParam(required = false, defaultValue = "30") Integer duracionCita) {
        try {
            Usuario nuevoUsuario = Usuario.builder()
                    .username(dni)
                    // EXPOSICIÓN CRISTIAN: Aquí explicamos cómo usamos BCryptPasswordEncoder para encriptar la clave y garantizar la seguridad
                    .password(passwordEncoder.encode(password))
                    .email(email != null && !email.isBlank() ? email : dni + "@medico.com")
                    .idRol(2)
                    .rol(Rol.ROLE_MEDICO)
                    .build();
            nuevoUsuario = usuarioRepository.save(nuevoUsuario);

            Medico med = Medico.builder()
                    .usuario(nuevoUsuario)
                    .nombres(nombres)
                    .apellidos(apellidos)
                    .dni(dni)
                    .cmp(cmp)
                    .especialidad(especialidadId != null ? especialidadRepository.findById(especialidadId).orElse(null) : null)
                    .sede(sedeId != null ? sedeRepository.findById(sedeId).orElse(null) : null)
                    .telefono(telefono)
                    .email(email)
                    .consultorio(consultorio)
                    .horarioLv(horarioLv)
                    .horarioSabado(horarioSabado)
                    .duracionCita(duracionCita != null ? duracionCita : 30)
                    .estado("Activo")
                    .build();
            medicoRepository.save(med);
            return "redirect:/admin/medicos?exito";
        } catch (Exception e) {
            log.error("Error al registrar médico", e);
            return "redirect:/admin/medicos?nuevoError";
        }
    }

    @GetMapping("/medicos/eliminar")
    public String eliminarMedico(@RequestParam Integer id) {
        try {
            usuarioRepository.deleteById(id);
            return "redirect:/admin/medicos?eliminado";
        } catch (Exception e) {
            log.error("Error eliminando medico", e);
            return "redirect:/admin/medicos?error";
        }
    }

    // ========== CITAS ==========
    @GetMapping("/citas")
    public String listarCitas(Model model) {
        log.info("[Admin] Acceso a Gestión de Citas");
        model.addAttribute("citas", citaRepository.findAll());
        model.addAttribute("citasHoy", citaRepository.findByFechaCitaOrderByHoraCitaAsc(LocalDate.now()));
        model.addAttribute("totalCitas", citaRepository.count());
        model.addAttribute("pageTitle", "Citas");
        model.addAttribute("view", "admin/citas");
        return LAYOUT;
    }

    // ========== ESPECIALIDADES ==========
    @GetMapping("/especialidades")
    public String listarEspecialidades(Model model) {
        log.info("[Admin] Acceso a Especialidades");
        model.addAttribute("especialidades", especialidadRepository.findAll());
        model.addAttribute("totalEspecialidades", especialidadRepository.count());
        model.addAttribute("pageTitle", "Especialidades");
        model.addAttribute("view", "admin/especialidades");
        return LAYOUT;
    }

    @PostMapping("/especialidades/nuevo")
    public String registrarEspecialidad(@RequestParam String nombre,
                                        @RequestParam(required = false) String descripcion,
                                        @RequestParam(required = false) String icono,
                                        @RequestParam(required = false) String color,
                                        @RequestParam(defaultValue = "true") Boolean estado,
                                        @RequestParam(required = false) String imagenUrl) {
        // CRISTIAN: Aquí mostramos cómo instanciamos el objeto limpiamente usando el patrón @Builder de Lombok
        Especialidad nuevaEspecialidad = Especialidad.builder()
                .nombre(nombre)
                .descripcion(descripcion)
                .icono(icono != null && !icono.isBlank() ? icono : "bi bi-stethoscope")
                .color(color)
                .estado(estado)
                .imagenUrl(imagenUrl)
                .build();
        especialidadRepository.save(nuevaEspecialidad);
        return "redirect:/admin/especialidades?exito";
    }

    @PostMapping("/especialidades/editar")
    public String editarEspecialidad(@RequestParam Integer id,
                                     @RequestParam String nombre,
                                     @RequestParam(required = false) String descripcion,
                                     @RequestParam(required = false) String icono,
                                     @RequestParam(required = false) String color,
                                     @RequestParam Boolean estado,
                                     @RequestParam(required = false) String imagenUrl) {
        Especialidad especialidad = especialidadRepository.findById(id).orElseThrow();
        especialidad.setNombre(nombre);
        especialidad.setDescripcion(descripcion);
        especialidad.setIcono(icono != null && !icono.isBlank() ? icono : "bi bi-stethoscope");
        especialidad.setColor(color);
        especialidad.setEstado(estado);
        if (imagenUrl != null && !imagenUrl.isBlank()) {
            especialidad.setImagenUrl(imagenUrl);
        }
        especialidadRepository.save(especialidad);
        return "redirect:/admin/especialidades?editado";
    }

    // ========== SERVICIOS ==========
    
    @GetMapping("/servicios")
    public String listarServicios(Model model) {
        log.info("[Admin] Acceso a Servicios");
        model.addAttribute("servicios", servicioRepository.findAll());
        model.addAttribute("especialidades", especialidadRepository.findAll());
        model.addAttribute("totalServicios", servicioRepository.count());
        model.addAttribute("pageTitle", "Servicios");
        model.addAttribute("view", "admin/servicios");
        return LAYOUT;
    }

    //  Operación de Creación (Create) de Servicios. Demuestra el uso del patrón @Builder de Lombok para registrar precios.
    @PostMapping("/servicios/nuevo")
    public String registrarServicio(@RequestParam String nombre,
                                   @RequestParam(required = false) String descripcion,
                                   @RequestParam BigDecimal precio,
                                   @RequestParam Integer especialidadId,
                                   @RequestParam(defaultValue = "Activo") String estado) {
        Especialidad especialidad = especialidadRepository.findById(especialidadId).orElse(null);
        Servicio nuevoServicio = Servicio.builder()
                .nombre(nombre)
                .descripcion(descripcion)
                .precio(precio)
                .especialidad(especialidad)
                .estado(estado)
                .build();
        servicioRepository.save(nuevoServicio);
        return "redirect:/admin/servicios?exito";
    }

    @PostMapping("/servicios/editar")
    public String editarServicio(@RequestParam Integer id,
                                 @RequestParam String nombre,
                                 @RequestParam(required = false) String descripcion,
                                 @RequestParam BigDecimal precio,
                                 @RequestParam Integer especialidadId,
                                 @RequestParam String estado) {
        Servicio servicio = servicioRepository.findById(id).orElseThrow();
        servicio.setNombre(nombre);
        servicio.setDescripcion(descripcion);
        servicio.setPrecio(precio);
        servicio.setEspecialidad(especialidadRepository.findById(especialidadId).orElse(null));
        servicio.setEstado(estado);
        servicioRepository.save(servicio);
        return "redirect:/admin/servicios?editado";
    }

    @GetMapping("/servicios/eliminar")
    public String eliminarServicio(@RequestParam Integer id) {
        try {
            servicioRepository.deleteById(id);
            return "redirect:/admin/servicios?eliminado";
        } catch (org.springframework.dao.DataIntegrityViolationException e) {
            return "redirect:/admin/servicios?error=en_uso";
        }
    }

    // ========== SEDES ==========
    @GetMapping("/sedes")
    public String listarSedes(Model model) {
        log.info("[Admin] Acceso a Sedes");
        model.addAttribute("sedes", sedeRepository.findAll());
        model.addAttribute("totalSedes", sedeRepository.count());
        model.addAttribute("pageTitle", "Sedes");
        model.addAttribute("view", "admin/sedes");
        return LAYOUT;
    }

    @PostMapping("/sedes/nuevo")
    public String registrarSede(@RequestParam String nombre,
                               @RequestParam String direccion,
                               @RequestParam(required = false) String distrito,
                               @RequestParam(required = false) String ciudad,
                               @RequestParam(required = false) String telefono,
                               @RequestParam(required = false) String email,
                               @RequestParam(required = false) String horarioLv,
                               @RequestParam(required = false) String horarioSabado,
                               @RequestParam(required = false) String horarioDomingo,
                               @RequestParam(required = false) Integer numConsultorios,
                               @RequestParam(defaultValue = "Activo") String estado) {
        Sede nuevaSede = Sede.builder()
                .nombre(nombre)
                .direccion(direccion)
                .distrito(distrito)
                .ciudad(ciudad)
                .telefono(telefono)
                .email(email)
                .horarioLv(horarioLv)
                .horarioSabado(horarioSabado)
                .horarioDomingo(horarioDomingo)
                .numConsultorios(numConsultorios)
                .estado(estado)
                .build();
        sedeRepository.save(nuevaSede);
        return "redirect:/admin/sedes?exito";
    }

    @PostMapping("/sedes/editar")
    public String editarSede(@RequestParam Integer id,
                             @RequestParam String nombre,
                             @RequestParam String direccion,
                             @RequestParam(required = false) String distrito,
                             @RequestParam(required = false) String ciudad,
                             @RequestParam(required = false) String telefono,
                             @RequestParam(required = false) String email,
                             @RequestParam(required = false) String horarioLv,
                             @RequestParam(required = false) String horarioSabado,
                             @RequestParam(required = false) String horarioDomingo,
                             @RequestParam(required = false) Integer numConsultorios,
                             @RequestParam String estado) {
        Sede sede = sedeRepository.findById(id).orElseThrow();
        sede.setNombre(nombre);
        sede.setDireccion(direccion);
        sede.setDistrito(distrito);
        sede.setCiudad(ciudad);
        sede.setTelefono(telefono);
        sede.setEmail(email);
        sede.setHorarioLv(horarioLv);
        sede.setHorarioSabado(horarioSabado);
        sede.setHorarioDomingo(horarioDomingo);
        sede.setNumConsultorios(numConsultorios);
        sede.setEstado(estado);
        sedeRepository.save(sede);
        return "redirect:/admin/sedes?editado";
    }

    @GetMapping("/sedes/eliminar")
    public String eliminarSede(@RequestParam Integer id) {
        sedeRepository.deleteById(id);
        return "redirect:/admin/sedes?eliminado";
    }

    // ========== PROMOCIONES ==========
    @GetMapping("/promociones")
    public String listarPromociones(Model model) {
        log.info("[Admin] Acceso a Promociones");
        model.addAttribute("promociones", promocionRepository.findAll());
        model.addAttribute("totalPromociones", promocionRepository.count());
        model.addAttribute("pageTitle", "Promociones");
        model.addAttribute("view", "admin/promociones");
        return LAYOUT;
    }

    @PostMapping("/promociones/nuevo")
    public String registrarPromocion(@RequestParam String titulo,
                                     @RequestParam(required = false) String descripcion,
                                     @RequestParam(required = false) BigDecimal descuentoPorcentaje,
                                     @RequestParam(required = false) LocalDate fechaInicio,
                                     @RequestParam(required = false) LocalDate fechaFin,
                                     @RequestParam(defaultValue = "Activo") String estado,
                                     @RequestParam(required = false) String imagenUrl) {
        Promocion nuevaPromocion = Promocion.builder()
                .titulo(titulo)
                .descripcion(descripcion)
                .descuentoPorcentaje(descuentoPorcentaje)
                .fechaInicio(fechaInicio)
                .fechaFin(fechaFin)
                .estado(estado)
                .imagenUrl(imagenUrl)
                .build();
        promocionRepository.save(nuevaPromocion);
        return "redirect:/admin/promociones?exito";
    }

    @GetMapping("/productos")
    public String listarProductos(Model model) {
        log.info("[Admin] Acceso a Gestión de Productos");
        model.addAttribute("productos", productoRepository.findAll());
        model.addAttribute("totalProductos", productoRepository.count());
        model.addAttribute("pageTitle", "Catálogo de Farmacia");
        model.addAttribute("view", "admin/productos");
        return LAYOUT;
    }

    @PostMapping("/productos/nuevo")
    public String registrarProducto(@RequestParam String nombre,
                                   @RequestParam(required = false) String descripcion,
                                   @RequestParam BigDecimal precio,
                                   @RequestParam(required = false) BigDecimal precioDescuento,
                                   @RequestParam String categoria,
                                   @RequestParam Integer stock,
                                   @RequestParam(defaultValue = "Activo") String estado,
                                   @RequestParam(required = false) String imagenUrl) {
        Producto producto = Producto.builder()
                .nombre(nombre)
                .descripcion(descripcion)
                .precio(precio)
                .precioDescuento(precioDescuento)
                .categoria(categoria)
                .stock(stock)
                .estado(estado)
                .imagenUrl(imagenUrl)
                .build();
        productoRepository.save(producto);
        return "redirect:/admin/productos?exito";
    }

    @PostMapping("/productos/editar")
    public String editarProducto(@RequestParam Integer id,
                                 @RequestParam String nombre,
                                 @RequestParam(required = false) String descripcion,
                                 @RequestParam BigDecimal precio,
                                 @RequestParam(required = false) BigDecimal precioDescuento,
                                 @RequestParam String categoria,
                                 @RequestParam Integer stock,
                                 @RequestParam String estado,
                                 @RequestParam(required = false) String imagenUrl) {
        Producto producto = productoRepository.findById(id).orElseThrow();
        producto.setNombre(nombre);
        producto.setDescripcion(descripcion);
        producto.setPrecio(precio);
        producto.setPrecioDescuento(precioDescuento);
        producto.setCategoria(categoria);
        producto.setStock(stock);
        producto.setEstado(estado);
        producto.setImagenUrl(imagenUrl);
        productoRepository.save(producto);
        return "redirect:/admin/productos?editado";
    }

    @GetMapping("/productos/eliminar")
    public String eliminarProducto(@RequestParam Integer id) {
        productoRepository.deleteById(id);
        return "redirect:/admin/productos?eliminado";
    }

    // ========== USUARIOS ==========
    @GetMapping("/usuarios")
    public String listarUsuarios(Model model) {
        log.info("[Admin] Acceso a Gestión de Usuarios");
        model.addAttribute("usuarios", usuarioRepository.findAll());
        model.addAttribute("pageTitle", "Centro de Control");
        model.addAttribute("view", "admin/usuarios");
        return LAYOUT;
    }

    @PostMapping("/usuarios/cambiar-rol")
    public String cambiarRol(@RequestParam Integer id, @RequestParam Integer idRol) {
        Usuario usuario = usuarioRepository.findById(id).orElseThrow();
        usuario.setIdRol(idRol);
        if (idRol == 1) usuario.setRol(Rol.ROLE_ADMIN);
        else if (idRol == 2) usuario.setRol(Rol.ROLE_MEDICO);
        else if (idRol == 3) usuario.setRol(Rol.ROLE_PACIENTE);
        else if (idRol == 4) usuario.setRol(Rol.ROLE_RECEPCIONISTA);
        usuarioRepository.save(usuario);
        return "redirect:/admin/usuarios?rolCambiado";
    }

    // Seguridad Spring Security. Permite al administrador inhabilitar una cuenta. El UserDetailsImpl validará este campo 'estado' para permitir o denegar el login.
    @PostMapping("/usuarios/toggle-estado")
    public String toggleEstadoUsuario(@RequestParam Integer id, @RequestParam Integer estado) {
        Usuario usuario = usuarioRepository.findById(id).orElseThrow();
        usuario.setEstado(estado);
        usuarioRepository.save(usuario);
        return "redirect:/admin/usuarios?estadoCambiado";
    }

    // ========== REPORTES ==========
    @GetMapping("/reportes")
    public String reportes(Model model) {
        log.info("[Admin] Acceso a Reportes");
        LocalDate hoy = LocalDate.now();
        LocalDate inicioMes = hoy.withDayOfMonth(1);
        LocalDate finMes = hoy.withDayOfMonth(hoy.lengthOfMonth());
        
        model.addAttribute("totalPacientes", pacienteRepository.count());
        model.addAttribute("totalMedicos", medicoRepository.count());
        model.addAttribute("citasMes", citaRepository.countByFechaCitaBetween(inicioMes, finMes));
        model.addAttribute("citasCompletadas", citaRepository.countByEstado("Completada"));
        model.addAttribute("pageTitle", "Reportes");
        model.addAttribute("view", "admin/reportes");
        return LAYOUT;
    }

    // ========== DASHBOARD POWER BI - DESEMPEÑO CLÍNICO ==========
    @GetMapping("/reportes/desempeno-clinico")
    public String reporteDesempenoClinico(Model model) {
        log.info("[Admin] Acceso al Dashboard de Gestión de Atención y Desempeño Clínico");
        model.addAttribute("pageTitle", "Gestión de Atención y Desempeño Clínico");
        model.addAttribute("view", "admin/reportes-desempeno");
        return LAYOUT;
    }

    @GetMapping("/configuracion")
    public String configuracion(Model model) {
        log.info("[Admin] Acceso a Configuración");
        model.addAttribute("pageTitle", "Configuración");
        model.addAttribute("view", "admin/configuracion");
        return LAYOUT;
    }

    @GetMapping("/auditoria")
    public String verAuditoria(Model model,
                               @RequestParam(required = false) String usuario,
                               @RequestParam(required = false) String tipo) {
        log.info("[Admin] Acceso a Auditoría de Seguridad");
        List<AuditoriaUsuario> logs;
        if (usuario != null && !usuario.isBlank() && tipo != null && !tipo.isBlank()) {
            logs = auditoriaUsuarioRepository.findByUsernameContainingIgnoreCaseAndTipoEventoOrderByFechaEventoDesc(usuario, tipo);
        } else if (usuario != null && !usuario.isBlank()) {
            logs = auditoriaUsuarioRepository.findByUsernameContainingIgnoreCaseOrderByFechaEventoDesc(usuario);
        } else if (tipo != null && !tipo.isBlank()) {
            logs = auditoriaUsuarioRepository.findByTipoEventoOrderByFechaEventoDesc(tipo);
        } else {
            logs = auditoriaUsuarioRepository.findAllByOrderByFechaEventoDesc();
        }

        model.addAttribute("logs", logs);
        model.addAttribute("usuarioFiltro", usuario);
        model.addAttribute("tipoFiltro", tipo);
        model.addAttribute("pageTitle", "Auditoría de Seguridad");
        model.addAttribute("view", "admin/auditoria");
        return LAYOUT;
    }

    @GetMapping("/consultorios")
    public String verConsultorios(Model model, @RequestParam(required = false) Integer idSede) {
        log.info("[Admin] Acceso a Gestión de Consultorios");
        List<Sede> sedes = sedeRepository.findAll();
        List<Medico> medicos = medicoRepository.findAll();

        Integer sedeSeleccionadaId = idSede;
        if (sedeSeleccionadaId == null && !sedes.isEmpty()) {
            sedeSeleccionadaId = sedes.get(0).getId();
        }

        final Integer finalSedeId = sedeSeleccionadaId;
        List<Medico> medicosDeSede = medicos.stream()
                .filter(m -> m.getSede() != null && m.getSede().getId().equals(finalSedeId))
                .collect(Collectors.toList());

        Map<String, List<Medico>> consultorioMedicos = new HashMap<>();
        for (Medico m : medicosDeSede) {
            String cons = m.getConsultorio();
            if (cons == null || cons.isBlank()) {
                cons = "Sin Consultorio";
            }
            consultorioMedicos.computeIfAbsent(cons, k -> new ArrayList<>()).add(m);
        }

        List<String> colisiones = new ArrayList<>();
        for (Map.Entry<String, List<Medico>> entry : consultorioMedicos.entrySet()) {
            if (entry.getValue().size() > 1 && !entry.getKey().equals("Sin Consultorio")) {
                colisiones.add(entry.getKey());
            }
        }

        model.addAttribute("sedes", sedes);
        model.addAttribute("sedeSeleccionadaId", sedeSeleccionadaId);
        model.addAttribute("medicos", medicosDeSede);
        model.addAttribute("consultorioMap", consultorioMedicos);
        model.addAttribute("colisiones", colisiones);
        model.addAttribute("pageTitle", "Gestión de Consultorios");
        model.addAttribute("view", "admin/consultorios");
        return LAYOUT;
    }

    @PostMapping("/consultorios/reasignar")
    @Transactional
    public String reasignarConsultorio(@RequestParam Integer idMedico,
                                       @RequestParam String consultorio,
                                       @RequestParam Integer idSede) {
        log.info("[Admin] Reasignando médico {} al consultorio {} de la sede {}", idMedico, consultorio, idSede);
        Medico medico = medicoRepository.findById(idMedico).orElse(null);
        Sede sede = sedeRepository.findById(idSede).orElse(null);
        if (medico != null && sede != null) {
            medico.setConsultorio(consultorio);
            medico.setSede(sede);
            medicoRepository.save(medico);
        }
        return "redirect:/admin/consultorios?idSede=" + idSede;
    }
}
