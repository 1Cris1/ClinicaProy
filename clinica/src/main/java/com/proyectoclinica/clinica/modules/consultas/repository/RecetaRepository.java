package com.proyectoclinica.clinica.modules.consultas.repository;

import com.proyectoclinica.clinica.modules.consultas.models.Receta;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface RecetaRepository extends JpaRepository<Receta, Integer> {
    List<Receta> findByPacienteIdOrderByFechaEmisionDesc(Integer idPaciente);
    List<Receta> findByPacienteIdAndEstadoOrderByFechaEmisionDesc(Integer idPaciente, String estado);
    List<Receta> findByMedicoIdOrderByFechaEmisionDesc(Integer idMedico);
}

