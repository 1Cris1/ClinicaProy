---
tags: [rol, medico]
controlador: MedicoController
ruta-base: /medico
---

# Rol Médico

Portal clínico del doctor. Controlador: `MedicoController` (`/medico`), layout `layout-medico.html` (sidebar con iniciales, especialidad y badge de citas de hoy), vistas en `templates/doctores/`.

## Rutas principales

| Ruta | Vista | Qué hace |
|---|---|---|
| GET `/inicio` | `doctores/dashboard` | citas de hoy, siguiente cita, métricas del mes |
| GET `/agenda` | `doctores/agenda` | agenda ordenada por hora (HU 16) → [[Módulo Citas]] |
| GET `/consulta` | `doctores/consulta` | consulta activa (siguiente cita confirmada) |
| POST `/consulta/completar` | — | **@Transactional**: completa cita + crea receta → [[Módulo Consultas y Recetas]] |
| GET `/pacientes` | `doctores/pacientes` | pacientes atendidos por este médico |
| GET `/laboratorio` | `doctores/laboratorio` | órdenes solicitadas (HU 5) → [[Módulo Laboratorio]] |
| GET `/recetas` | `doctores/recetas` | historial de recetas emitidas |
| GET `/perfil` + POST `/horario/actualizar` | `doctores/perfil` | perfil y disponibilidad horaria |
| GET `/api/paciente/historial` | JSON | historial de un paciente (AJAX) |

## Métricas del dashboard
`citasHoy`, `siguienteCita`, `atendidosHoy`, `consultasMes`, `notasMes`, `totalPacientes` — todas filtradas por el médico autenticado (`Principal`).

## Puntos clave
- **HU 16**: agenda con `findByMedicoIdAndFechaCitaOrderByHoraCitaAsc`
- **HU 17**: `completarConsulta()` es la transacción ACID estrella ([[Patrones de Diseño]])
- Recibe notificaciones en tiempo real de laboratorio por WebSocket ([[Módulo Notificaciones]])
- Código de receta generado: `R-{millis%1000000}`

## Relacionado
- [[Módulo Recursos]] — entidad Medico
- [[Equipo y Responsabilidades]] — módulo de JHOAN
