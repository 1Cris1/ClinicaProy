package com.proyectoclinica.clinica.dto;

import lombok.Data;
import java.util.List;

@Data
public class PedidoRequest {
    private List<ItemPedido> items;
    private String notas;

    @Data
    public static class ItemPedido {
        private Integer idProducto;
        private Integer cantidad;
    }
}
