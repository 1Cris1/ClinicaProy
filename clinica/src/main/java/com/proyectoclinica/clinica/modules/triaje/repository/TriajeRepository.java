package com.proyectoclinica.clinica.modules.triaje.repository;

import com.proyectoclinica.clinica.modules.triaje.models.Triaje;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface TriajeRepository extends JpaRepository<Triaje, Integer> {
    Optional<Triaje> findByCitaIdCita(Integer idCita);
}

