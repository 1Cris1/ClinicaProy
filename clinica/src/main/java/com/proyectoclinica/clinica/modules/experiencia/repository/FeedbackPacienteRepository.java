package com.proyectoclinica.clinica.modules.experiencia.repository;

import com.proyectoclinica.clinica.modules.experiencia.models.FeedbackPaciente;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface FeedbackPacienteRepository extends JpaRepository<FeedbackPaciente, Integer> {
    Optional<FeedbackPaciente> findByCitaIdCita(Integer idCita);
}

