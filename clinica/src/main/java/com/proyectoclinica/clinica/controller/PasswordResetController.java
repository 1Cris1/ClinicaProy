package com.proyectoclinica.clinica.controller;

import com.proyectoclinica.clinica.modules.seguridad.models.Usuario;
import com.proyectoclinica.clinica.modules.seguridad.repository.UsuarioRepository;
import com.proyectoclinica.clinica.service.PasswordResetService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/password")
@RequiredArgsConstructor
@Slf4j
public class PasswordResetController {

    private final PasswordResetService passwordResetService;
    private final UsuarioRepository usuarioRepository;
    private final PasswordEncoder passwordEncoder;

    @PostMapping("/forgot")
    public ResponseEntity<?> forgotPassword(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        if (email == null || email.trim().isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("success", false, "message", "El correo es requerido"));
        }

        Optional<Usuario> usuarioOpt = usuarioRepository.findByEmail(email.trim());
        if (usuarioOpt.isEmpty()) {
            // Por seguridad, simulamos que fue exitoso aunque no exista el correo
            // Esto evita ataques de enumeración de usuarios
            return ResponseEntity.ok(Map.of("success", true, "message", "Si el correo existe, se le enviará un código."));
        }

        Usuario usuario = usuarioOpt.get();
        // Generar código y enviar correo de forma asíncrona (podría usarse @Async, pero lo dejamos simple)
        try {
            passwordResetService.generarYEnviarCodigo(email.trim(), usuario.getUsername());
            return ResponseEntity.ok(Map.of("success", true, "message", "Código enviado correctamente."));
        } catch (Exception e) {
            log.error("Error al enviar código de recuperación", e);
            return ResponseEntity.internalServerError().body(Map.of("success", false, "message", "Error al enviar el correo."));
        }
    }

    @PostMapping("/verify")
    public ResponseEntity<?> verifyCode(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        String code = request.get("code");

        if (email == null || code == null) {
            return ResponseEntity.badRequest().body(Map.of("success", false, "message", "Datos incompletos"));
        }

        boolean isValid = passwordResetService.verificarCodigo(email.trim(), code.trim());
        if (isValid) {
            return ResponseEntity.ok(Map.of("success", true, "message", "Código verificado correctamente"));
        } else {
            return ResponseEntity.badRequest().body(Map.of("success", false, "message", "El código es incorrecto o ha expirado"));
        }
    }

    @PostMapping("/reset")
    public ResponseEntity<?> resetPassword(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        String code = request.get("code");
        String newPassword = request.get("newPassword");

        if (email == null || code == null || newPassword == null || newPassword.trim().isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("success", false, "message", "Datos incompletos"));
        }

        // Volver a verificar el código por seguridad antes de cambiar
        boolean isValid = passwordResetService.verificarCodigo(email.trim(), code.trim());
        if (!isValid) {
            return ResponseEntity.badRequest().body(Map.of("success", false, "message", "El código es incorrecto o ha expirado"));
        }

        Optional<Usuario> usuarioOpt = usuarioRepository.findByEmail(email.trim());
        if (usuarioOpt.isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("success", false, "message", "Usuario no encontrado"));
        }

        try {
            Usuario usuario = usuarioOpt.get();
            usuario.setPassword(passwordEncoder.encode(newPassword));
            usuarioRepository.save(usuario);
            
            // Limpiar el código usado
            passwordResetService.limpiarCodigo(email.trim());
            
            return ResponseEntity.ok(Map.of("success", true, "message", "Contraseña actualizada exitosamente"));
        } catch (Exception e) {
            log.error("Error al cambiar la contraseña", e);
            return ResponseEntity.internalServerError().body(Map.of("success", false, "message", "Error interno al actualizar la contraseña"));
        }
    }
}
