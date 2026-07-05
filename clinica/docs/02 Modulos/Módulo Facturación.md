---
tags: [modulo, facturacion, pagos]
carpeta: modules/facturacion
---

# Módulo Facturación

Registro de pagos y emisión de comprobantes, operado por el [[Rol Recepcionista]].

## Entidad `Pago` (tabla `pagos`)

| Campo | Nota |
|---|---|
| id_paciente | FK → [[Módulo Pacientes\|Paciente]] |
| id_servicio | FK → [[Módulo Recursos\|Servicio]] (define el monto base) |
| monto | DECIMAL(10,2) |
| metodo_pago | Efectivo, Tarjeta, Transferencia... |
| tipo_comprobante | **Boleta / Factura / Ticket** |
| numero_comprobante | único, generado por PagoService |
| fecha_pago | DATETIME |
| estado | Pagado, Pendiente, Anulado, Reembolsado |
| observaciones | TEXT |

## `PagoService` — numeración concurrencia-segura

Usa **`AtomicInteger`** para que varios recepcionistas simultáneos nunca generen el mismo número ([[Patrones de Diseño]]).

Formato: `[PREFIJO]-[YYYYMMDD]-[SECUENCIAL]`

| Tipo | Prefijo | Ejemplo |
|---|---|---|
| Factura | F001 | F001-20260705-000003 |
| Ticket | T | T-20260705-000012 |
| Boleta (default) | B001 | B001-20260705-000001 |

## Pantallas
- `recepcionista/pagos.html` — historial y registro (`POST /recepcionista/pagos/nuevo`)
- `recepcionista/comprobante.html` — comprobante imprimible
- Dashboard de recepción muestra `totalPagosHoy` (suma de pagos completados)

## Análisis financiero
La vista SQL `v_reporte_pagos` alimenta el dashboard financiero de [[Power BI]] (monto, método, estado, servicio).

## Relacionado
- [[Rol Recepcionista]]
- [[Flujo Completo del Sistema]]
