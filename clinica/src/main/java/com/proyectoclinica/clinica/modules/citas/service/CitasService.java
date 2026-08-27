package com.proyectoclinica.clinica.modules.citas.service;

import com.proyectoclinica.clinica.modules.citas.models.Cita;
import com.proyectoclinica.clinica.modules.citas.repository.CitaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CitasService {
    private final CitaRepository citaRepository;

    public List<Cita> listarCitasPorFecha(LocalDate fecha) {
        return citaRepository.findByFechaCitaOrderByHoraCitaAsc(fecha);
    }

    public List<Cita> listarCitasPorMedicoYFecha(Integer idMedico, LocalDate fecha) {
        return citaRepository.findByMedicoIdAndFechaCitaOrderByHoraCitaAsc(idMedico, fecha);
    }

    public List<Cita> listarCitasPorPaciente(Integer idPaciente) {
        return citaRepository.findByPacienteIdOrderByFechaCitaDesc(idPaciente);
    }

    public List<Cita> listarCitasCompletadasPorPaciente(Integer idPaciente) {
        return citaRepository.findByPacienteIdAndEstadoOrderByFechaCitaDesc(idPaciente, "Completada");
    }

    public Cita obtenerProximaCita(Integer idPaciente) {
        return citaRepository.findProximaCita(idPaciente);
    }

    public long contarCitasPendientes(Integer idPaciente) {
        return citaRepository.countCitasPendientes(idPaciente);
    }

    public long contarConsultasAnioActual(Integer idPaciente) {
        return citaRepository.countConsultasAnioActual(idPaciente);
    }



    public Cita obtenerSiguienteCitaMedico(Integer idMedico) {
        return citaRepository.findSiguienteCitaMedico(idMedico);
    }

    public long contarAtendidosMedicoPorFecha(Integer idMedico, LocalDate fecha) {
        return citaRepository.countByMedicoIdAndEstadoAndFechaCita(idMedico, "Completada", fecha);
    }

    public long contarConsultasMesActualMedico(Integer idMedico) {
        return citaRepository.countConsultasMesActual(idMedico);
    }

    public long contarNotasMesActualMedico(Integer idMedico) {
        return citaRepository.countNotasMesActual(idMedico);
    }

    public long contarPacientesDistintosMedico(Integer idMedico) {
        return citaRepository.countPacientesDistintosByMedico(idMedico);
    }

    public List<com.proyectoclinica.clinica.modules.paciente.models.Paciente> listarPacientesDeMedico(Integer idMedico) {
        return citaRepository.findPacientesByMedico(idMedico);
    }

    public Optional<Cita> obtenerPorId(Integer id) {
        return citaRepository.findById(id);
    }

    @Transactional
    public Cita guardar(Cita cita) {
        return citaRepository.save(cita);
    }

    @Transactional
    public boolean checkIn(Integer idCita) {
        return citaRepository.findById(idCita).map(cita -> {
            if ("Pendiente".equals(cita.getEstado())) {
                cita.setEstado("Confirmada");
                citaRepository.save(cita);
                return true;
            }
            return false;
        }).orElse(false);
    }

    public boolean existeConflicto(Integer medicoId, LocalDate fecha, String hora) {
        return citaRepository.existsByMedicoIdAndFechaCitaAndHoraCitaAndEstadoNot(
                medicoId, fecha, hora, "Cancelada"
        );
    }

    public boolean existeConflictoEdicion(Integer medicoId, LocalDate fecha, String hora, Integer idCita) {
        return citaRepository.existsByMedicoIdAndFechaCitaAndHoraCitaAndEstadoNotAndIdCitaNot(
                medicoId, fecha, hora, "Cancelada", idCita
        );
    }

    @Transactional
    public void actualizarEstado(Integer idCita, String nuevoEstado) {
        citaRepository.findById(idCita).ifPresent(cita -> {
            cita.setEstado(nuevoEstado);
            citaRepository.save(cita);
        });
    }

    public long contarCitasHoy() {
        return citaRepository.countByFechaCita(LocalDate.now());
    }

    public long contarAtendidosHoy() {
        return citaRepository.countByEstadoAndFechaCita("Completada", LocalDate.now());
    }
    
    public long contarCancelacionesHoy() {
        return citaRepository.countByEstadoAndFechaCita("Cancelada", LocalDate.now());
    }

    @Transactional
    public Cita agendarCita(com.proyectoclinica.clinica.modules.paciente.models.Paciente paciente,
                            com.proyectoclinica.clinica.modules.recursos.models.Medico medico,
                            com.proyectoclinica.clinica.modules.recursos.models.Servicio servicio,
                            LocalDate fecha, String hora, String observaciones) {
        
        if (existeConflicto(medico.getId(), fecha, hora)) {
            throw new IllegalStateException("Horario ocupado");
        }

        Cita nuevaCita = Cita.builder()
                .paciente(paciente)
                .medico(medico)
                .servicio(servicio)
                .fechaCita(fecha)
                .horaCita(hora)
                .estado("Pendiente")
                .motivo(observaciones)
                .fechaRegistro(java.time.LocalDateTime.now())
                .build();
        
        return citaRepository.save(nuevaCita);
    }

    @Transactional
    public void editarCita(Integer idCita, LocalDate fecha, String hora, String estado, String observaciones) {
        citaRepository.findById(idCita).ifPresent(cita -> {
            if (existeConflictoEdicion(cita.getMedico().getId(), fecha, hora, idCita)) {
                throw new IllegalStateException("Horario ocupado");
            }
            cita.setFechaCita(fecha);
            cita.setHoraCita(hora);
            cita.setEstado(estado);
            if (observaciones != null) cita.setMotivo(observaciones);
            citaRepository.save(cita);
        });
    }

    @Transactional
    public void reagendarCitaPaciente(Integer idCita, Integer idPacienteSolicitante,
                                       com.proyectoclinica.clinica.modules.recursos.models.Medico nuevoMedico,
                                       LocalDate fecha, String hora) {
        Cita cita = citaRepository.findById(idCita)
                .orElseThrow(() -> new IllegalStateException("Cita no encontrada"));

        if (!cita.getPaciente().getId().equals(idPacienteSolicitante)) {
            throw new SecurityException("No tiene permiso para modificar esta cita");
        }

        Integer medicoId = nuevoMedico != null ? nuevoMedico.getId() : cita.getMedico().getId();
        if (existeConflictoEdicion(medicoId, fecha, hora, idCita)) {
            throw new IllegalStateException("Horario ocupado");
        }

        if (nuevoMedico != null) {
            cita.setMedico(nuevoMedico);
        }
        cita.setFechaCita(fecha);
        cita.setHoraCita(hora);
        cita.setEstado("Pendiente");
        citaRepository.save(cita);
    }
}
