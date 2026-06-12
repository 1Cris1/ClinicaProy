package com.proyectoclinica.clinica.controller;

import com.proyectoclinica.clinica.modules.citas.repository.CitaRepository;
import com.proyectoclinica.clinica.modules.paciente.repository.PacienteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import java.security.Principal;

@ControllerAdvice(assignableTypes = AdminController.class)
@RequiredArgsConstructor
public class AdminGlobalController {
    private final PacienteRepository pacienteRepository;
    private final CitaRepository citaRepository;

    @ModelAttribute
    public void addGlobalAttributes(Model model, Principal principal) {
        if (principal != null) {
            // Total de pacientes registrados
            long totalPacientesGlobal = pacienteRepository.count();
            // Total de citas en el sistema
            long totalCitasGlobal = citaRepository.count();
            model.addAttribute("totalPacientesGlobal", totalPacientesGlobal);
            model.addAttribute("totalCitasGlobal", totalCitasGlobal);
        }
    }
}
