package com.proyectoclinica.clinica.modules.laboratorio.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;
@Entity
@Table(name = "resultados_detalle")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ResultadoDetalle {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_detalle")
    private Integer id;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_orden", nullable = false)
    private OrdenLaboratorio orden;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_examen", nullable = false)
    private ExamenCatalogo examen;
    @Column(precision = 10, scale = 2)
    private BigDecimal valor;
    @Column(length = 50)
    private String unidad; // Unidad utilizada en el ingreso
    @Column(columnDefinition = "TEXT")
    private String observaciones;
}
