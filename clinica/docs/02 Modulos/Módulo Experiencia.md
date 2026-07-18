---
tags: [modulo, experiencia, feedback]
carpeta: modules/experiencia
---

# Módulo Experiencia

Recoge la **satisfacción del paciente** después de cada consulta.

## Entidad `FeedbackPaciente` (tabla `feedback_paciente`)

| Campo | Nota |
|---|---|
| id_cita | FK 1:1 → [[Módulo Citas\|Cita]] (cascade desde la cita) |
| puntuacion | INT 1–5 (estrellas) |
| comentario | TEXT |
| fecha_envio | DATETIME, default NOW() |

## Conexiones

- Un feedback por cita completada — cierra el [[Flujo Completo del Sistema]].
- El campo `satisfaccion` del `Medico` ([[Módulo Recursos]]) es el promedio de estas puntuaciones (0.0–5.0), visible en directorios y dashboards.
- Fuente potencial para análisis de satisfacción en [[Power BI]].

## Estado actual
Es el módulo más pequeño: entidad + repositorio (sin servicio dedicado). Punto natural de extensión futura (encuestas post-cita automáticas, NPS, etc.).

## Relacionado
- [[Modelo de Datos]]
