package com.proyectoclinica.clinica.modules.shared.service;

import com.proyectoclinica.clinica.modules.laboratorio.models.OrdenLaboratorio;
import com.proyectoclinica.clinica.modules.laboratorio.models.ResultadoDetalle;
import com.proyectoclinica.clinica.modules.laboratorio.repository.ResultadoDetalleRepository;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.springframework.stereotype.Service;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ReportService {
    private final ResultadoDetalleRepository resultadoDetalleRepository;

    public byte[] generarReporteLaboratorio(OrdenLaboratorio orden) throws JRException {
        List<ResultadoDetalle> detalles = resultadoDetalleRepository.findByOrdenId(orden.getId());
        // Parámetros para el reporte
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("nombrePaciente", orden.getPaciente().getNombres() + " " + orden.getPaciente().getApellidos());
        parameters.put("dniPaciente", orden.getPaciente().getDni());
        parameters.put("medicoSolicitante", orden.getMedico().getNombres() + " " + orden.getMedico().getApellidos());
        parameters.put("fechaOrden", orden.getFechaSolicitud().toString());
        parameters.put("idOrden", orden.getId().toString());
        // DataSource para la tabla de resultados
        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(detalles);
        // Cargar y compilar el reporte (archivo .jrxml en resources/reports)
        InputStream reportStream = getClass().getResourceAsStream("/reports/resultado_laboratorio.jrxml");
        JasperReport jasperReport = JasperCompileManager.compileReport(reportStream);
        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, dataSource);
        return JasperExportManager.exportReportToPdf(jasperPrint);
    }
}
