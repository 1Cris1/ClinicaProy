package com.proyectoclinica.clinica.modules.seguridad.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "auditoria_usuarios")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AuditoriaUsuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_auditoria")
    private Integer idAuditoria;

    @Column(name = "username")
    private String username;

    @Column(name = "id_usuario")
    private Integer idUsuario;

    @Column(name = "fecha_evento")
    private LocalDateTime fechaEvento;

    @Column(name = "tipo_evento")
    private String tipoEvento;

    @Column(name = "direccion_ip")
    private String direccionIp;

    @Column(name = "detalles", columnDefinition = "TEXT")
    private String detalles;
}
