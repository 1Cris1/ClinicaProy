package com.proyectoclinica.clinica.controller;

import com.proyectoclinica.clinica.modules.seguridad.models.Usuario;
import com.proyectoclinica.clinica.service.TwoFactorService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class VerificationController {

    private final TwoFactorService twoFactorService;

    @GetMapping("/verificar-codigo")
    public String mostrarPaginaVerificacion() {
        return "publico/verificar-codigo";
    }

    @PostMapping("/verificar-codigo")
    public String verificarCodigo(@RequestParam String codigo,
                                  HttpSession session) {

        Usuario usuario = (Usuario) session.getAttribute("usuario2FA");

        if (usuario == null) {
            return "redirect:/login";
        }

        boolean valido = twoFactorService.validarCodigo(usuario, codigo);

        if (!valido) {
            return "redirect:/verificar-codigo?error";
        }

        session.setAttribute("otpVerificado", true);

        switch (usuario.getRol()) {

            case ROLE_ADMIN:
                return "redirect:/admin";

            case ROLE_MEDICO:
                return "redirect:/medico/inicio";

            case ROLE_RECEPCIONISTA:
                return "redirect:/recepcionista/inicio";

            case ROLE_PACIENTE:
                return "redirect:/paciente/inicio";

            default:
                return "redirect:/login";
}
    }

}