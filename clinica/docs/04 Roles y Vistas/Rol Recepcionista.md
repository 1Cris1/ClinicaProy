---
tags: [rol, recepcionista]
controlador: RecepcionistaController
ruta-base: /recepcionista
---

# Rol Recepcionista

El **hub operativo** de la clínica: citas, llegadas, pacientes y cobros. Controlador: `RecepcionistaController` (`/recepcionista`), layout `layout-recepcionista.html` ("Reception Desk", contador animado de citas, indicador "Sistema en línea").

## Rutas principales

| Ruta | Vista | Qué hace |
|---|---|---|
| GET `/inicio` | `recepcionista/dashboard` | citas de hoy, sala de espera, pagos del día |
| GET `/citas` | `recepcionista/citas` | gestión de citas (filtro por fecha) |
| POST `/citas/nuevo` | — | crear cita (HU 3, anti double-booking) + sync [[Google Calendar]] |
| POST `/citas/editar` | — | reprogramar (excluye la propia cita del conflicto) |
| POST `/citas/checkin` | — | **HU 23**: Pendiente → Confirmada → [[Módulo Citas]] |
| GET `/pacientes` + POST `/pacientes/nuevo` | `recepcionista/pacientes` | directorio + alta rápida (sin usuario web) |
| GET `/medicos` | `recepcionista/medicos` | cuerpo médico y disponibilidad |
| GET `/pagos` + POST `/pagos/nuevo` | `recepcionista/pagos` | registrar pagos → [[Módulo Facturación]] |
| — | `recepcionista/comprobante` | comprobante imprimible |
| GET `/pacientes/historial` | JSON | historial de paciente (AJAX) |

## Métricas del dashboard
`citasHoy`, `enSalaEspera` (confirmadas), `citasRestantes` (pendientes), `totalPagosHoy`, `cancelaciones`.

## Puntos clave
- **HU 3 (agendamiento)** y **HU 23 (check-in)** son de este rol — módulo de MIGUEL ([[Equipo y Responsabilidades]])
- La sincronización con Google Calendar es asíncrona: si falla, la cita se guarda igual
- Servicio por defecto "Consulta General" si no se especifica

## Relacionado
- [[Flujo Completo del Sistema]] — pasos 2 y 3
- [[Historias de Usuario]]
