package com.proyectoclinica.clinica.modules.laboratorio.service;

import com.proyectoclinica.clinica.modules.laboratorio.models.ResultadoLaboratorio;
import com.proyectoclinica.clinica.modules.laboratorio.models.OrdenLaboratorio;
import com.proyectoclinica.clinica.modules.laboratorio.models.ExamenCatalogo;
import com.proyectoclinica.clinica.modules.laboratorio.repository.ResultadoLaboratorioRepository;
import com.proyectoclinica.clinica.modules.laboratorio.repository.OrdenLaboratorioRepository;
import com.proyectoclinica.clinica.modules.laboratorio.repository.ExamenCatalogoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class LaboratorioService {
    private final ResultadoLaboratorioRepository resultadoLaboratorioRepository;
    private final OrdenLaboratorioRepository ordenLaboratorioRepository;
    private final ExamenCatalogoRepository examenCatalogoRepository;

    public List<ExamenCatalogo> listarExamenesCatalogo() {
        return examenCatalogoRepository.findAll();
    }

    public ExamenCatalogo obtenerExamenPorId(Integer idExamen) {
        return examenCatalogoRepository.findById(idExamen).orElse(null);
    }

    public List<OrdenLaboratorio> listarOrdenesPorMedico(Integer medicoId) {
        return ordenLaboratorioRepository.findByMedicoIdOrderByFechaSolicitudDesc(medicoId);
    }

    public OrdenLaboratorio obtenerOrdenPorId(Integer idOrden) {
        return ordenLaboratorioRepository.findById(idOrden).orElse(null);
    }

    @Transactional
    public OrdenLaboratorio guardarOrden(OrdenLaboratorio orden) {
        return ordenLaboratorioRepository.save(orden);
    }

    public List<ResultadoLaboratorio> listarResultadosPorPaciente(Integer idPaciente) {
        return resultadoLaboratorioRepository.findByPacienteIdOrderByFechaExamenDesc(idPaciente);
    }

    public long contarResultadosListos(Integer idPaciente) {
        return resultadoLaboratorioRepository.countByPacienteIdAndEstado(idPaciente, "Disponible");
    }

    public long contarPendientesPorPaciente(Integer idPaciente) {
        return resultadoLaboratorioRepository.countByPacienteIdAndEstado(idPaciente, "En proceso");
    }

    public Optional<ResultadoLaboratorio> obtenerPorId(Integer id) {
        return resultadoLaboratorioRepository.findById(id);
    }

    @Transactional
    public ResultadoLaboratorio guardar(ResultadoLaboratorio resultado) {
        return resultadoLaboratorioRepository.save(resultado);
    }
}
