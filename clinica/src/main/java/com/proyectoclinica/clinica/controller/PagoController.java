package com.proyectoclinica.clinica.controller;

import com.proyectoclinica.clinica.modules.farmacia.models.Pedido;
import com.proyectoclinica.clinica.modules.farmacia.repository.PedidoRepository;
import com.proyectoclinica.clinica.modules.citas.models.Cita;
import com.proyectoclinica.clinica.modules.citas.repository.CitaRepository;
import com.proyectoclinica.clinica.modules.facturacion.models.Pago;
import com.proyectoclinica.clinica.modules.facturacion.repository.PagoRepository;
import com.proyectoclinica.clinica.modules.facturacion.service.PagoService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;
import java.time.LocalDateTime;

@Controller
@RequestMapping("/pago")
@RequiredArgsConstructor
@Slf4j
public class PagoController {

    private final PedidoRepository pedidoRepository;
    private final CitaRepository citaRepository;
    private final PagoRepository pagoRepository;
    private final PagoService pagoService;

    @GetMapping("/mercado-pago/success")
    public String pagoExitoso(
            @RequestParam("payment_id") String paymentId,
            @RequestParam("status") String status,
            @RequestParam("external_reference") String externalReference) {
        
        log.info("Pago de Mercado Pago exitoso: paymentId={}, status={}, externalReference={}", paymentId, status, externalReference);
        
        try {
            Integer pedidoId = Integer.parseInt(externalReference);
            Optional<Pedido> pedidoOpt = pedidoRepository.findById(pedidoId);
            if (pedidoOpt.isPresent()) {
                Pedido pedido = pedidoOpt.get();
                pedido.setEstado("Pagado");
                pedidoRepository.save(pedido);
                log.info("Pedido {} marcado como Pagado.", pedidoId);
            } else {
                log.warn("No se encontró el pedido con ID {} para Mercado Pago", pedidoId);
            }
        } catch (NumberFormatException e) {
            log.error("Error al procesar external_reference '{}' como ID de pedido", externalReference, e);
        }
        
        return "redirect:/paciente/farmacia?exito=true";
    }

    @GetMapping("/cita/success")
    public String citaPagoExitoso(
            @RequestParam("payment_id") String paymentId,
            @RequestParam("status") String status,
            @RequestParam("external_reference") String externalReference) {
        
        log.info("Pago de Cita de Mercado Pago exitoso: paymentId={}, status={}, externalReference={}", paymentId, status, externalReference);
        
        try {
            Integer citaId = Integer.parseInt(externalReference);
            Optional<Cita> citaOpt = citaRepository.findById(citaId);
            if (citaOpt.isPresent()) {
                Cita cita = citaOpt.get();
                cita.setEstado("Confirmada"); 
                citaRepository.save(cita);
                
                String numeroComprobante = pagoService.generarNumeroComprobante("Boleta");
                
                Pago nuevoPago = Pago.builder()
                        .paciente(cita.getPaciente())
                        .servicio(cita.getServicio())
                        .monto(cita.getServicio() != null ? cita.getServicio().getPrecio() : new java.math.BigDecimal("50.00"))
                        .metodoPago("Mercado Pago")
                        .tipoComprobante("Boleta")
                        .numeroComprobante(numeroComprobante)
                        .fechaPago(LocalDateTime.now())
                        .estado("Completado")
                        .observaciones("Pago online por Mercado Pago, Cita #" + citaId + ", Transacción: " + paymentId)
                        .build();
                        
                pagoRepository.save(nuevoPago);
                log.info("Cita {} marcada como Confirmada y Pago registrado.", citaId);
            } else {
                log.warn("No se encontró la cita con ID {} para Mercado Pago", citaId);
            }
        } catch (Exception e) {
            log.error("Error al procesar external_reference '{}' como ID de cita", externalReference, e);
        }
        
        return "redirect:/paciente/citas?exito=true";
    }

    @GetMapping("/cita/failure")
    public String citaPagoFallido(
            @RequestParam(value = "external_reference", required = false) String externalReference) {
        log.warn("Pago de Cita de Mercado Pago fallido o cancelado. Referencia: {}", externalReference);
        return "redirect:/paciente/citas?error=pago_fallido";
    }

    @GetMapping("/cita/pending")
    public String citaPagoPendiente(
            @RequestParam(value = "external_reference", required = false) String externalReference) {
        log.info("Pago de Cita de Mercado Pago pendiente. Referencia: {}", externalReference);
        return "redirect:/paciente/citas?info=pago_pendiente";
    }

    @GetMapping("/mercado-pago/failure")
    public String pagoFallido(
            @RequestParam(value = "external_reference", required = false) String externalReference) {
        log.warn("Pago de Mercado Pago fallido o cancelado. Referencia: {}", externalReference);
        return "redirect:/paciente/farmacia?error=pago_fallido";
    }

    @GetMapping("/mercado-pago/pending")
    public String pagoPendiente(
            @RequestParam(value = "external_reference", required = false) String externalReference) {
        log.info("Pago de Mercado Pago pendiente. Referencia: {}", externalReference);
        return "redirect:/paciente/farmacia?info=pago_pendiente";
    }
}
