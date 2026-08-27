package com.proyectoclinica.clinica.modules.recursos.service;

import com.proyectoclinica.clinica.modules.recursos.models.Promocion;
import com.proyectoclinica.clinica.modules.recursos.repository.PromocionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class PromocionService {

    private final PromocionRepository promocionRepository;

    public List<Promocion> listarPromociones() {
        return promocionRepository.findAll();
    }
    
    public long contarPromociones() {
        return promocionRepository.count();
    }

    public void registrarPromocion(String titulo, String descripcion, BigDecimal descuentoPorcentaje, LocalDate fechaInicio, LocalDate fechaFin, String estado, String imagenUrl) {
        Promocion nuevaPromocion = Promocion.builder()
                .titulo(titulo)
                .descripcion(descripcion)
                .descuentoPorcentaje(descuentoPorcentaje)
                .fechaInicio(fechaInicio)
                .fechaFin(fechaFin)
                .estado(estado)
                .imagenUrl(imagenUrl)
                .build();
        promocionRepository.save(nuevaPromocion);
    }

    public void editarPromocion(Integer id, String titulo, String descripcion, BigDecimal descuentoPorcentaje, LocalDate fechaInicio, LocalDate fechaFin, String estado, String imagenUrl) {
        Promocion promocion = promocionRepository.findById(id).orElseThrow();
        promocion.setTitulo(titulo);
        promocion.setDescripcion(descripcion);
        promocion.setDescuentoPorcentaje(descuentoPorcentaje);
        promocion.setFechaInicio(fechaInicio);
        promocion.setFechaFin(fechaFin);
        promocion.setEstado(estado);
        if (imagenUrl != null && !imagenUrl.isBlank()) {
            promocion.setImagenUrl(imagenUrl);
        }
        promocionRepository.save(promocion);
    }

    public void eliminarPromocion(Integer id) {
        promocionRepository.deleteById(id);
    }
}
