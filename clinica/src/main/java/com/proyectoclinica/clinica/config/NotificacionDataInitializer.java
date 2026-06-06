package com.proyectoclinica.clinica.config;

import com.proyectoclinica.clinica.modules.notificaciones.models.Notificacion;
import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import com.proyectoclinica.clinica.modules.notificaciones.repository.NotificacionRepository;
import com.proyectoclinica.clinica.modules.paciente.repository.PacienteRepository;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import java.time.LocalDateTime;

@Configuration
@RequiredArgsConstructor
public class NotificacionDataInitializer {
    private static final Logger log = LoggerFactory.getLogger(NotificacionDataInitializer.class);

    @Bean
    public CommandLineRunner initNotificaciones(NotificacionRepository notificacionRepository,
                                               PacienteRepository pacienteRepository) {
        return args -> {
            if (notificacionRepository.count() == 0) {
                log.info("Inicializando notificaciones de prueba...");
                Paciente luis = pacienteRepository.findByDni("75695332").orElse(null);
                
                if (luis == null) {
                    luis = pacienteRepository.findAll().stream().findFirst().orElse(null);
                }

                if (luis != null) {
                    notificacionRepository.save(Notificacion.builder()
                            .paciente(luis)
                            .mensaje("Tu receta para Losartán está lista para descargar.")
                            .icono("bi-capsule")
                            .fecha(LocalDateTime.now().minusMinutes(15))
                            .leida(false)
                            .build());

                    notificacionRepository.save(Notificacion.builder()
                            .paciente(luis)
                            .mensaje("Recordatorio: Mañana tienes una cita en Sede Central.")
                            .icono("bi-calendar-event")
                            .fecha(LocalDateTime.now().minusHours(2))
                            .leida(false)
                            .build());
                    
                    notificacionRepository.save(Notificacion.builder()
                            .paciente(luis)
                            .mensaje("Bienvenido a ClinicX, " + luis.getNombres() + "!")
                            .icono("bi-person-check")
                            .fecha(LocalDateTime.now().minusDays(1))
                            .leida(true)
                            .build());

                    log.info("Notificaciones de prueba creadas.");
                }
            }
        };
    }
}
