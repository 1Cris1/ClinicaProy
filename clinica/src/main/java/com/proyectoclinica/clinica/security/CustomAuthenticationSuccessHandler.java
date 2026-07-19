package com.proyectoclinica.clinica.security;

import com.proyectoclinica.clinica.modules.seguridad.models.Usuario;
import com.proyectoclinica.clinica.service.TwoFactorService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
@RequiredArgsConstructor
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    private static final Logger log =
            LoggerFactory.getLogger(CustomAuthenticationSuccessHandler.class);

    private final TwoFactorService twoFactorService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication)
            throws IOException, ServletException {

        UserDetailsImpl userDetails =
                (UserDetailsImpl) authentication.getPrincipal();

        Usuario usuario = userDetails.getUsuario();

        log.info("Authentication success for {}", usuario.getUsername());

        // Generar y enviar OTP
        twoFactorService.generarYEnviarCodigo(usuario);

        // Guardar datos en sesión
        request.getSession().setAttribute("usuario2FA", usuario);
        request.getSession().setAttribute("otpVerificado", false);

        // Ir a la pantalla de verificación
        response.sendRedirect("/verificar-codigo");
    }
}