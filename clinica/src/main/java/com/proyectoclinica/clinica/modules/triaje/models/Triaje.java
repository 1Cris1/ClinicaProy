package com.proyectoclinica.clinica.modules.triaje.models;

import com.proyectoclinica.clinica.modules.citas.models.Cita;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "triaje")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Triaje {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_triaje")
    private Integer idTriaje;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_cita", nullable = false)
    private Cita cita;

    @Column(precision = 5, scale = 2)
    private BigDecimal peso;

    @Column(precision = 3, scale = 2)
    private BigDecimal talla;

    @Column(name = "presion_arterial", length = 20)
    private String presionArterial;

    @Column(precision = 4, scale = 2)
    private BigDecimal temperatura;

    @Column(name = "frecuencia_cardiaca")
    private Integer frecuenciaCardiaca;

    @Column(name = "saturacion_oxigeno")
    private Integer saturacionOxigeno;

    @Column(name = "fecha_registro")
    @Builder.Default
    private LocalDateTime fechaRegistro = LocalDateTime.now();
}
