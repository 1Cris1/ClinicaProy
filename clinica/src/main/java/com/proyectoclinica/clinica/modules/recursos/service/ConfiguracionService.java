package com.proyectoclinica.clinica.modules.recursos.service;

import com.proyectoclinica.clinica.modules.recursos.models.Configuracion;
import com.proyectoclinica.clinica.modules.recursos.repository.ConfiguracionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ConfiguracionService {
    private final ConfiguracionRepository configuracionRepository;

    public Optional<Configuracion> obtenerConfiguracionActual() {
        return configuracionRepository.findCurrentConfig();
    }

    @Transactional
    public Configuracion guardar(Configuracion configuracion) {
        return configuracionRepository.save(configuracion);
    }
}
