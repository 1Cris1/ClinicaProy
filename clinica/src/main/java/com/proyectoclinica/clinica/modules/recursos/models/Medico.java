package com.proyectoclinica.clinica.modules.recursos.models;

import com.proyectoclinica.clinica.modules.seguridad.models.Usuario;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "medicos")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Medico {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_medico")
    private Integer id;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "id_usuario", referencedColumnName = "id_usuario")
    private Usuario usuario;

    @Column(nullable = false, length = 100)
    private String nombres;

    @Column(nullable = false, length = 100)
    private String apellidos;

    @Column(unique = true, nullable = false, length = 10)
    private String cmp;

    @Column(unique = true, nullable = false, length = 8)
    private String dni;

    @ManyToOne
    @JoinColumn(name = "id_especialidad", nullable = false)
    private Especialidad especialidad;

    @ManyToOne
    @JoinColumn(name = "id_sede", nullable = false)
    private Sede sede;

    private String telefono;
    private String email;
    private String consultorio;

    @Column(name = "horario_lv")
    private String horarioLv;

    @Column(name = "horario_sabado")
    private String horarioSabado;

    @Column(name = "duracion_cita")
    private Integer duracionCita;

    private Double satisfaccion;

    @Column(name = "anio_ingreso")
    private Integer anioIngreso;

    private String estado;

    @Column(name = "foto_url")
    private String fotoUrl;
}
