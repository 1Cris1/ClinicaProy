package com.proyectoclinica.clinica.modules.integraciones.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import com.proyectoclinica.clinica.config.ApiPeruConfig;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class ApiPeruService {
    private final ApiPeruConfig apiPeruConfig;
    private final RestTemplate restTemplate = new RestTemplate();

    /**
     * HISTORIA DE USUARIO: Validación de Identidad (DNI)
     * Integrante: 4
     * Consulta los datos de un DNI en apiperu.dev
     * @param dni El número de DNI a consultar
     * @return Mapa con la respuesta de la API
     */
    public Map<String, Object> consultarDni(String dni) {
        String url = apiPeruConfig.getBaseUrl() + "/dni?numero=" + dni;
        
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(apiPeruConfig.getToken());
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> entity = new HttpEntity<>(headers);
        try {
            log.info("Consultando DNI {} en apis.net.pe", dni);
            ResponseEntity<Map<String, Object>> response = restTemplate.exchange(
                url, 
                HttpMethod.GET, 
                entity, 
                new org.springframework.core.ParameterizedTypeReference<Map<String, Object>>() {}
            );
            
            if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
                return response.getBody();
            }
        } catch (Exception e) {
            log.error("Error consultando DNI {} en apiperu.dev: {}", dni, e.getMessage());
        }
        return Map.of("success", false, "message", "No se pudo obtener información del DNI");
    }
}
