package com.proyectoclinica.clinica.modules.facturacion.service;

import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.atomic.AtomicInteger;

@Service
public class PagoService {
    private final AtomicInteger contadorBoletas = new AtomicInteger(0);
    private final AtomicInteger contadorFacturas = new AtomicInteger(0);
    private final AtomicInteger contadorTickets = new AtomicInteger(0);

    // EXPOSICIÓN JHOAN: Destacar el uso de AtomicInteger para que, si dos recepcionistas cobran a la vez, no se duplique el número de comprobante (concurrencia segura).
    public String generarNumeroComprobante(String tipoComprobante) {
        String prefijo;
        AtomicInteger contador;
        switch (tipoComprobante) {
            case "Factura":
                prefijo = "F001";
                contador = contadorFacturas;
                break;
            case "Ticket":
                prefijo = "T";
                contador = contadorTickets;
                break;
            default:
                prefijo = "B001";
                contador = contadorBoletas;
        }
        String fecha = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        return prefijo + "-" + fecha + "-" + String.format("%06d", contador.incrementAndGet());
    }
}
