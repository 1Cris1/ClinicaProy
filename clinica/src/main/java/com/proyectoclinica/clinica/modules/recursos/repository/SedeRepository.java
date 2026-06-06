package com.proyectoclinica.clinica.modules.recursos.repository;

import com.proyectoclinica.clinica.modules.recursos.models.Sede;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SedeRepository extends JpaRepository<Sede, Integer> {
}
