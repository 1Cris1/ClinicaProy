package com.proyectoclinica.clinica.modules.laboratorio.service;

import com.proyectoclinica.clinica.modules.laboratorio.models.OrdenLaboratorio;

import org.openpdf.text.Document;
import org.openpdf.text.DocumentException;
import org.openpdf.text.Element;
import org.openpdf.text.Font;
import org.openpdf.text.FontFactory;
import org.openpdf.text.PageSize;
import org.openpdf.text.Paragraph;
import org.openpdf.text.Phrase;
import org.openpdf.text.pdf.PdfPCell;
import org.openpdf.text.pdf.PdfPTable;
import org.openpdf.text.pdf.PdfWriter;

import org.springframework.stereotype.Service;

import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;

@Service
public class OrdenLaboratorioPdfService {

    public byte[] generarPdf(OrdenLaboratorio orden) {

        ByteArrayOutputStream salida = new ByteArrayOutputStream();
        Document documento = new Document(PageSize.A4);

        try {
            PdfWriter.getInstance(documento, salida);
            documento.open();

            Font titulo = FontFactory.getFont(
                    FontFactory.HELVETICA_BOLD,
                    18,
                    new Color(13, 110, 253)
            );

            Font subtitulo = FontFactory.getFont(
                    FontFactory.HELVETICA_BOLD,
                    12,
                    Color.DARK_GRAY
            );

            Font normal = FontFactory.getFont(
                    FontFactory.HELVETICA,
                    10,
                    Color.BLACK
            );

            Paragraph nombreClinica = new Paragraph("CLINICX", titulo);
            nombreClinica.setAlignment(Element.ALIGN_CENTER);
            documento.add(nombreClinica);

            Paragraph tipoDocumento = new Paragraph(
                    "SOLICITUD DE EXAMEN DE LABORATORIO",
                    subtitulo
            );

            tipoDocumento.setAlignment(Element.ALIGN_CENTER);
            tipoDocumento.setSpacingAfter(5);
            documento.add(tipoDocumento);

            Paragraph numeroOrden = new Paragraph(
                    "Orden: ORD-" + orden.getId(),
                    normal
            );

            numeroOrden.setAlignment(Element.ALIGN_CENTER);
            numeroOrden.setSpacingAfter(20);
            documento.add(numeroOrden);

            agregarTituloSeccion(documento, "DATOS DEL PACIENTE");

            PdfPTable tablaPaciente = crearTabla();

            agregarFila(
                    tablaPaciente,
                    "Paciente",
                    orden.getPaciente().getNombres()
                            + " "
                            + orden.getPaciente().getApellidos()
            );

            agregarFila(
                    tablaPaciente,
                    "DNI",
                    valorSeguro(orden.getPaciente().getDni())
            );

            agregarFila(
                    tablaPaciente,
                    "Teléfono",
                    valorSeguro(orden.getPaciente().getTelefono())
            );

            agregarFila(
                    tablaPaciente,
                    "Correo",
                    valorSeguro(orden.getPaciente().getEmail())
            );

            documento.add(tablaPaciente);

            agregarTituloSeccion(documento, "MÉDICO SOLICITANTE");

            PdfPTable tablaMedico = crearTabla();

            agregarFila(
                    tablaMedico,
                    "Médico",
                    "Dr(a). "
                            + orden.getMedico().getNombres()
                            + " "
                            + orden.getMedico().getApellidos()
            );

            agregarFila(
                    tablaMedico,
                    "CMP",
                    valorSeguro(orden.getMedico().getCmp())
            );

            String especialidad =
                    orden.getMedico().getEspecialidad() != null
                            ? orden.getMedico()
                                .getEspecialidad()
                                .getNombre()
                            : "No registrada";

            agregarFila(
                    tablaMedico,
                    "Especialidad",
                    especialidad
            );

            documento.add(tablaMedico);

            agregarTituloSeccion(documento, "INFORMACIÓN DE LA ORDEN");

            PdfPTable tablaOrden = crearTabla();

            String nombreExamen =
                    orden.getExamen() != null
                            ? orden.getExamen().getNombre()
                            : "Examen no especificado";

            String categoria =
                    orden.getExamen() != null
                            && orden.getExamen().getCategoria() != null
                            ? orden.getExamen().getCategoria()
                            : "No registrada";

            agregarFila(tablaOrden, "Examen solicitado", nombreExamen);
            agregarFila(tablaOrden, "Categoría", categoria);
            agregarFila(tablaOrden, "Prioridad", orden.getPrioridad());
            agregarFila(tablaOrden, "Estado", orden.getEstado());

            String fecha =
                    orden.getFechaSolicitud() != null
                            ? orden.getFechaSolicitud().format(
                                DateTimeFormatter.ofPattern(
                                        "dd/MM/yyyy HH:mm"
                                )
                            )
                            : "No registrada";

            agregarFila(tablaOrden, "Fecha de solicitud", fecha);

            documento.add(tablaOrden);

            agregarTituloSeccion(
                    documento,
                    "INDICACIONES PARA EL LABORATORIO"
            );

            String indicaciones =
                    orden.getObservacionesTecnicas() != null
                            && !orden.getObservacionesTecnicas().isBlank()
                            ? orden.getObservacionesTecnicas()
                            : "Sin indicaciones registradas.";

            Paragraph textoIndicaciones = new Paragraph(
                    indicaciones,
                    normal
            );

            textoIndicaciones.setSpacingAfter(35);
            documento.add(textoIndicaciones);

            Paragraph firma = new Paragraph(
                    "________________________________________\n"
                            + "Firma y sello del médico solicitante",
                    normal
            );

            firma.setAlignment(Element.ALIGN_CENTER);
            documento.add(firma);

            Paragraph pie = new Paragraph(
                    "\nDocumento generado electrónicamente por ClinicX.",
                    FontFactory.getFont(
                            FontFactory.HELVETICA_OBLIQUE,
                            8,
                            Color.GRAY
                    )
            );

            pie.setAlignment(Element.ALIGN_CENTER);
            documento.add(pie);

        } catch (DocumentException e) {
            throw new IllegalStateException(
                    "No se pudo generar el PDF.",
                    e
            );
        } finally {
            if (documento.isOpen()) {
                documento.close();
            }
        }

        return salida.toByteArray();
    }

    private void agregarTituloSeccion(
            Document documento,
            String titulo
    ) throws DocumentException {

        Paragraph encabezado = new Paragraph(
                titulo,
                FontFactory.getFont(
                        FontFactory.HELVETICA_BOLD,
                        11,
                        new Color(13, 110, 253)
                )
        );

        encabezado.setSpacingBefore(15);
        encabezado.setSpacingAfter(8);

        documento.add(encabezado);
    }

    private PdfPTable crearTabla() throws DocumentException {

        PdfPTable tabla = new PdfPTable(
                new float[]{1.2f, 2.8f}
        );

        tabla.setWidthPercentage(100);
        tabla.setSpacingAfter(5);

        return tabla;
    }

    private void agregarFila(
            PdfPTable tabla,
            String etiqueta,
            String valor
    ) {

        Font fuenteEtiqueta = FontFactory.getFont(
                FontFactory.HELVETICA_BOLD,
                9,
                Color.DARK_GRAY
        );

        Font fuenteValor = FontFactory.getFont(
                FontFactory.HELVETICA,
                9,
                Color.BLACK
        );

        PdfPCell celdaEtiqueta = new PdfPCell(
                new Phrase(etiqueta, fuenteEtiqueta)
        );

        celdaEtiqueta.setPadding(8);
        celdaEtiqueta.setBackgroundColor(
                new Color(241, 245, 249)
        );

        PdfPCell celdaValor = new PdfPCell(
                new Phrase(valorSeguro(valor), fuenteValor)
        );

        celdaValor.setPadding(8);

        tabla.addCell(celdaEtiqueta);
        tabla.addCell(celdaValor);
    }

    private String valorSeguro(String valor) {
        return valor != null && !valor.isBlank()
                ? valor
                : "No registrado";
    }
}