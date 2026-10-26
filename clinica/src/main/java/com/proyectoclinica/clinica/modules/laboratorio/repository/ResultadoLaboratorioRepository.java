package com.proyectoclinica.clinica.modules.laboratorio.repository;

import com.proyectoclinica.clinica.modules.laboratorio.models.ResultadoLaboratorio;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface ResultadoLaboratorioRepository extends JpaRepository<ResultadoLaboratorio, Integer> {
    List<ResultadoLaboratorio> findByPacienteIdOrderByFechaExamenDesc(Integer idPaciente);
    long countByPacienteIdAndEstado(Integer idPaciente, String estado);
}

