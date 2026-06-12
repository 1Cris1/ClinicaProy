package com.proyectoclinica.clinica.modules.laboratorio.models;

import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import com.proyectoclinica.clinica.modules.recursos.models.Medico;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;
@Entity
@Table(name = "ordenes_laboratorio")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrdenLaboratorio {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_orden")
    private Integer id;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_paciente", nullable = false)
    private Paciente paciente;
    @ManyToOne
    @JoinColumn(name = "id_medico", nullable = false)
    private Medico medico;
    @Column(name = "fecha_solicitud")
    @Builder.Default
    private LocalDateTime fechaSolicitud = LocalDateTime.now();
    @Builder.Default
    private String estado = "Pendiente de toma"; // Pendiente de toma, En proceso, Validado, Entregado
    @Builder.Default
    private String prioridad = "Normal"; // Normal, STAT (Urgente)
    @Column(name = "observaciones_tecnicas", columnDefinition = "TEXT")
    private String observacionesTecnicas;
}
