package com.proyectoclinica.clinica.modules.consultas.repository;

import com.proyectoclinica.clinica.modules.consultas.models.HistorialClinico;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface HistorialClinicoRepository extends JpaRepository<HistorialClinico, Integer> {
    Optional<HistorialClinico> findByCitaIdCita(Integer idCita);
    List<HistorialClinico> findByPacienteIdOrderByFechaRegistroDesc(Integer idPaciente);
}
