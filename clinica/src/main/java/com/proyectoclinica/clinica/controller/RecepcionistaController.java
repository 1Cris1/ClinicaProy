package com.proyectoclinica.clinica.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import com.proyectoclinica.clinica.modules.citas.service.CitasService;
import com.proyectoclinica.clinica.modules.paciente.service.PacienteService;
import com.proyectoclinica.clinica.modules.citas.models.Cita;
import com.proyectoclinica.clinica.modules.facturacion.models.Pago;
import com.proyectoclinica.clinica.modules.facturacion.service.PagoService;
import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import com.proyectoclinica.clinica.modules.recursos.models.Medico;
import com.proyectoclinica.clinica.modules.recursos.models.Servicio;
import com.proyectoclinica.clinica.modules.recursos.service.MedicoService;
import com.proyectoclinica.clinica.modules.recursos.service.CatalogoService;
import com.proyectoclinica.clinica.modules.integraciones.service.GoogleCalendarService;
import com.proyectoclinica.clinica.modules.farmacia.service.PedidoService;
import com.proyectoclinica.clinica.modules.farmacia.models.Pedido;


import com.proyectoclinica.clinica.modules.triaje.service.TriajeService;

import java.security.Principal;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;
import java.util.concurrent.CompletableFuture;

@Controller
@RequestMapping("/recepcionista")
@RequiredArgsConstructor
@Slf4j
public class RecepcionistaController {
    private final CitasService citasService;
    private final PacienteService pacienteService;
    private final MedicoService medicoService;
    private final CatalogoService catalogoService;
    private final PagoService pagoService;
    private final GoogleCalendarService googleCalendarService;
    private final PedidoService pedidoService;
    private final TriajeService triajeService;

    private static final String LAYOUT = "layout-recepcionista";

    @Value("${powerbi.base.url:}")
    private String powerBiBaseUrl;
    @Value("${powerbi.page.recepcion:}")
    private String powerBiPageRecepcion;

    @GetMapping({"", "/"})
    public String root() {
        return "redirect:/recepcionista/inicio";
    }

    @GetMapping("/inicio")
    public String dashboard(Model model, Principal principal) {
        model.addAttribute("pageTitle", "Panel");
        model.addAttribute("view", "recepcionista/dashboard");
        
        LocalDate hoy = LocalDate.now();
        List<Cita> citasDeHoy = citasService.listarCitasPorFecha(hoy);
        model.addAttribute("citasHoy", citasDeHoy);

        long enSalaEspera = citasDeHoy.stream().filter(c -> "Confirmada".equals(c.getEstado())).count();
        long citasRestantes = citasDeHoy.stream().filter(c -> "Pendiente".equals(c.getEstado())).count();
        long cancelaciones = citasService.contarCancelacionesHoy();

        List<Pago> pagosHoy = pagoService.listarTodos().stream()
            .filter(p -> p.getFechaPago() != null && p.getFechaPago().toLocalDate().equals(hoy))
            .filter(p -> "Completado".equals(p.getEstado()))
            .collect(Collectors.toList());

        BigDecimal totalPagosHoy = pagosHoy.stream()
            .map(p -> p.getMonto() != null ? p.getMonto() : BigDecimal.ZERO)
            .reduce(BigDecimal.ZERO, (a, b) -> a.add(b));

        model.addAttribute("enSalaEspera", enSalaEspera);
        model.addAttribute("citasRestantes", citasRestantes);
        model.addAttribute("totalPagosHoy", totalPagosHoy);
        model.addAttribute("cancelaciones", cancelaciones);
        model.addAttribute("citasPendientes", enSalaEspera + citasRestantes);

        String powerBiUrl = powerBiBaseUrl + "&pageName=" + powerBiPageRecepcion;
        model.addAttribute("medicos", medicoService.listarMedicos());
        model.addAttribute("powerBiUrl", powerBiUrl);
        model.addAttribute("powerBiPageName", "Dashboard Recepcion");
        return LAYOUT;
    }

    /**
     * HISTORIA DE USUARIO: Confirmación de llegada (Check-in)
     * Integrante: 1
     */
    // Escucha peticiones POST en /recepcionista/citas/checkin
    @PostMapping("/citas/checkin")
    public String checkIn(
            // Captura el ID de la cita enviado desde el HTML
            @RequestParam Integer idCita) {
        citasService.checkIn(idCita);
        // Redirige al panel de inicio de la recepcionista
        return "redirect:/recepcionista/inicio";
    }

    @GetMapping("/citas")
    public String listarCitas(@RequestParam(required = false) String fecha, Model model) {
        LocalDate fechaSeleccionada = (fecha != null && !fecha.isBlank()) ? LocalDate.parse(fecha) : LocalDate.now();
        List<Cita> citas = citasService.listarCitasPorFecha(fechaSeleccionada);
        
        model.addAttribute("citas", citas);
        model.addAttribute("fechaSeleccionada", fechaSeleccionada.toString());
        model.addAttribute("pacientes", pacienteService.listarTodosLosPacientes());
        model.addAttribute("medicos", medicoService.listarMedicos());
        model.addAttribute("servicios", catalogoService.listarServicios());
        model.addAttribute("pageTitle", "Gestión de Citas");
        model.addAttribute("view", "recepcionista/citas");
        return LAYOUT;
    }

    /**
     * HISTORIA DE USUARIO: Agendamiento de Citas
     * Integrante: 1
     */
    // Escucha peticiones POST en /recepcionista/citas/nuevo
    @PostMapping("/citas/nuevo")
    public String nuevaCita(
            @RequestParam Integer pacienteId,
            @RequestParam Integer medicoId,
            @RequestParam String fecha,
            @RequestParam String hora,
            @RequestParam(required = false) Integer servicioId,
            @RequestParam(required = false) String observaciones) {
        try {
            Paciente paciente = pacienteService.obtenerPacientePorId(pacienteId);
            Medico medico = medicoService.obtenerMedicoPorId(medicoId);
            Servicio servicio = (servicioId != null)
                    ? catalogoService.obtenerServicioPorId(servicioId)
                    : null;
            if (servicio == null) {
                servicio = catalogoService.obtenerServicioPorId(1);
            }

            if (paciente != null && medico != null && servicio != null) {
                try {
                    Cita nuevaCita = citasService.agendarCita(paciente, medico, servicio, LocalDate.parse(fecha), hora, observaciones);
                    
                    try {
                        CompletableFuture.runAsync(() -> {
                            try {
                                googleCalendarService.crearEventoCita(nuevaCita);
                            } catch (Exception e) {
                                log.warn("Error en la sincronización asíncrona de calendar: {}", e.getMessage());
                            }
                        });
                    } catch (Exception e) {
                        log.warn("Error al iniciar el hilo de sincronización de calendar: {}", e.getMessage());
                    }
                    
                    return "redirect:/recepcionista/citas?fecha=" + fecha + "&success=agendado";
                } catch (IllegalStateException e) {
                    return "redirect:/recepcionista/citas?fecha=" + fecha + "&error=horario_ocupado";
                }
            }
        } catch (Exception e) {
            log.error("Error agendando cita", e);
        }
        return "redirect:/recepcionista/citas?error=internal_error";
    }

    @PostMapping("/citas/editar")
    public String editarCita(@RequestParam Integer idCita,
                             @RequestParam String fecha,
                             @RequestParam String hora,
                             @RequestParam String estado,
                             @RequestParam(required = false) String observaciones) {
        try {
            citasService.editarCita(idCita, LocalDate.parse(fecha), hora, estado, observaciones);
        } catch (IllegalStateException e) {
            return "redirect:/recepcionista/citas?fecha=" + fecha + "&error=horario_ocupado";
        }
        return "redirect:/recepcionista/citas?fecha=" + fecha;
    }

    @GetMapping("/pacientes")
    public String pacientesDashboard(Model model) {
        List<Paciente> pacientes = pacienteService.listarTodosLosPacientes();
        long pacientesActivos = pacientes.stream().filter(p -> "Activo".equals(p.getEstado()) || p.getEstado() == null).count();
        long pacientesInactivos = pacientes.stream().filter(p -> "Inactivo".equals(p.getEstado())).count();
        
        model.addAttribute("pacientes", pacientes);
        model.addAttribute("totalPacientes", pacientes.size());
        model.addAttribute("pacientesActivos", pacientesActivos);
        model.addAttribute("pacientesInactivos", pacientesInactivos);
        model.addAttribute("pageTitle", "Pacientes");
        model.addAttribute("view", "recepcionista/pacientes");
        return LAYOUT;
    }

    @GetMapping("/medicos")
    public String listarMedicos(Model model) {
        List<Medico> medicos = medicoService.listarMedicos();
        long medicosActivos = medicos.stream().filter(m -> "Activo".equals(m.getEstado()) || m.getEstado() == null).count();
        long totalSedes = medicoService.contarSedes();
        long citasHoy = citasService.contarCitasHoy();

        model.addAttribute("medicos", medicos);
        model.addAttribute("totalMedicos", medicos.size());
        model.addAttribute("medicosActivos", medicosActivos);
        model.addAttribute("totalSedes", totalSedes);
        model.addAttribute("citasHoy", citasHoy);

        model.addAttribute("pageTitle", "Cuerpo Médico");
        model.addAttribute("view", "recepcionista/medicos");
        return LAYOUT;
    }

    @PostMapping("/pacientes/nuevo")
    public String nuevoPaciente(@RequestParam String nombres,
                               @RequestParam String apellidos,
                               @RequestParam String dni,
                               @RequestParam(required = false) String telefono,
                               @RequestParam(required = false) String email,
                               @RequestParam(required = false) String direccion) {
        try {
            Paciente nuevoPaciente = Paciente.builder()
                    .nombres(nombres)
                    .apellidos(apellidos)
                    .dni(dni)
                    .telefono(telefono)
                    .email(email)
                    .direccion(direccion)
                    .estado("Activo")
                    .build();
            pacienteService.guardarPaciente(nuevoPaciente);
            return "redirect:/recepcionista/pacientes?exito";
        } catch (Exception e) {
            return "redirect:/recepcionista/pacientes?error=duplicado";
        }
    }

    @GetMapping("/pagos")
    public String listarPagos(Model model) {
        List<Pago> pagos = pagoService.listarTodos();
        BigDecimal totalRecaudado = pagos.stream()
                .filter(p -> "Completado".equals(p.getEstado()))
                .map(p -> p.getMonto() != null ? p.getMonto() : BigDecimal.ZERO)
                .reduce(BigDecimal.ZERO, (a, b) -> a.add(b));
        
        long totalTransacciones = pagos.size();
        long pagosPendientes = pagos.stream().filter(p -> "Pendiente".equals(p.getEstado())).count();
        long pagosAnulados = pagos.stream().filter(p -> "Anulado".equals(p.getEstado())).count();

        List<Pedido> pedidos = pedidoService.listarTodos();
        pedidos.sort((p1, p2) -> p2.getFechaPedido().compareTo(p1.getFechaPedido()));

        model.addAttribute("pagos", pagos);
        model.addAttribute("totalRecaudado", totalRecaudado);
        model.addAttribute("totalTransacciones", totalTransacciones);
        model.addAttribute("pagosPendientes", pagosPendientes);
        model.addAttribute("pagosAnulados", pagosAnulados);
        model.addAttribute("pedidos", pedidos);
        model.addAttribute("pacientes", pacienteService.listarTodosLosPacientes());
        model.addAttribute("servicios", catalogoService.listarServicios());
        model.addAttribute("pageTitle", "Pagos");
        model.addAttribute("view", "recepcionista/pagos");
        return LAYOUT;
    }

    @PostMapping("/pagos/nuevo")
    public String nuevoPago(@RequestParam Integer pacienteId,
                           @RequestParam(required = false) Integer servicioId,
                           @RequestParam BigDecimal monto,
                           @RequestParam String metodoPago,
                           @RequestParam(defaultValue = "Boleta") String tipoComprobante,
                           @RequestParam(required = false) String observaciones) {
        Paciente paciente = pacienteService.obtenerPacientePorId(pacienteId);
        Servicio servicio = servicioId != null ? catalogoService.obtenerServicioPorId(servicioId) : null;
        
        if (paciente != null) {
            String numeroComprobante = pagoService.generarNumeroComprobante(tipoComprobante);
            Pago nuevoPago = Pago.builder()
                    .paciente(paciente)
                    .servicio(servicio)
                    .monto(monto)
                    .metodoPago(metodoPago)
                    .tipoComprobante(tipoComprobante)
                    .numeroComprobante(numeroComprobante)
                    .fechaPago(LocalDateTime.now())
                    .estado("Completado")
                    .observaciones(observaciones)
                    .build();
            pagoService.guardar(nuevoPago);
            return "redirect:/recepcionista/pagos?exito";
        }
        return "redirect:/recepcionista/pagos?error";
    }

    @GetMapping("/perfil")
    public String perfil(Model model) {
        model.addAttribute("pageTitle", "Mi Perfil");
        model.addAttribute("view", "recepcionista/perfil");
        return LAYOUT;
    }

    @GetMapping("/pacientes/historial")
    @ResponseBody
    public ResponseEntity<List<Map<String, Object>>> getPacienteHistorial(@RequestParam Integer id) {
        List<Cita> citas = citasService.listarCitasPorPaciente(id);
        List<Map<String, Object>> responseList = citas.stream().map(c -> {
            Map<String, Object> map = new HashMap<>();
            map.put("fecha", c.getFechaCita().toString());
            map.put("hora", c.getHoraCita());
            map.put("medico", "Dr. " + c.getMedico().getNombres() + " " + c.getMedico().getApellidos());
            map.put("servicio", c.getServicio() != null ? c.getServicio().getNombre() : "Particular");
            
            String estado = c.getEstado() != null ? c.getEstado() : "Pendiente";
            map.put("estado", estado);
            
            String color = "#FEF3C7";
            String textColor = "#D97706";
            if ("Confirmada".equals(estado)) {
                color = "#DBEAFE";
                textColor = "#2563EB";
            } else if ("Completada".equals(estado)) {
                color = "#D1FAE5";
                textColor = "#059669";
            } else if ("Cancelada".equals(estado)) {
                color = "#FEE2E2";
                textColor = "#DC2626";
            }
            
            map.put("color", color);
            map.put("textColor", textColor);
            return map;
        }).collect(Collectors.toList());
        return ResponseEntity.ok(responseList);
    }

    @GetMapping("/triaje")
    public String verTriaje(@RequestParam(required = false) Integer citaId, Model model) {
        LocalDate hoy = LocalDate.now();
        List<Cita> citasConfirmadasSinTriaje = citasService.listarCitasPorFecha(hoy).stream()
                .filter(c -> "Confirmada".equals(c.getEstado()))
                .filter(c -> c.getTriaje() == null)
                .collect(Collectors.toList());

        model.addAttribute("citas", citasConfirmadasSinTriaje);
        model.addAttribute("citaSeleccionadaId", citaId);
        model.addAttribute("pageTitle", "Registro de Triaje");
        model.addAttribute("view", "recepcionista/triaje");
        return LAYOUT;
    }

    @PostMapping("/triaje/guardar")
    public String guardarTriaje(@RequestParam Integer idCita,
                                @RequestParam BigDecimal peso,
                                @RequestParam BigDecimal talla,
                                @RequestParam String presionArterial,
                                @RequestParam BigDecimal temperatura,
                                @RequestParam Integer frecuenciaCardiaca,
                                @RequestParam Integer saturacionOxigeno) {
        Cita cita = citasService.obtenerPorId(idCita).orElse(null);
        if (triajeService.registrarTriaje(cita, peso, talla, presionArterial, temperatura, frecuenciaCardiaca, saturacionOxigeno)) {
            return "redirect:/recepcionista/triaje?exito";
        }
        return "redirect:/recepcionista/triaje?error";
    }
}

