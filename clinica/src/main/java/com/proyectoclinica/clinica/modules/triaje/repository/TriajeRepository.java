package com.proyectoclinica.clinica.modules.triaje.repository;

import com.proyectoclinica.clinica.modules.triaje.models.Triaje;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface TriajeRepository extends JpaRepository<Triaje, Integer> {
    Optional<Triaje> findByCitaIdCita(Integer idCita);
}
