package com.proyectoclinica.clinica.modules.recursos.service;

import com.proyectoclinica.clinica.modules.seguridad.models.Usuario;
import com.proyectoclinica.clinica.modules.seguridad.models.Rol;
import com.proyectoclinica.clinica.modules.recursos.models.Medico;
import com.proyectoclinica.clinica.modules.recursos.repository.MedicoRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.EspecialidadRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.SedeRepository;
import com.proyectoclinica.clinica.modules.seguridad.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MedicoService {

    private static final Logger log = LoggerFactory.getLogger(MedicoService.class);

    private final UsuarioRepository usuarioRepository;
    private final MedicoRepository medicoRepository;
    private final EspecialidadRepository especialidadRepository;
    private final SedeRepository sedeRepository;
    private final PasswordEncoder passwordEncoder;

    public List<Usuario> listarUsuariosMedicos() {
        return usuarioRepository.findAll().stream()
                .filter(u -> u.getIdRol() == 2)
                .collect(Collectors.toList());
    }

    public List<Medico> listarMedicos() {
        return medicoRepository.findAll();
    }

    public List<com.proyectoclinica.clinica.modules.recursos.models.Especialidad> listarEspecialidades() {
        return especialidadRepository.findAll();
    }

    @Transactional
    public Medico guardar(Medico medico) {
        return medicoRepository.save(medico);
    }

    public java.util.Optional<Medico> obtenerPorUsername(String username) {
        return medicoRepository.findByUsuarioUsername(username);
    }

    public java.util.Optional<Medico> obtenerPorDni(String dni) {
        return medicoRepository.findByDni(dni);
    }

    public long contarSedes() {
        return sedeRepository.count();
    }

    public Medico obtenerMedicoPorId(Integer id) {
        return medicoRepository.findById(id).orElse(null);
    }

    @Transactional
    public boolean editarMedico(Integer idUsuario, String username, String nuevaPassword, String email,
                                String nombres, String apellidos, String cmp, Integer especialidadId, Integer sedeId,
                                String telefono, String consultorio, String estado, String horarioLv, String horarioSabado, Integer duracionCita) {
        log.info("Editando medico ID de usuario: {}", idUsuario);
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

                Medico medico = medicoRepository.findByUsuarioId(usuario.getId()).orElse(null);
                if (medico != null) {
                    if (nombres != null) medico.setNombres(nombres);
                    if (apellidos != null) medico.setApellidos(apellidos);
                    if (cmp != null) medico.setCmp(cmp);
                    if (especialidadId != null) {
                        medico.setEspecialidad(especialidadRepository.findById(especialidadId).orElse(null));
                    }
                    if (sedeId != null) {
                        medico.setSede(sedeRepository.findById(sedeId).orElse(null));
                    }
                    if (telefono != null) medico.setTelefono(telefono);
                    if (consultorio != null) medico.setConsultorio(consultorio);
                    if (estado != null) medico.setEstado(estado);
                    if (horarioLv != null) medico.setHorarioLv(horarioLv);
                    if (horarioSabado != null) medico.setHorarioSabado(horarioSabado);
                    if (duracionCita != null) medico.setDuracionCita(duracionCita);
                    medicoRepository.save(medico);
                }
                return true;
            }
        } catch (Exception e) {
            log.error("Error editando medico", e);
        }
        return false;
    }

    @Transactional
    public boolean registrarMedico(String nombres, String apellidos, String dni, String password, String cmp,
                                   Integer especialidadId, Integer sedeId, String telefono, String email,
                                   String consultorio, String horarioLv, String horarioSabado, Integer duracionCita) {
        try {
            Usuario nuevoUsuario = Usuario.builder()
                    .username(dni)
                    .password(passwordEncoder.encode(password))
                    .email(email != null && !email.isBlank() ? email : dni + "@medico.com")
                    .idRol(2)
                    .rol(Rol.ROLE_MEDICO)
                    .build();
            nuevoUsuario = usuarioRepository.save(nuevoUsuario);

            Medico med = Medico.builder()
                    .usuario(nuevoUsuario)
                    .nombres(nombres)
                    .apellidos(apellidos)
                    .dni(dni)
                    .cmp(cmp)
                    .especialidad(especialidadId != null ? especialidadRepository.findById(especialidadId).orElse(null) : null)
                    .sede(sedeId != null ? sedeRepository.findById(sedeId).orElse(null) : null)
                    .telefono(telefono)
                    .email(email)
                    .consultorio(consultorio)
                    .horarioLv(horarioLv)
                    .horarioSabado(horarioSabado)
                    .duracionCita(duracionCita != null ? duracionCita : 30)
                    .estado("Activo")
                    .build();
            medicoRepository.save(med);
            return true;
        } catch (Exception e) {
            log.error("Error al registrar médico", e);
            return false;
        }
    }

    @Transactional
    public boolean eliminarMedico(Integer id) {
        try {
            usuarioRepository.deleteById(id);
            return true;
        } catch (Exception e) {
            log.error("Error eliminando medico", e);
            return false;
        }
    }
}
