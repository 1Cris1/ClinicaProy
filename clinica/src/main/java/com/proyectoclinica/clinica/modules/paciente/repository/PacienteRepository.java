package com.proyectoclinica.clinica.modules.paciente.repository;

import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
import java.util.List;
public interface PacienteRepository extends JpaRepository<Paciente, Integer> {
    Optional<Paciente> findByDni(String dni);
    Optional<Paciente> findByUsuarioUsername(String username);
    Optional<Paciente> findByUsuarioId(Integer usuarioId);
    List<Paciente> findByNombresContainingIgnoreCaseOrApellidosContainingIgnoreCaseOrDniContaining(String nombres, String apellidos, String dni);
}

