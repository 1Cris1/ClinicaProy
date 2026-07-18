---
tags: [modulo, citas]
carpeta: modules/citas
---

# Módulo Citas

El **corazón del sistema**: toda la operación clínica gira alrededor de la entidad `Cita`.

## Entidad `Cita` (tabla `citas`)

| Campo | Tipo | Nota |
|---|---|---|
| id_cita | INT PK | autoincremental |
| id_paciente | FK → [[Módulo Pacientes\|Paciente]] | NOT NULL, EAGER |
| id_medico | FK → [[Módulo Recursos\|Medico]] | NOT NULL, EAGER |
| id_servicio | FK → [[Módulo Recursos\|Servicio]] | NOT NULL, LAZY |
| fecha_cita | DATE | |
| hora_cita | VARCHAR(20) | "HH:MM:SS" |
| motivo | VARCHAR(255) | |
| estado | VARCHAR(50) | ver ciclo de vida ↓ |
| notas_medicas | TEXT | escritas por el médico al completar |
| fecha_registro | DATETIME | inmutable |

**Relaciones 1:1 inversas** (cascade=ALL): [[Módulo Triaje|Triaje]], [[Módulo Consultas y Recetas|HistorialClinico]], [[Módulo Experiencia|FeedbackPaciente]].

## Ciclo de vida

```
Pendiente → Confirmada (check-in) → Completada
         ↘ Cancelada / No asistió
```

## `CitasService`

- `listarCitasPorFecha(fecha)` — orden por hora ASC (agenda diaria del médico, HU 16)
- `listarCitasPorMedicoYFecha(id, fecha)`
- `listarCitasPorPaciente(id)` — historial descendente
- `actualizarEstado(id, estado)` — transaccional
- `contarCitasHoy()` / `contarAtendidosHoy()` — métricas de dashboards

## Reglas de negocio clave

1. **Anti double-booking** (HU 3): antes de guardar se verifica `existsByMedicoIdAndFechaCitaAndHoraCitaAndEstadoNot("Cancelada")`. En edición se excluye la propia cita.
2. **Servicio por defecto**: si no se elige servicio, se asigna "Consulta General" (ID 1).
3. **Sincronización con [[Google Calendar]]**: asíncrona (`CompletableFuture`), nunca bloquea ni rompe el agendamiento.
4. **Propiedad**: el paciente solo gestiona sus citas; el médico solo completa las suyas (validación por `Principal`).

## Quién la usa

| Actor | Operación |
|---|---|
| [[Rol Paciente]] | agendar, reagendar, cancelar, ver historial |
| [[Rol Recepcionista]] | crear, editar, check-in |
| [[Rol Médico]] | agenda diaria, completar consulta |
| [[Rol Administrador]] | vista global de todas las citas |
| [[API REST]] | `/api/v1/citas/*` |

## Relacionado
- [[Flujo Completo del Sistema]]
- [[Historias de Usuario]] — HU 3, HU 16, HU 23
