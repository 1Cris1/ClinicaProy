package com.proyectoclinica.clinica.modules.farmacia.repository;

import com.proyectoclinica.clinica.modules.farmacia.models.DigemidObservatorio;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface DigemidObservatorioRepository extends JpaRepository<DigemidObservatorio, Integer> {
    List<DigemidObservatorio> findByNombreProductoContainingIgnoreCase(String nombre);
}

