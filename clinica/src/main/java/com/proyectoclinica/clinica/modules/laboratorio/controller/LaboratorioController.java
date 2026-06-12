package com.proyectoclinica.clinica.modules.laboratorio.controller;

import com.proyectoclinica.clinica.modules.laboratorio.models.OrdenLaboratorio;
import com.proyectoclinica.clinica.modules.laboratorio.models.ResultadoDetalle;
import com.proyectoclinica.clinica.modules.laboratorio.repository.ExamenCatalogoRepository;
import com.proyectoclinica.clinica.modules.laboratorio.repository.OrdenLaboratorioRepository;
import com.proyectoclinica.clinica.modules.laboratorio.repository.ResultadoDetalleRepository;
import com.proyectoclinica.clinica.modules.shared.service.ReportService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequestMapping("/laboratorio")
@RequiredArgsConstructor
public class LaboratorioController {
    private final OrdenLaboratorioRepository ordenRepository;
    private final ExamenCatalogoRepository examenCatalogoRepository;
    private final ResultadoDetalleRepository resultadoDetalleRepository;
    private final ReportService reportService;

    private static final String LAYOUT = "layout-admin";

    @GetMapping("/gestion")
    public String gestion(Model model) {
        List<OrdenLaboratorio> ordenes = ordenRepository.findAll();
        model.addAttribute("ordenes", ordenes);
        model.addAttribute("pageTitle", "Gestión de Órdenes - Laboratorio");
        model.addAttribute("view", "laboratorio/gestion");
        return LAYOUT;
    }

    @GetMapping("/orden/{id}")
    public String verOrden(@PathVariable Integer id, Model model) {
        OrdenLaboratorio orden = ordenRepository.findById(id).orElseThrow();
        List<ResultadoDetalle> detalles = resultadoDetalleRepository.findByOrdenId(id);
        
        model.addAttribute("orden", orden);
        model.addAttribute("detalles", detalles);
        model.addAttribute("catalogo", examenCatalogoRepository.findAll());
        model.addAttribute("pageTitle", "Detalle de Orden #" + id);
        model.addAttribute("view", "laboratorio/entrada-datos");
        return LAYOUT;
    }

    @PostMapping("/orden/actualizar-estado")
    @ResponseBody
    public String actualizarEstado(@RequestParam Integer id, @RequestParam String estado) {
        OrdenLaboratorio orden = ordenRepository.findById(id).orElse(null);
        if (orden != null) {
            orden.setEstado(estado);
            ordenRepository.save(orden);
            return "OK";
        }
        return "ERROR";
    }

    @GetMapping("/orden/{id}/pdf")
    public ResponseEntity<byte[]> descargarPdf(@PathVariable Integer id) {
        try {
            OrdenLaboratorio orden = ordenRepository.findById(id).orElseThrow();
            byte[] pdf = reportService.generarReporteLaboratorio(orden);
            
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.setContentDispositionFormData("filename", "Resultado_Laboratorio_" + id + ".pdf");
            return ResponseEntity.ok().headers(headers).body(pdf);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }
}
