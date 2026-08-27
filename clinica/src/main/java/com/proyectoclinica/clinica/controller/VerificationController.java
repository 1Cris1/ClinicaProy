package com.proyectoclinica.clinica.controller;

import com.proyectoclinica.clinica.modules.seguridad.models.Usuario;
import com.proyectoclinica.clinica.service.TwoFactorService;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Cookie;
import lombok.RequiredArgsConstructor;
import java.util.UUID;
import com.proyectoclinica.clinica.modules.seguridad.models.DispositivoConfianza;
import com.proyectoclinica.clinica.modules.seguridad.repository.DispositivoConfianzaRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
public class VerificationController {

    private final TwoFactorService twoFactorService;
    private final DispositivoConfianzaRepository dispositivoConfianzaRepository;

    @GetMapping("/verificar-codigo")
    public String mostrarPaginaVerificacion(@RequestParam(value = "error", required = false) String error,
                                            Model model) {
        if (error != null) {
            model.addAttribute("error", "El código ingresado es incorrecto o ha expirado.");
        }
        return "publico/verificar-codigo";
    }

    @PostMapping("/verificar-codigo")
    public String verificarCodigo(@RequestParam String codigo,
                                  @RequestParam(required = false, defaultValue = "false") boolean recordarDispositivo,
                                  HttpSession session, HttpServletRequest request, HttpServletResponse response) {

        Usuario usuario = (Usuario) session.getAttribute("usuario2FA");

        if (usuario == null) {
            return "redirect:/login";
        }

        boolean valido = twoFactorService.validarCodigo(usuario, codigo);

        if (!valido) {
            return "redirect:/verificar-codigo?error";
        }

        session.setAttribute("otpVerificado", true);

        // Guardar dispositivo de confianza si el usuario lo desea o por defecto para doctores/admins
        if (recordarDispositivo || usuario.getRol() == com.proyectoclinica.clinica.modules.seguridad.models.Rol.ROLE_ADMIN || usuario.getRol() == com.proyectoclinica.clinica.modules.seguridad.models.Rol.ROLE_MEDICO) {
            String cookieValue = UUID.randomUUID().toString();
            Cookie cookie = new Cookie("CLINICX_TRUSTED_DEVICE", cookieValue);
            cookie.setPath("/");
            cookie.setMaxAge(30 * 24 * 60 * 60); // 30 días
            cookie.setHttpOnly(true);
            response.addCookie(cookie);

            DispositivoConfianza dispositivo = DispositivoConfianza.builder()
                .usuario(usuario)
                .deviceCookieId(cookieValue)
                .userAgent(request.getHeader("User-Agent") != null ? request.getHeader("User-Agent") : "Unknown")
                .ipAddress(request.getRemoteAddr() != null ? request.getRemoteAddr() : "Unknown")
                .build();
            dispositivoConfianzaRepository.save(dispositivo);
        }

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

    @GetMapping("/reenviar-codigo")
    public String reenviarCodigo(HttpSession session, RedirectAttributes redirectAttributes) {
        Usuario usuario = (Usuario) session.getAttribute("usuario2FA");
        if (usuario == null) {
            return "redirect:/login";
        }
        try {
            twoFactorService.generarYEnviarCodigo(usuario);
            redirectAttributes.addFlashAttribute("mensaje", "Código de verificación reenviado con éxito a tu correo.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error al intentar reenviar el código. Por favor, intente nuevamente.");
        }
        return "redirect:/verificar-codigo";
    }

}