package com.proyectoclinica.clinica.modules.recursos.repository;

import com.proyectoclinica.clinica.modules.recursos.models.Administrador;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface AdministradorRepository extends JpaRepository<Administrador, Integer> {
    Optional<Administrador> findByUsuarioId(Integer idUsuario);
}

