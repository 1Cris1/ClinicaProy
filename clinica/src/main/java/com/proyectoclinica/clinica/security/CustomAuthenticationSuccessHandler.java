package com.proyectoclinica.clinica.security;

import java.io.IOException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
    private static final Logger log = LoggerFactory.getLogger(CustomAuthenticationSuccessHandler.class);
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        String username = authentication.getName();
        log.info("Authentication success for user={}", username);
        String redirectUrl = "/";
        for (GrantedAuthority authority : authentication.getAuthorities()) {
            log.debug("Granted authority for {}: {}", username, authority.getAuthority());
            // EXPOSICIÓN RHOMEL: Aquí explicamos el Enrutamiento Basado en Roles (RBAC). Dependiendo del ROL del usuario logueado, lo mandamos a un dashboard distinto (Admin, Médico, Paciente, Recepcionista).
            if (authority.getAuthority().equals("ROLE_ADMIN")) {
                redirectUrl = "/admin/inicio";
                break;
            } else if (authority.getAuthority().equals("ROLE_MEDICO")) {
                redirectUrl = "/medico/inicio";
            } else if (authority.getAuthority().equals("ROLE_PACIENTE")) {
                redirectUrl = "/paciente/inicio";
            } else if (authority.getAuthority().equals("ROLE_RECEPCIONISTA")) {
                redirectUrl = "/recepcionista/inicio";
            }
        }
        log.info("Redirecting user {} to {}", username, redirectUrl);
        response.sendRedirect(redirectUrl);
    }
}
