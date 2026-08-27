package com.proyectoclinica.clinica.modules.farmacia.service;

import com.proyectoclinica.clinica.modules.farmacia.models.Pedido;
import com.proyectoclinica.clinica.modules.farmacia.repository.PedidoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

import com.proyectoclinica.clinica.modules.farmacia.repository.DetallePedidoRepository;
import com.proyectoclinica.clinica.modules.farmacia.repository.ProductoRepository;
import com.proyectoclinica.clinica.modules.farmacia.models.Producto;
import com.proyectoclinica.clinica.modules.farmacia.models.DetallePedido;
import com.proyectoclinica.clinica.dto.PedidoRequest;
import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import com.mercadopago.client.preference.PreferenceItemRequest;


import java.math.BigDecimal;
import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class PedidoService {

    private final PedidoRepository pedidoRepository;
    private final DetallePedidoRepository detallePedidoRepository;
    private final ProductoRepository productoRepository;

    public List<Pedido> listarTodos() {
        return pedidoRepository.findAll();
    }

    public List<Pedido> listarPedidosPorPaciente(Integer pacienteId) {
        return pedidoRepository.findByPacienteIdOrderByFechaPedidoDesc(pacienteId);
    }

    @org.springframework.transaction.annotation.Transactional
    public Pedido crearPedido(Paciente paciente, PedidoRequest pedidoReq, List<PreferenceItemRequest> mpItemsOut) {
        Pedido pedido = Pedido.builder()
                .paciente(paciente)
                .fechaPedido(LocalDateTime.now())
                .estado("Pendiente")
                .notas(pedidoReq.getNotas())
                .total(BigDecimal.ZERO)
                .build();

        pedido = pedidoRepository.save(pedido);
        BigDecimal total = BigDecimal.ZERO;

        for (PedidoRequest.ItemPedido item : pedidoReq.getItems()) {
            Producto producto = productoRepository.findById(item.getIdProducto()).orElse(null);
            if (producto != null) {
                BigDecimal precioFinal = producto.getPrecioDescuento() != null ? producto.getPrecioDescuento()
                        : producto.getPrecio();
                
                if ("Unidad".equalsIgnoreCase(item.getPresentacion())) {
                    precioFinal = precioFinal.divide(new BigDecimal(10), 2, java.math.RoundingMode.HALF_UP);
                }

                BigDecimal subtotal = precioFinal.multiply(new BigDecimal(item.getCantidad()));
                total = total.add(subtotal);

                DetallePedido detalle = DetallePedido.builder()
                        .pedido(pedido)
                        .producto(producto)
                        .cantidad(item.getCantidad())
                        .precioUnitario(precioFinal)
                        .subtotal(subtotal)
                        .build();
                detallePedidoRepository.save(detalle);

                PreferenceItemRequest mpItem = PreferenceItemRequest.builder()
                        .id(producto.getId().toString())
                        .title(producto.getNombre() + ( "Unidad".equalsIgnoreCase(item.getPresentacion()) ? " (Unidad)" : " (Caja)" ))
                        .quantity(item.getCantidad())
                        .unitPrice(precioFinal)
                        .currencyId("PEN")
                        .build();
                mpItemsOut.add(mpItem);
            }
        }
        
        pedido.setTotal(total);
        return pedidoRepository.save(pedido);
    }
}
