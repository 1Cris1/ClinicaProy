package com.proyectoclinica.clinica.controller;

import com.proyectoclinica.clinica.modules.seguridad.models.Usuario;
import com.proyectoclinica.clinica.modules.seguridad.models.Rol;
import com.proyectoclinica.clinica.modules.recursos.models.Medico;
import com.proyectoclinica.clinica.modules.recursos.models.Sede;
import com.proyectoclinica.clinica.modules.citas.repository.CitaRepository;
import com.proyectoclinica.clinica.modules.paciente.repository.PacienteRepository;
import com.proyectoclinica.clinica.modules.paciente.service.PacienteService;
import com.proyectoclinica.clinica.modules.recursos.service.MedicoService;
import com.proyectoclinica.clinica.modules.seguridad.repository.UsuarioRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.MedicoRepository;
import com.proyectoclinica.clinica.modules.recursos.service.CatalogoService;
import com.proyectoclinica.clinica.modules.farmacia.service.ProductoService;
import com.proyectoclinica.clinica.modules.recursos.service.PromocionService;
import com.proyectoclinica.clinica.config.PowerBiProperties;
import com.proyectoclinica.clinica.modules.seguridad.models.AuditoriaUsuario;
import com.proyectoclinica.clinica.modules.seguridad.repository.AuditoriaUsuarioRepository;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
    private final CatalogoService catalogoService;
    private final ProductoService productoService;
    private final PromocionService promocionService;
    private final PasswordEncoder passwordEncoder;
    private final PowerBiProperties powerBiProperties;
    private final AuditoriaUsuarioRepository auditoriaUsuarioRepository;
    private final PacienteService pacienteService;
    private final MedicoService medicoService;

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

        //Inyección de URL para reportes desde application.properties (Power BI)
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
        List<Usuario> usuariosPacientes = pacienteService.listarUsuariosPacientes();
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
        if (pacienteService.registrarPaciente(nombres, apellidos, dni, password, email, telefono)) {
            return "redirect:/admin/pacientes?exito";
        }
        return "redirect:/admin/pacientes?error=duplicado";
    }

    @PostMapping("/pacientes/editar")
    public String editarPaciente(@RequestParam Integer id_usuario,
                                @RequestParam String username,
                                @RequestParam(required = false) String nueva_password,
                                @RequestParam(required = false) String email) {
        if (pacienteService.editarPaciente(id_usuario, username, nueva_password, email)) {
            return "redirect:/admin/pacientes?editado";
        }
        return "redirect:/admin/pacientes?error";
    }

    @GetMapping("/pacientes/eliminar")
    public String eliminarPaciente(@RequestParam Integer id) {
        if (pacienteService.eliminarPaciente(id)) {
            return "redirect:/admin/pacientes?eliminado";
        }
        return "redirect:/admin/pacientes?error";
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
        List<Usuario> usuariosMedicos = medicoService.listarUsuariosMedicos();
        model.addAttribute("usuarios", usuariosMedicos);
        model.addAttribute("totalMedicos", usuariosMedicos.size());
        model.addAttribute("medicos", medicoService.listarMedicos());
        model.addAttribute("especialidades", catalogoService.listarEspecialidades());
        model.addAttribute("sedes", catalogoService.listarSedes());
        model.addAttribute("pageTitle", "Médicos");
        model.addAttribute("view", "admin/medicos");
        return LAYOUT;
    }

    @PostMapping("/medicos/editar")
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
        if (medicoService.editarMedico(id_usuario, username, nueva_password, email, nombres, apellidos, cmp, especialidadId, sedeId, telefono, consultorio, estado, horarioLv, horarioSabado, duracionCita)) {
            return "redirect:/admin/medicos?editado";
        }
        return "redirect:/admin/medicos?error";
    }

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
        if (medicoService.registrarMedico(nombres, apellidos, dni, password, cmp, especialidadId, sedeId, telefono, email, consultorio, horarioLv, horarioSabado, duracionCita)) {
            return "redirect:/admin/medicos?exito";
        }
        return "redirect:/admin/medicos?nuevoError";
    }

    @GetMapping("/medicos/eliminar")
    public String eliminarMedico(@RequestParam Integer id) {
        if (medicoService.eliminarMedico(id)) {
            return "redirect:/admin/medicos?eliminado";
        }
        return "redirect:/admin/medicos?error";
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
        model.addAttribute("especialidades", catalogoService.listarEspecialidades());
        model.addAttribute("totalEspecialidades", catalogoService.contarEspecialidades());
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
        catalogoService.registrarEspecialidad(nombre, descripcion, icono, color, estado, imagenUrl);
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
        catalogoService.editarEspecialidad(id, nombre, descripcion, icono, color, estado, imagenUrl);
        return "redirect:/admin/especialidades?editado";
    }

    // ========== SERVICIOS ==========
    
    @GetMapping("/servicios")
    public String listarServicios(Model model) {
        log.info("[Admin] Acceso a Servicios");
        model.addAttribute("servicios", catalogoService.listarServicios());
        model.addAttribute("especialidades", catalogoService.listarEspecialidades());
        model.addAttribute("totalServicios", catalogoService.contarServicios());
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
        catalogoService.registrarServicio(nombre, descripcion, precio, especialidadId, estado);
        return "redirect:/admin/servicios?exito";
    }

    @PostMapping("/servicios/editar")
    public String editarServicio(@RequestParam Integer id,
                                 @RequestParam String nombre,
                                 @RequestParam(required = false) String descripcion,
                                 @RequestParam BigDecimal precio,
                                 @RequestParam Integer especialidadId,
                                 @RequestParam String estado) {
        catalogoService.editarServicio(id, nombre, descripcion, precio, especialidadId, estado);
        return "redirect:/admin/servicios?editado";
    }

    @GetMapping("/servicios/eliminar")
    public String eliminarServicio(@RequestParam Integer id) {
        if (catalogoService.eliminarServicio(id)) {
            return "redirect:/admin/servicios?eliminado";
        }
        return "redirect:/admin/servicios?error=en_uso";
    }

    // ========== SEDES ==========
    @GetMapping("/sedes")
    public String listarSedes(Model model) {
        log.info("[Admin] Acceso a Sedes");
        model.addAttribute("sedes", catalogoService.listarSedes());
        model.addAttribute("totalSedes", catalogoService.contarSedes());
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
        catalogoService.registrarSede(nombre, direccion, distrito, ciudad, telefono, email, horarioLv, horarioSabado, horarioDomingo, numConsultorios, estado);
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
        catalogoService.editarSede(id, nombre, direccion, distrito, ciudad, telefono, email, horarioLv, horarioSabado, horarioDomingo, numConsultorios, estado);
        return "redirect:/admin/sedes?editado";
    }

    @GetMapping("/sedes/eliminar")
    public String eliminarSede(@RequestParam Integer id) {
        catalogoService.eliminarSede(id);
        return "redirect:/admin/sedes?eliminado";
    }

    // ========== PROMOCIONES ==========
    @GetMapping("/promociones")
    public String listarPromociones(Model model) {
        log.info("[Admin] Acceso a Promociones");
        model.addAttribute("promociones", promocionService.listarPromociones());
        model.addAttribute("totalPromociones", promocionService.contarPromociones());
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
        promocionService.registrarPromocion(titulo, descripcion, descuentoPorcentaje, fechaInicio, fechaFin, estado, imagenUrl);
        return "redirect:/admin/promociones?exito";
    }

    @GetMapping("/productos")
    public String listarProductos(Model model) {
        log.info("[Admin] Acceso a Gestión de Productos");
        model.addAttribute("productos", productoService.listarProductos());
        model.addAttribute("totalProductos", productoService.contarProductos());
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
                                    @RequestParam String estado,
                                    @RequestParam(required = false) String imagenUrl,
                                    @RequestParam(required = false) @org.springframework.format.annotation.DateTimeFormat(iso = org.springframework.format.annotation.DateTimeFormat.ISO.DATE) java.time.LocalDate fechaVencimiento,
                                    @RequestParam(required = false) String lote,
                                    @RequestParam(required = false) Integer stockMinimo,
                                    @RequestParam(required = false) String proveedor) {
        productoService.registrarProducto(nombre, descripcion, precio, precioDescuento, categoria, stock, estado, imagenUrl, fechaVencimiento, lote, stockMinimo, proveedor);
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
                                 @RequestParam(required = false) String imagenUrl,
                                 @RequestParam(required = false) @org.springframework.format.annotation.DateTimeFormat(iso = org.springframework.format.annotation.DateTimeFormat.ISO.DATE) java.time.LocalDate fechaVencimiento,
                                 @RequestParam(required = false) String lote,
                                 @RequestParam(required = false) Integer stockMinimo,
                                 @RequestParam(required = false) String proveedor) {
        productoService.editarProducto(id, nombre, descripcion, precio, precioDescuento, categoria, stock, estado, imagenUrl, fechaVencimiento, lote, stockMinimo, proveedor);
        return "redirect:/admin/productos?editado";
    }

    @GetMapping("/productos/eliminar")
    public String eliminarProducto(@RequestParam Integer id) {
        if (productoService.eliminarProducto(id)) {
            return "redirect:/admin/productos?eliminado";
        }
        return "redirect:/admin/productos?descontinuado";
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
        String powerBiUrl = powerBiProperties.getBase().getUrl() + "&pageName=" + powerBiProperties.getPage().getAdmin();
        model.addAttribute("powerBiUrl", powerBiUrl);
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
                               @RequestParam(required = false) String tipo,
                               @RequestHeader(value = "X-Requested-With", required = false) String requestedWith) {
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

        for (AuditoriaUsuario logItem : logs) {
            if (logItem.getUsername() != null) {
                if ("admin".equalsIgnoreCase(logItem.getUsername())) {
                    logItem.setNombreCompleto("Administrador");
                } else {
                    java.util.Optional<Usuario> optUser = usuarioRepository.findByUsername(logItem.getUsername());
                    if (optUser.isPresent()) {
                        Usuario u = optUser.get();
                        if (u.getRol() == Rol.ROLE_PACIENTE && u.getPaciente() != null) {
                            logItem.setNombreCompleto(u.getPaciente().getNombres() + " " + u.getPaciente().getApellidos());
                        } else if (u.getRol() == Rol.ROLE_MEDICO && u.getMedico() != null) {
                            logItem.setNombreCompleto("Dr. " + u.getMedico().getNombres() + " " + u.getMedico().getApellidos());
                        } else if (u.getRol() == Rol.ROLE_ADMIN && u.getAdministrador() != null) {
                            logItem.setNombreCompleto(u.getAdministrador().getNombres() + " " + u.getAdministrador().getApellidos());
                        } else if (u.getRol() == Rol.ROLE_RECEPCIONISTA) {
                            logItem.setNombreCompleto("Recepcionista");
                        } else {
                            logItem.setNombreCompleto(u.getUsername());
                        }
                    } else {
                        logItem.setNombreCompleto(logItem.getUsername());
                    }
                }
            } else {
                logItem.setNombreCompleto("N/A");
            }
        }

        model.addAttribute("logs", logs);
        model.addAttribute("usuarioFiltro", usuario);
        model.addAttribute("tipoFiltro", tipo);
        model.addAttribute("pageTitle", "Auditoría de Seguridad");
        
        if ("Fetch".equals(requestedWith) || "XMLHttpRequest".equals(requestedWith)) {
            return "admin/auditoria :: resultados";
        }
        
        model.addAttribute("view", "admin/auditoria");
        return LAYOUT;
    }

    @GetMapping("/consultorios")
    public String verConsultorios(Model model, @RequestParam(required = false) Integer idSede) {
        log.info("[Admin] Acceso a Gestión de Consultorios");
        List<Sede> sedes = catalogoService.listarSedes();
        List<Medico> medicos = medicoService.listarMedicos();

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
        Map<String, List<String>> roomGroup = new HashMap<>();
        for (String cons : consultorioMedicos.keySet()) {
            if (!cons.equals("Sin Consultorio")) {
                String roomNum = cons.replaceAll("[^0-9]", "");
                if (roomNum.isEmpty()) roomNum = cons;
                roomGroup.computeIfAbsent(roomNum, k -> new ArrayList<>()).add(cons);
            }
        }
        for (Map.Entry<String, List<String>> entry : roomGroup.entrySet()) {
            if (entry.getValue().size() > 1) {
                colisiones.addAll(entry.getValue());
            } else {
                String originalName = entry.getValue().get(0);
                if (consultorioMedicos.get(originalName).size() > 1) {
                    colisiones.add(originalName);
                }
            }
        }

        // Calcular conflictos para todas las sedes
        Map<Integer, Long> sedeConflictosCount = new HashMap<>();
        for (Sede s : sedes) {
            List<Medico> medicosDeEstaSede = medicos.stream()
                    .filter(m -> m.getSede() != null && m.getSede().getId().equals(s.getId()))
                    .collect(Collectors.toList());
            Map<String, List<Medico>> tempMap = new HashMap<>();
            for (Medico m : medicosDeEstaSede) {
                String cons = m.getConsultorio();
                if (cons != null && !cons.isBlank() && !cons.equalsIgnoreCase("Sin Consultorio")) {
                    String roomNum = cons.replaceAll("[^0-9]", "");
                    if (roomNum.isEmpty()) roomNum = cons;
                    tempMap.computeIfAbsent(roomNum, k -> new ArrayList<>()).add(m);
                }
            }
            long conflictos = tempMap.values().stream().filter(list -> list.size() > 1).count();
            sedeConflictosCount.put(s.getId(), conflictos);
        }

        model.addAttribute("sedes", sedes);
        model.addAttribute("sedeSeleccionadaId", sedeSeleccionadaId);
        model.addAttribute("sedeConflictosCount", sedeConflictosCount);
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
        Medico medico = medicoService.obtenerMedicoPorId(idMedico);
        Sede sede = catalogoService.obtenerSedePorId(idSede);
        if (medico != null && sede != null) {
            medico.setConsultorio(consultorio);
            medico.setSede(sede);
            medicoService.guardar(medico);
        }
        return "redirect:/admin/consultorios?idSede=" + idSede;
    }
}
