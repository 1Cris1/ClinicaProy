package com.proyectoclinica.clinica.controller;

import com.proyectoclinica.clinica.dto.RecepcionistaDto;
import com.proyectoclinica.clinica.modules.citas.repository.CitaRepository;
import com.proyectoclinica.clinica.modules.seguridad.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import java.security.Principal;
import java.time.LocalDate;

@ControllerAdvice(assignableTypes = RecepcionistaController.class)
@RequiredArgsConstructor
public class RecepcionistaGlobalController {
    private final CitaRepository citaRepository;
    private final UsuarioRepository usuarioRepository;

    @ModelAttribute
    public void addGlobalAttributes(Model model, Principal principal) {
        if (principal != null) {
            String username = principal.getName();
            RecepcionistaDto dto = usuarioRepository.findByUsername(username)
                    .map(u -> {
                        String email = u.getEmail() != null ? u.getEmail() : "-";
                        return new RecepcionistaDto("Recepcionista", u.getUsername(), email, u.getUsername());
                    })
                    .orElse(new RecepcionistaDto("Recepción", "General", "-", "-"));
            
            model.addAttribute("recepcionistaGlobal", dto);
            
            long citasHoyCount = citaRepository.findByFechaCitaOrderByHoraCitaAsc(LocalDate.now())
                    .stream()
                    .filter(c -> "Pendiente".equals(c.getEstado()) || "Confirmada".equals(c.getEstado()))
                    .count();
            model.addAttribute("citasHoyGlobalCount", citasHoyCount);
        }
    }
}
