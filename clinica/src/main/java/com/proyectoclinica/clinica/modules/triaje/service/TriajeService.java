package com.proyectoclinica.clinica.modules.triaje.service;

import com.proyectoclinica.clinica.modules.triaje.models.Triaje;
import com.proyectoclinica.clinica.modules.triaje.repository.TriajeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class TriajeService {
    private final TriajeRepository triajeRepository;

    public Optional<Triaje> obtenerPorCita(Integer idCita) {
        return triajeRepository.findByCitaIdCita(idCita);
    }

    @Transactional
    public Triaje guardar(Triaje triaje) {
        return triajeRepository.save(triaje);
    }

    @Transactional
    public void eliminar(Integer id) {
        triajeRepository.deleteById(id);
    }
}
