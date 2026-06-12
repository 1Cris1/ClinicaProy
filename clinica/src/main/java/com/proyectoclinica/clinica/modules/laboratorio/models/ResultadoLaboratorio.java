package com.proyectoclinica.clinica.modules.laboratorio.models;

import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDate;
@Entity
@Table(name = "resultados_laboratorio")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ResultadoLaboratorio {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_resultado")
    private Integer idResultado;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_paciente", nullable = false)
    @com.fasterxml.jackson.annotation.JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private Paciente paciente;
    @Column(name = "nombre_examen", nullable = false, length = 150)
    private String nombreExamen;
    @Column(name = "orden", length = 50)
    private String orden;
    @Column(name = "sede_laboratorio", length = 100)
    private String sedeLaboratorio;
    @Column(name = "estado", length = 50)
    @Builder.Default
    private String estado = "En proceso"; // Puede ser: "En proceso" o "Disponible"
    @Column(name = "tipo_examen", length = 50)
    private String tipoExamen; // "Laboratorio" o "Imagen"
    @Column(name = "fecha_examen")
    private LocalDate fechaExamen;
    @Column(name = "fecha_vencimiento")
    private LocalDate fechaVencimiento;
}
