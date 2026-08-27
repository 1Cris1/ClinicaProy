package com.proyectoclinica.clinica.modules.seguridad.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "dispositivos_confianza")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DispositivoConfianza {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_usuario", nullable = false)
    private Usuario usuario;

    @Column(name = "device_cookie_id", nullable = false, unique = true, length = 64)
    private String deviceCookieId;

    @Column(name = "fecha_registro")
    @Builder.Default
    private LocalDateTime fechaRegistro = LocalDateTime.now();

    @Column(name = "fecha_ultimo_uso")
    @Builder.Default
    private LocalDateTime fechaUltimoUso = LocalDateTime.now();
    
    @Column(length = 255)
    private String userAgent;
    
    @Column(length = 45)
    private String ipAddress;
}
