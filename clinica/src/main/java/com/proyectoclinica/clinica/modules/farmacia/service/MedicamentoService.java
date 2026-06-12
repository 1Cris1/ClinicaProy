package com.proyectoclinica.clinica.modules.farmacia.service;

import com.proyectoclinica.clinica.modules.farmacia.models.DigemidObservatorio;
import com.proyectoclinica.clinica.modules.farmacia.repository.DigemidObservatorioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MedicamentoService {
    private final DigemidObservatorioRepository digemidRepository;

    /**
     * Busca medicamentos en el catálogo oficial de DIGEMID por nombre
     * @param nombre Término de búsqueda (ej: "Paracetamol")
     * @return Lista de medicamentos que coinciden
     */
    public List<DigemidObservatorio> buscarMedicamentos(String nombre) {
        if (nombre == null || nombre.length() < 3) {
            return List.of();
        }
        return digemidRepository.findByNombreProductoContainingIgnoreCase(nombre);
    }

    /**
     * Obtiene una lista sugerida de medicamentos (primeros 20)
     */
    public List<DigemidObservatorio> obtenerCatalogoSugerido() {
        return digemidRepository.findAll().stream().limit(20).toList();
    }
}
