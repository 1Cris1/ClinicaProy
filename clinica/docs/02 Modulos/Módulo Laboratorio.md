---
tags: [modulo, laboratorio]
carpeta: modules/laboratorio
---

# Módulo Laboratorio

Ciclo completo de exámenes clínicos: el médico ordena → el laboratorista ingresa resultados → el paciente los descarga en PDF (HU 5 y HU 6).

## Entidades

### `ExamenCatalogo` (tabla `catalogo_examenes`)
nombre ("Glucosa Basal"), categoría (Bioquímica, Hematología...), precio, **unidad_medida** (mg/dL) y **rango_min / rango_max** de referencia — con esto el reporte marca valores anormales.

### `OrdenLaboratorio` (tabla `ordenes_laboratorio`)
FK paciente + médico, fecha_solicitud, **estado** (Pendiente de toma → En proceso → Validado → Entregado), **prioridad** (Normal / **STAT** = urgente), observaciones_tecnicas.

### `ResultadoDetalle` (tabla `resultados_detalle`)
FK orden + examen, **valor** numérico, unidad, observaciones. Un registro por examen dentro de la orden.

### `ResultadoLaboratorio` (tabla `resultados_laboratorio`)
Vista histórica agregada por paciente: nombre_examen, orden, sede_laboratorio, estado (En proceso / **Disponible**), tipo_examen (Laboratorio / Imagen), fecha_examen, fecha_vencimiento.

## Actores y pantallas

| Actor | Pantalla | Acción |
|---|---|---|
| [[Rol Médico]] | `doctores/laboratorio.html` | ve sus órdenes solicitadas |
| [[Rol Laboratorio]] | `laboratorio/gestion.html` y `entrada-datos.html` | ingresa valores, cambia estado |
| [[Rol Paciente]] | `paciente/resultados.html` (**Vue.js**, tabla reactiva) | ve/descarga solo SUS resultados |

## Generación de PDF — JasperReports

`ReportService.generarReporteLaboratorio(orden)`:
- Plantilla: `src/main/resources/reports/resultado_laboratorio.jrxml`
- Parámetros: paciente, DNI, médico solicitante, fecha, N° orden
- Datasource: lista de `ResultadoDetalle`
- Columnas: EXAMEN | RESULTADO | UNIDAD | RANGO REFERENCIA
- Pie: "copia electrónica validada por Laboratorio Central"
- Descarga: `GET /laboratorio/orden/{id}/pdf`

## Notificación en tiempo real
Al validar resultados, `NotificacionService` publica en `/topic/notificaciones/{idMedico}` vía WebSocket → [[Módulo Notificaciones]].

## Relacionado
- [[Datos Semilla]] — 3 exámenes de catálogo + 2 órdenes de prueba (una con glucosa 145 anormal)
- [[Historias de Usuario]] — HU 5, HU 6
