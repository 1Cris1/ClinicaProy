package com.proyectoclinica.clinica.modules.experiencia.repository;

import com.proyectoclinica.clinica.modules.experiencia.models.FeedbackPaciente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface FeedbackPacienteRepository extends JpaRepository<FeedbackPaciente, Integer> {
    Optional<FeedbackPaciente> findByCitaIdCita(Integer idCita);

    @Query("""
    SELECT AVG(f.puntuacion)
    FROM FeedbackPaciente f
    WHERE f.cita.medico.id = :idMedico
""")
Double obtenerPromedioCalificacionMedico(@Param("idMedico") Integer idMedico);
}
