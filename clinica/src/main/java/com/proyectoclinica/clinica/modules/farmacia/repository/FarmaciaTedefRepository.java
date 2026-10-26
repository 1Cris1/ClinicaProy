package com.proyectoclinica.clinica.modules.farmacia.repository;

import com.proyectoclinica.clinica.modules.farmacia.models.FarmaciaTedef;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface FarmaciaTedefRepository extends JpaRepository<FarmaciaTedef, Integer> {
    
    // BÃºsqueda por cÃ³digo de producto (CIE-10 o CÃ³digo de barras)
    List<FarmaciaTedef> findByVcodprodFar003(String vcodprodFar003);
    // BÃºsqueda por Ubigeo
    List<FarmaciaTedef> findByUbigeo(String ubigeo);
}

