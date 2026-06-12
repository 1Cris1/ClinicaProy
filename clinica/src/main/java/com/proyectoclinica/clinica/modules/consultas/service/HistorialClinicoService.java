package com.proyectoclinica.clinica.modules.consultas.service;

import com.proyectoclinica.clinica.modules.consultas.models.HistorialClinico;
import com.proyectoclinica.clinica.modules.consultas.repository.HistorialClinicoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class HistorialClinicoService {
    private final HistorialClinicoRepository historialClinicoRepository;

    public List<HistorialClinico> listarPorPaciente(Integer idPaciente) {
        return historialClinicoRepository.findByPacienteIdOrderByFechaRegistroDesc(idPaciente);
    }

    public Optional<HistorialClinico> obtenerPorCita(Integer idCita) {
        return historialClinicoRepository.findByCitaIdCita(idCita);
    }

    @Transactional
    public HistorialClinico guardar(HistorialClinico historialClinico) {
        return historialClinicoRepository.save(historialClinico);
    }
}
