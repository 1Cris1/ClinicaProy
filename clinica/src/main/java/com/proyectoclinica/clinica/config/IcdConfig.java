package com.proyectoclinica.clinica.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "icd.api")
@Data
public class IcdConfig {
    /**
     * Client ID para la API de la OMS (ICD-11)
     */
    private String clientid;

    /**
     * Client Secret para la API de la OMS (ICD-11)
     */
    private String clientsecret;

    /**
     * URL para obtener el token de acceso
     */
    private String tokenurl;

    /**
     * URL base para las consultas de la API
     */
    private String baseUrl = "https://id.who.int/icd/release/11/2024-01/mms";
}
