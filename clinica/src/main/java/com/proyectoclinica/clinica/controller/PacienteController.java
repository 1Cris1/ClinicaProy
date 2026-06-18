package com.proyectoclinica.clinica.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import org.springframework.beans.factory.annotation.Value;
import java.util.*;
import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.stream.Collectors;
import java.math.BigDecimal;
import org.springframework.security.crypto.password.PasswordEncoder;
import com.proyectoclinica.clinica.modules.seguridad.repository.UsuarioRepository;
import com.proyectoclinica.clinica.modules.seguridad.models.Usuario;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import com.proyectoclinica.clinica.modules.consultas.service.RecetaService;
import com.proyectoclinica.clinica.modules.recursos.repository.EspecialidadRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.MedicoRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.SedeRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.ServicioRepository;
import com.proyectoclinica.clinica.modules.citas.repository.CitaRepository;
import com.proyectoclinica.clinica.modules.paciente.repository.PacienteRepository;
import com.proyectoclinica.clinica.modules.farmacia.repository.*;
import com.proyectoclinica.clinica.modules.farmacia.models.*;
import com.proyectoclinica.clinica.dto.PedidoRequest;
import com.proyectoclinica.clinica.modules.citas.models.Cita;
import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import com.proyectoclinica.clinica.modules.recursos.models.Medico;
import com.proyectoclinica.clinica.modules.recursos.models.Servicio;
import com.proyectoclinica.clinica.service.MercadoPagoService;
import com.mercadopago.client.preference.PreferenceItemRequest;
import com.mercadopago.resources.preference.Preference;

/**
 * Controlador del portal del paciente.
 */
@Controller
@RequestMapping("/paciente")
@RequiredArgsConstructor
@Slf4j
public class PacienteController {
    private final EspecialidadRepository especialidadRepository;
    private final MedicoRepository medicoRepository;
    private final SedeRepository sedeRepository;
    private final CitaRepository citaRepository;
    private final PacienteRepository pacienteRepository;
    private final ServicioRepository servicioRepository;
    private final ProductoRepository productoRepository;
    private final PedidoRepository pedidoRepository;
    private final DetallePedidoRepository detallePedidoRepository;
    private final RecetaService recetaService;
    private final com.proyectoclinica.clinica.modules.laboratorio.repository.ResultadoLaboratorioRepository resultadoLaboratorioRepository;
    private final PasswordEncoder passwordEncoder;
    private final UsuarioRepository usuarioRepository;
    private final MercadoPagoService mercadoPagoService;

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
        return pacienteRepository.findByUsuarioUsername(principal.getName()).orElse(null);
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
            model.addAttribute("proximaCita", citaRepository.findProximaCita(paciente.getId()));
            model.addAttribute("citasPendientesCount", citaRepository.countCitasPendientes(paciente.getId()));
            model.addAttribute("consultasAnioActual", citaRepository.countConsultasAnioActual(paciente.getId()));

            String powerBiUrl = powerBiBaseUrl
                    + "&pageName=" + powerBiPagePaciente
                    + "&filter=" + powerBiTablePacientes + "/id_paciente%20eq%20" + paciente.getId();

            model.addAttribute("powerBiUrl", powerBiUrl);
            model.addAttribute("powerBiPageName", "Dashboard Paciente");
            model.addAttribute("recetasActivas", recetaService.obtenerRecetasActivas(paciente.getId()).size());
            model.addAttribute("resultadosListosCount",
                    resultadoLaboratorioRepository.countByPacienteIdAndEstado(paciente.getId(), "Disponible"));
            model.addAttribute("ultimosResultados",
                    resultadoLaboratorioRepository.findByPacienteIdOrderByFechaExamenDesc(paciente.getId()).stream()
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

        List<Cita> citas = citaRepository.findByPacienteIdOrderByFechaCitaDesc(paciente.getId());
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
            Cita citaExistente = citaRepository.findById(id_cita).orElse(null);
            model.addAttribute("citaReagendar", citaExistente);
            model.addAttribute("pageTitle", "Re-agendar Cita");
        } else {
            model.addAttribute("pageTitle", "Agendar Cita");
        }
        model.addAttribute("pacienteGlobal", paciente);
        model.addAttribute("especialidades", especialidadRepository.findAll());
        model.addAttribute("medicos", medicoRepository.findAll());
        model.addAttribute("sedes", sedeRepository.findAll());
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
        Medico medico = medicoRepository.findById(id_medico).orElse(null);
        Servicio servicioDefault = servicioRepository.findById(1).orElse(null);

        if (paciente != null && medico != null) {
            LocalDate fechaParsed = LocalDate.parse(fecha);

            if (id_cita != null) {
                // Validación de conflicto de horario para re-agendamiento (excluye la propia
                // cita)
                boolean conflicto = citaRepository.existsByMedicoIdAndFechaCitaAndHoraCitaAndEstadoNotAndIdCitaNot(
                        id_medico, fechaParsed, hora, "Cancelada", id_cita);
                if (conflicto) {
                    return "redirect:/paciente/agendar?id_cita=" + id_cita + "&error=horario_ocupado";
                }

                Cita cita = citaRepository.findById(id_cita).orElse(null);
                if (cita != null && cita.getPaciente().getId().equals(paciente.getId())) {
                    cita.setMedico(medico);
                    cita.setFechaCita(fechaParsed);
                    cita.setHoraCita(hora);
                    cita.setEstado("Pendiente");
                    citaRepository.save(cita);
                    return "redirect:/paciente/citas?reagendado=true";
                }
            } else {
                // Validación de conflicto de horario para cita nueva
                boolean conflicto = citaRepository.existsByMedicoIdAndFechaCitaAndHoraCitaAndEstadoNot(
                        id_medico, fechaParsed, hora, "Cancelada");
                if (conflicto) {
                    return "redirect:/paciente/agendar?error=horario_ocupado";
                }

                Servicio servicio = servicioRepository.findById(medico.getEspecialidad().getId()).orElse(servicioDefault);

                Cita nuevaCita = Cita.builder()
                        .paciente(paciente)
                        .medico(medico)
                        .servicio(servicio)
                        .fechaCita(fechaParsed)
                        .horaCita(hora)
                        .estado("Pendiente")
                        .build();
                Cita savedCita = citaRepository.save(nuevaCita);

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

                return "redirect:/paciente/citas?agendado=true";
            }
        }
        return "redirect:/paciente/agendar?error=true";
    }

    @PostMapping("/citas/cancelar")
    public String cancelarCita(@RequestParam Integer id_cita, Principal principal) {
        Paciente paciente = getPacienteAutenticado(principal);
        Cita cita = citaRepository.findById(id_cita).orElse(null);
        if (cita != null && paciente != null && cita.getPaciente().getId().equals(paciente.getId())) {
            cita.setEstado("Cancelada");
            citaRepository.save(cita);
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
                resultadoLaboratorioRepository.findByPacienteIdOrderByFechaExamenDesc(paciente.getId()));
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
                citaRepository.findByPacienteIdAndEstadoOrderByFechaCitaDesc(paciente.getId(), "Completada"));
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
            pacienteRepository.save(paciente);
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
        model.addAttribute("productos", productoRepository.findByEstado("Activo"));
        model.addAttribute("misPedidos", pedidoRepository.findByPacienteIdOrderByFechaPedidoDesc(paciente.getId()));
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

        Pedido pedido = Pedido.builder()
                .paciente(paciente)
                .fechaPedido(LocalDateTime.now())
                .estado("Pendiente")
                .notas(pedidoReq.getNotas())
                .total(BigDecimal.ZERO)
                .build();

        pedido = pedidoRepository.save(pedido);
        BigDecimal total = BigDecimal.ZERO;
        List<PreferenceItemRequest> mpItems = new ArrayList<>();

        for (PedidoRequest.ItemPedido item : pedidoReq.getItems()) {
            Producto producto = productoRepository.findById(item.getIdProducto()).orElse(null);
            if (producto != null) {
                BigDecimal precioFinal = producto.getPrecioDescuento() != null ? producto.getPrecioDescuento()
                        : producto.getPrecio();
                
                // Si la presentación elegida es "Unidad" (Blíster), el precio es la décima parte de la caja
                if ("Unidad".equalsIgnoreCase(item.getPresentacion())) {
                    precioFinal = precioFinal.divide(new BigDecimal(10), 2, java.math.RoundingMode.HALF_UP);
                }

                BigDecimal subtotal = precioFinal.multiply(new BigDecimal(item.getCantidad()));
                total = total.add(subtotal);

                DetallePedido detalle = DetallePedido.builder()
                        .pedido(pedido)
                        .producto(producto)
                        .cantidad(item.getCantidad())
                        .precioUnitario(precioFinal)
                        .subtotal(subtotal)
                        .build();
                detallePedidoRepository.save(detalle);

                // Add to Mercado Pago items list
                PreferenceItemRequest mpItem = PreferenceItemRequest.builder()
                        .id(producto.getId().toString())
                        .title(producto.getNombre() + ( "Unidad".equalsIgnoreCase(item.getPresentacion()) ? " (Unidad)" : " (Caja)" ))
                        .quantity(item.getCantidad())
                        .unitPrice(precioFinal)
                        .currencyId("PEN")
                        .build();
                mpItems.add(mpItem);
            }
        }
        pedido.setTotal(total);
        pedidoRepository.save(pedido);

        try {
            Preference preference = mercadoPagoService.crearPreference(
                    total.doubleValue(),
                    "Medicamentos ClinicX - Pedido #" + pedido.getId(),
                    pedido.getId().toString(),
                    mpItems
            );
            return ResponseEntity.ok(Map.of(
                    "success", true,
                    "checkoutUrl", preference.getInitPoint(),
                    "pedidoId", pedido.getId()
            ));
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of(
                    "success", false,
                    "message", "Error al generar la preferencia de Mercado Pago: " + e.getMessage()
            ));
        }
    }
}
