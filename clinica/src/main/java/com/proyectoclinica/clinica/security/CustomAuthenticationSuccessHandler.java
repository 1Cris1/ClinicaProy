package com.proyectoclinica.clinica.security;

import java.io.IOException;
import com.proyectoclinica.clinica.modules.seguridad.models.AuditoriaUsuario;
import com.proyectoclinica.clinica.modules.seguridad.models.Usuario;
import com.proyectoclinica.clinica.modules.seguridad.repository.AuditoriaUsuarioRepository;
import com.proyectoclinica.clinica.service.TwoFactorService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
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
    private final TwoFactorService twoFactorService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        Usuario usuario = userDetails.getUsuario();
        String username = usuario.getUsername();
        log.info("Authentication success for user={}", username);

        // Si el usuario es ADMINISTRADOR o MEDICO, omitir 2FA y redirigir directamente
        if (usuario.getRol() == com.proyectoclinica.clinica.modules.seguridad.models.Rol.ROLE_ADMIN ||
            usuario.getRol() == com.proyectoclinica.clinica.modules.seguridad.models.Rol.ROLE_MEDICO) {
            try {
                String ipAddress = request.getRemoteAddr();
                if ("0:0:0:0:0:0:0:1".equals(ipAddress)) {
                    ipAddress = "127.0.0.1";
                }
                auditoriaUsuarioRepository.save(AuditoriaUsuario.builder()
                        .username(username)
                        .idUsuario(usuario.getId())
                        .fechaEvento(java.time.LocalDateTime.now())
                        .tipoEvento("LOGIN")
                        .direccionIp(ipAddress)
                        .detalles("Inicio de sesión correcto en el sistema (" + usuario.getRol().name() + " sin 2FA)")
                        .build());
                log.info("Audit log saved for login of user {} bypassing 2FA", username);
            } catch (Exception e) {
                log.error("Failed to save audit log for login of user {}", username, e);
            }
            if (usuario.getRol() == com.proyectoclinica.clinica.modules.seguridad.models.Rol.ROLE_ADMIN) {
                response.sendRedirect("/admin");
            } else {
                response.sendRedirect("/medico");
            }
            return;
        }
        
        // Guardar registro de auditoría del inicio de sesión
        try {
            String ipAddress = request.getRemoteAddr();
            if ("0:0:0:0:0:0:0:1".equals(ipAddress)) {
                ipAddress = "127.0.0.1";
            }
            auditoriaUsuarioRepository.save(AuditoriaUsuario.builder()
                    .username(username)
                    .idUsuario(usuario.getId())
                    .fechaEvento(java.time.LocalDateTime.now())
                    .tipoEvento("LOGIN")
                    .direccionIp(ipAddress)
                    .detalles("Inicio de sesión correcto en el sistema (Pendiente de 2FA)")
                    .build());
            log.info("Audit log saved for login of user {}", username);
        } catch (Exception e) {
            log.error("Failed to save audit log for login of user {}", username, e);
        }

        // Generar y enviar código 2FA
        try {
            twoFactorService.generarYEnviarCodigo(usuario);
            log.info("2FA code generated and sent to {}", usuario.getEmail());
        } catch (Exception e) {
            log.error("Failed to generate/send 2FA code for user {}", username, e);
        }

        // Guardar datos en sesión para la pantalla de verificación
        request.getSession().setAttribute("usuario2FA", usuario);
        request.getSession().setAttribute("otpVerificado", false);

        // Redirigir a la pantalla de verificación de código 2FA
        response.sendRedirect("/verificar-codigo");
    }
}
