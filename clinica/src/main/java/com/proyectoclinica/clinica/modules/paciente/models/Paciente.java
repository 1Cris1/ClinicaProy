package com.proyectoclinica.clinica.modules.paciente.models;

import com.proyectoclinica.clinica.modules.seguridad.models.Usuario;
import com.proyectoclinica.clinica.modules.recursos.models.Sede;
import com.proyectoclinica.clinica.modules.consultas.models.HistorialClinico;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "pacientes")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Paciente {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_paciente")
    private Integer id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_usuario", referencedColumnName = "id_usuario")
    private Usuario usuario;

    @Column(nullable = false, length = 100)
    private String nombres;

    @Column(nullable = false, length = 100)
    private String apellidos;

    @Column(unique = true, nullable = false, length = 8)
    private String dni;

    @Column(name = "fecha_nacimiento")
    private LocalDate fechaNacimiento;

    private String sexo;
    private String telefono;
    private String email;
    private String direccion;
    private String distrito;

    @Column(name = "tipo_sangre")
    private String tipoSangre;

    @Column(columnDefinition = "TEXT")
    private String alergias;

    private String seguro;

    @Column(name = "contacto_emergencia")
    private String contactoEmergencia;

    @Column(name = "telefono_emergencia")
    private String telefonoEmergencia;

    @ManyToOne(optional = true)
    @JoinColumn(name = "id_sede")
    private Sede sede;

    private String estado;

    @Column(name = "nombre_iafas")
    private String nombreIafas;

    @Column(name = "tipo_plan")
    private String tipoPlan;

    @Column(name = "estado_seguro")
    private String estadoSeguro;

    @Column(name = "fecha_sincronizacion_seguro")
    private LocalDateTime fechaSincronizacionSeguro;

    @Column(name = "enfermedades_cronicas", columnDefinition = "TEXT")
    private String enfermedadesCronicas;

    @Column(columnDefinition = "TEXT")
    private String antecedente;

    @OneToMany(mappedBy = "paciente", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<HistorialClinico> historiales;
}
