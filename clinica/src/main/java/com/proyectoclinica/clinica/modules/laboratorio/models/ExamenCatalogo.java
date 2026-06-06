package com.proyectoclinica.clinica.modules.laboratorio.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;
@Entity
@Table(name = "catalogo_examenes")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ExamenCatalogo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_examen")
    private Integer id;
    @Column(nullable = false, length = 150)
    private String nombre;
    @Column(length = 100)
    private String categoria; // Bioquímica, Hematología, Inmunología, etc.
    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal precio;
    @Column(name = "unidad_medida", length = 50)
    private String unidadMedida;
    @Column(name = "rango_min", precision = 10, scale = 2)
    private BigDecimal rangoMin;
    @Column(name = "rango_max", precision = 10, scale = 2)
    private BigDecimal rangoMax;
}
