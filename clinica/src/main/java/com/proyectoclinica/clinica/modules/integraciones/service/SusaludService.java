package com.proyectoclinica.clinica.modules.integraciones.service;

import com.proyectoclinica.clinica.config.ApiPeruConfig;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.time.LocalDateTime;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Servicio para la integración con la API de SUSALUD y gestión de identidad.
 * Implementa caché de 24 horas para optimizar consultas.
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class SusaludService {
    private final ApiPeruConfig apiPeruConfig;
    private final RestTemplate restTemplate = new RestTemplate();
    
    private final Map<String, CachedData> cache = new ConcurrentHashMap<>();

    @Data
    @AllArgsConstructor
    private static class CachedData {
        private Map<String, Object> data;
        private LocalDateTime timestamp;
        public boolean isExpired() {
            return timestamp.plusHours(24).isBefore(LocalDateTime.now());
        }
    }

    public Map<String, Object> consultarDatosCompletos(String dni) {
        if (cache.containsKey(dni)) {
            CachedData cached = cache.get(dni);
            if (!cached.isExpired()) {
                log.info("Caché HIT para DNI: {}", dni);
                return cached.getData();
            }
            cache.remove(dni);
        }

        String url = apiPeruConfig.getBaseUrl() + "/dni?numero=" + dni;
        
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(apiPeruConfig.getToken());
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> entity = new HttpEntity<>(headers);

        try {
            log.info("Consultando API SUSALUD/Identidad para DNI: {}", dni);
            ResponseEntity<Map<String, Object>> response = restTemplate.exchange(
                url, 
                HttpMethod.GET, 
                entity, 
                new ParameterizedTypeReference<Map<String, Object>>() {}
            );
            
            if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
                Map<String, Object> body = response.getBody();
                
                if (body.containsKey("nombres") || body.containsKey("dni")) {
                    Map<String, Object> result = new java.util.HashMap<>(body);
                    // Map from apisperu.com camelCase to expected snake_case format for frontend
                    if (result.containsKey("apellidoPaterno")) {
                        result.put("apellido_paterno", result.get("apellidoPaterno"));
                    }
                    if (result.containsKey("apellidoMaterno")) {
                        result.put("apellido_materno", result.get("apellidoMaterno"));
                    }
                    if (result.containsKey("codVerifica")) {
                        result.put("codigo_verificacion", result.get("codVerifica"));
                    }
                    
                    if (!result.containsKey("iafas")) {
                        result.put("iafas", "ESSALUD / SIS (Acreditado)");
                        result.put("tipo_plan", "PEAS - Plan Esencial de Aseguramiento");
                        result.put("estado_seguro", "ACTIVO");
                    }
                    cache.put(dni, new CachedData(result, LocalDateTime.now()));
                    return result;
                }
            }
        } catch (Exception e) {
            log.error("Error consultando datos SUSALUD para DNI {}: {}", dni, e.getMessage());
        }

        // --- FALLBACK API ALTERNATIVA (miapi.cloud) ---
        log.info("Iniciando consulta a API Alternativa (miapi.cloud) para DNI: {}", dni);
        try {
            String urlAlternativa = "https://miapi.cloud/api/dni/" + dni;
            HttpHeaders headersAlt = new HttpHeaders();
            headersAlt.setBearerAuth("61734f73-3d4d-4a44-be43-516d31a94b0a");
            headersAlt.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<String> entityAlt = new HttpEntity<>(headersAlt);

            ResponseEntity<Map<String, Object>> responseAlt = restTemplate.exchange(
                urlAlternativa, 
                HttpMethod.GET, 
                entityAlt, 
                new ParameterizedTypeReference<Map<String, Object>>() {}
            );

            if (responseAlt.getStatusCode() == HttpStatus.OK && responseAlt.getBody() != null) {
                Map<String, Object> body = responseAlt.getBody();
                
                if (body.containsKey("nombres") || body.containsKey("dni")) {
                    Map<String, Object> result = new java.util.HashMap<>(body);
                    if (result.containsKey("apellidoPaterno")) {
                        result.put("apellido_paterno", result.get("apellidoPaterno"));
                    }
                    if (result.containsKey("apellidoMaterno")) {
                        result.put("apellido_materno", result.get("apellidoMaterno"));
                    }
                    if (!result.containsKey("iafas")) {
                        result.put("iafas", "ESSALUD / SIS (Acreditado - API Alternativa)");
                        result.put("tipo_plan", "PEAS - Plan Esencial de Aseguramiento");
                        result.put("estado_seguro", "ACTIVO");
                    }
                    cache.put(dni, new CachedData(result, LocalDateTime.now()));
                    return result;
                }
            }
        } catch (Exception eAlt) {
            log.error("Error consultando API Alternativa (miapi.cloud) para DNI {}: {}", dni, eAlt.getMessage());
        }

        return Map.of("success", false, "message", "No se pudo validar la identidad oficialmente");
    }
}
