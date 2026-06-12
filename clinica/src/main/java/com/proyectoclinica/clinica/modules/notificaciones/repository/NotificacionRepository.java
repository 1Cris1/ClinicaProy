package com.proyectoclinica.clinica.modules.notificaciones.repository;

import com.proyectoclinica.clinica.modules.notificaciones.models.Notificacion;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface NotificacionRepository extends JpaRepository<Notificacion, Integer> {
    List<Notificacion> findByPacienteIdOrderByFechaDesc(Integer idPaciente);
    long countByPacienteIdAndLeidaFalse(Integer idPaciente);
}

