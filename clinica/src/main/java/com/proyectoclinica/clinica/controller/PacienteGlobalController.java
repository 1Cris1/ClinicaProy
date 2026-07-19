package com.proyectoclinica.clinica.controller;

import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import com.proyectoclinica.clinica.modules.citas.repository.CitaRepository;
import com.proyectoclinica.clinica.modules.paciente.repository.PacienteRepository;
import com.proyectoclinica.clinica.modules.notificaciones.repository.NotificacionRepository;
import com.proyectoclinica.clinica.modules.laboratorio.repository.ResultadoLaboratorioRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import java.security.Principal;
import java.time.LocalDate;
import java.util.Comparator;

@ControllerAdvice(assignableTypes = PacienteController.class)
@RequiredArgsConstructor
@Slf4j
public class PacienteGlobalController {
    private final CitaRepository citaRepository;
    private final PacienteRepository pacienteRepository;
    private final NotificacionRepository notificacionRepository;
    private final ResultadoLaboratorioRepository resultadoLaboratorioRepository;

    @ModelAttribute
    public void addGlobalAttributes(Model model, Principal principal) {
        if (principal != null) {
            Paciente paciente = pacienteRepository.findByUsuarioUsername(principal.getName()).orElse(null);
            log.debug("Cargando atributos globales para el paciente: {}", principal.getName());
            
            if (paciente != null) {
                // Cantidad de citas pendientes o confirmadas
                long citasPendientes = citaRepository.findByPacienteIdOrderByFechaCitaDesc(paciente.getId())
                        .stream()
                        .filter(c ->
                                "Programada".equals(c.getEstado()) ||
                                "Pendiente".equals(c.getEstado()) ||
                                "Confirmada".equals(c.getEstado())
                                )
                        .count();
                
                model.addAttribute("citasPendientesCount", citasPendientes);

                // Buscar la cita más próxima
                var proximaCita = citaRepository.findByPacienteIdOrderByFechaCitaDesc(paciente.getId())
                        .stream()
                        .filter(c ->
                                ("Programada".equals(c.getEstado()) ||
                                "Pendiente".equals(c.getEstado()) ||
                                "Confirmada".equals(c.getEstado()))
                                &&
                                (c.getFechaCita().isEqual(LocalDate.now())
                                || c.getFechaCita().isAfter(LocalDate.now()))
                                )
                        .min(Comparator.comparing(com.proyectoclinica.clinica.modules.citas.models.Cita::getFechaCita)
                                .thenComparing(com.proyectoclinica.clinica.modules.citas.models.Cita::getHoraCita))
                        .orElse(null);
                
                model.addAttribute("proximaCita", proximaCita);
                model.addAttribute("pacienteGlobal", paciente);

                // Notificaciones
                var notifs = notificacionRepository.findByPacienteIdOrderByFechaDesc(paciente.getId())
                        .stream().limit(5).toList();
                long unread = notificacionRepository.countByPacienteIdAndLeidaFalse(paciente.getId());
                
                model.addAttribute("notificacionesGlobal", notifs);
                model.addAttribute("unreadNotifCount", unread);

                // Resultados de laboratorio listos (estado 'Disponible')
                long resultadosListos = resultadoLaboratorioRepository.countByPacienteIdAndEstado(paciente.getId(), "Disponible");
                model.addAttribute("resultadosListosCount", resultadosListos);
            }
        }
    }
}
