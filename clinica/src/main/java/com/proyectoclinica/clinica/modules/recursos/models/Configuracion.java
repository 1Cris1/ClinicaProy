package com.proyectoclinica.clinica.modules.recursos.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "configuracion")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Configuracion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_config")
    private Integer idConfig;

    @Column(name = "nombre_clinica", nullable = false)
    private String nombreClinica;

    @Column(length = 11)
    private String ruc;
    private String direccion;

    @Column(length = 20)
    private String telefono;

    @Column(name = "email_contacto")
    private String emailContacto;

    @Column(name = "logo_url")
    private String logoUrl;

    @Column(name = "horario_atencion")
    private String horarioAtencion;
}
