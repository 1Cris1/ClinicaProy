package com.proyectoclinica.clinica.modules.experiencia.service;

import com.proyectoclinica.clinica.modules.citas.models.Cita;
import com.proyectoclinica.clinica.modules.citas.repository.CitaRepository;
import com.proyectoclinica.clinica.modules.experiencia.models.FeedbackPaciente;
import com.proyectoclinica.clinica.modules.experiencia.repository.FeedbackPacienteRepository;
import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import com.proyectoclinica.clinica.modules.recursos.models.Medico;
import com.proyectoclinica.clinica.modules.recursos.repository.MedicoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class FeedbackPacienteService {

    private final FeedbackPacienteRepository feedbackPacienteRepository;
    private final CitaRepository citaRepository;
    private final MedicoRepository medicoRepository;


    public void guardarCalificacion(
        Integer idCita,
        Integer puntuacion,
        String comentario,
        Paciente paciente) {

    // Buscar la cita
    Cita cita = citaRepository.findById(idCita)
            .orElseThrow(() -> new RuntimeException("La cita no existe."));

    // Verificar que la cita pertenezca al paciente autenticado
    if (!cita.getPaciente().getId().equals(paciente.getId())) {
        throw new RuntimeException("No tiene permiso para calificar esta cita.");
    }

    // Verificar que aún no haya sido calificada
    if (feedbackPacienteRepository.findByCitaIdCita(idCita).isPresent()) {
        throw new RuntimeException("Esta cita ya fue calificada.");
    }

    // Crear el feedback
    FeedbackPaciente feedback = FeedbackPaciente.builder()
            .cita(cita)
            .puntuacion(puntuacion)
            .comentario(comentario)
            .build();

    feedbackPacienteRepository.save(feedback);

    // Recalcular el promedio del médico
    Double promedio = feedbackPacienteRepository
            .obtenerPromedioCalificacionMedico(cita.getMedico().getId());

    Medico medico = cita.getMedico();

    medico.setSatisfaccion(promedio);

    medicoRepository.save(medico);
}

}