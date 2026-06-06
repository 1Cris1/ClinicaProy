package com.proyectoclinica.clinica.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.proyectoclinica.clinica.modules.recursos.repository.SedeRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.EspecialidadRepository;
import com.proyectoclinica.clinica.modules.recursos.models.Sede;
import com.proyectoclinica.clinica.modules.recursos.models.Especialidad;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.List;

@Configuration
public class SedeEspecialidadDataInitializer {
    private static final Logger log = LoggerFactory.getLogger(SedeEspecialidadDataInitializer.class);

    @Bean
    public CommandLineRunner initSedesEspecialidades(SedeRepository sedeRepository, EspecialidadRepository especialidadRepository) {
        return args -> {
            if (sedeRepository.count() == 0) {
                log.info("Inicializando sedes por defecto...");
                List<Sede> sedes = List.of(
                    Sede.builder()
                        .nombre("Clínica Centro Lima")
                        .direccion("Av. Arenales 1256, Centro de Lima")
                        .distrito("Lima Centro")
                        .ciudad("Lima")
                        .telefono("(01) 424-1234")
                        .email("centrolima@clinicx.pe")
                        .horarioLv("07:00 - 20:00")
                        .horarioSabado("08:00 - 14:00")
                        .horarioDomingo("Cerrado")
                        .numConsultorios(12)
                        .estado("Activo")
                        .build(),
                    Sede.builder()
                        .nombre("Clínica Miraflores")
                        .direccion("Av. Larco 890, Miraflores")
                        .distrito("Miraflores")
                        .ciudad("Lima")
                        .telefono("(01) 445-5678")
                        .email("miraflores@clinicx.pe")
                        .horarioLv("07:00 - 21:00")
                        .horarioSabado("08:00 - 16:00")
                        .horarioDomingo("09:00 - 13:00")
                        .numConsultorios(8)
                        .estado("Activo")
                        .build(),
                    Sede.builder()
                        .nombre("Clínica San Isidro")
                        .direccion("Av. Javier Prado Este 2150, San Isidro")
                        .distrito("San Isidro")
                        .ciudad("Lima")
                        .telefono("(01) 512-8901")
                        .email("sanisidro@clinicx.pe")
                        .numConsultorios(10)
                        .estado("Activo")
                        .build(),
                    Sede.builder()
                        .nombre("Clínica Surco")
                        .direccion("Av. El Derby 250, Surco")
                        .distrito("Santiago de Surco")
                        .ciudad("Lima")
                        .telefono("(01) 634-2100")
                        .email("surco@clinicx.pe")
                        .horarioSabado("08:00 - 15:00")
                        .numConsultorios(6)
                        .estado("Activo")
                        .build()
                );
                sedeRepository.saveAll(sedes);
                log.info("Sedes creadas con éxito.");
            }

            if (especialidadRepository.count() == 0) {
                log.info("Inicializando especialidades por defecto...");
                List<Especialidad> especialidades = List.of(
                    Especialidad.builder()
                        .nombre("Medicina General")
                        .descripcion("Atención primaria.")
                        .icono("bi-activity")
                        .color("#2563EB")
                        .estado(true)
                        .imagenUrl("https://placehold.co/400x300/DBEAFE/1E40AF?text=Medicina+General")
                        .build(),
                    Especialidad.builder()
                        .nombre("Pediatría")
                        .descripcion("Cuidado de niños.")
                        .icono("bi-heart-pulse")
                        .color("#059669")
                        .estado(true)
                        .imagenUrl("https://placehold.co/400x300/D1FAE5/065F46?text=Pediatría")
                        .build(),
                    Especialidad.builder()
                        .nombre("Ginecología")
                        .descripcion("Salud femenina.")
                        .icono("bi-people")
                        .color("#DB2777")
                        .estado(true)
                        .imagenUrl("https://placehold.co/400x300/FCE7F3/9D174D?text=Ginecología")
                        .build(),
                    Especialidad.builder()
                        .nombre("Cardiología")
                        .descripcion("Salud del corazón.")
                        .icono("bi-heart")
                        .color("#DC2626")
                        .estado(true)
                        .imagenUrl("https://placehold.co/400x300/FEE2E2/991B1B?text=Cardiología")
                        .build()
                );
                especialidadRepository.saveAll(especialidades);
                log.info("Especialidades creadas con éxito.");
            }
        };
    }
}
