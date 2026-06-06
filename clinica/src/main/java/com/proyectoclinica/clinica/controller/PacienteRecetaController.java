package com.proyectoclinica.clinica.controller;

import com.proyectoclinica.clinica.modules.consultas.service.RecetaService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
@RequestMapping("/paciente/recetas")
@RequiredArgsConstructor
public class PacienteRecetaController {
    private final RecetaService recetaService;
    @GetMapping("/descargar/{id}")
    public ResponseEntity<byte[]> descargarReceta(@PathVariable Integer id) {
        try {
            byte[] pdfContents = recetaService.generarPdfReceta(id);
            
            String filename = "Receta_" + id + ".pdf";
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filename + "\"")
                    .contentType(MediaType.APPLICATION_PDF)
                    .body(pdfContents);
                    
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }
}
