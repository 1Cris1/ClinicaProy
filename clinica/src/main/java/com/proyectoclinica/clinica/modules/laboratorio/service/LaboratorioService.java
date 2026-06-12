package com.proyectoclinica.clinica.modules.laboratorio.service;

import com.proyectoclinica.clinica.modules.laboratorio.models.ResultadoLaboratorio;
import com.proyectoclinica.clinica.modules.laboratorio.repository.ResultadoLaboratorioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class LaboratorioService {
    private final ResultadoLaboratorioRepository resultadoLaboratorioRepository;

    public List<ResultadoLaboratorio> listarPorPaciente(Integer idPaciente) {
        return resultadoLaboratorioRepository.findByPacienteIdOrderByFechaExamenDesc(idPaciente);
    }

    public long contarPendientesPorPaciente(Integer idPaciente) {
        return resultadoLaboratorioRepository.countByPacienteIdAndEstado(idPaciente, "Pendiente");
    }

    public Optional<ResultadoLaboratorio> obtenerPorId(Integer id) {
        return resultadoLaboratorioRepository.findById(id);
    }

    @Transactional
    public ResultadoLaboratorio guardar(ResultadoLaboratorio resultado) {
        return resultadoLaboratorioRepository.save(resultado);
    }
}
