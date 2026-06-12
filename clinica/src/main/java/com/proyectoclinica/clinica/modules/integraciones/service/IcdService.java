package com.proyectoclinica.clinica.modules.integraciones.service;

import com.proyectoclinica.clinica.config.IcdConfig;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.core.ParameterizedTypeReference;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class IcdService {
    private final IcdConfig icdConfig;
    private final RestTemplate restTemplate = new RestTemplate();
    
    private String cachedToken;
    private long tokenExpiryTime;

    private String getAccessToken() {
        if (cachedToken != null && System.currentTimeMillis() < tokenExpiryTime) {
            return cachedToken;
        }
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
        map.add("client_id", icdConfig.getClientid());
        map.add("client_secret", icdConfig.getClientsecret());
        map.add("scope", "icdapi_access");
        map.add("grant_type", "client_credentials");
        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, headers);
        try {
            ResponseEntity<Map<String, Object>> response = restTemplate.exchange(
                icdConfig.getTokenurl(),
                HttpMethod.POST,
                request,
                new ParameterizedTypeReference<Map<String, Object>>() {}
            );
            
            if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
                Map<String, Object> body = response.getBody();
                cachedToken = (String) body.get("access_token");
                Integer expiresIn = (Integer) body.get("expires_in");
                tokenExpiryTime = System.currentTimeMillis() + (expiresIn != null ? (expiresIn - 60) * 1000 : 3540 * 1000);
                return cachedToken;
            }
        } catch (Exception e) {
            log.error("Error obteniendo token de ICD API: {}", e.getMessage());
        }
        return null;
    }

    public Map<String, Object> buscarTermino(String query) {
        String token = getAccessToken();
        if (token == null) {
            return Map.of("success", false, "message", "No se pudo autenticar con la API de la OMS");
        }
        String url = icdConfig.getBaseUrl() + "/search?q=" + query;
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(token);
        headers.set("API-Version", "v2");
        headers.set("Accept-Language", "es");
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> entity = new HttpEntity<>(headers);
        try {
            log.info("Buscando '{}' en CIE-11", query);
            ResponseEntity<Map<String, Object>> response = restTemplate.exchange(
                url,
                HttpMethod.GET,
                entity,
                new ParameterizedTypeReference<Map<String, Object>>() {}
            );
            return response.getBody();
        } catch (Exception e) {
            log.error("Error buscando en CIE-11: {}", e.getMessage());
        }
        return Map.of("success", false, "message", "Error al consultar la API de la OMS");
    }
}
