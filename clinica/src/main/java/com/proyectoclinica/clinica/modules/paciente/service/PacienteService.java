package com.proyectoclinica.clinica.modules.paciente.service;

import com.proyectoclinica.clinica.modules.seguridad.models.Usuario;
import com.proyectoclinica.clinica.modules.seguridad.models.Rol;
import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import com.proyectoclinica.clinica.modules.paciente.repository.PacienteRepository;
import com.proyectoclinica.clinica.modules.seguridad.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PacienteService {

    private static final Logger log = LoggerFactory.getLogger(PacienteService.class);
    
    private final UsuarioRepository usuarioRepository;
    private final PacienteRepository pacienteRepository;

    private final PasswordEncoder passwordEncoder;

    public Paciente obtenerPacientePorId(Integer id) {
        return pacienteRepository.findById(id).orElse(null);
    }

    public java.util.Optional<Paciente> obtenerPorUsername(String username) {
        return pacienteRepository.findByUsuarioUsername(username);
    }

    @Transactional
    public Paciente guardarPaciente(Paciente paciente) {
        return pacienteRepository.save(paciente);
    }

    public List<Usuario> listarUsuariosPacientes() {
        return usuarioRepository.findAll().stream()
                .filter(u -> u.getIdRol() == 3)
                .collect(Collectors.toList());
    }

    public List<Paciente> listarTodosLosPacientes() {
        return pacienteRepository.findAll();
    }

    @Transactional
    public boolean registrarPaciente(String nombres, String apellidos, String dni, String password, String email, String telefono) {
        log.info("Creando nuevo paciente: {}", dni);
        Usuario nuevoUsuario = Usuario.builder()
                .username(dni)
                .password(passwordEncoder.encode(password))
                .email(email != null && !email.isBlank() ? email : dni + "@paciente.com")
                .idRol(3)
                .rol(Rol.ROLE_PACIENTE)
                .build();
        try {
            usuarioRepository.save(nuevoUsuario);
            
            Paciente nuevoPaciente = Paciente.builder()
                    .usuario(nuevoUsuario)
                    .nombres(nombres)
                    .apellidos(apellidos)
                    .dni(dni)
                    .email(email)
                    .telefono(telefono)
                    .estado("Activo")
                    .build();
            pacienteRepository.save(nuevoPaciente);
            return true;
        } catch (DataIntegrityViolationException e) {
            log.error("Error al registrar paciente: {}", e.getMessage());
            return false;
        }
    }

    @Transactional
    public boolean editarPaciente(Integer idUsuario, String username, String nuevaPassword, String email) {
        log.info("Editando paciente ID: {}", idUsuario);
        try {
            Usuario usuario = usuarioRepository.findById(idUsuario).orElse(null);
            if (usuario != null) {
                usuario.setUsername(username);
                if (email != null && !email.isBlank()) {
                    usuario.setEmail(email);
                }
                if (nuevaPassword != null && !nuevaPassword.isBlank()) {
                    usuario.setPassword(passwordEncoder.encode(nuevaPassword));
                }
                usuarioRepository.save(usuario);
                return true;
            }
        } catch (Exception e) {
            log.error("Error editando paciente", e);
        }
        return false;
    }

    @Transactional
    public boolean eliminarPaciente(Integer id) {
        try {
            usuarioRepository.deleteById(id);
            return true;
        } catch (Exception e) {
            log.error("Error eliminando paciente", e);
            return false;
        }
    }
}
