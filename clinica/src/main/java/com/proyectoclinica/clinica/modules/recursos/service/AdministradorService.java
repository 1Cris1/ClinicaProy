package com.proyectoclinica.clinica.modules.recursos.service;

import com.proyectoclinica.clinica.modules.recursos.models.Administrador;
import com.proyectoclinica.clinica.modules.recursos.repository.AdministradorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AdministradorService {
    private final AdministradorRepository administradorRepository;

    public List<Administrador> listarTodos() {
        return administradorRepository.findAll();
    }

    public Optional<Administrador> obtenerPorId(Integer id) {
        return administradorRepository.findById(id);
    }

    public Optional<Administrador> obtenerPorUsuario(Integer idUsuario) {
        return administradorRepository.findByUsuarioId(idUsuario);
    }

    @Transactional
    public Administrador guardar(Administrador administrador) {
        return administradorRepository.save(administrador);
    }

    @Transactional
    public void eliminar(Integer id) {
        administradorRepository.deleteById(id);
    }
}
