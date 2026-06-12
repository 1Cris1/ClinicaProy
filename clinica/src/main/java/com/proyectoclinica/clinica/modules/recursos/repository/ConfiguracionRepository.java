package com.proyectoclinica.clinica.modules.recursos.repository;

import com.proyectoclinica.clinica.modules.recursos.models.Configuracion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.Optional;

public interface ConfiguracionRepository extends JpaRepository<Configuracion, Integer> {
    
    @Query("SELECT c FROM Configuracion c ORDER BY c.idConfig ASC LIMIT 1")
    Optional<Configuracion> findCurrentConfig();
}

