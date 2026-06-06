package com.proyectoclinica.clinica.config;

import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import com.proyectoclinica.clinica.modules.recursos.models.Medico;
import com.proyectoclinica.clinica.modules.consultas.models.Receta;
import com.proyectoclinica.clinica.modules.consultas.models.MedicamentoPrescrito;
import com.proyectoclinica.clinica.modules.paciente.repository.PacienteRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.MedicoRepository;
import com.proyectoclinica.clinica.modules.consultas.repository.RecetaRepository;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import java.time.LocalDate;
import java.util.ArrayList;

@Configuration
@RequiredArgsConstructor
public class RecetaDataInitializer {
    private static final Logger log = LoggerFactory.getLogger(RecetaDataInitializer.class);

    @Bean
    public CommandLineRunner initRecetas(RecetaRepository recetaRepository,
                                        PacienteRepository pacienteRepository,
                                        MedicoRepository medicoRepository) {
        return args -> {
            if (recetaRepository.count() == 0) {
                log.info("Inicializando recetas de prueba...");
                Paciente luis = pacienteRepository.findByDni("75695332").orElse(null);
                if (luis == null) {
                    luis = pacienteRepository.findAll().stream().findFirst().orElse(null);
                }
                Medico medico = medicoRepository.findAll().stream().findFirst().orElse(null);
                
                if (luis != null && medico != null) {
                    Receta r1 = Receta.builder()
                            .codigo("R-2026-0412")
                            .paciente(luis)
                            .medico(medico)
                            .fechaEmision(LocalDate.now().minusDays(5))
                            .estado("Activa")
                            .medicamentos(new ArrayList<>())
                            .build();
                    
                    r1.getMedicamentos().add(MedicamentoPrescrito.builder()
                            .receta(r1).nombre("Atorvastatina 20mg").dosis("1 tableta").frecuencia("Cada noche").duracion("30 días")
                            .instrucciones("Tomar después de la cena.").build());
                    
                    r1.getMedicamentos().add(MedicamentoPrescrito.builder()
                            .receta(r1).nombre("Losartán 50mg").dosis("1 tableta").frecuencia("Cada mañana").duracion("60 días")
                            .instrucciones("Tomar en ayunas.").build());
                    
                    recetaRepository.save(r1);

                    Receta r2 = Receta.builder()
                            .codigo("R-2026-0215")
                            .paciente(luis)
                            .medico(medico)
                            .fechaEmision(LocalDate.of(2026, 2, 15))
                            .estado("Finalizada")
                            .medicamentos(new ArrayList<>())
                            .build();
                            
                    r2.getMedicamentos().add(MedicamentoPrescrito.builder()
                            .receta(r2).nombre("Amoxicilina 500mg").dosis("1 cápsula").frecuencia("Cada 8 horas").duracion("7 días")
                            .instrucciones("Completar tratamiento.").build());
                            
                    recetaRepository.save(r2);
                    log.info("Recetas de prueba creadas.");
                }
            }
        };
    }
}
