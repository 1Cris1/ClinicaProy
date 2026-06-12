package com.proyectoclinica.clinica.modules.consultas.repository;

import com.proyectoclinica.clinica.modules.consultas.models.HistorialClinico;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface HistorialClinicoRepository extends JpaRepository<HistorialClinico, Integer> {
    Optional<HistorialClinico> findByCitaIdCita(Integer idCita);
    List<HistorialClinico> findByPacienteIdOrderByFechaRegistroDesc(Integer idPaciente);
}

