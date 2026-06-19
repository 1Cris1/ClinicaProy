package com.proyectoclinica.clinica.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
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
    public String agenda(Model model, Principal principal) {
        Medico medico = getMedicoAutenticado(principal);
        if (medico == null) return "redirect:/login";

        LocalDate hoy = LocalDate.now();
        List<Cita> citasSemana = citaRepository.findByMedicoIdAndFechaCitaOrderByHoraCitaAsc(medico.getId(), hoy);
        
        model.addAttribute("medico", medico);
        model.addAttribute("citasSemana", citasSemana);
        model.addAttribute("fechaFormateada", hoy.format(DateTimeFormatter.ofPattern("dd MMMM yyyy")));
        model.addAttribute("pageTitle", "Mi Agenda");
        model.addAttribute("view", "doctores/agenda");
        return LAYOUT;
    }

    @GetMapping("/consulta")
    public String consulta(Model model, Principal principal) {
        Medico medico = getMedicoAutenticado(principal);
        if (medico == null) return "redirect:/login";

        Cita siguienteCita = citaRepository.findSiguienteCitaMedico(medico.getId());
        model.addAttribute("medico", medico);
        model.addAttribute("cita", siguienteCita);
        model.addAttribute("pageTitle", "Consulta Activa");
        model.addAttribute("view", "doctores/consulta");
        return LAYOUT;
    }

    
    @PostMapping("/consulta/completar")
    @Transactional
    public String completarConsulta(@RequestParam Integer idCita,
                                    @RequestParam(required = false) String notasMedicas,
                                    @RequestParam(value = "med_nombre", required = false) List<String> medNombres,
                                    @RequestParam(value = "med_dosis", required = false) List<String> medDosis,
                                    @RequestParam(value = "med_frecuencia", required = false) List<String> medFrecuencias,
                                    @RequestParam(value = "med_duracion", required = false) List<String> medDuraciones,
                                    @RequestParam(value = "med_instrucciones", required = false) List<String> medInstrucciones,
                                    Principal principal) {
        
        Medico medico = getMedicoAutenticado(principal);
        if (medico == null) return "redirect:/login";

        Cita cita = citaRepository.findById(idCita).orElse(null);
        if (cita != null && cita.getMedico().getId().equals(medico.getId())) {
            cita.setEstado("Completada");
            // EXPOSICIÓN JHOAN: (US 17) Aquí capturamos las notas médicas del formulario para registrar la evolución del paciente en la base de datos.
            if (notasMedicas != null && !notasMedicas.isBlank()) {
                cita.setNotasMedicas(notasMedicas);
            }
            citaRepository.save(cita);

            if (medNombres != null && !medNombres.isEmpty()) {
                Receta receta = Receta.builder()
                        .codigo("R-" + System.currentTimeMillis() % 1000000)
                        .paciente(cita.getPaciente())
                        .medico(medico)
                        .fechaEmision(LocalDate.now())
                        .estado("Activa")
                        .build();
                
                receta = recetaRepository.save(receta);
                // EXPOSICIÓN JHOAN: (US 17) Iteramos sobre las listas de medicamentos que se agregaron dinámicamente en el frontend y los asociamos a la nueva Receta digital.
                for (int i = 0; i < medNombres.size(); i++) {
                    if (medNombres.get(i) != null && !medNombres.get(i).isBlank()) {
                        MedicamentoPrescrito mp = MedicamentoPrescrito.builder()
                                .receta(receta)
                                .nombre(medNombres.get(i))
                                .dosis(medDosis != null && medDosis.size() > i ? medDosis.get(i) : "")
                                .frecuencia(medFrecuencias != null && medFrecuencias.size() > i ? medFrecuencias.get(i) : "")
                                .duracion(medDuraciones != null && medDuraciones.size() > i ? medDuraciones.get(i) : "")
                                .instrucciones(medInstrucciones != null && medInstrucciones.size() > i ? medInstrucciones.get(i) : "")
                                .build();
                        medicamentoPrescritoRepository.save(mp);
                    }
                }
            }
            log.info("[Médico] Cita {} completada por {}", idCita, medico.getNombres());
        }
        return "redirect:/medico/inicio?exito";
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

    /**
     * HISTORIA DE USUARIO: Solicitud de Órdenes de Laboratorio
     * Integrante: 3
     */
    @GetMapping("/laboratorio")
    public String laboratorio(Model model, Principal principal) {
        Medico medico = getMedicoAutenticado(principal);
        if (medico == null) return "redirect:/login";

        List<OrdenLaboratorio> ordenes = ordenRepository.findByMedicoIdOrderByFechaSolicitudDesc(medico.getId());
        
        if (!ordenes.isEmpty()) {
            Paciente p = ordenes.get(0).getPaciente();
            model.addAttribute("pacienteSeleccionado", p);
        }
        
        model.addAttribute("medico", medico);
        model.addAttribute("ordenes", ordenes);
        model.addAttribute("pageTitle", "Laboratorio Clínico");
        model.addAttribute("view", "doctores/laboratorio");
        return LAYOUT;
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
    public String actualizarHorario(@RequestParam(required = false) String inicioLv,
                                    @RequestParam(required = false) String finLv,
                                    @RequestParam(required = false) Boolean noLv,
                                    @RequestParam(required = false) String inicioSabado,
                                    @RequestParam(required = false) String finSabado,
                                    @RequestParam(required = false) Boolean noSabado,
                                    @RequestParam(required = false) Integer duracionCita,
                                    Principal principal) {
        Medico medico = getMedicoAutenticado(principal);
        if (medico == null) return "redirect:/login";

        if (noLv != null && noLv) {
            medico.setHorarioLv("No disponible");
        } else if (inicioLv != null && !inicioLv.isBlank() && finLv != null && !finLv.isBlank()) {
            medico.setHorarioLv(inicioLv + " - " + finLv);
        } else {
            medico.setHorarioLv("No disponible");
        }

        if (noSabado != null && noSabado) {
            medico.setHorarioSabado("No disponible");
        } else if (inicioSabado != null && !inicioSabado.isBlank() && finSabado != null && !finSabado.isBlank()) {
            medico.setHorarioSabado(inicioSabado + " - " + finSabado);
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
