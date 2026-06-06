package com.proyectoclinica.clinica.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import lombok.Data;

@Configuration
@ConfigurationProperties(prefix = "powerbi")
@Data
public class PowerBiProperties {
    
    private Base base = new Base();
    private Page page = new Page();
    private Filter filter = new Filter();

    @Data
    public static class Base {
        private String url;
    }

    @Data
    public static class Page {
        private String admin;
        private String medico;
        private String paciente;
        private String recepcion;
    }

    @Data
    public static class Filter {
        private Table table = new Table();

        @Data
        public static class Table {
            private String medicos;
            private String pacientes;
        }
    }
}
