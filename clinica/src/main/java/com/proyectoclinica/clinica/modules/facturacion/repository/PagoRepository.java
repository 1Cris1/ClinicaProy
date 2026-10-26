package com.proyectoclinica.clinica.modules.facturacion.repository;

import com.proyectoclinica.clinica.modules.facturacion.models.Pago;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PagoRepository extends JpaRepository<Pago, Integer> {
}

