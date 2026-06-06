package com.proyectoclinica.clinica.modules.consultas.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "medicamentos_prescritos")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MedicamentoPrescrito {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_medicamento_prescrito")
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_receta", nullable = false)
    private Receta receta;

    @Column(nullable = false)
    private String nombre;
    private String dosis;
    private String frecuencia;
    private String duracion;
    
    @Column(length = 500)
    private String instrucciones;
}
