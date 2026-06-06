package com.proyectoclinica.clinica.modules.facturacion.repository;

import com.proyectoclinica.clinica.modules.facturacion.models.Pago;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PagoRepository extends JpaRepository<Pago, Integer> {
}
