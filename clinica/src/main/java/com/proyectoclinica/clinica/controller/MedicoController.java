package com.proyectoclinica.clinica.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import com.proyectoclinica.clinica.modules.citas.models.Cita;
import com.proyectoclinica.clinica.modules.recursos.models.Medico;
import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import com.proyectoclinica.clinica.modules.consultas.models.Receta;
import com.proyectoclinica.clinica.modules.consultas.models.MedicamentoPrescrito;
import com.proyectoclinica.clinica.modules.laboratorio.models.OrdenLaboratorio;
import com.proyectoclinica.clinica.modules.citas.repository.CitaRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.MedicoRepository;
import com.proyectoclinica.clinica.modules.consultas.repository.RecetaRepository;
import com.proyectoclinica.clinica.modules.consultas.repository.MedicamentoPrescritoRepository;
import com.proyectoclinica.clinica.modules.laboratorio.repository.OrdenLaboratorioRepository;
import com.proyectoclinica.clinica.config.PowerBiProperties;
import lombok.RequiredArgsConstructor;

import com.proyectoclinica.clinica.modules.laboratorio.models.ExamenCatalogo;
import com.proyectoclinica.clinica.modules.laboratorio.repository.ExamenCatalogoRepository;
import com.proyectoclinica.clinica.modules.consultas.models.HistorialClinico;
import com.proyectoclinica.clinica.modules.consultas.repository.HistorialClinicoRepository;
import com.proyectoclinica.clinica.modules.paciente.repository.PacienteRepository;
import com.proyectoclinica.clinica.modules.laboratorio.service.OrdenLaboratorioPdfService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;


/**
 * Controlador del portal del médico. 
 * * Gestiona las vistas del médico autenticado con datos reales de BD.
 */
@Controller
@RequestMapping("/medico")
@RequiredArgsConstructor
public class MedicoController {
    private static final Logger log = LoggerFactory.getLogger(MedicoController.class);
    private static final String LAYOUT = "layout-medico";

    private final MedicoRepository medicoRepository;
    private final CitaRepository citaRepository;
    private final RecetaRepository recetaRepository;
    private final MedicamentoPrescritoRepository medicamentoPrescritoRepository;
    private final OrdenLaboratorioRepository ordenRepository;
    private final HistorialClinicoRepository historialClinicoRepository;
    private final PacienteRepository pacienteRepository;
    private final ExamenCatalogoRepository examenCatalogoRepository;
    private final OrdenLaboratorioPdfService ordenLaboratorioPdfService;
    private final PowerBiProperties powerBiProperties;

    private Medico getMedicoAutenticado(Principal principal) {
        if (principal == null) return null;
        String identifier = principal.getName();
        return medicoRepository.findByUsuarioUsername(identifier)
                .or(() -> medicoRepository.findByDni(identifier))
                .orElse(null);
    }

    @GetMapping({"", "/"})
    public String root() {
        return "redirect:/medico/inicio";
    }

    @GetMapping("/inicio")
    @Transactional(readOnly = true)
    public String dashboard(Model model, Principal principal) {
        Medico medico = getMedicoAutenticado(principal);
        if (medico == null) return "redirect:/login";

        LocalDate hoy = LocalDate.now();
        // EXPOSICIÓN JHOAN: Aquí usamos Spring Data JPA para filtrar automáticamente las citas de la BD que pertenezcan solo a este Médico y sean del día de hoy.
        List<Cita> citasHoy = citaRepository.findByMedicoIdAndFechaCitaOrderByHoraCitaAsc(medico.getId(), hoy);
        Cita siguienteCita = citaRepository.findSiguienteCitaMedico(medico.getId());

        long atendidosHoy = citaRepository.countByMedicoIdAndEstadoAndFechaCita(medico.getId(), "Completada", hoy);
        long consultasMes = citaRepository.countConsultasMesActual(medico.getId());
        long notasMes     = citaRepository.countNotasMesActual(medico.getId());
        long totalPacientes = citaRepository.countPacientesDistintosByMedico(medico.getId());

        model.addAttribute("medico", medico);
        model.addAttribute("citasHoy", citasHoy);
        model.addAttribute("siguienteCita", siguienteCita);
        model.addAttribute("totalCitasHoy", citasHoy.size());
        model.addAttribute("atendidosHoy", atendidosHoy);
        model.addAttribute("consultasMes", consultasMes);
        model.addAttribute("notasMes", notasMes);
        model.addAttribute("totalPacientes", totalPacientes);

        String powerBiUrl = powerBiProperties.getBase().getUrl() 
            + "&pageName=" + powerBiProperties.getPage().getMedico()
            + "&filter=" + powerBiProperties.getFilter().getTable().getMedicos() + "/id_medico%20eq%20" + medico.getId();
        
        model.addAttribute("powerBiUrl", powerBiUrl);
        model.addAttribute("pageTitle", "Panel");
        model.addAttribute("view", "doctores/dashboard");
        return LAYOUT;
    }



    @GetMapping("/agenda")
    @Transactional(readOnly = true)
public String agenda(Model model, Principal principal) {

    Medico medico = getMedicoAutenticado(principal);

    if (medico == null) {
        return "redirect:/login";
    }

    LocalDate hoy = LocalDate.now();

    List<Cita> citasSemana =
            citaRepository.findByMedicoIdAndFechaCitaOrderByHoraCitaAsc(
                    medico.getId(),
                    hoy
            );

    List<Cita> citasManana = citasSemana.stream()
            .filter(cita -> {
                if (cita.getHoraCita() == null) {
                    return false;
                }

                String hora = cita.getHoraCita().trim();

                if (hora.length() < 5) {
                    return false;
                }

                hora = hora.substring(0, 5);

                return hora.compareTo("12:00") < 0;
            })
            .toList();

    List<Cita> citasTarde = citasSemana.stream()
            .filter(cita -> {
                if (cita.getHoraCita() == null) {
                    return false;
                }

                String hora = cita.getHoraCita().trim();

                if (hora.length() < 5) {
                    return false;
                }

                hora = hora.substring(0, 5);

                return hora.compareTo("13:00") >= 0;
            })
            .toList();
            // Pacientes que ya llegaron y están en sala de espera.
List<Cita> pacientesEnSala = citasSemana.stream()
        .filter(cita -> "Confirmada".equalsIgnoreCase(cita.getEstado()))
        .toList();

            

    model.addAttribute("medico", medico);
    model.addAttribute("citasSemana", citasSemana);
    model.addAttribute("citasManana", citasManana);
    model.addAttribute("citasTarde", citasTarde);
    model.addAttribute("pacientesEnSala", pacientesEnSala);
    model.addAttribute("totalPacientesEnSala", pacientesEnSala.size());

    model.addAttribute(
            "fechaFormateada",
            hoy.format(DateTimeFormatter.ofPattern("dd MMMM yyyy"))
    );

    model.addAttribute("pageTitle", "Mi Agenda");
    model.addAttribute("view", "doctores/agenda");

    return LAYOUT;
}


    @GetMapping("/consulta")
@Transactional(readOnly = true)
public String consulta(
        @RequestParam(required = false) Integer idCita,
        Model model,
        Principal principal) {

    Medico medico = getMedicoAutenticado(principal);

    if (medico == null) {
        return "redirect:/login";
    }

    Cita cita;

    if (idCita != null) {
        cita = citaRepository.findById(idCita)
                .filter(c -> c.getMedico() != null
                        && c.getMedico().getId().equals(medico.getId()))
                .orElse(null);
    } else {
        cita = citaRepository.findSiguienteCitaMedico(medico.getId());
    }

    Integer edadPaciente = null;
    if (cita != null && cita.getPaciente() != null && cita.getPaciente().getFechaNacimiento() != null) {
        edadPaciente = Period.between(
                cita.getPaciente().getFechaNacimiento(),
                LocalDate.now()
        ).getYears();
    }

    model.addAttribute("medico", medico);
    model.addAttribute("cita", cita);
    model.addAttribute("edadPaciente", edadPaciente);
    model.addAttribute("pageTitle", "Consulta Activa");
    model.addAttribute("view", "doctores/consulta");

    return LAYOUT;
}

    
    @PostMapping("/consulta/completar")
    @Transactional
    public String completarConsulta(@RequestParam Integer idCita,
        @RequestParam(required = false) Double peso,
        @RequestParam(required = false) Double talla,
        @RequestParam(required = false) Double temperatura,
        @RequestParam(required = false) String presion,
        @RequestParam(required = false) String notasMedicas,
        @RequestParam(required = false) String diagnostico_cie10,
        @RequestParam(value = "med_nombre", required = false) List<String> medNombres,
        @RequestParam(value = "med_dosis", required = false) List<String> medDosis,
        @RequestParam(value = "med_frecuencia", required = false) List<String> medFrecuencias,
        @RequestParam(value = "med_duracion", required = false) List<String> medDuraciones,
        @RequestParam(value = "med_instrucciones", required = false) List<String> medInstrucciones,
        Principal principal) {
        
        Medico medico = getMedicoAutenticado(principal);

    if (medico == null) {
        return "redirect:/login";
    }

    Cita cita = citaRepository.findById(idCita).orElse(null);

    if (cita == null
            || cita.getMedico() == null
            || !cita.getMedico().getId().equals(medico.getId())) {

        return "redirect:/medico/agenda?error=cita";
    }

    cita.setEstado("Completada");

    if (notasMedicas != null && !notasMedicas.isBlank()) {
        cita.setNotasMedicas(notasMedicas);
    }

    citaRepository.save(cita);

    HistorialClinico historial = historialClinicoRepository
            .findByCitaIdCita(idCita)
            .orElse(null);

    if (historial == null) {
        historial = HistorialClinico.builder()
                .paciente(cita.getPaciente())
                .cita(cita)
                .build();
    }

    historial.setPeso(peso);
    historial.setTalla(talla);
    historial.setTemperatura(temperatura);
    historial.setPresionArterial(presion);
    historial.setObservaciones(notasMedicas);
    historial.setDiagnostico(diagnostico_cie10);
    historial.setCodigoDiagnostico(diagnostico_cie10);
    historial.setTratamiento("Tratamiento registrado durante la consulta");

    historialClinicoRepository.save(historial);

    if (medNombres != null && !medNombres.isEmpty()) {

        Receta receta = Receta.builder()
                .codigo("R-" + System.currentTimeMillis() % 1000000)
                .paciente(cita.getPaciente())
                .medico(medico)
                .fechaEmision(LocalDate.now())
                .estado("Activa")
                .build();

        receta = recetaRepository.save(receta);

        for (int i = 0; i < medNombres.size(); i++) {

            String nombre = medNombres.get(i);

            if (nombre != null && !nombre.isBlank()) {

                MedicamentoPrescrito medicamento =
                        MedicamentoPrescrito.builder()
                                .receta(receta)
                                .nombre(nombre)
                                .dosis(
                                        medDosis != null && medDosis.size() > i
                                                ? medDosis.get(i)
                                                : ""
                                )
                                .frecuencia(
                                        medFrecuencias != null && medFrecuencias.size() > i
                                                ? medFrecuencias.get(i)
                                                : ""
                                )
                                .duracion(
                                        medDuraciones != null && medDuraciones.size() > i
                                                ? medDuraciones.get(i)
                                                : ""
                                )
                                .instrucciones(
                                        medInstrucciones != null && medInstrucciones.size() > i
                                                ? medInstrucciones.get(i)
                                                : ""
                                )
                                .build();

                medicamentoPrescritoRepository.save(medicamento);
            }
        }
    }

    log.info(
            "[Médico] Consulta {} completada por {}",
            idCita,
            medico.getNombres()
    );

    return "redirect:/medico/agenda?consulta=finalizada";

    }

    @GetMapping("/pacientes")
    public String pacientes(Model model, Principal principal) {
        Medico medico = getMedicoAutenticado(principal);
        if (medico == null) return "redirect:/login";

        List<Paciente> misPacientes = citaRepository.findPacientesByMedico(medico.getId());
        model.addAttribute("medico", medico);
        model.addAttribute("pacientes", misPacientes);
        model.addAttribute("totalPacientes", misPacientes.size());
        model.addAttribute("pageTitle", "Mis Pacientes");
        model.addAttribute("view", "doctores/pacientes");
        return LAYOUT;
    }
    
    /**Obtiene al médico que inició sesión.
Busca al paciente por su identificador.
Verifica que ese paciente realmente haya sido atendido por el médico.
Consulta el historial clínico del paciente.
Envía los datos a Thymeleaf.
Muestra la nueva pantalla. */
    @GetMapping("/pacientes/{idPaciente}/historial")
    @Transactional(readOnly = true)
    public String historialPaciente(
        @PathVariable Integer idPaciente,
        Model model,
        Principal principal) {

    Medico medico = getMedicoAutenticado(principal);

    if (medico == null) {
        return "redirect:/login";
    }

    Paciente paciente = pacienteRepository.findById(idPaciente)
            .orElse(null);

    if (paciente == null) {
        return "redirect:/medico/pacientes?error=paciente";
    }

    List<Paciente> pacientesDelMedico =
            citaRepository.findPacientesByMedico(medico.getId());

    boolean perteneceAlMedico = pacientesDelMedico.stream()
            .anyMatch(p -> p.getId().equals(idPaciente));

    if (!perteneceAlMedico) {
        return "redirect:/medico/pacientes?error=acceso";
    }

    List<HistorialClinico> historiales =
            historialClinicoRepository
                    .findByPacienteIdOrderByFechaRegistroDesc(idPaciente);

    model.addAttribute("medico", medico);
    model.addAttribute("paciente", paciente);
    model.addAttribute("historiales", historiales);
    model.addAttribute("totalHistoriales", historiales.size());
    model.addAttribute("pageTitle", "Historial Clínico");
    model.addAttribute("view", "doctores/historial-paciente");

    return LAYOUT;
}

    /**
     * HISTORIA DE USUARIO: Solicitud de Órdenes de Laboratorio
     * Integrante: 3
     */
    @GetMapping("/laboratorio")
    @Transactional(readOnly = true)
    public String laboratorio(Model model, Principal principal) {
        Medico medico = getMedicoAutenticado(principal);
        if (medico == null) {
            return "redirect:/login";
        }

    List<OrdenLaboratorio> ordenes =
            ordenRepository.findByMedicoIdOrderByFechaSolicitudDesc(
                    medico.getId()
            );

    List<ExamenCatalogo> examenes =
            examenCatalogoRepository.findAll();

    List<Paciente> pacientes =
            citaRepository.findPacientesByMedico(medico.getId());

    if (!ordenes.isEmpty()) {
        Paciente pacienteSeleccionado =
                ordenes.get(0).getPaciente();

        model.addAttribute(
                "pacienteSeleccionado",
                pacienteSeleccionado
        );
    }

    model.addAttribute("medico", medico);
    model.addAttribute("ordenes", ordenes);
    model.addAttribute("examenes", examenes);
    model.addAttribute("pacientes", pacientes);
    model.addAttribute("pageTitle", "Laboratorio Clínico");
    model.addAttribute("view", "doctores/laboratorio");

    return LAYOUT;
}

@PostMapping("/laboratorio/solicitar")
@Transactional
public String solicitarExamen(
        @RequestParam Integer idPaciente,
        @RequestParam Integer idExamen,
        @RequestParam String prioridad,
        @RequestParam(required = false) String observaciones,
        Principal principal) {

    Medico medico = getMedicoAutenticado(principal);

    if (medico == null) {
        return "redirect:/login";
    }

    Paciente paciente = pacienteRepository.findById(idPaciente)
            .orElse(null);

    ExamenCatalogo examen = examenCatalogoRepository.findById(idExamen)
            .orElse(null);

    if (paciente == null || examen == null) {
        return "redirect:/medico/laboratorio?error=datos";
    }

    boolean perteneceAlMedico =
            citaRepository.findPacientesByMedico(medico.getId())
                    .stream()
                    .anyMatch(p -> p.getId().equals(idPaciente));

    if (!perteneceAlMedico) {
        return "redirect:/medico/laboratorio?error=acceso";
    }

    OrdenLaboratorio orden = OrdenLaboratorio.builder()
            .paciente(paciente)
            .medico(medico)
            .examen(examen)
            .prioridad(prioridad)
            .estado("Pendiente de toma")
            .observacionesTecnicas(observaciones)
            .build();

    ordenRepository.save(orden);

    return "redirect:/medico/laboratorio?solicitud=ok";
}


@GetMapping("/laboratorio/orden/{idOrden}/pdf")
@Transactional(readOnly = true)
public ResponseEntity<byte[]> descargarOrdenLaboratorioPdf(
        @PathVariable Integer idOrden,
        Principal principal) {

    Medico medico = getMedicoAutenticado(principal);

    if (medico == null) {
        return ResponseEntity.status(401).build();
    }

    OrdenLaboratorio orden = ordenRepository.findById(idOrden)
            .orElse(null);

    if (orden == null) {
        return ResponseEntity.notFound().build();
    }

    if (orden.getMedico() == null
            || !orden.getMedico().getId().equals(medico.getId())) {

        return ResponseEntity.status(403).build();
    }

    byte[] archivo =
            ordenLaboratorioPdfService.generarPdf(orden);

    String nombre =
            "solicitud-laboratorio-ORD-"
                    + orden.getId()
                    + ".pdf";

    return ResponseEntity.ok()
            .header(
                    HttpHeaders.CONTENT_DISPOSITION,
                    "attachment; filename=\"" + nombre + "\""
            )
            .contentType(MediaType.APPLICATION_PDF)
            .body(archivo);
}


    @GetMapping("/recetas")
    public String recetas(Model model, Principal principal) {
        Medico medico = getMedicoAutenticado(principal);
        if (medico == null) return "redirect:/login";

        List<Receta> historialRecetas = recetaRepository.findByMedicoIdOrderByFechaEmisionDesc(medico.getId());
        model.addAttribute("medico", medico);
        model.addAttribute("historialRecetas", historialRecetas);
        model.addAttribute("pageTitle", "Historial de Recetas");
        model.addAttribute("view", "doctores/recetas");
        return LAYOUT;
    }

    @GetMapping("/perfil")
    public String perfil(Model model, Principal principal) {
        Medico medico = getMedicoAutenticado(principal);
        if (medico == null) return "redirect:/login";

        model.addAttribute("medico", medico);
        model.addAttribute("pageTitle", "Mi Perfil");
        model.addAttribute("view", "doctores/perfil");
        return LAYOUT;
    }

    // EXPOSICIÓN JHOAN: Gestión de Turnos y Horarios Médicos (UPDATE)
    // El médico actualiza su propia disponibilidad desde su perfil. El controlador captura los datos, busca su entidad y hace un save().
    @org.springframework.transaction.annotation.Transactional
    @PostMapping("/horario/actualizar")
public String actualizarHorario(@RequestParam(required = false) String horarioLv,
                                @RequestParam(required = false) String horarioSabado,
                                @RequestParam(required = false) Integer duracionCita,
                                @RequestParam(required = false) Boolean atenderSabado,
                                Principal principal) {

    Medico medico = getMedicoAutenticado(principal);

    if (medico == null) {
        return "redirect:/login";
    }

    medico.setHorarioLv(
            horarioLv != null && !horarioLv.isBlank()
                    ? horarioLv
                    : "No disponible"
    );

    if (Boolean.TRUE.equals(atenderSabado)) {

        medico.setHorarioSabado(
                horarioSabado != null && !horarioSabado.isBlank()
                        ? horarioSabado
                        : "No disponible"
        );

    } else {

        medico.setHorarioSabado("No disponible");

    }

    if (duracionCita != null && duracionCita > 0) {
        medico.setDuracionCita(duracionCita);
    }

    medicoRepository.save(medico);

    return "redirect:/medico/perfil?success=true";
}


    @GetMapping("/configuracion")
    public String configuracion(Model model, Principal principal) {
        Medico medico = getMedicoAutenticado(principal);
        if (medico == null) return "redirect:/login";

        model.addAttribute("medico", medico);
        model.addAttribute("pageTitle", "Configuración");
        model.addAttribute("view", "doctores/configuracion");
        return LAYOUT;
    }

    @GetMapping("/api/paciente/historial")
    @ResponseBody
    public ResponseEntity<List<Map<String, Object>>> getPacienteHistorial(@RequestParam Integer idPaciente) {
        List<Cita> historial = citaRepository.findByPacienteIdOrderByFechaCitaDesc(idPaciente);
        return ResponseEntity.ok(historial.stream()
            .filter(c -> "Completada".equals(c.getEstado()))
            .map(c -> {
                Map<String, Object> map = new HashMap<>();
                map.put("fecha", c.getFechaCita().toString());
                map.put("medico", c.getMedico().getNombres() + " " + c.getMedico().getApellidos());
                map.put("especialidad", c.getMedico().getEspecialidad().getNombre());
                map.put("notas", c.getNotasMedicas());
                map.put("diagnostico", c.getHistorial() != null ? c.getHistorial().getDiagnostico() : "N/A");
                return map;
            }).collect(Collectors.toList()));
    }
}
