package com.proyectoclinica.clinica.modules.laboratorio.repository;

import com.proyectoclinica.clinica.modules.laboratorio.models.ExamenCatalogo;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface ExamenCatalogoRepository extends JpaRepository<ExamenCatalogo, Integer> {
    List<ExamenCatalogo> findByCategoria(String categoria);
}

