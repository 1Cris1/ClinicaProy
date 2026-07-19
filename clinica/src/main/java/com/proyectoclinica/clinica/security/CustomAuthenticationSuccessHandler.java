package com.proyectoclinica.clinica.security;

import java.io.IOException;
import com.proyectoclinica.clinica.modules.seguridad.models.AuditoriaUsuario;
import com.proyectoclinica.clinica.modules.seguridad.repository.AuditoriaUsuarioRepository;
import com.proyectoclinica.clinica.modules.seguridad.repository.UsuarioRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
    private static final Logger log = LoggerFactory.getLogger(CustomAuthenticationSuccessHandler.class);
    private final AuditoriaUsuarioRepository auditoriaUsuarioRepository;
    private final UsuarioRepository usuarioRepository;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        String username = authentication.getName();
        log.info("Authentication success for user={}", username);
        
        // Guardar registro de auditoría del inicio de sesión
        try {
            String ipAddress = request.getRemoteAddr();
            if ("0:0:0:0:0:0:0:1".equals(ipAddress)) {
                ipAddress = "127.0.0.1";
            }
            Integer userId = usuarioRepository.findByUsername(username)
                    .map(com.proyectoclinica.clinica.modules.seguridad.models.Usuario::getId)
                    .orElse(1); // fallback to 1

            auditoriaUsuarioRepository.save(AuditoriaUsuario.builder()
                    .username(username)
                    .idUsuario(userId)
                    .fechaEvento(java.time.LocalDateTime.now())
                    .tipoEvento("LOGIN")
                    .direccionIp(ipAddress)
                    .detalles("Inicio de sesión correcto en el sistema")
                    .build());
            log.info("Audit log saved for login of user {}", username);
        } catch (Exception e) {
            log.error("Failed to save audit log for login of user {}", username, e);
        }

        String redirectUrl = "/";
        for (GrantedAuthority authority : authentication.getAuthorities()) {
            log.debug("Granted authority for {}: {}", username, authority.getAuthority());
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
