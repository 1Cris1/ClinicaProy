package com.proyectoclinica.clinica.modules.recursos.repository;

import com.proyectoclinica.clinica.modules.recursos.models.Medico;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface MedicoRepository extends JpaRepository<Medico, Integer> {
    Optional<Medico> findByUsuarioEmail(String email);
    Optional<Medico> findByUsuarioUsername(String username);
    Optional<Medico> findByDni(String dni);
    Optional<Medico> findByUsuarioId(Integer idUsuario);
}
