package com.proyectoclinica.clinica.modules.recursos.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "sedes")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Sede {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_sede")
    private Integer id;

    @Column(nullable = false, length = 100)
    private String nombre;

    @Column(nullable = false, length = 250)
    private String direccion;

    private String distrito;
    private String ciudad;
    private String telefono;
    private String email;

    @Column(name = "horario_lv")
    private String horarioLv;

    @Column(name = "horario_sabado")
    private String horarioSabado;

    @Column(name = "horario_domingo")
    private String horarioDomingo;

    @Column(name = "num_consultorios")
    private Integer numConsultorios;

    private String estado;
}
