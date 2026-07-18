---
tags: [modulo, consultas, recetas]
carpeta: modules/consultas
---

# Módulo Consultas y Recetas

Registra la **evolución clínica** del paciente y emite la **receta digital** (HU 17 — la "joya de la corona" de la exposición).

## Entidades

### `HistorialClinico` (tabla `historial_clinico`)
| Campo | Nota |
|---|---|
| id_paciente | FK → [[Módulo Pacientes\|Paciente]] |
| id_cita | FK 1:1 → [[Módulo Citas\|Cita]] |
| diagnostico | TEXT |
| tratamiento, observaciones | VARCHAR(255) |
| fecha_registro | timestamp |

Un historial por cita. Solo lectura tras crearse (no hay delete).

### `Receta` (tabla `recetas`)
| Campo | Nota |
|---|---|
| codigo | único, ej. `R-2026-0412` |
| id_paciente / id_medico | FK |
| fecha_emision | DATE |
| estado | **Activa** / **Finalizada** / Anulada |
| medicamentos | 1:N → MedicamentoPrescrito (cascade=ALL, orphanRemoval) |

### `MedicamentoPrescrito` (tabla `medicamentos_prescritos`)
nombre, dosis ("500mg"), frecuencia ("cada 8 horas"), duración ("7 días"), instrucciones.

## El flujo `completarConsulta()` — @Transactional

En `MedicoController` ([[Rol Médico]]):

1. Valida que el médico autenticado sea dueño de la cita (`Principal`).
2. `cita.setEstado("Completada")` + guarda `notasMedicas`.
3. Crea la `Receta` (código único con timestamp).
4. Itera las listas paralelas `med_nombre[]`, `med_dosis[]`... y crea un `MedicamentoPrescrito` por cada una.
5. Si algo falla → **rollback total** (ACID). Nunca queda receta a medias. Ver [[Patrones de Diseño]].

En el frontend (`doctores/consulta.html`) los medicamentos se agregan clonando un `<template>` HTML, con autocompletado contra el catálogo DIGEMID ([[Módulo Farmacia]]) y CIE para diagnósticos ([[CIE-11 OMS]]).

## `RecetaService`

- `obtenerRecetasActivas(idPaciente)` / `obtenerHistorialRecetas(idPaciente)`
- `generarPdfReceta(id)` — **PDF A5 con OpenPDF**: encabezado ClinicX ("Tu Salud, Nuestra Prioridad"), datos de médico y paciente, medicamentos con instrucciones, espacio para firma y sello.

Descarga: `GET /paciente/recetas/descargar/{id}` — permitido a PACIENTE y MEDICO ([[Seguridad]]).

## `HistorialClinicoService`
`listarPorPaciente`, `obtenerPorCita`, `guardar`. Expuesto también por [[API REST]] (`/api/v1/historia/*`).

## Relacionado
- [[Historias de Usuario]] — HU 17
- [[Datos Semilla]] — recetas de prueba R-2026-0412 y R-2026-0215
