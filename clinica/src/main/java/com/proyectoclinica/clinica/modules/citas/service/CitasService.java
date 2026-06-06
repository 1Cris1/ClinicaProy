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

    public Optional<Cita> obtenerPorId(Integer id) {
        return citaRepository.findById(id);
    }

    @Transactional
    public Cita guardar(Cita cita) {
        return citaRepository.save(cita);
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
}
