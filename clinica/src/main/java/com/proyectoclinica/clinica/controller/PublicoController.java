package com.proyectoclinica.clinica.controller;

import com.proyectoclinica.clinica.modules.recursos.repository.MedicoRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.EspecialidadRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.SedeRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.ServicioRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.PromocionRepository;
import com.proyectoclinica.clinica.modules.seguridad.repository.UsuarioRepository;
import com.proyectoclinica.clinica.modules.integraciones.service.FhirService;
import com.proyectoclinica.clinica.modules.integraciones.service.SusaludService;
import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import com.proyectoclinica.clinica.modules.seguridad.models.Usuario;
import com.proyectoclinica.clinica.modules.seguridad.models.Rol;
import com.proyectoclinica.clinica.modules.seguridad.models.EstadoRegistro;
import com.proyectoclinica.clinica.modules.paciente.repository.PacienteRepository;
import com.proyectoclinica.clinica.service.EmailService;
import java.util.concurrent.CompletableFuture;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.http.ResponseEntity;
import org.springframework.dao.DataIntegrityViolationException;

import java.util.Map;
import java.util.regex.Pattern;

@Controller
@RequiredArgsConstructor
public class PublicoController {
    private final MedicoRepository medicoRepository;
    private final EspecialidadRepository especialidadRepository;
    private final SedeRepository sedeRepository;
    private final ServicioRepository servicioRepository;
    private final PromocionRepository promocionRepository;
    private final PacienteRepository pacienteRepository;
    private final UsuarioRepository usuarioRepository;
    private final PasswordEncoder passwordEncoder;
    private final FhirService fhirService;
    private final SusaludService susaludService;
    private final EmailService emailService;

    private static final String LAYOUT = "layout-public";
    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^(?=.*[A-Z])(?=.*[@#$%^&+=!_\\-]).{8,}$");

    @GetMapping("/")
    public String inicio() {
        return "redirect:/login";
    }

    @GetMapping("/medicos")
    public String verMedicos(Model model) {
        model.addAttribute("pageTitle", "Nuestros Médicos");
        model.addAttribute("medicos", medicoRepository.findAll());
        model.addAttribute("especialidades", especialidadRepository.findAll());
        model.addAttribute("view", "publico/medicos");
        return LAYOUT;
    }

    @GetMapping("/sedes")
    public String verSedes(Model model) {
        model.addAttribute("pageTitle", "Nuestras Sedes");
        model.addAttribute("sedes", sedeRepository.findAll());
        model.addAttribute("view", "publico/sedes");
        return LAYOUT;
    }

    @GetMapping("/servicios")
    public String verServicios(Model model) {
        model.addAttribute("pageTitle", "Servicios");
        model.addAttribute("servicios", servicioRepository.findAll());
        model.addAttribute("view", "publico/servicios");
        return LAYOUT;
    }

    @GetMapping("/promociones")
    public String verPromociones(Model model) {
        model.addAttribute("pageTitle", "Promociones");
        model.addAttribute("promociones", promocionRepository.findAll());
        model.addAttribute("view", "publico/promociones");
        return LAYOUT;
    }

    @GetMapping("/especialidades")
    public String verEspecialidades(Model model) {
        model.addAttribute("pageTitle", "Especialidades");
        model.addAttribute("especialidades", especialidadRepository.findAll());
        model.addAttribute("view", "publico/especialidades");
        return LAYOUT;
    }

    @GetMapping("/blog")
    public String verBlog(@RequestParam(required = false) String categoria, Model model) {
        model.addAttribute("pageTitle", "Blog Educativo");
        model.addAttribute("categoriaSel", categoria);
        model.addAttribute("view", "publico/blog");
        return LAYOUT;
    }

    @GetMapping("/login")
    public String login(@RequestParam(name = "error", required = false) String error,
                        @RequestParam(name = "logout", required = false) String logout,
                        Model model) {
        if (error != null) model.addAttribute("errorMsg", "Credenciales incorrectas.");
        if (logout != null) model.addAttribute("logoutMsg", "Sesión cerrada.");
        return "publico/login";
    }

    @GetMapping("/registro")
    public String registro(Model model) {
        return "publico/registro";
    }

    @GetMapping("/agendar-cita")
    public String agendarCitaBridge() {
        return "redirect:/login";
    }

    @GetMapping("/api/identidad/{dni}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> consultarIdentidad(@PathVariable String dni) {
        Map<String, Object> data = susaludService.consultarDatosCompletos(dni);
        if (data.containsKey("nombres")) return ResponseEntity.ok(data);
        return ResponseEntity.status(404).body(data);
    }

    // EXPOSICIÓN CRISTIAN: Explicar que esto es un Endpoint REST que responde en formato JSON (por eso usa @ResponseBody) para validar el CMP en vivo
    @GetMapping("/api/colegiatura/{cmp}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> consultarColegiatura(@PathVariable String cmp) {
        // Mapeamos algunos médicos conocidos del Perú de forma simulada para la demo
        if ("16075".equals(cmp)) {
            return ResponseEntity.ok(Map.of(
                "success", true,
                "nombres", "ELMER",
                "apellidos", "HUERTA RAMIREZ",
                "estado", "ACTIVO",
                "situacion", "HABILITADO"
            ));
        } else if ("13426".equals(cmp)) {
            return ResponseEntity.ok(Map.of(
                "success", true,
                "nombres", "CIRO",
                "apellidos", "MAGUIÑA VARGAS",
                "estado", "ACTIVO",
                "situacion", "HABILITADO"
            ));
        } else if ("35012".equals(cmp)) {
            return ResponseEntity.ok(Map.of(
                "success", true,
                "nombres", "MARCO",
                "apellidos", "ALMERÍ ESTRADA",
                "estado", "ACTIVO",
                "situacion", "HABILITADO"
            ));
        } else if ("22532".equals(cmp)) {
            return ResponseEntity.ok(Map.of(
                "success", true,
                "nombres", "TOMÁS",
                "apellidos", "BORDA NORIEGA",
                "estado", "ACTIVO",
                "situacion", "HABILITADO"
            ));
        }
        
        // Si no es un CMP conocido pero tiene formato válido (5 o 6 dígitos numéricos)
        if (cmp != null && cmp.matches("\\d{5,6}")) {
            return ResponseEntity.ok(Map.of(
                "success", true,
                "nombres", "MEDICO DEMO",
                "apellidos", "CMP " + cmp,
                "estado", "ACTIVO",
                "situacion", "HABILITADO"
            ));
        }
        
        return ResponseEntity.status(404).body(Map.of(
            "success", false, 
            "message", "El número de CMP ingresado no es válido o no está habilitado."
        ));
    }

    // EXPOSICIÓN RHOMEL: Explicar que este método @PostMapping intercepta el formulario HTML de registro, extrae los datos, encripta la clave y guarda el Paciente en la BD.
    @PostMapping("/registro")
    public String registrarPaciente(@RequestParam String dni,
                                    @RequestParam String nombres,
                                    @RequestParam String apellidos,
                                    @RequestParam String correo,
                                    @RequestParam String telefono,
                                    @RequestParam String password,
                                    @RequestParam(required = false) String fechaNacimiento,
                                    @RequestParam(required = false) String direccion,
                                    @RequestParam(required = false) String distrito,
                                    Model model) {
        
        if (!PASSWORD_PATTERN.matcher(password).matches()) {
            return "redirect:/registro?error=contrasena";
        }
        try {
            Usuario usuario = Usuario.builder()
                .username(dni)
                .password(passwordEncoder.encode(password))
                .email(correo)
                .idRol(3)
                .rol(Rol.ROLE_PACIENTE)
                .estadoRegistro(EstadoRegistro.PENDIENTE)
                .build();
            
            usuarioRepository.save(usuario);
            Map<String, Object> dataSusalud = susaludService.consultarDatosCompletos(dni);
            
            Paciente paciente = Paciente.builder()
                .dni(dni)
                .nombres(nombres)
                .apellidos(apellidos)
                .telefono(telefono)
                .usuario(usuario)
                .direccion(direccion)
                .distrito(distrito)
                .estado("Activo")
                .nombreIafas((String) dataSusalud.getOrDefault("iafas", "S/N"))
                .tipoPlan((String) dataSusalud.getOrDefault("tipo_plan", "PARTICULAR"))
                .estadoSeguro((String) dataSusalud.getOrDefault("estado_seguro", "INACTIVO"))
                .fechaSincronizacionSeguro(java.time.LocalDateTime.now())
                .build();

            if (fechaNacimiento != null && !fechaNacimiento.isEmpty()) {
                paciente.setFechaNacimiento(java.time.LocalDate.parse(fechaNacimiento));
            }
            
            pacienteRepository.save(paciente);
            fhirService.syncPatient(paciente);
            
            // Enviar correo de bienvenida asincrónicamente
            CompletableFuture.runAsync(() -> {
                emailService.enviarCorreoBienvenida(correo, nombres + " " + apellidos);
            });
            
            return "redirect:/login?registrado=true";
        } catch (DataIntegrityViolationException e) {
            return "redirect:/registro?error=duplicado";
        } catch (Exception e) {
            return "redirect:/registro?error=general";
        }
    }
}
