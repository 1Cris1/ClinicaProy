package com.proyectoclinica.clinica.controller;

import com.proyectoclinica.clinica.modules.citas.models.Cita;
import com.proyectoclinica.clinica.modules.citas.repository.CitaRepository;
import com.proyectoclinica.clinica.modules.experiencia.models.FeedbackPaciente;
import com.proyectoclinica.clinica.modules.experiencia.repository.FeedbackPacienteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@Controller
@RequestMapping("/publico/encuesta")
@RequiredArgsConstructor
public class FeedbackController {

    private final CitaRepository citaRepository;
    private final FeedbackPacienteRepository feedbackPacienteRepository;

    @GetMapping
    public String mostrarEncuesta(@RequestParam("idCita") Integer idCita, Model model) {
        Cita cita = citaRepository.findById(idCita).orElse(null);
        if (cita == null) {
            model.addAttribute("error", "Cita no encontrada.");
            return "publico/encuesta-error";
        }

        // Verificar si ya se registró feedback para esta cita
        if (feedbackPacienteRepository.findByCitaIdCita(idCita).isPresent()) {
            model.addAttribute("error", "Esta encuesta ya ha sido completada anteriormente. ¡Muchas gracias por tu tiempo!");
            return "publico/encuesta-error";
        }

        model.addAttribute("cita", cita);
        return "publico/encuesta";
    }

    @PostMapping("/guardar")
    public String guardarFeedback(@RequestParam("idCita") Integer idCita,
                                  @RequestParam("puntuacion") Integer puntuacion,
                                  @RequestParam(value = "comentario", required = false) String comentario,
                                  Model model) {
        Cita cita = citaRepository.findById(idCita).orElse(null);
        if (cita == null) {
            model.addAttribute("error", "Cita no encontrada.");
            return "publico/encuesta-error";
        }

        if (feedbackPacienteRepository.findByCitaIdCita(idCita).isPresent()) {
            model.addAttribute("error", "Esta encuesta ya ha sido completada.");
            return "publico/encuesta-error";
        }

        // Validar rango de puntuación de 1 a 5
        if (puntuacion < 1 || puntuacion > 5) {
            model.addAttribute("error", "La puntuación debe estar entre 1 y 5 estrellas.");
            model.addAttribute("cita", cita);
            return "publico/encuesta";
        }

        FeedbackPaciente feedback = FeedbackPaciente.builder()
                .cita(cita)
                .puntuacion(puntuacion)
                .comentario(comentario)
                .fechaEnvio(LocalDateTime.now())
                .build();

        feedbackPacienteRepository.save(feedback);
        return "publico/encuesta-exito";
    }
}
