package com.proyectoclinica.clinica.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "apiperu")
@Data
public class ApiPeruConfig {
    /**
     * Token de autenticación para apiperu.dev
     */
    private String token;

    /**
     * URL base de la API de apiperu.dev
     */
    private String baseUrl;
}
