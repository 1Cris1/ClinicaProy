---
tags: [modulo, triaje]
carpeta: modules/triaje
---

# Módulo Triaje

Registro de **signos vitales** previo a la consulta. Relación **1:1 con la [[Módulo Citas|Cita]]** (un triaje por cita, cascade=ALL desde la cita).

## Entidad `Triaje` (tabla `triaje`)

| Campo | Tipo | Referencia normal |
|---|---|---|
| id_cita | FK 1:1 → Cita | |
| peso | DECIMAL(5,2) kg | |
| talla | DECIMAL(3,2) m | |
| presion_arterial | VARCHAR "120/80" | |
| temperatura | DECIMAL(4,2) °C | ~36.5 |
| frecuencia_cardiaca | INT ppm | 60–100 |
| saturacion_oxigeno | INT % | 95–100 |
| fecha_registro | DATETIME | inmutable |

## `TriajeService`
- `obtenerPorCita(idCita)` — el médico consulta los signos vitales antes/durante la consulta
- `guardar(triaje)` / `eliminar(id)`

## En el flujo
Se toma tras el check-in ([[Rol Recepcionista]]) y el médico lo ve en la pantalla de consulta ([[Rol Médico]]). Ver [[Flujo Completo del Sistema]].

## Relacionado
- [[Módulo Citas]]
- [[Modelo de Datos]]
