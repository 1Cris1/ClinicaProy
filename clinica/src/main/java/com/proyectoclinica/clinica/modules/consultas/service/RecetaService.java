package com.proyectoclinica.clinica.modules.consultas.service;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.proyectoclinica.clinica.modules.consultas.models.MedicamentoPrescrito;
import com.proyectoclinica.clinica.modules.consultas.models.Receta;
import com.proyectoclinica.clinica.modules.consultas.repository.RecetaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RecetaService {

    private final RecetaRepository recetaRepository;

    private static final DateTimeFormatter FORMATO_FECHA =
            DateTimeFormatter.ofPattern("dd/MM/yyyy");

    public List<Receta> obtenerRecetasPorPaciente(Integer idPaciente) {
        return recetaRepository.findByPacienteIdOrderByFechaEmisionDesc(idPaciente);
    }

    public List<Receta> obtenerRecetasActivas(Integer idPaciente) {
        return recetaRepository.findByPacienteIdAndEstadoOrderByFechaEmisionDesc(
                idPaciente,
                "Activa"
        );
    }

    public List<Receta> obtenerHistorialRecetas(Integer idPaciente) {
        return recetaRepository.findByPacienteIdAndEstadoOrderByFechaEmisionDesc(
                idPaciente,
                "Finalizada"
        );
    }

    public byte[] generarPdfReceta(Integer idReceta) throws Exception {

        Receta receta = recetaRepository.findById(idReceta)
                .orElseThrow(() -> new RuntimeException("Receta no encontrada"));

        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        Document document = new Document(
                PageSize.A4,
                40,
                40,
                35,
                35
        );

        PdfWriter.getInstance(document, baos);

        document.open();

        Font titulo = FontFactory.getFont(
                FontFactory.HELVETICA_BOLD,
                22,
                new Color(0,102,204)
        );

        Font subtitulo = FontFactory.getFont(
                FontFactory.HELVETICA_BOLD,
                14,
                new Color(80,80,80)
        );

        Font seccion = FontFactory.getFont(
                FontFactory.HELVETICA_BOLD,
                11,
                Color.WHITE
        );

        Font bold = FontFactory.getFont(
                FontFactory.HELVETICA_BOLD,
                10,
                Color.BLACK
        );

        Font normal = FontFactory.getFont(
                FontFactory.HELVETICA,
                10,
                Color.BLACK
        );

        Font pequena = FontFactory.getFont(
                FontFactory.HELVETICA,
                8,
                Color.GRAY
        );
            //====================================================
        // ENCABEZADO
        //====================================================

        Paragraph pTitulo = new Paragraph("CLINICX", titulo);
        pTitulo.setAlignment(Element.ALIGN_CENTER);
        pTitulo.setSpacingAfter(5);
        document.add(pTitulo);

        Paragraph pSubtitulo = new Paragraph(
                "RECETA MÉDICA ELECTRÓNICA",
                subtitulo
        );

        pSubtitulo.setAlignment(Element.ALIGN_CENTER);
        pSubtitulo.setSpacingAfter(20);

        document.add(pSubtitulo);

        PdfPTable tablaCabecera = new PdfPTable(2);
        tablaCabecera.setWidthPercentage(100);
        tablaCabecera.setWidths(new float[]{50,50});
        tablaCabecera.setSpacingAfter(20);

        PdfPCell celdaCodigo = new PdfPCell(
                new Phrase(
                        "Código: " + receta.getCodigo(),
                        bold
                )
        );

        celdaCodigo.setPadding(8);
        celdaCodigo.setBackgroundColor(new Color(230,240,255));

        PdfPCell celdaFecha = new PdfPCell(
                new Phrase(
                        "Fecha: " + receta.getFechaEmision().format(FORMATO_FECHA),
                        bold
                )
        );

        celdaFecha.setPadding(8);
        celdaFecha.setBackgroundColor(new Color(230,240,255));

        PdfPCell celdaMedico = new PdfPCell(
                new Phrase(
                        "Médico: Dr(a). "
                                + receta.getMedico().getNombres()
                                + " "
                                + receta.getMedico().getApellidos(),
                        normal
                )
        );

        celdaMedico.setPadding(8);

        PdfPCell celdaEspecialidad = new PdfPCell(
                new Phrase(
                        "Especialidad: "
                                + receta.getMedico()
                                        .getEspecialidad()
                                        .getNombre(),
                        normal
                )
        );

        celdaEspecialidad.setPadding(8);

        tablaCabecera.addCell(celdaCodigo);
        tablaCabecera.addCell(celdaFecha);
        tablaCabecera.addCell(celdaMedico);
        tablaCabecera.addCell(celdaEspecialidad);

        document.add(tablaCabecera);

        //====================================================
        // DATOS DEL PACIENTE
        //====================================================

        PdfPCell tituloPaciente = new PdfPCell(
                new Phrase("DATOS DEL PACIENTE", seccion)
        );

        tituloPaciente.setColspan(2);
        tituloPaciente.setPadding(8);
        tituloPaciente.setHorizontalAlignment(Element.ALIGN_CENTER);
        tituloPaciente.setBackgroundColor(new Color(0,102,204));
        tituloPaciente.setBorder(Rectangle.NO_BORDER);

        PdfPTable tablaPaciente = new PdfPTable(2);
        tablaPaciente.setWidthPercentage(100);
        tablaPaciente.setWidths(new float[]{30,70});
        tablaPaciente.setSpacingAfter(20);

        tablaPaciente.addCell(tituloPaciente);

        PdfPCell lblNombre = new PdfPCell(new Phrase("Nombre", bold));
        lblNombre.setBackgroundColor(new Color(245,245,245));
        lblNombre.setPadding(7);

        PdfPCell txtNombre = new PdfPCell(
                new Phrase(
                        receta.getPaciente().getNombres()
                                + " "
                                + receta.getPaciente().getApellidos(),
                        normal
                )
        );

        txtNombre.setPadding(7);

        PdfPCell lblDni = new PdfPCell(new Phrase("DNI", bold));
        lblDni.setBackgroundColor(new Color(245,245,245));
        lblDni.setPadding(7);

        PdfPCell txtDni = new PdfPCell(
                new Phrase(
                        receta.getPaciente().getDni(),
                        normal
                )
        );

        txtDni.setPadding(7);

        PdfPCell lblEstado = new PdfPCell(new Phrase("Estado", bold));
        lblEstado.setBackgroundColor(new Color(245,245,245));
        lblEstado.setPadding(7);

        PdfPCell txtEstado = new PdfPCell(
                new Phrase(
                        receta.getEstado(),
                        normal
                )
        );

        txtEstado.setPadding(7);

        tablaPaciente.addCell(lblNombre);
        tablaPaciente.addCell(txtNombre);

        tablaPaciente.addCell(lblDni);
        tablaPaciente.addCell(txtDni);

        tablaPaciente.addCell(lblEstado);
        tablaPaciente.addCell(txtEstado);

        document.add(tablaPaciente);
            //====================================================
        // MEDICAMENTOS 
        //====================================================

        PdfPCell tituloMedicamentos = new PdfPCell(
                new Phrase("MEDICAMENTOS", seccion)
        );

        tituloMedicamentos.setColspan(5);
        tituloMedicamentos.setPadding(8);
        tituloMedicamentos.setHorizontalAlignment(Element.ALIGN_CENTER);
        tituloMedicamentos.setBackgroundColor(new Color(0,102,204));
        tituloMedicamentos.setBorder(Rectangle.NO_BORDER);

        PdfPTable tablaMedicamentos = new PdfPTable(5);

        tablaMedicamentos.setWidthPercentage(100);

        tablaMedicamentos.setWidths(
                new float[]{28,14,18,15,25}
        );

        tablaMedicamentos.setSpacingAfter(20);

        tablaMedicamentos.addCell(tituloMedicamentos);

        Color colorCabecera = new Color(225,238,255);

        PdfPCell hMedicamento = new PdfPCell(new Phrase("Medicamento", bold));
        hMedicamento.setHorizontalAlignment(Element.ALIGN_CENTER);
        hMedicamento.setBackgroundColor(colorCabecera);
        hMedicamento.setPadding(6);

        PdfPCell hDosis = new PdfPCell(new Phrase("Dosis", bold));
        hDosis.setHorizontalAlignment(Element.ALIGN_CENTER);
        hDosis.setBackgroundColor(colorCabecera);
        hDosis.setPadding(6);

        PdfPCell hFrecuencia = new PdfPCell(new Phrase("Frecuencia", bold));
        hFrecuencia.setHorizontalAlignment(Element.ALIGN_CENTER);
        hFrecuencia.setBackgroundColor(colorCabecera);
        hFrecuencia.setPadding(6);

        PdfPCell hDuracion = new PdfPCell(new Phrase("Duración", bold));
        hDuracion.setHorizontalAlignment(Element.ALIGN_CENTER);
        hDuracion.setBackgroundColor(colorCabecera);
        hDuracion.setPadding(6);

        PdfPCell hIndicaciones = new PdfPCell(new Phrase("Indicaciones", bold));
        hIndicaciones.setHorizontalAlignment(Element.ALIGN_CENTER);
        hIndicaciones.setBackgroundColor(colorCabecera);
        hIndicaciones.setPadding(6);

        tablaMedicamentos.addCell(hMedicamento);
        tablaMedicamentos.addCell(hDosis);
        tablaMedicamentos.addCell(hFrecuencia);
        tablaMedicamentos.addCell(hDuracion);
        tablaMedicamentos.addCell(hIndicaciones);

        boolean alternarColor = false;

        for (MedicamentoPrescrito med : receta.getMedicamentos()) {

            Color colorFila = alternarColor
                    ? new Color(248,248,248)
                    : Color.WHITE;

            PdfPCell cMedicamento = new PdfPCell(
                    new Phrase(
                            med.getNombre(),
                            normal
                    )
            );

            cMedicamento.setPadding(6);
            cMedicamento.setBackgroundColor(colorFila);

            PdfPCell cDosis = new PdfPCell(
                    new Phrase(
                            med.getDosis(),
                            normal
                    )
            );

            cDosis.setPadding(6);
            cDosis.setBackgroundColor(colorFila);

            PdfPCell cFrecuencia = new PdfPCell(
                    new Phrase(
                            med.getFrecuencia(),
                            normal
                    )
            );

            cFrecuencia.setPadding(6);
            cFrecuencia.setBackgroundColor(colorFila);

            PdfPCell cDuracion = new PdfPCell(
                    new Phrase(
                            med.getDuracion(),
                            normal
                    )
            );

            cDuracion.setPadding(6);
            cDuracion.setBackgroundColor(colorFila);

            PdfPCell cIndicaciones = new PdfPCell(
                    new Phrase(
                            med.getInstrucciones(),
                            normal
                    )
            );

            cIndicaciones.setPadding(6);
            cIndicaciones.setBackgroundColor(colorFila);

            tablaMedicamentos.addCell(cMedicamento);
            tablaMedicamentos.addCell(cDosis);
            tablaMedicamentos.addCell(cFrecuencia);
            tablaMedicamentos.addCell(cDuracion);
            tablaMedicamentos.addCell(cIndicaciones);

            alternarColor = !alternarColor;
        }

        document.add(tablaMedicamentos);
            //====================================================
        // INDICACIONES GENERALES
        //====================================================

        PdfPCell tituloIndicaciones = new PdfPCell(
                new Phrase("INDICACIONES GENERALES", seccion)
        );

        tituloIndicaciones.setBackgroundColor(new Color(0,102,204));
        tituloIndicaciones.setHorizontalAlignment(Element.ALIGN_CENTER);
        tituloIndicaciones.setPadding(8);
        tituloIndicaciones.setBorder(Rectangle.NO_BORDER);

        PdfPTable tablaIndicaciones = new PdfPTable(1);
        tablaIndicaciones.setWidthPercentage(100);
        tablaIndicaciones.setSpacingAfter(30);

        tablaIndicaciones.addCell(tituloIndicaciones);

        PdfPCell contenidoIndicaciones = new PdfPCell(
                new Phrase(
                        "• Siga estrictamente la dosis y frecuencia indicada por el médico.\n\n"
                      + "• No suspenda el tratamiento sin autorización médica.\n\n"
                      + "• Si presenta alguna reacción adversa, comuníquese con la clínica.\n\n"
                      + "• Mantenga los medicamentos fuera del alcance de los niños.\n\n"
                      + "• Conserve este documento para futuros controles.",
                        normal
                )
        );

        contenidoIndicaciones.setPadding(12);

        tablaIndicaciones.addCell(contenidoIndicaciones);

        document.add(tablaIndicaciones);

        //====================================================
        // FIRMA
        //====================================================

        Paragraph lineaFirma = new Paragraph(
                "____________________________________________"
        );

        lineaFirma.setAlignment(Element.ALIGN_CENTER);

        document.add(lineaFirma);

        Paragraph medicoFirma = new Paragraph(
                "Dr(a). "
                        + receta.getMedico().getNombres()
                        + " "
                        + receta.getMedico().getApellidos(),
                bold
        );

        medicoFirma.setAlignment(Element.ALIGN_CENTER);

        document.add(medicoFirma);

        Paragraph especialidadFirma = new Paragraph(
                receta.getMedico()
                        .getEspecialidad()
                        .getNombre(),
                normal
        );

        especialidadFirma.setAlignment(Element.ALIGN_CENTER);

        document.add(especialidadFirma);

        Paragraph fechaDocumento = new Paragraph(
                "Fecha de emisión: "
                        + receta.getFechaEmision().format(FORMATO_FECHA),
                normal
        );

        fechaDocumento.setAlignment(Element.ALIGN_CENTER);

        fechaDocumento.setSpacingAfter(25);

        document.add(fechaDocumento);

        //====================================================
        // PIE DE PÁGINA
        //====================================================

        Paragraph pie = new Paragraph(
                "CLINICX - Sistema Integral de Gestión Clínica\n"
              + "Documento generado electrónicamente.\n"
              + "La información contenida en esta receta es confidencial.",
                pequena
        );

        pie.setAlignment(Element.ALIGN_CENTER);

        document.add(pie);

        document.close();

        return baos.toByteArray();

    }

}