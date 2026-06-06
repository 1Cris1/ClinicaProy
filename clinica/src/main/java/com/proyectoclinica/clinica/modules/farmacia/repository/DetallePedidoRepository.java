package com.proyectoclinica.clinica.modules.farmacia.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.proyectoclinica.clinica.modules.farmacia.models.DetallePedido;
@Repository
public interface DetallePedidoRepository extends JpaRepository<DetallePedido, Integer> {
}
