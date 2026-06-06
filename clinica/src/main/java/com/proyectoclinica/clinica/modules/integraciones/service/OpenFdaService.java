package com.proyectoclinica.clinica.modules.integraciones.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class OpenFdaService {
    private final RestTemplate restTemplate = new RestTemplate();
    private static final String BASE_URL = "https://api.fda.gov/drug/label.json";

    /**
     * Busca información de un medicamento en OpenFDA (Dosis, Contraindicaciones).
     * @param query Nombre del medicamento (genérico o comercial en inglés/estándar).
     * @return Mapa con la información relevante.
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> buscarInfoMedicamento(String query) {
        try {
            String url = UriComponentsBuilder.fromUriString(BASE_URL)
                    .queryParam("search", "openfda.generic_name:\"" + query + "\" OR openfda.brand_name:\"" + query + "\"")
                    .queryParam("limit", 1)
                    .build()
                    .toUriString();
            Map<String, Object> response = restTemplate.getForObject(url, Map.class);
            if (response != null && response.containsKey("results")) {
                List<Map<String, Object>> results = (List<Map<String, Object>>) response.get("results");
                if (!results.isEmpty()) {
                    Map<String, Object> first = results.get(0);
                    Map<String, Object> filtered = new HashMap<>();
                    
                    filtered.put("dosage_and_administration", getFirstElement(first, "dosage_and_administration"));
                    filtered.put("contraindications", getFirstElement(first, "contraindications"));
                    filtered.put("warnings", getFirstElement(first, "warnings"));
                    filtered.put("indications_and_usage", getFirstElement(first, "indications_and_usage"));
                    return filtered;
                }
            }
        } catch (Exception e) {
            log.warn("Error consultando OpenFDA para '{}': {}", query, e.getMessage());
        }
        return null;
    }

    private String getFirstElement(Map<String, Object> map, String key) {
        if (map.containsKey(key)) {
            Object obj = map.get(key);
            if (obj instanceof List && !((List<?>) obj).isEmpty()) {
                return ((List<?>) obj).get(0).toString();
            }
        }
        return "Información no disponible";
    }
}
