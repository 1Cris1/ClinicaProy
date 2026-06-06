package com.proyectoclinica.clinica.modules.seguridad.models;

import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import com.proyectoclinica.clinica.modules.recursos.models.Medico;
import com.proyectoclinica.clinica.modules.recursos.models.Administrador;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "usuarios")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Usuario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_usuario")
    private Integer id;

    @Column(nullable = false, length = 100)
    private String username;

    @Column(nullable = false)
    private String password;

    @Builder.Default
    private String email = "no-email@test.com";

    @Builder.Default
    @Column(name = "id_rol", nullable = false)
    private Integer idRol = 1;

    @Transient
    private Rol rol;

    public Rol getRol() {
        if (idRol == null) return null;
        return switch (idRol) {
            case 1 -> Rol.ROLE_ADMIN;
            case 2 -> Rol.ROLE_MEDICO;
            case 3 -> Rol.ROLE_PACIENTE;
            case 4 -> Rol.ROLE_RECEPCIONISTA;
            default -> null;
        };
    }

    public void setRol(Rol rol) {
        this.rol = rol;
        if (rol != null) {
            this.idRol = switch (rol) {
                case ROLE_ADMIN -> 1;
                case ROLE_MEDICO -> 2;
                case ROLE_PACIENTE -> 3;
                case ROLE_RECEPCIONISTA -> 4;
            };
        }
    }

    @Builder.Default
    private Integer estado = 1;

    @Builder.Default
    @Enumerated(EnumType.STRING)
    @Column(name = "estado_registro")
    private EstadoRegistro estadoRegistro = EstadoRegistro.PENDIENTE;

    @Column(name = "ultimo_acceso")
    private LocalDateTime ultimoAcceso;

    @Builder.Default
    @Column(name = "fecha_creacion", updatable = false)
    private LocalDateTime fechaCreacion = LocalDateTime.now();

    @Builder.Default
    @Column(name = "fecha_actualizacion")
    private LocalDateTime fechaActualizacion = LocalDateTime.now();

    @OneToOne(mappedBy = "usuario", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Administrador administrador;

    @OneToOne(mappedBy = "usuario", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Medico medico;

    @OneToOne(mappedBy = "usuario", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Paciente paciente;
}
