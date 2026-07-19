package com.proyectoclinica.clinica.modules.seguridad.repository;

import com.proyectoclinica.clinica.modules.seguridad.models.CodigoVerificacion;
import com.proyectoclinica.clinica.modules.seguridad.models.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.List;

@Repository
public interface CodigoVerificacionRepository extends JpaRepository<CodigoVerificacion, Integer> {

    Optional<CodigoVerificacion> findTopByUsuarioOrderByFechaGeneracionDesc(Usuario usuario);

    Optional<CodigoVerificacion> findByUsuarioAndCodigoAndUsadoFalse(
            Usuario usuario,
            String codigo
    );

    List<CodigoVerificacion> findByUsuarioAndUsadoFalse(Usuario usuario);
    void deleteByFechaExpiracionBefore(LocalDateTime fecha);
}