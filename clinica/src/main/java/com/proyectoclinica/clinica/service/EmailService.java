package com.proyectoclinica.clinica.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
@RequiredArgsConstructor
@Slf4j
public class EmailService {

    private final JavaMailSender mailSender;

    public void enviarCorreoBienvenida(String to, String nombreUsuario) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setTo(to);
            helper.setSubject("¡Bienvenido a ClinicX! - Tu cuenta ha sido creada");
            
            String htmlContent = "<div style=\"font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 10px;\">" +
                    "<div style=\"text-align: center; margin-bottom: 20px;\">" +
                    "<h2 style=\"color: #2563EB; margin: 0;\">ClinicX</h2>" +
                    "<p style=\"color: #6b7280; margin: 5px 0 0 0;\">Sistema de Gestión Médica</p>" +
                    "</div>" +
                    "<h3 style=\"color: #1f2937;\">¡Hola, " + nombreUsuario + "!</h3>" +
                    "<p style=\"color: #4b5563; font-size: 16px; line-height: 1.6;\">Nos alegra darte la bienvenida a <strong>ClinicX</strong>. Tu cuenta ha sido creada exitosamente y tu identidad ha sido verificada correctamente en nuestro sistema.</p>" +
                    "<div style=\"background-color: #f3f4f6; padding: 15px; border-radius: 8px; margin: 20px 0; border-left: 4px solid #2563EB;\">" +
                    "<p style=\"margin: 0; color: #1f2937; font-size: 14px;\"><strong>A partir de ahora podrás:</strong></p>" +
                    "<ul style=\"color: #4b5563; font-size: 14px; margin-top: 10px; padding-left: 20px;\">" +
                    "<li>Agendar y gestionar tus citas médicas en línea.</li>" +
                    "<li>Acceder a tu historial clínico y resultados de laboratorio.</li>" +
                    "<li>Revisar las recetas y medicamentos indicados por tu médico.</li>" +
                    "</ul>" +
                    "</div>" +
                    "<p style=\"color: #6b7280; font-size: 14px;\">Inicia sesión con tu DNI y la contraseña que creaste durante el registro para comenzar a utilizar nuestros servicios.</p>" +
                    "<div style=\"text-align: center; margin: 30px 0;\">" +
                    "<a href=\"http://localhost:8080/login\" style=\"background-color: #2563EB; color: white; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; font-size: 14px;\">Iniciar Sesión Ahora</a>" +
                    "</div>" +
                    "<hr style=\"border: none; border-top: 1px solid #e0e0e0; margin: 20px 0;\">" +
                    "<p style=\"color: #9ca3af; font-size: 12px; text-align: center;\">&copy; 2026 ClinicX. Todos los derechos reservados.</p>" +
                    "</div>";

            helper.setText(htmlContent, true);
            mailSender.send(message);
            log.info("Correo de bienvenida enviado exitosamente a {}", to);

        } catch (MessagingException e) {
            log.error("Error enviando correo de bienvenida a {}", to, e);
        }
    }
}
