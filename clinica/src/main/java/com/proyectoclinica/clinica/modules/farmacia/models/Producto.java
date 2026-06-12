package com.proyectoclinica.clinica.modules.farmacia.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;
@Entity
@Table(name = "productos")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Producto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_producto")
    private Integer id;
    @Column(nullable = false, length = 255)
    private String nombre;
    @Column(columnDefinition = "TEXT")
    private String descripcion;
    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal precio;
    
    @Column(precision = 10, scale = 2)
    private BigDecimal precioDescuento;
    @Column(length = 100)
    private String categoria;
    @Column(length = 50)
    private String estado;
    @Column(name = "imagen_url", length = 255)
    private String imagenUrl;
    @Column(nullable = false)
    private Integer stock;
}
