package com.proyectoclinica.clinica.controller;

import com.proyectoclinica.clinica.modules.recursos.models.Medico;
import com.proyectoclinica.clinica.modules.citas.repository.CitaRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.MedicoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import java.security.Principal;
import java.time.LocalDate;
@ControllerAdvice(assignableTypes = MedicoController.class)
@RequiredArgsConstructor
public class MedicoGlobalController {
    private final CitaRepository citaRepository;
    private final MedicoRepository medicoRepository;
    @ModelAttribute
    public void addGlobalAttributes(Model model, Principal principal) {
        if (principal != null) {
            String identifier = principal.getName();
            Medico medico = medicoRepository.findByUsuarioUsername(identifier)
                    .or(() -> medicoRepository.findByDni(identifier))
                    .orElse(null);
            if (medico != null) {
                // Cantidad de citas para hoy
                long citasHoyCount = citaRepository.countByMedicoIdAndFechaCita(medico.getId(), LocalDate.now());
                model.addAttribute("citasHoyCount", citasHoyCount);
                
                // Mantenemos el objeto medico globalmente para el sidebar (avatar, nombre, etc)
                model.addAttribute("medicoGlobal", medico);
            }
        }
    }
}
