package com.proyectoclinica.clinica.modules.consultas.repository;

import com.proyectoclinica.clinica.modules.consultas.models.MedicamentoPrescrito;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MedicamentoPrescritoRepository extends JpaRepository<MedicamentoPrescrito, Integer> {
}
