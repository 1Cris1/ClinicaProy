package com.proyectoclinica.clinica.controller;

import com.proyectoclinica.clinica.modules.integraciones.service.OpenFdaService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import java.util.Map;
@RestController
@RequestMapping("/api/v1/external")
@RequiredArgsConstructor
public class ExternalApiController {
    private final OpenFdaService openFdaService;
    @GetMapping("/medicamentos/info")
    public ResponseEntity<Map<String, Object>> getMedicamentoInfo(@RequestParam String q) {
        Map<String, Object> info = openFdaService.buscarInfoMedicamento(q);
        if (info != null) {
            return ResponseEntity.ok(info);
        }
        return ResponseEntity.notFound().build();
    }
}
