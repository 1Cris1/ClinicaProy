package com.proyectoclinica.clinica.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import java.time.LocalDateTime;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;

@Service
@RequiredArgsConstructor
@Slf4j
public class PasswordResetService {

    private final JavaMailSender mailSender;

    // Estructura en memoria: email -> {codigo, expiracion}
    private final Map<String, ResetCodeData> resetCodes = new ConcurrentHashMap<>();
    private final Random random = new Random();

    public void generarYEnviarCodigo(String email, String nombreUsuario) {
        // Generar código de 6 dígitos
        String codigo = String.format("%06d", random.nextInt(1000000));
        
        // Guardar código con expiración (5 minutos)
        resetCodes.put(email, new ResetCodeData(codigo, LocalDateTime.now().plusMinutes(5)));

        // Enviar correo
        enviarCorreoHtml(email, nombreUsuario, codigo);
    }

    public boolean verificarCodigo(String email, String codigoInput) {
        ResetCodeData data = resetCodes.get(email);
        if (data == null) {
            return false;
        }
        
        // Verificar expiración
        if (LocalDateTime.now().isAfter(data.expiration)) {
            resetCodes.remove(email);
            return false;
        }

        // Verificar si el código coincide
        return data.code.equals(codigoInput);
    }

    public void limpiarCodigo(String email) {
        resetCodes.remove(email);
    }

    private void enviarCorreoHtml(String to, String nombreUsuario, String codigo) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setTo(to);
            helper.setSubject("Código de Recuperación - ClinicX");
            
            String htmlContent = "<div style=\"font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 10px;\">" +
                    "<div style=\"text-align: center; margin-bottom: 20px;\">" +
                    "<h2 style=\"color: #2563EB; margin: 0;\">ClinicX</h2>" +
                    "<p style=\"color: #6b7280; margin: 5px 0 0 0;\">Sistema de Gestión Médica</p>" +
                    "</div>" +
                    "<h3 style=\"color: #1f2937;\">Hola, " + nombreUsuario + "</h3>" +
                    "<p style=\"color: #4b5563; font-size: 16px; line-height: 1.5;\">Hemos recibido una solicitud para restablecer tu contraseña. Por favor, utiliza el siguiente código de verificación. Este código <strong>expirará en 5 minutos</strong>.</p>" +
                    "<div style=\"text-align: center; margin: 30px 0;\">" +
                    "<span style=\"font-size: 32px; font-weight: bold; letter-spacing: 5px; color: #10B981; background: #ecfdf5; padding: 15px 30px; border-radius: 8px; border: 1px dashed #34d399;\">" + codigo + "</span>" +
                    "</div>" +
                    "<p style=\"color: #6b7280; font-size: 14px;\">Si no solicitaste un restablecimiento de contraseña, ignora este correo. Tu cuenta sigue siendo segura.</p>" +
                    "<hr style=\"border: none; border-top: 1px solid #e0e0e0; margin: 20px 0;\">" +
                    "<p style=\"color: #9ca3af; font-size: 12px; text-align: center;\">&copy; 2026 ClinicX. Todos los derechos reservados.</p>" +
                    "</div>";

            helper.setText(htmlContent, true);
            mailSender.send(message);
            log.info("Correo de recuperación enviado a {}", to);

        } catch (MessagingException e) {
            log.error("Error enviando correo de recuperación a {}", to, e);
        }
    }

    private static class ResetCodeData {
        String code;
        LocalDateTime expiration;

        ResetCodeData(String code, LocalDateTime expiration) {
            this.code = code;
            this.expiration = expiration;
        }
    }
}
