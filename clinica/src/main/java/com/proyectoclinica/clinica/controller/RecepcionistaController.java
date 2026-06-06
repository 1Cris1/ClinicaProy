package com.proyectoclinica.clinica.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import com.proyectoclinica.clinica.modules.citas.repository.CitaRepository;
import com.proyectoclinica.clinica.modules.paciente.repository.PacienteRepository;
import com.proyectoclinica.clinica.modules.citas.models.Cita;
import com.proyectoclinica.clinica.modules.facturacion.models.Pago;
import com.proyectoclinica.clinica.modules.facturacion.repository.PagoRepository;
import com.proyectoclinica.clinica.modules.facturacion.service.PagoService;
import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import com.proyectoclinica.clinica.modules.recursos.models.Medico;
import com.proyectoclinica.clinica.modules.recursos.models.Servicio;
import com.proyectoclinica.clinica.modules.recursos.repository.MedicoRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.ServicioRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.SedeRepository;
import com.proyectoclinica.clinica.modules.integraciones.service.GoogleCalendarService;

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
    private final CitaRepository citaRepository;
    private final PacienteRepository pacienteRepository;
    private final MedicoRepository medicoRepository;
    private final ServicioRepository servicioRepository;
    private final PagoRepository pagoRepository;
    private final PagoService pagoService;
    private final GoogleCalendarService googleCalendarService;
    private final SedeRepository sedeRepository;

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
        List<Cita> citasDeHoy = citaRepository.findByFechaCitaOrderByHoraCitaAsc(hoy);
        model.addAttribute("citasHoy", citasDeHoy);

        long enSalaEspera = citasDeHoy.stream().filter(c -> "Confirmada".equals(c.getEstado())).count();
        long citasRestantes = citasDeHoy.stream().filter(c -> "Pendiente".equals(c.getEstado())).count();
        long cancelaciones = citaRepository.countByEstadoAndFechaCita("Cancelada", hoy);

        List<Pago> pagosHoy = pagoRepository.findAll().stream()
            .filter(p -> p.getFechaPago() != null && p.getFechaPago().toLocalDate().equals(hoy))
            .filter(p -> "Completado".equals(p.getEstado()))
            .collect(Collectors.toList());

        BigDecimal totalPagosHoy = pagosHoy.stream().map(Pago::getMonto).reduce(BigDecimal.ZERO, BigDecimal::add);

        model.addAttribute("enSalaEspera", enSalaEspera);
        model.addAttribute("citasRestantes", citasRestantes);
        model.addAttribute("totalPagosHoy", totalPagosHoy);
        model.addAttribute("cancelaciones", cancelaciones);
        model.addAttribute("citasPendientes", enSalaEspera + citasRestantes);

        String powerBiUrl = powerBiBaseUrl + "&pageName=" + powerBiPageRecepcion;
        model.addAttribute("medicos", medicoRepository.findAll());
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
        // Busca la cita en la base de datos por su ID
        Cita cita = citaRepository.findById(idCita).orElse(null);
        // Valida que la cita exista y este en estado Pendiente
        if (cita != null && "Pendiente".equals(cita.getEstado())) {
            // Cambia el estado de la cita a Confirmada
            cita.setEstado("Confirmada");
            // EXPOSICIÓN MIGUEL: Aquí explicamos que usamos JPA. Como la cita ya tiene ID, Spring Boot ejecuta un UPDATE automático para cambiar el estado en lugar de insertar una nueva cita.
            citaRepository.save(cita);
        }
        // Redirige al panel de inicio de la recepcionista
        return "redirect:/recepcionista/inicio";
    }

    @GetMapping("/citas")
    public String listarCitas(@RequestParam(required = false) String fecha, Model model) {
        LocalDate fechaSeleccionada = (fecha != null && !fecha.isBlank()) ? LocalDate.parse(fecha) : LocalDate.now();
        List<Cita> citas = citaRepository.findByFechaCitaOrderByHoraCitaAsc(fechaSeleccionada);
        
        model.addAttribute("citas", citas);
        model.addAttribute("fechaSeleccionada", fechaSeleccionada.toString());
        model.addAttribute("pacientes", pacienteRepository.findAll());
        model.addAttribute("medicos", medicoRepository.findAll());
        model.addAttribute("servicios", servicioRepository.findAll());
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
            // Captura el ID del paciente seleccionado
            @RequestParam Integer pacienteId,
            // Captura el ID del medico seleccionado
            @RequestParam Integer medicoId,
            // Captura la fecha seleccionada en formato texto
            @RequestParam String fecha,
            // Captura la hora seleccionada en formato texto
            @RequestParam String hora,
            // Captura el ID del servicio opcional
            @RequestParam(required = false) Integer servicioId,
            // Captura las observaciones o motivo de la cita
            @RequestParam(required = false) String observaciones) {
        try {
            // Busca al paciente en la base de datos por su ID
            Paciente paciente = pacienteRepository.findById(pacienteId).orElse(null);
            // Busca al medico en la base de datos por su ID
            Medico medico = medicoRepository.findById(medicoId).orElse(null);
            // Busca el servicio. Si es nulo, asigna el servicio por defecto (ID 1)
            Servicio servicio = (servicioId != null) 
                    ? servicioRepository.findById(servicioId).orElse(servicioRepository.findById(1).orElse(null))
                    : servicioRepository.findById(1).orElse(null);

            // Valida que el paciente, medico y servicio existan en el sistema
            if (paciente != null && medico != null && servicio != null) {
                // Validación de conflicto de horario
                boolean conflicto = citaRepository.existsByMedicoIdAndFechaCitaAndHoraCitaAndEstadoNot(
                        medicoId, LocalDate.parse(fecha), hora, "Cancelada"
                );
                if (conflicto) {
                    return "redirect:/recepcionista/citas?fecha=" + fecha + "&error=horario_ocupado";
                }

                // Construye el objeto Cita con los datos ingresados
                Cita nuevaCita = Cita.builder()
                        .paciente(paciente)
                        .medico(medico)
                        .servicio(servicio)
                        // Convierte la fecha de texto a LocalDate
                        .fechaCita(LocalDate.parse(fecha))
                        .horaCita(hora)
                        // Define el estado inicial de la cita como Pendiente
                        .estado("Pendiente")
                        .motivo(observaciones)
                        // Registra la fecha y hora de creacion de la cita
                        .fechaRegistro(LocalDateTime.now())
                        .build();
                // Guarda la nueva cita en la base de datos
                citaRepository.save(nuevaCita);
                try {
                    // Intenta sincronizar de manera asíncrona en segundo plano para evitar bloquear el hilo de ejecución y la base de datos
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
                // EXPOSICIÓN MIGUEL: Explicar el patrón POST-REDIRECT-GET. Hacemos un redirect en vez de cargar la vista directamente para evitar que, si el usuario presiona F5, la cita se vuelva a guardar duplicada.
                return "redirect:/recepcionista/citas?fecha=" + fecha + "&success=agendado";
            }
        } catch (Exception e) {
            // Registra cualquier error inesperado en la consola del servidor
            log.error("Error agendando cita", e);
        }
        // Redirige indicando que hubo un error interno
        return "redirect:/recepcionista/citas?error=internal_error";
    }

    // EXPOSICIÓN MIGUEL: Lógica de Reagendamiento de Citas con Validación.
    // Antes de guardar (UPDATE) la nueva hora, el sistema consulta en la Base de Datos si el médico ya tiene otra cita en esa hora exacta.
    @PostMapping("/citas/editar")
    public String editarCita(@RequestParam Integer idCita,
                            @RequestParam String fecha,
                            @RequestParam String hora,
                            @RequestParam String estado,
                            @RequestParam(required = false) String observaciones) {
        Cita cita = citaRepository.findById(idCita).orElse(null);
        if (cita != null) {
            // Validación de conflicto de horario excluyendo la propia cita
            boolean conflicto = citaRepository.existsByMedicoIdAndFechaCitaAndHoraCitaAndEstadoNotAndIdCitaNot(
                    cita.getMedico().getId(), LocalDate.parse(fecha), hora, "Cancelada", idCita
            );
            if (conflicto) {
                return "redirect:/recepcionista/citas?fecha=" + fecha + "&error=horario_ocupado";
            }

            cita.setFechaCita(LocalDate.parse(fecha));
            cita.setHoraCita(hora);
            cita.setEstado(estado);
            if (observaciones != null) cita.setMotivo(observaciones);
            citaRepository.save(cita);
        }
        return "redirect:/recepcionista/citas?fecha=" + fecha;
    }

    @GetMapping("/pacientes")
    public String listarPacientes(Model model) {
        List<Paciente> pacientes = pacienteRepository.findAll();
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
        List<Medico> medicos = medicoRepository.findAll();
        long medicosActivos = medicos.stream().filter(m -> "Activo".equals(m.getEstado()) || m.getEstado() == null).count();
        long totalSedes = sedeRepository.count();
        long citasHoy = citaRepository.countByFechaCita(LocalDate.now());

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
            pacienteRepository.save(nuevoPaciente);
            return "redirect:/recepcionista/pacientes?exito";
        } catch (Exception e) {
            return "redirect:/recepcionista/pacientes?error=duplicado";
        }
    }

    @GetMapping("/pagos")
    public String listarPagos(Model model) {
        List<Pago> pagos = pagoRepository.findAll();
        BigDecimal totalRecaudado = pagos.stream()
                .filter(p -> "Completado".equals(p.getEstado()))
                .map(Pago::getMonto)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        model.addAttribute("pagos", pagos);
        model.addAttribute("totalRecaudado", totalRecaudado);
        model.addAttribute("pacientes", pacienteRepository.findAll());
        model.addAttribute("servicios", servicioRepository.findAll());
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
        Paciente paciente = pacienteRepository.findById(pacienteId).orElse(null);
        Servicio servicio = servicioId != null ? servicioRepository.findById(servicioId).orElse(null) : null;
        
        if (paciente != null) {
            // EXPOSICIÓN JHOAN: Explicar que la lógica de negocio pesada (generar el correlativo F001-XXXX) está separada en PagoService, cumpliendo con las buenas prácticas de arquitectura.
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
            pagoRepository.save(nuevoPago);
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

    // EXPOSICIÓN MIGUEL: Consumo Asíncrono de Historial.
    // En lugar de devolver una vista de Thymeleaf, este endpoint devuelve puro JSON (@ResponseBody). 
    // Es consumido vía AJAX (fetch) desde el Dashboard de la recepcionista para cargar historiales dinámicamente sin recargar la página.
    @GetMapping("/pacientes/historial")
    @ResponseBody
    public ResponseEntity<List<Map<String, Object>>> getPacienteHistorial(@RequestParam Integer id) {
        List<Cita> citas = citaRepository.findByPacienteIdOrderByFechaCitaDesc(id);
        List<Map<String, Object>> responseList = citas.stream().map(c -> {
            Map<String, Object> map = new HashMap<>();
            map.put("fecha", c.getFechaCita().toString());
            map.put("hora", c.getHoraCita());
            map.put("medico", "Dr. " + c.getMedico().getNombres() + " " + c.getMedico().getApellidos());
            map.put("servicio", c.getServicio() != null ? c.getServicio().getNombre() : "Particular");
            
            String estado = c.getEstado() != null ? c.getEstado() : "Pendiente";
            map.put("estado", estado);
            
            // Definición de colores según el estado
            String color = "#FEF3C7"; // Amarillo/Ámbar para Pendiente
            String textColor = "#D97706";
            if ("Confirmada".equals(estado)) {
                color = "#DBEAFE"; // Azul
                textColor = "#2563EB";
            } else if ("Completada".equals(estado)) {
                color = "#D1FAE5"; // Verde
                textColor = "#059669";
            } else if ("Cancelada".equals(estado)) {
                color = "#FEE2E2"; // Rojo
                textColor = "#DC2626";
            }
            
            map.put("color", color);
            map.put("textColor", textColor);
            return map;
        }).collect(Collectors.toList());
        return ResponseEntity.ok(responseList);
    }
}
