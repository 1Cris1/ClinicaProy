package com.proyectoclinica.clinica.modules.recursos.repository;

import com.proyectoclinica.clinica.modules.recursos.models.Promocion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PromocionRepository extends JpaRepository<Promocion, Integer> {
}
