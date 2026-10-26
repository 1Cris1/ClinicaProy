package com.proyectoclinica.clinica.modules.farmacia.service;

import com.proyectoclinica.clinica.modules.farmacia.models.Producto;
import com.proyectoclinica.clinica.modules.farmacia.repository.ProductoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductoService {

    private final ProductoRepository productoRepository;

    public List<Producto> listarProductos() {
        return productoRepository.findAll();
    }

    public List<Producto> listarActivos() {
        return productoRepository.findByEstado("Activo");
    }
    
    public long contarProductos() {
        return productoRepository.count();
    }

    public void registrarProducto(String nombre, String descripcion, BigDecimal precio, BigDecimal precioDescuento, String categoria, Integer stock, String estado, String imagenUrl, java.time.LocalDate fechaVencimiento, String lote, Integer stockMinimo, String proveedor) {
        Producto producto = Producto.builder()
                .nombre(nombre)
                .descripcion(descripcion)
                .precio(precio)
                .precioDescuento(precioDescuento)
                .categoria(categoria)
                .stock(stock)
                .estado(estado)
                .imagenUrl(imagenUrl)
                .fechaVencimiento(fechaVencimiento)
                .lote(lote)
                .stockMinimo(stockMinimo != null ? stockMinimo : 10)
                .proveedor(proveedor)
                .build();
        productoRepository.save(producto);
    }

    public void editarProducto(Integer id, String nombre, String descripcion, BigDecimal precio, BigDecimal precioDescuento, String categoria, Integer stock, String estado, String imagenUrl, java.time.LocalDate fechaVencimiento, String lote, Integer stockMinimo, String proveedor) {
        Producto producto = productoRepository.findById(id).orElseThrow();
        producto.setNombre(nombre);
        producto.setDescripcion(descripcion);
        producto.setPrecio(precio);
        producto.setPrecioDescuento(precioDescuento);
        producto.setCategoria(categoria);
        producto.setStock(stock);
        producto.setEstado(estado);
        if (imagenUrl != null && !imagenUrl.isBlank()) {
            producto.setImagenUrl(imagenUrl);
        }
        producto.setFechaVencimiento(fechaVencimiento);
        producto.setLote(lote);
        producto.setStockMinimo(stockMinimo != null ? stockMinimo : 10);
        producto.setProveedor(proveedor);
        productoRepository.save(producto);
    }

    public boolean eliminarProducto(Integer id) {
        try {
            productoRepository.deleteById(id);
            return true;
        } catch (DataIntegrityViolationException e) {
            productoRepository.findById(id).ifPresent(p -> {
                p.setEstado("Inactivo");
                p.setStock(0);
                productoRepository.save(p);
            });
            return false;
        }
    }
}
