package com.proyectoclinica.clinica.modules.farmacia.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.proyectoclinica.clinica.modules.farmacia.models.Pedido;
import java.util.List;
@Repository
public interface PedidoRepository extends JpaRepository<Pedido, Integer> {
    List<Pedido> findByPacienteIdOrderByFechaPedidoDesc(Integer idPaciente);
}
