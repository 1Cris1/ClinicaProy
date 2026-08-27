package com.proyectoclinica.clinica.modules.seguridad.repository;

import com.proyectoclinica.clinica.modules.seguridad.models.DispositivoConfianza;
import org.springframework.data.jpa.repository.JpaRepository;


import java.util.Optional;

public interface DispositivoConfianzaRepository extends JpaRepository<DispositivoConfianza, Integer> {
    Optional<DispositivoConfianza> findByDeviceCookieId(String deviceCookieId);
    Optional<DispositivoConfianza> findByUsuarioIdAndDeviceCookieId(Integer usuarioId, String deviceCookieId);
}
