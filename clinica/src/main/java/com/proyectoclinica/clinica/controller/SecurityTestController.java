package com.proyectoclinica.clinica.controller;

import com.proyectoclinica.clinica.modules.seguridad.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
@RestController
@RequiredArgsConstructor
public class SecurityTestController {
    private final UsuarioRepository repo;
    private final PasswordEncoder encoder;
    @GetMapping("/api/test/users")
    public String testUsers() {
        StringBuilder sb = new StringBuilder();
        repo.findAll().forEach(u -> {
            sb.append(u.getUsername()).append(" - ")
              .append(u.getRol().name()).append(" - ")
              .append("coincide(1234)? ").append(encoder.matches("1234", u.getPassword())).append("<br>");
        });
        return sb.toString();
    }
}
