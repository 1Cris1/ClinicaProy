package com.proyectoclinica.clinica.config;

import com.mercadopago.MercadoPagoConfig;
import jakarta.annotation.PostConstruct;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "mercadopago")
@Data
public class MercadoPagoProperties {
    /**
     * Clave pública de Mercado Pago.
     */
    private String publicKey;

    /**
     * Token de acceso privado de Mercado Pago.
     */
    private String accessToken;

    @PostConstruct
    public void init() {
        if (accessToken != null && !accessToken.trim().isEmpty()) {
            MercadoPagoConfig.setAccessToken(accessToken);
        }
    }
}
