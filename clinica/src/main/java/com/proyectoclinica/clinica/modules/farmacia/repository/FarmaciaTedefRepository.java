package com.proyectoclinica.clinica.modules.farmacia.repository;

import com.proyectoclinica.clinica.modules.farmacia.models.FarmaciaTedef;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
@Repository
public interface FarmaciaTedefRepository extends JpaRepository<FarmaciaTedef, Integer> {
    
    // Búsqueda por código de producto (CIE-10 o Código de barras)
    List<FarmaciaTedef> findByVcodprodFar003(String vcodprodFar003);
    // Búsqueda por Ubigeo
    List<FarmaciaTedef> findByUbigeo(String ubigeo);
}
