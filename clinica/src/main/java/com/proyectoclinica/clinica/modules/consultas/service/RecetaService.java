package com.proyectoclinica.clinica.modules.consultas.service;

import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.proyectoclinica.clinica.modules.consultas.models.MedicamentoPrescrito;
import com.proyectoclinica.clinica.modules.consultas.models.Receta;
import com.proyectoclinica.clinica.modules.consultas.repository.RecetaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.io.ByteArrayOutputStream;
import java.awt.Color;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RecetaService {
    private final RecetaRepository recetaRepository;

    public List<Receta> obtenerRecetasPorPaciente(Integer idPaciente) {
        return recetaRepository.findByPacienteIdOrderByFechaEmisionDesc(idPaciente);
    }

    public List<Receta> obtenerRecetasActivas(Integer idPaciente) {
        return recetaRepository.findByPacienteIdAndEstadoOrderByFechaEmisionDesc(idPaciente, "Activa");
    }

    public List<Receta> obtenerHistorialRecetas(Integer idPaciente) {
        return recetaRepository.findByPacienteIdAndEstadoOrderByFechaEmisionDesc(idPaciente, "Finalizada");
    }

    public byte[] generarPdfReceta(Integer idReceta) throws Exception {
        Receta receta = recetaRepository.findById(idReceta)
                .orElseThrow(() -> new RuntimeException("Receta no encontrada"));

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Document document = new Document(PageSize.A5);
        PdfWriter.getInstance(document, baos);
        document.open();

        Font fontTitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16, Color.BLUE);
        Font fontSubtitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Color.DARK_GRAY);
        Font fontNormal = FontFactory.getFont(FontFactory.HELVETICA, 10);
        Font fontBold = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10);
        Font fontChica = FontFactory.getFont(FontFactory.HELVETICA, 8);

        Paragraph header = new Paragraph("ClinicX", fontTitulo);
        header.setAlignment(Element.ALIGN_CENTER);
        document.add(header);

        Paragraph subHeader = new Paragraph("Tu Salud, Nuestra Prioridad", fontChica);
        subHeader.setAlignment(Element.ALIGN_CENTER);
        subHeader.setSpacingAfter(20);
        document.add(subHeader);

        PdfPTable infoTable = new PdfPTable(2);
        infoTable.setWidthPercentage(100);
        
        infoTable.addCell(getCell("Código: " + receta.getCodigo(), fontBold, false));
        infoTable.addCell(getCell("Fecha: " + receta.getFechaEmision().toString(), fontNormal, false));
        infoTable.addCell(getCell("Médico: " + receta.getMedico().getNombres(), fontBold, false));
        infoTable.addCell(getCell("Especialidad: " + receta.getMedico().getEspecialidad().getNombre(), fontNormal, false));
        infoTable.setSpacingAfter(15);
        document.add(infoTable);

        Paragraph pPaciente = new Paragraph("PACIENTE: " + receta.getPaciente().getNombres() + " " + receta.getPaciente().getApellidos(), fontBold);
        pPaciente.setSpacingAfter(10);
        document.add(pPaciente);

        document.add(new Paragraph("__________________________________________________________"));

        Paragraph pPrescripcion = new Paragraph("PRESCRIPCIÓN MÉDICA", fontSubtitulo);
        pPrescripcion.setSpacingBefore(10);
        pPrescripcion.setSpacingAfter(10);
        document.add(pPrescripcion);

        for (MedicamentoPrescrito item : receta.getMedicamentos()) {
            Paragraph pMed = new Paragraph("- " + item.getNombre() + " (" + item.getDosis() + ")", fontBold);
            document.add(pMed);
            
            Paragraph pInst = new Paragraph("  Tomar por " + item.getDuracion() + ". " + item.getInstrucciones(), fontNormal);
            pInst.setSpacingAfter(5);
            document.add(pInst);
        }

        document.add(new Paragraph("\n\n\n"));
        Paragraph pFirma = new Paragraph("__________________________", fontNormal);
        pFirma.setAlignment(Element.ALIGN_CENTER);
        document.add(pFirma);

        Paragraph pSello = new Paragraph("Firma y Sello del Médico", fontChica);
        pSello.setAlignment(Element.ALIGN_CENTER);
        document.add(pSello);

        document.close();
        return baos.toByteArray();
    }

    private PdfPCell getCell(String text, Font font, boolean border) {
        PdfPCell cell = new PdfPCell(new Phrase(text, font));
        if (!border) cell.setBorder(Rectangle.NO_BORDER);
        return cell;
    }
}
