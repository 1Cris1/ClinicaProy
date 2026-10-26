package com.proyectoclinica.clinica.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Value;
import java.time.LocalDate;
import java.util.stream.Collectors;
import java.security.Principal;
import java.util.Map;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import com.proyectoclinica.clinica.modules.seguridad.repository.UsuarioRepository;
import com.proyectoclinica.clinica.modules.seguridad.models.Usuario;
import java.util.ArrayList;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import com.proyectoclinica.clinica.modules.consultas.service.RecetaService;
import com.proyectoclinica.clinica.modules.citas.service.CitasService;
import com.proyectoclinica.clinica.modules.paciente.service.PacienteService;
import com.proyectoclinica.clinica.modules.recursos.service.CatalogoService;
import com.proyectoclinica.clinica.modules.recursos.service.MedicoService;
import com.proyectoclinica.clinica.modules.farmacia.service.PedidoService;
import com.proyectoclinica.clinica.modules.farmacia.service.ProductoService;
import com.proyectoclinica.clinica.modules.laboratorio.service.LaboratorioService;
import com.proyectoclinica.clinica.modules.farmacia.models.*;
import com.proyectoclinica.clinica.dto.PedidoRequest;
import com.proyectoclinica.clinica.modules.citas.models.Cita;
import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import com.proyectoclinica.clinica.modules.recursos.models.Medico;
import com.proyectoclinica.clinica.modules.recursos.models.Servicio;
import com.mercadopago.client.preference.PreferenceItemRequest;
import com.mercadopago.resources.preference.Preference;

import com.proyectoclinica.clinica.modules.experiencia.service.FeedbackPacienteService;

/**
 * Controlador del portal del paciente.
 */
@Controller
@RequestMapping("/paciente")
@RequiredArgsConstructor
@Slf4j
public class PacienteController {
    private final CatalogoService catalogoService;
    private final MedicoService medicoService;
    private final CitasService citasService;
    private final PacienteService pacienteService;
    private final ProductoService productoService;
    private final PedidoService pedidoService;
    private final RecetaService recetaService;
    private final LaboratorioService laboratorioService;
    private final PasswordEncoder passwordEncoder;
    private final UsuarioRepository usuarioRepository;
    private final FeedbackPacienteService feedbackPacienteService;
    private static final String LAYOUT = "layout-paciente";

    @Value("${powerbi.base.url:}")
    private String powerBiBaseUrl;
    @Value("${powerbi.page.paciente:}")
    private String powerBiPagePaciente;
    @Value("${powerbi.filter.table.pacientes:}")
    private String powerBiTablePacientes;

    private Paciente getPacienteAutenticado(Principal principal) {
        if (principal == null)
            return null;
        return pacienteService.obtenerPorUsername(principal.getName()).orElse(null);
    }

    @GetMapping({ "", "/" })
    public String root() {
        return "redirect:/paciente/inicio";
    }

    @GetMapping("/inicio")
    public String dashboard(Model model, Principal principal) {
        Paciente paciente = getPacienteAutenticado(principal);
        if (paciente != null) {
            model.addAttribute("pacienteGlobal", paciente);
            model.addAttribute("proximaCita", citasService.obtenerProximaCita(paciente.getId()));
            model.addAttribute("citasPendientesCount", citasService.contarCitasPendientes(paciente.getId()));
            model.addAttribute("consultasAnioActual", citasService.contarConsultasAnioActual(paciente.getId()));

            String powerBiUrl = powerBiBaseUrl
                    + "&pageName=" + powerBiPagePaciente
                    + "&filter=" + powerBiTablePacientes + "/id_paciente%20eq%20" + paciente.getId();

            model.addAttribute("powerBiUrl", powerBiUrl);
            model.addAttribute("powerBiPageName", "Dashboard Paciente");
            model.addAttribute("recetasActivas", recetaService.obtenerRecetasActivas(paciente.getId()).size());
            model.addAttribute("resultadosListosCount",
                    laboratorioService.contarResultadosListos(paciente.getId()));
            model.addAttribute("ultimosResultados",
                    laboratorioService.listarResultadosPorPaciente(paciente.getId()).stream()
                            .limit(3).collect(Collectors.toList()));
        }
        model.addAttribute("pageTitle", "Mi Panel");
        model.addAttribute("view", "paciente/dashboard");
        return LAYOUT;
    }

    @GetMapping("/citas")
    public String misCitas(Model model, Principal principal) {
        Paciente paciente = getPacienteAutenticado(principal);
        if (paciente == null)
            return "redirect:/login";

        List<Cita> citas = citasService.listarCitasPorPaciente(paciente.getId());
        model.addAttribute("pacienteGlobal", paciente);
        model.addAttribute("citas", citas);
        model.addAttribute("pageTitle", "Mis Citas");
        model.addAttribute("view", "paciente/mis-citas");
        return LAYOUT;
    }

    @GetMapping("/agendar")
    public String agendarCita(@RequestParam(required = false) Integer id_cita, Model model, Principal principal) {
        Paciente paciente = getPacienteAutenticado(principal);
        if (paciente == null)
            return "redirect:/login";

        if (id_cita != null) {
            Cita citaExistente = citasService.obtenerPorId(id_cita)
                    .filter(c -> c.getPaciente().getId().equals(paciente.getId()))
                    .orElse(null);
            model.addAttribute("citaReagendar", citaExistente);
            model.addAttribute("pageTitle", "Re-agendar Cita");
        } else {
            model.addAttribute("pageTitle", "Agendar Cita");
        }
        model.addAttribute("pacienteGlobal", paciente);
        model.addAttribute("especialidades", catalogoService.listarEspecialidades());
        model.addAttribute("medicos", medicoService.listarMedicos());
        model.addAttribute("sedes", catalogoService.listarSedes());
        model.addAttribute("view", "paciente/agendar");
        return LAYOUT;
    }

    @PostMapping("/agendar")
    public String procesarAgendarCita(@RequestParam Integer id_medico,
            @RequestParam String fecha,
            @RequestParam String hora,
            @RequestParam(required = false) Integer id_cita,
            @RequestParam(defaultValue = "clinica") String metodoPago,
            Principal principal) {
        Paciente paciente = getPacienteAutenticado(principal);
        Medico medico = medicoService.obtenerMedicoPorId(id_medico);
        Servicio servicioDefault = catalogoService.obtenerServicioPorId(1);

        if (paciente != null && medico != null) {
            LocalDate fechaParsed = LocalDate.parse(fecha);

            if (id_cita != null) {
                try {
                    citasService.reagendarCitaPaciente(id_cita, paciente.getId(), medico, fechaParsed, hora);
                    return "redirect:/paciente/citas?reagendado=true";
                } catch (SecurityException e) {
                    return "redirect:/paciente/citas?error=true";
                } catch (IllegalStateException e) {
                    return "redirect:/paciente/agendar?id_cita=" + id_cita + "&error=horario_ocupado";
                }
            } else {
                Servicio servicio = catalogoService.obtenerServicioPorId(medico.getEspecialidad().getId());
                if (servicio == null) {
                    servicio = servicioDefault;
                }

                try {
                    Cita savedCita = citasService.agendarCita(paciente, medico, servicio, fechaParsed, hora, null);

                if ("online".equals(metodoPago)) {
                    try {
                        String title = "Consulta de " + medico.getEspecialidad().getNombre() + " - Dr. " + medico.getApellidos();
                        PreferenceItemRequest item = PreferenceItemRequest.builder()
                                .title(title)
                                .quantity(1)
                                .unitPrice(servicio.getPrecio())
                                .build();
                        
                        com.mercadopago.client.preference.PreferenceBackUrlsRequest backUrls =
                                com.mercadopago.client.preference.PreferenceBackUrlsRequest.builder()
                                        .success("http://localhost:8080/pago/cita/success")
                                        .failure("http://localhost:8080/pago/cita/failure")
                                        .pending("http://localhost:8080/pago/cita/pending")
                                        .build();

                        com.mercadopago.client.preference.PreferenceRequest request =
                                com.mercadopago.client.preference.PreferenceRequest.builder()
                                        .items(List.of(item))
                                        .externalReference(savedCita.getIdCita().toString())
                                        .backUrls(backUrls)
                                        .statementDescriptor("ClinicX Cita")
                                        .build();

                        com.mercadopago.client.preference.PreferenceClient client = new com.mercadopago.client.preference.PreferenceClient();
                        Preference preference = client.create(request);
                        
                        return "redirect:" + preference.getInitPoint();
                    } catch (Exception e) {
                        log.error("Error al crear preferencia de Mercado Pago para la cita", e);
                        return "redirect:/paciente/citas?agendado=true&error=pago_inicializacion";
                    }
                }

                } catch (IllegalStateException e) {
                    return "redirect:/paciente/agendar?error=horario_ocupado";
                }

                return "redirect:/paciente/citas?agendado=true";
            }
        }
        return "redirect:/paciente/agendar?error=true";
    }

    @PostMapping("/citas/cancelar")
    public String cancelarCita(@RequestParam Integer id_cita, Principal principal) {
        Paciente paciente = getPacienteAutenticado(principal);
        Cita cita = citasService.obtenerPorId(id_cita).orElse(null);
        if (cita != null && paciente != null && cita.getPaciente().getId().equals(paciente.getId())) {
            citasService.actualizarEstado(id_cita, "Cancelada");
            return "redirect:/paciente/citas?cancelado=true";
        }
        return "redirect:/paciente/citas?error=true";
    }

    /**
     * HISTORIA DE USUARIO: Visualización de Resultados de Laboratorio
     * Integrante: 3
     */
    // EXPOSICIÓN RHOMEL: Aquí obtenemos los resultados de laboratorio listos
    // asociados al paciente usando JPA.
    @GetMapping("/resultados")
    public String resultados(Model model, Principal principal) {
        Paciente paciente = getPacienteAutenticado(principal);
        if (paciente == null)
            return "redirect:/login";

        model.addAttribute("pacienteGlobal", paciente);
        model.addAttribute("resultados",
                laboratorioService.listarResultadosPorPaciente(paciente.getId()));
        model.addAttribute("pageTitle", "Mis Resultados");
        model.addAttribute("view", "paciente/resultados");
        return LAYOUT;
    }

    // EXPOSICIÓN RHOMEL: Explicar cómo funciona el servicio RecetaService para
    // separar la lógica de negocio del controlador.
    @GetMapping("/recetas")
    public String recetas(Model model, Principal principal) {
        Paciente paciente = getPacienteAutenticado(principal);
        if (paciente == null)
            return "redirect:/login";

        model.addAttribute("pacienteGlobal", paciente);
        model.addAttribute("recetasActivas", recetaService.obtenerRecetasActivas(paciente.getId()));
        model.addAttribute("historialRecetas", recetaService.obtenerHistorialRecetas(paciente.getId()));
        model.addAttribute("pageTitle", "Mis Recetas");
        model.addAttribute("view", "paciente/recetas");
        return LAYOUT;
    }

    @GetMapping("/historial")
    public String historial(Model model, Principal principal) {
        Paciente paciente = getPacienteAutenticado(principal);
        if (paciente == null)
            return "redirect:/login";

        model.addAttribute("pacienteGlobal", paciente);
        model.addAttribute("atenciones",
                citasService.listarCitasCompletadasPorPaciente(paciente.getId()));
        model.addAttribute("pageTitle", "Mi Historial");
        model.addAttribute("view", "paciente/historial");
        return LAYOUT;
    }

    @GetMapping("/perfil")
    public String perfil(Model model, Principal principal) {
        Paciente paciente = getPacienteAutenticado(principal);
        if (paciente == null)
            return "redirect:/login";

        model.addAttribute("pacienteGlobal", paciente);
        model.addAttribute("pageTitle", "Mi Perfil");
        model.addAttribute("view", "paciente/perfil");
        return LAYOUT;
    }

    // EXPOSICIÓN RHOMEL: Aquí actualizamos los datos permitidos del paciente,
    // excluyendo campos sensibles como el DNI.
    @PostMapping("/perfil/actualizar")
    public String actualizarPerfil(
            @RequestParam("telefono") String telefono,
            @RequestParam("email") String email,
            Principal principal) {

        Paciente paciente = getPacienteAutenticado(principal);
        if (paciente != null) {
            paciente.setTelefono(telefono);
            paciente.setEmail(email);
            pacienteService.guardarPaciente(paciente);
        }
        return "redirect:/paciente/perfil?actualizado=true";
    }

    // EXPOSICIÓN RHOMEL: Endpoint añadido para cambiar la contraseña usando BCrypt,
    // mejorando la seguridad.
    @PostMapping("/perfil/password")
    public String cambiarPassword(
            @RequestParam("currentPassword") String currentPassword,
            @RequestParam("newPassword") String newPassword,
            Principal principal) {

        Paciente paciente = getPacienteAutenticado(principal);
        if (paciente != null) {
            Usuario usuario = paciente.getUsuario();
            if (passwordEncoder.matches(currentPassword, usuario.getPassword())) {
                usuario.setPassword(passwordEncoder.encode(newPassword));
                usuarioRepository.save(usuario);
                return "redirect:/paciente/perfil?password_success=true";
            } else {
                return "redirect:/paciente/perfil?error=password_incorrect";
            }
        }
        return "redirect:/login";
    }

    @GetMapping("/configuracion")
    public String configuracion(Model model, Principal principal) {
        Paciente paciente = getPacienteAutenticado(principal);
        if (paciente == null)
            return "redirect:/login";

        model.addAttribute("pacienteGlobal", paciente);
        model.addAttribute("pageTitle", "Configuración");
        model.addAttribute("view", "paciente/configuracion");
        return LAYOUT;
    }

    @GetMapping("/farmacia")
    public String farmacia(Model model, Principal principal) {
        Paciente paciente = getPacienteAutenticado(principal);
        if (paciente == null)
            return "redirect:/login";

        // Obtener última receta para sugerencia predictiva
        String sugerencia = "";
        try {
            var recetas = recetaService.obtenerRecetasPorPaciente(paciente.getId());
            if (recetas != null && !recetas.isEmpty()) {
                var ultimaReceta = recetas.get(0);
                if (ultimaReceta.getMedicamentos() != null && !ultimaReceta.getMedicamentos().isEmpty()) {
                    sugerencia = ultimaReceta.getMedicamentos().stream()
                            .map(m -> m.getNombre())
                            .collect(java.util.stream.Collectors.joining(", "));
                }
            }
        } catch (Exception e) {
            // Ignorar en caso de que no tenga recetas
        }

        model.addAttribute("pacienteGlobal", paciente);
        model.addAttribute("productos", productoService.listarActivos());
        model.addAttribute("misPedidos", pedidoService.listarPedidosPorPaciente(paciente.getId()));
        model.addAttribute("sugerenciaReceta", sugerencia);
        model.addAttribute("pageTitle", "Farmacia y Ofertas");
        model.addAttribute("view", "paciente/farmacia");
        return LAYOUT;
    }

    // EXPOSICIÓN RHOMEL: Lógica del carrito de compras, valida ítems y guarda la
    // relación de Pedido y DetallePedido en cascada/loop.
    @PostMapping("/farmacia/comprar")
    @ResponseBody
    public ResponseEntity<?> procesarCompra(@RequestBody PedidoRequest pedidoReq, Principal principal) {
        Paciente paciente = getPacienteAutenticado(principal);
        if (paciente == null)
            return ResponseEntity.status(401).body(Map.of("success", false, "message", "No autenticado"));

        if (pedidoReq.getItems() == null || pedidoReq.getItems().isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("success", false, "message", "El carrito está vacío"));
        }

        List<PreferenceItemRequest> mpItems = new ArrayList<>();
        Pedido pedido = pedidoService.crearPedido(paciente, pedidoReq, mpItems);

        try {
            com.mercadopago.client.preference.PreferenceBackUrlsRequest backUrls =
                    com.mercadopago.client.preference.PreferenceBackUrlsRequest.builder()
                            .success("http://localhost:8080/pago/farmacia/success")
                            .failure("http://localhost:8080/pago/farmacia/failure")
                            .pending("http://localhost:8080/pago/farmacia/pending")
                            .build();

            com.mercadopago.client.preference.PreferenceRequest request =
                    com.mercadopago.client.preference.PreferenceRequest.builder()
                            .items(mpItems)
                            .externalReference(pedido.getId().toString())
                            .backUrls(backUrls)
                            .statementDescriptor("ClinicX Farmacia")
                            .build();

            com.mercadopago.client.preference.PreferenceClient client = new com.mercadopago.client.preference.PreferenceClient();
            Preference preference = client.create(request);

            return ResponseEntity.ok(Map.of("success", true, "init_point", preference.getInitPoint()));
        } catch (Exception e) {
            log.error("Error al crear preferencia MP para farmacia", e);
            return ResponseEntity.status(500).body(Map.of("success", false, "message", "Error procesando el pago."));
        }
    }

    @GetMapping("/calificaciones")
    public String calificaciones(Model model, Principal principal) {
        Paciente paciente = getPacienteAutenticado(principal);
        if (paciente == null) {
            return "redirect:/login";
        }
        model.addAttribute("pacienteGlobal", paciente);
        model.addAttribute("citas", citasService.listarCitasCompletadasPorPaciente(paciente.getId()));
        model.addAttribute("pageTitle", "Calificar Atención");
        model.addAttribute("view", "paciente/calificaciones");
        return LAYOUT;
    }

    @PostMapping("/calificaciones")
    public String guardarCalificacion(
            @RequestParam Integer idCita,
            @RequestParam Integer puntuacion,
            @RequestParam(required = false) String comentario,
            Principal principal) {
        Paciente paciente = getPacienteAutenticado(principal);
        if (paciente == null) {
            return "redirect:/login";
        }
        try {
            feedbackPacienteService.guardarCalificacion(
                    idCita,
                    puntuacion,
                    comentario,
                    paciente
            );
            return "redirect:/paciente/calificaciones?success";
        } catch (RuntimeException ex) {
            return "redirect:/paciente/calificaciones?error";
        }
    }

    @GetMapping("/doctores")
    public String doctores(Model model, Principal principal) {
        Paciente paciente = getPacienteAutenticado(principal);
        if (paciente == null) {
            return "redirect:/login";
        }
        model.addAttribute("pacienteGlobal", paciente);
        model.addAttribute("medicos", medicoService.listarMedicos());
        model.addAttribute("especialidades", medicoService.listarEspecialidades());
        model.addAttribute("pageTitle", "Nuestros Especialistas");
        model.addAttribute("view", "paciente/doctores");
        return LAYOUT;
    }
}
