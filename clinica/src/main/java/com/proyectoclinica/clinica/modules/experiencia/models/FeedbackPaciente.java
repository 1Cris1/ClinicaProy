package com.proyectoclinica.clinica.modules.experiencia.models;

import com.proyectoclinica.clinica.modules.citas.models.Cita;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "feedback_paciente")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FeedbackPaciente {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_feedback")
    private Integer idFeedback;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_cita", nullable = false)
    private Cita cita;

    @Column(name = "puntuacion")
    private Integer puntuacion;

    @Column(name = "comentario", columnDefinition = "TEXT")
    private String comentario;

    @Column(name = "fecha_envio")
    @Builder.Default
    private LocalDateTime fechaEnvio = LocalDateTime.now();
}
