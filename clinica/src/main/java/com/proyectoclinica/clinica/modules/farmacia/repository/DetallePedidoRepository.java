package com.proyectoclinica.clinica.modules.farmacia.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.proyectoclinica.clinica.modules.farmacia.models.DetallePedido;
public interface DetallePedidoRepository extends JpaRepository<DetallePedido, Integer> {
}

