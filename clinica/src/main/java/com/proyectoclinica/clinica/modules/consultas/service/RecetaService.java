package com.proyectoclinica.clinica.modules.consultas.service;

import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
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

    public List<Receta> obtenerRecetasPorPaciente(Integer idPaciente) {
        return recetaRepository
                .findByPacienteIdOrderByFechaEmisionDesc(idPaciente);
    }

    public List<Receta> obtenerRecetasActivas(Integer idPaciente) {
        return recetaRepository
                .findByPacienteIdAndEstadoOrderByFechaEmisionDesc(
                        idPaciente,
                        "Activa"
                );
    }

    public List<Receta> obtenerHistorialRecetas(Integer idPaciente) {
        return recetaRepository
                .findByPacienteIdAndEstadoOrderByFechaEmisionDesc(
                        idPaciente,
                        "Finalizada"
                );
    }

    public byte[] generarPdfReceta(Integer idReceta) throws Exception {

        Receta receta = recetaRepository.findById(idReceta)
                .orElseThrow(
                        () -> new RuntimeException("Receta no encontrada")
                );

        ByteArrayOutputStream salida = new ByteArrayOutputStream();

        Document documento = new Document(
                PageSize.A4,
                45,
                45,
                35,
                35
        );

        PdfWriter.getInstance(documento, salida);
        documento.open();

        Color azulPrincipal = new Color(13, 110, 253);
        Color grisClaro = new Color(241, 245, 249);
        Color grisBorde = new Color(226, 232, 240);
        Color grisTexto = new Color(71, 85, 105);

        Font fuenteTitulo = FontFactory.getFont(
                FontFactory.HELVETICA_BOLD,
                22,
                azulPrincipal
        );

        Font fuenteSubtitulo = FontFactory.getFont(
                FontFactory.HELVETICA_BOLD,
                13,
                Color.DARK_GRAY
        );

        Font fuenteSeccion = FontFactory.getFont(
                FontFactory.HELVETICA_BOLD,
                11,
                azulPrincipal
        );

        Font fuenteNormal = FontFactory.getFont(
                FontFactory.HELVETICA,
                10,
                Color.BLACK
        );

        Font fuenteNegrita = FontFactory.getFont(
                FontFactory.HELVETICA_BOLD,
                10,
                Color.BLACK
        );

        Font fuentePequena = FontFactory.getFont(
                FontFactory.HELVETICA,
                8,
                grisTexto
        );

        // Encabezado
        Paragraph tituloClinica = new Paragraph(
                "CLINICX",
                fuenteTitulo
        );

        tituloClinica.setAlignment(Element.ALIGN_CENTER);
        documento.add(tituloClinica);

        Paragraph lema = new Paragraph(
                "Tu salud, nuestra prioridad",
                fuentePequena
        );

        lema.setAlignment(Element.ALIGN_CENTER);
        lema.setSpacingAfter(5);
        documento.add(lema);

        Paragraph tipoDocumento = new Paragraph(
                "RECETA MÉDICA",
                fuenteSubtitulo
        );

        tipoDocumento.setAlignment(Element.ALIGN_CENTER);
        tipoDocumento.setSpacingAfter(20);
        documento.add(tipoDocumento);

        // Código y fecha
        PdfPTable tablaGeneral = new PdfPTable(
                new float[]{1, 1}
        );

        tablaGeneral.setWidthPercentage(100);
        tablaGeneral.setSpacingAfter(15);

        tablaGeneral.addCell(
                crearCeldaInformacion(
                        "Código",
                        valorSeguro(receta.getCodigo()),
                        grisClaro,
                        grisBorde,
                        fuenteNegrita,
                        fuenteNormal
                )
        );

        String fecha = receta.getFechaEmision() != null
                ? receta.getFechaEmision().format(
                        DateTimeFormatter.ofPattern("dd/MM/yyyy")
                )
                : "No registrada";

        tablaGeneral.addCell(
                crearCeldaInformacion(
                        "Fecha de emisión",
                        fecha,
                        grisClaro,
                        grisBorde,
                        fuenteNegrita,
                        fuenteNormal
                )
        );

        documento.add(tablaGeneral);

        // Datos del médico
        agregarTituloSeccion(
                documento,
                "DATOS DEL MÉDICO",
                fuenteSeccion
        );

        PdfPTable tablaMedico = crearTablaDatos();

        String nombreMedico = "Dr(a). "
                + receta.getMedico().getNombres()
                + " "
                + receta.getMedico().getApellidos();

        agregarFila(
                tablaMedico,
                "Médico",
                nombreMedico,
                grisClaro,
                grisBorde,
                fuenteNegrita,
                fuenteNormal
        );

        String especialidad =
                receta.getMedico().getEspecialidad() != null
                        ? receta.getMedico()
                                .getEspecialidad()
                                .getNombre()
                        : "No registrada";

        agregarFila(
                tablaMedico,
                "Especialidad",
                especialidad,
                grisClaro,
                grisBorde,
                fuenteNegrita,
                fuenteNormal
        );

        String cmp = valorSeguro(
                receta.getMedico().getCmp()
        );

        agregarFila(
                tablaMedico,
                "CMP",
                cmp,
                grisClaro,
                grisBorde,
                fuenteNegrita,
                fuenteNormal
        );

        documento.add(tablaMedico);

        // Datos del paciente
        agregarTituloSeccion(
                documento,
                "DATOS DEL PACIENTE",
                fuenteSeccion
        );

        PdfPTable tablaPaciente = crearTablaDatos();

        String nombrePaciente =
                receta.getPaciente().getNombres()
                        + " "
                        + receta.getPaciente().getApellidos();

        agregarFila(
                tablaPaciente,
                "Paciente",
                nombrePaciente,
                grisClaro,
                grisBorde,
                fuenteNegrita,
                fuenteNormal
        );

        agregarFila(
                tablaPaciente,
                "DNI",
                valorSeguro(receta.getPaciente().getDni()),
                grisClaro,
                grisBorde,
                fuenteNegrita,
                fuenteNormal
        );

        documento.add(tablaPaciente);

        // Medicamentos
        agregarTituloSeccion(
                documento,
                "PRESCRIPCIÓN MÉDICA",
                fuenteSeccion
        );

        PdfPTable tablaMedicamentos = new PdfPTable(
                new float[]{2.2f, 1.3f, 1.3f, 2.2f}
        );

        tablaMedicamentos.setWidthPercentage(100);
        tablaMedicamentos.setSpacingAfter(20);
        tablaMedicamentos.setHeaderRows(1);

        agregarEncabezado(
                tablaMedicamentos,
                "Medicamento",
                azulPrincipal
        );

        agregarEncabezado(
                tablaMedicamentos,
                "Dosis",
                azulPrincipal
        );

        agregarEncabezado(
                tablaMedicamentos,
                "Duración",
                azulPrincipal
        );

        agregarEncabezado(
                tablaMedicamentos,
                "Indicaciones",
                azulPrincipal
        );

        if (receta.getMedicamentos() != null
                && !receta.getMedicamentos().isEmpty()) {

            for (MedicamentoPrescrito medicamento
                    : receta.getMedicamentos()) {

                agregarCeldaMedicamento(
                        tablaMedicamentos,
                        medicamento.getNombre(),
                        fuenteNormal,
                        grisBorde
                );

                agregarCeldaMedicamento(
                        tablaMedicamentos,
                        medicamento.getDosis(),
                        fuenteNormal,
                        grisBorde
                );

                agregarCeldaMedicamento(
                        tablaMedicamentos,
                        medicamento.getDuracion(),
                        fuenteNormal,
                        grisBorde
                );

                agregarCeldaMedicamento(
                        tablaMedicamentos,
                        medicamento.getInstrucciones(),
                        fuenteNormal,
                        grisBorde
                );
            }

        } else {

            PdfPCell sinMedicamentos = new PdfPCell(
                    new Phrase(
                            "No se registraron medicamentos.",
                            fuenteNormal
                    )
            );

            sinMedicamentos.setColspan(4);
            sinMedicamentos.setPadding(10);
            sinMedicamentos.setHorizontalAlignment(
                    Element.ALIGN_CENTER
            );
            sinMedicamentos.setBorderColor(grisBorde);

            tablaMedicamentos.addCell(sinMedicamentos);
        }

        documento.add(tablaMedicamentos);

        // Recomendaciones
        Paragraph recomendacion = new Paragraph(
                "Indicaciones generales: cumplir el tratamiento "
                        + "según las instrucciones del médico y no "
                        + "suspenderlo sin una evaluación profesional.",
                fuentePequena
        );

        recomendacion.setSpacingAfter(40);
        documento.add(recomendacion);

        // Firma
        Paragraph firma = new Paragraph(
                "________________________________________\n"
                        + nombreMedico
                        + "\nCMP: "
                        + cmp
                        + "\nFirma y sello del médico",
                fuentePequena
        );

        firma.setAlignment(Element.ALIGN_CENTER);
        firma.setSpacingAfter(25);
        documento.add(firma);

        // Pie del documento
        Paragraph pie = new Paragraph(
                "Documento generado electrónicamente por ClinicX.",
                fuentePequena
        );

        pie.setAlignment(Element.ALIGN_CENTER);
        documento.add(pie);

        documento.close();

        return salida.toByteArray();
    }

    private void agregarTituloSeccion(
            Document documento,
            String texto,
            Font fuente
    ) throws DocumentException {

        Paragraph titulo = new Paragraph(texto, fuente);
        titulo.setSpacingBefore(8);
        titulo.setSpacingAfter(7);

        documento.add(titulo);
    }

    private PdfPTable crearTablaDatos()
            throws DocumentException {

        PdfPTable tabla = new PdfPTable(
                new float[]{1.2f, 2.8f}
        );

        tabla.setWidthPercentage(100);
        tabla.setSpacingAfter(12);

        return tabla;
    }

    private PdfPCell crearCeldaInformacion(
            String etiqueta,
            String valor,
            Color fondo,
            Color borde,
            Font fuenteEtiqueta,
            Font fuenteValor
    ) {

        Paragraph contenido = new Paragraph();

        contenido.add(
                new Chunk(
                        etiqueta + ":\n",
                        fuenteEtiqueta
                )
        );

        contenido.add(
                new Chunk(
                        valorSeguro(valor),
                        fuenteValor
                )
        );

        PdfPCell celda = new PdfPCell(contenido);

        celda.setPadding(10);
        celda.setBackgroundColor(fondo);
        celda.setBorderColor(borde);

        return celda;
    }

    private void agregarFila(
            PdfPTable tabla,
            String etiqueta,
            String valor,
            Color fondo,
            Color borde,
            Font fuenteEtiqueta,
            Font fuenteValor
    ) {

        PdfPCell celdaEtiqueta = new PdfPCell(
                new Phrase(etiqueta, fuenteEtiqueta)
        );

        celdaEtiqueta.setPadding(8);
        celdaEtiqueta.setBackgroundColor(fondo);
        celdaEtiqueta.setBorderColor(borde);

        PdfPCell celdaValor = new PdfPCell(
                new Phrase(
                        valorSeguro(valor),
                        fuenteValor
                )
        );

        celdaValor.setPadding(8);
        celdaValor.setBorderColor(borde);

        tabla.addCell(celdaEtiqueta);
        tabla.addCell(celdaValor);
    }

    private void agregarEncabezado(
            PdfPTable tabla,
            String texto,
            Color fondo
    ) {

        Font fuente = FontFactory.getFont(
                FontFactory.HELVETICA_BOLD,
                9,
                Color.WHITE
        );

        PdfPCell celda = new PdfPCell(
                new Phrase(texto, fuente)
        );

        celda.setPadding(8);
        celda.setBackgroundColor(fondo);
        celda.setHorizontalAlignment(
                Element.ALIGN_CENTER
        );

        tabla.addCell(celda);
    }

    private void agregarCeldaMedicamento(
            PdfPTable tabla,
            String texto,
            Font fuente,
            Color borde
    ) {

        PdfPCell celda = new PdfPCell(
                new Phrase(
                        valorSeguro(texto),
                        fuente
                )
        );

        celda.setPadding(8);
        celda.setVerticalAlignment(
                Element.ALIGN_MIDDLE
        );
        celda.setBorderColor(borde);

        tabla.addCell(celda);
    }

    private String valorSeguro(String valor) {
        return valor != null && !valor.isBlank()
                ? valor
                : "No registrado";
    }
}