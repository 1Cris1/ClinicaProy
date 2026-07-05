---
tags: [integracion, reportes, analytics]
config: PowerBiProperties
---

# Power BI

Dashboards de inteligencia de negocios **embebidos** en la aplicación, con una página distinta por rol.

## Configuración (`PowerBiProperties` + application.properties)

```
powerbi.base.url            → URL del reporte publicado (embed)
powerbi.page.admin          → "Dashboard Administrador"
powerbi.page.medico         → "Dashboard Medico"
powerbi.page.paciente       → "Dashboard Paciente"
powerbi.page.recepcion      → "Dashboard Recepcion"
powerbi.filter.table.medicos / .pacientes → tablas para filtrar por usuario
```

Los controladores de cada rol construyen la URL con la página y el **filtro por identidad** (el médico solo ve SUS métricas, el paciente las suyas).

## Orígenes de datos (vistas SQL sobre [[Modelo de Datos]])

| Vista | Propósito | Campos clave | Gráficos sugeridos |
|---|---|---|---|
| `v_reporte_citas` | operativo | fecha, estado, especialidad, sede, médico, DNI paciente | anillo (estados), barras (especialidad), líneas (evolución) |
| `v_reporte_pagos` | financiero | fecha, monto, método, estado, servicio | tarjeta (suma), barras apiladas (método), treemap (servicio) |

## Guía de diseño (de `docs/powerbi_setup_guia.md`)
- Paleta: azul #2563EB y verde #059669 (los colores de la marca ClinicX)
- Segmentadores por Fecha y Sede
- Logo de la clínica en el encabezado

> ⚠️ La guía original conecta a MySQL local; la BD real del proyecto es **SQL Server en puerto 1434** ([[Base de Datos y Configuración]]). Ajustar el conector al replicarla.

## Relacionado
- [[Integraciones Externas]]
- [[Rol Administrador]] — página `/admin/reportes`
