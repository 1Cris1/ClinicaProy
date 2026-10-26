package com.proyectoclinica.clinica.modules.recursos.repository;

import com.proyectoclinica.clinica.modules.recursos.models.Especialidad;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface EspecialidadRepository extends JpaRepository<Especialidad, Integer> {
    Optional<Especialidad> findByNombre(String nombre);
}

