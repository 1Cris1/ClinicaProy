package com.proyectoclinica.clinica.modules.farmacia.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.proyectoclinica.clinica.modules.farmacia.models.Producto;
import java.util.List;
@Repository
public interface ProductoRepository extends JpaRepository<Producto, Integer> {
    List<Producto> findByEstado(String estado);
    List<Producto> findByNombreContainingIgnoreCaseAndEstado(String nombre, String estado);
}
