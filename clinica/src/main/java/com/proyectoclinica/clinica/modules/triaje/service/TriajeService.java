package com.proyectoclinica.clinica.modules.triaje.service;

import com.proyectoclinica.clinica.modules.triaje.models.Triaje;
import com.proyectoclinica.clinica.modules.triaje.repository.TriajeRepository;
import com.proyectoclinica.clinica.modules.citas.repository.CitaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.Optional;
import com.proyectoclinica.clinica.modules.citas.models.Cita;

@Service
@RequiredArgsConstructor
public class TriajeService {
    private final TriajeRepository triajeRepository;
    private final CitaRepository citaRepository;

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

    @Transactional
    public boolean registrarTriaje(Cita cita, java.math.BigDecimal peso, java.math.BigDecimal talla, String presionArterial, java.math.BigDecimal temperatura, Integer frecuenciaCardiaca, Integer saturacionOxigeno) {
        if (cita != null) {
            Triaje triaje = Triaje.builder()
                    .cita(cita)
                    .peso(peso)
                    .talla(talla)
                    .presionArterial(presionArterial)
                    .temperatura(temperatura)
                    .frecuenciaCardiaca(frecuenciaCardiaca)
                    .saturacionOxigeno(saturacionOxigeno)
                    .fechaRegistro(java.time.LocalDateTime.now())
                    .build();
            triajeRepository.save(triaje);
            cita.setTriaje(triaje);
            citaRepository.save(cita);
            return true;
        }
        return false;
    }
}
