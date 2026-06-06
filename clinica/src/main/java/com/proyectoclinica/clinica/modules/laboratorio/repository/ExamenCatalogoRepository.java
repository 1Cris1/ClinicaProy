package com.proyectoclinica.clinica.modules.laboratorio.repository;

import com.proyectoclinica.clinica.modules.laboratorio.models.ExamenCatalogo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
@Repository
public interface ExamenCatalogoRepository extends JpaRepository<ExamenCatalogo, Integer> {
    List<ExamenCatalogo> findByCategoria(String categoria);
}
