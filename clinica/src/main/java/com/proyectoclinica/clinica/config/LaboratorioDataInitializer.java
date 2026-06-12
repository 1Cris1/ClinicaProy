package com.proyectoclinica.clinica.config;

import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import com.proyectoclinica.clinica.modules.recursos.models.Medico;
import com.proyectoclinica.clinica.modules.laboratorio.models.*;
import com.proyectoclinica.clinica.modules.paciente.repository.PacienteRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.MedicoRepository;
import com.proyectoclinica.clinica.modules.laboratorio.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Arrays;

@Configuration
@RequiredArgsConstructor
@Order(10)
public class LaboratorioDataInitializer implements CommandLineRunner {
    private final ExamenCatalogoRepository examenRepository;
    private final OrdenLaboratorioRepository ordenRepository;
    private final ResultadoDetalleRepository detalleRepository;
    private final PacienteRepository pacienteRepository;
    private final MedicoRepository medicoRepository;

    @Override
    public void run(String... args) throws Exception {
        if (examenRepository.count() > 0) return;

        ExamenCatalogo glucosa = ExamenCatalogo.builder()
                .nombre("Glucosa Basal")
                .categoria("Bioquímica")
                .precio(new BigDecimal("15.00"))
                .unidadMedida("mg/dL")
                .rangoMin(new BigDecimal("70.00"))
                .rangoMax(new BigDecimal("110.00"))
                .build();

        ExamenCatalogo hemoglobina = ExamenCatalogo.builder()
                .nombre("Hemoglobina")
                .categoria("Hematología")
                .precio(new BigDecimal("25.00"))
                .unidadMedida("g/dL")
                .rangoMin(new BigDecimal("13.50"))
                .rangoMax(new BigDecimal("17.50"))
                .build();

        ExamenCatalogo colesterol = ExamenCatalogo.builder()
                .nombre("Colesterol Total")
                .categoria("Perfil Lipídico")
                .precio(new BigDecimal("20.00"))
                .rangoMin(new BigDecimal("0.00"))
                .rangoMax(new BigDecimal("200.00"))
                .build();

        examenRepository.saveAll(Arrays.asList(glucosa, hemoglobina, colesterol));

        Paciente paciente = pacienteRepository.findAll().stream().findFirst().orElse(null);
        Medico medico = medicoRepository.findAll().stream().findFirst().orElse(null);

        if (paciente != null && medico != null) {
            OrdenLaboratorio orden1 = OrdenLaboratorio.builder()
                    .paciente(paciente)
                    .medico(medico)
                    .fechaSolicitud(LocalDateTime.now().minusDays(15))
                    .estado("Validado")
                    .prioridad("Normal")
                    .observacionesTecnicas("Muestra procesada correctamente.")
                    .build();
            ordenRepository.save(orden1);

            detalleRepository.save(ResultadoDetalle.builder()
                    .orden(orden1)
                    .examen(glucosa)
                    .valor(new BigDecimal("92.5"))
                    .unidad("mg/dL")
                    .build());

            OrdenLaboratorio orden2 = OrdenLaboratorio.builder()
                    .paciente(paciente)
                    .medico(medico)
                    .fechaSolicitud(LocalDateTime.now().minusDays(2))
                    .estado("Validado")
                    .prioridad("STAT")
                    .observacionesTecnicas("Prioridad por cuadro clínico.")
                    .build();
            ordenRepository.save(orden2);

            detalleRepository.save(ResultadoDetalle.builder()
                    .orden(orden2)
                    .examen(glucosa)
                    .valor(new BigDecimal("145.0"))
                    .unidad("mg/dL")
                    .observaciones("Resultado anormal, requiere control.")
                    .build());

            detalleRepository.save(ResultadoDetalle.builder()
                    .orden(orden2)
                    .examen(hemoglobina)
                    .valor(new BigDecimal("14.2"))
                    .unidad("g/dL")
                    .build());
        }
    }
}
