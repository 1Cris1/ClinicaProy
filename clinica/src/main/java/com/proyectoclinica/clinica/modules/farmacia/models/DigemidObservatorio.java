package com.proyectoclinica.clinica.modules.farmacia.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Entity
@Table(name = "digemid_observatorio")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DigemidObservatorio {
    @Id
    @Column(name = "id_medicamento")
    private Integer idMedicamento;
    @Column(name = "nombre_producto")
    private String nombreProducto;
    @Column(name = "concentracion")
    private String concentracion;
    @Column(name = "forma_farmaceutica")
    private String formaFarmaceutica;
    @Column(name = "presentacion")
    private String presentacion;
    @Column(name = "registro_sanitario")
    private String registroSanitario;
}
