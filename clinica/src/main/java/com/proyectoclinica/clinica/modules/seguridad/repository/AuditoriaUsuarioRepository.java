package com.proyectoclinica.clinica.modules.seguridad.repository;

import com.proyectoclinica.clinica.modules.seguridad.models.AuditoriaUsuario;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface AuditoriaUsuarioRepository extends JpaRepository<AuditoriaUsuario, Integer> {
    List<AuditoriaUsuario> findAllByOrderByFechaEventoDesc();
    List<AuditoriaUsuario> findByUsernameContainingIgnoreCaseOrderByFechaEventoDesc(String username);
    List<AuditoriaUsuario> findByTipoEventoOrderByFechaEventoDesc(String tipoEvento);
    List<AuditoriaUsuario> findByUsernameContainingIgnoreCaseAndTipoEventoOrderByFechaEventoDesc(String username, String tipoEvento);
}
