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
    private final com.proyectoclinica.clinica.modules.seguridad.repository.DispositivoConfianzaRepository dispositivoConfianzaRepository;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        Usuario usuario = userDetails.getUsuario();
        String username = usuario.getUsername();
        log.info("Authentication success for user={}", username);

        boolean isMfaEnabled = usuario.getMfaEnabled() != null && usuario.getMfaEnabled();
        boolean bypassMfa = false;
        
        // EXPOSICIÓN RHOMEL: Verificamos si el dispositivo ya está marcado como de confianza
        boolean isTrustedDevice = false;
        jakarta.servlet.http.Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (jakarta.servlet.http.Cookie cookie : cookies) {
                if ("CLINICX_TRUSTED_DEVICE".equals(cookie.getName())) {
                    String deviceCookieId = cookie.getValue();
                    var optionalDevice = dispositivoConfianzaRepository.findByUsuarioIdAndDeviceCookieId(usuario.getId(), deviceCookieId);
                    if (optionalDevice.isPresent()) {
                        isTrustedDevice = true;
                        
                        // Actualizar fecha de último uso
                        var device = optionalDevice.get();
                        device.setFechaUltimoUso(java.time.LocalDateTime.now());
                        dispositivoConfianzaRepository.save(device);
                        break;
                    }
                }
            }
        }

        // Si el usuario tiene mfaEnabled (fuerte), pedimos 2FA siempre a menos que confíe en el dispositivo.
        // Si no tiene mfaEnabled, los admins y medicos asumen bypass, a menos que el 2FA de dispositivo aplique.
        // Haremos que el 2FA no intrusivo funcione así: Si es un nuevo dispositivo, SIEMPRE pide código, a menos que sea un rol bajo sin MFA (ej. paciente).
        // Modificado según requerimiento de que el médico/admin sólo pida código si el dispositivo es nuevo.
        if (isTrustedDevice) {
            bypassMfa = true;
        } else if (usuario.getRol() == com.proyectoclinica.clinica.modules.seguridad.models.Rol.ROLE_PACIENTE || usuario.getRol() == com.proyectoclinica.clinica.modules.seguridad.models.Rol.ROLE_RECEPCIONISTA) {
            // A estos roles menores no les forzamos 2FA de dispositivo a menos que lo tengan enabled explícitamente
            bypassMfa = !isMfaEnabled;
        } else {
            // Admin y Medico, si es dispositivo nuevo, fuerzan 2FA (no se bypass).
            bypassMfa = false;
        }

        if (bypassMfa) {
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
            switch (usuario.getRol()) {
                case ROLE_ADMIN:
                    response.sendRedirect("/admin");
                    break;
                case ROLE_MEDICO:
                    response.sendRedirect("/medico/inicio");
                    break;
                case ROLE_RECEPCIONISTA:
                    response.sendRedirect("/recepcionista/inicio");
                    break;
                case ROLE_PACIENTE:
                    response.sendRedirect("/paciente/inicio");
                    break;
                default:
                    response.sendRedirect("/login");
                    break;
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
