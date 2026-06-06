package com.proyectoclinica.clinica.modules.consultas.repository;

import com.proyectoclinica.clinica.modules.consultas.models.Receta;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface RecetaRepository extends JpaRepository<Receta, Integer> {
    List<Receta> findByPacienteIdOrderByFechaEmisionDesc(Integer idPaciente);
    List<Receta> findByPacienteIdAndEstadoOrderByFechaEmisionDesc(Integer idPaciente, String estado);
    List<Receta> findByMedicoIdOrderByFechaEmisionDesc(Integer idMedico);
}
