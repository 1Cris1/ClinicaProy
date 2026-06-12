package com.proyectoclinica.clinica.controller;

import com.proyectoclinica.clinica.modules.citas.models.Cita;
import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import com.proyectoclinica.clinica.modules.laboratorio.models.ResultadoLaboratorio;
import com.proyectoclinica.clinica.modules.consultas.models.HistorialClinico;
import com.proyectoclinica.clinica.modules.consultas.service.HistorialClinicoService;
import com.proyectoclinica.clinica.modules.farmacia.models.Producto;
import com.proyectoclinica.clinica.modules.citas.service.CitasService;
import com.proyectoclinica.clinica.modules.laboratorio.service.LaboratorioService;
import com.proyectoclinica.clinica.modules.integraciones.service.ApiPeruService;
import com.proyectoclinica.clinica.modules.integraciones.service.IcdService;
import com.proyectoclinica.clinica.modules.farmacia.service.MedicamentoService;
import com.proyectoclinica.clinica.modules.paciente.repository.PacienteRepository;
import com.proyectoclinica.clinica.modules.farmacia.repository.FarmaciaTedefRepository;
import com.proyectoclinica.clinica.modules.farmacia.models.FarmaciaTedef;
import com.proyectoclinica.clinica.modules.farmacia.models.DigemidObservatorio;
import com.proyectoclinica.clinica.modules.recursos.repository.MedicoRepository;
import com.proyectoclinica.clinica.modules.farmacia.repository.ProductoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.util.*;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
public class ApiController {
    private final CitasService citasService;
    private final LaboratorioService laboratorioService;
    private final HistorialClinicoService historialClinicoService;
    private final PacienteRepository pacienteRepository;
    private final MedicoRepository medicoRepository;
    private final ProductoRepository productoRepository;
    private final ApiPeruService apiPeruService;
    private final IcdService icdService;
    private final FarmaciaTedefRepository farmaciaTedefRepository;
    private final MedicamentoService medicamentoService;

    @GetMapping("/citas/hoy")
    public List<Cita> getCitasHoy() {
        return citasService.listarCitasPorFecha(LocalDate.now());
    }

    @GetMapping("/citas/medico/{id}")
    public List<Cita> getCitasMedico(@PathVariable Integer id, @RequestParam(required = false) String fecha) {
        LocalDate localDate = (fecha != null) ? LocalDate.parse(fecha) : LocalDate.now();
        return citasService.listarCitasPorMedicoYFecha(id, localDate);
    }

    @PatchMapping("/citas/{id}/estado")
    public ResponseEntity<?> updateCitaEstado(@PathVariable Integer id, @RequestBody Map<String, String> body) {
        String estado = body.get("estado");
        citasService.actualizarEstado(id, estado);
        return ResponseEntity.ok(Map.of("success", true));
    }

    @GetMapping("/pacientes/{id}/resultados")
    public List<ResultadoLaboratorio> getResultadosPaciente(@PathVariable Integer id) {
        return laboratorioService.listarPorPaciente(id);
    }

    @GetMapping("/pacientes/dni/{dni}")
    public ResponseEntity<Paciente> getPacienteByDni(@PathVariable String dni) {
        return pacienteRepository.findByDni(dni)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/external/dni/{dni}")
    public Map<String, Object> lookupExternalDni(@PathVariable String dni) {
        return apiPeruService.consultarDni(dni);
    }

    @GetMapping("/external/cie11/search")
    public Map<String, Object> searchCie11(@RequestParam String q) {
        return icdService.buscarTermino(q);
    }

    @GetMapping("/external/farmacia/search")
    public List<FarmaciaTedef> searchFarmacia(@RequestParam String q) {
        return farmaciaTedefRepository.findByVcodprodFar003(q);
    }

    @GetMapping("/external/medicamentos/search")
    public List<DigemidObservatorio> searchMedicamentos(@RequestParam String q) {
        return medicamentoService.buscarMedicamentos(q);
    }

    @GetMapping("/historia/paciente/{id}")
    public List<HistorialClinico> getHistoriaPaciente(@PathVariable Integer id) {
        return historialClinicoService.listarPorPaciente(id);
    }

    @PostMapping("/historia")
    public HistorialClinico saveHistoria(@RequestBody HistorialClinico historia) {
        return historialClinicoService.guardar(historia);
    }

    @GetMapping("/farmacia/productos")
    public List<Producto> getProductos(@RequestParam(required = false) String q) {
        if (q != null && !q.isBlank()) {
            return productoRepository.findByNombreContainingIgnoreCaseAndEstado(q, "Activo");
        }
        return productoRepository.findAll();
    }

    @GetMapping("/admin/stats")
    public Map<String, Object> getAdminStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("citasHoy", citasService.contarCitasHoy());
        stats.put("atendidosHoy", citasService.contarAtendidosHoy());
        stats.put("pacientesTotal", pacienteRepository.count());
        stats.put("medicosTotal", medicoRepository.count());
        return stats;
    }

    @GetMapping("/admin/health")
    public Map<String, Object> getHealth() {
        Map<String, Object> health = new HashMap<>();
        health.put("status", "UP");
        health.put("services", List.of(
            Map.of("name", "paciente-service", "status", "UP"),
            Map.of("name", "citas-service", "status", "UP"),
            Map.of("name", "historia-clinica-service", "status", "UP"),
            Map.of("name", "laboratorio-service", "status", "UP"),
            Map.of("name", "farmacia-service", "status", "UP")
        ));
        return health;
    }
}
