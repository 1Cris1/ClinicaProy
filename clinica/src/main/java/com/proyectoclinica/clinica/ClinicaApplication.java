package com.proyectoclinica.clinica;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import com.proyectoclinica.clinica.config.PowerBiProperties;
@SpringBootApplication
@EnableConfigurationProperties({PowerBiProperties.class})
public class ClinicaApplication {
	public static void main(String[] args) {
		SpringApplication.run(ClinicaApplication.class, args);
	}
}
