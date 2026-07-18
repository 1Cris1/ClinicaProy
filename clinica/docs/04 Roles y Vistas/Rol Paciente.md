---
tags: [rol, paciente]
controlador: PacienteController
ruta-base: /paciente
---

# Rol Paciente

Portal de **autogestión de salud**. Controlador: `PacienteController` (`/paciente`), layout `layout-paciente.html` (sidebar con avatar, DNI y campana de [[Módulo Notificaciones|notificaciones]]).

## Rutas principales

| Ruta | Vista | Qué hace |
|---|---|---|
| GET `/inicio` | `paciente/dashboard` | resumen: próximas citas, resultados, recetas, [[Power BI]] |
| GET `/citas` | `paciente/mis-citas` | mis citas |
| GET/POST `/agendar` | `paciente/agendar` | agendar o reagendar (validación anti double-booking → [[Módulo Citas]]) |
| POST `/citas/cancelar` | — | cancelar cita propia |
| GET `/resultados` | `paciente/resultados` | resultados de laboratorio (**Vue.js**) → [[Módulo Laboratorio]] |
| GET `/recetas` | `paciente/recetas` | recetas activas e historial → [[Módulo Consultas y Recetas]] |
| GET `/recetas/descargar/{id}` | PDF | descarga receta (OpenPDF, A5) |
| GET `/historial` | `paciente/historial` | citas completadas |
| GET `/farmacia` + POST `/farmacia/comprar` | `paciente/farmacia` | catálogo + carrito → [[Módulo Farmacia]] |
| GET `/perfil` + POST `/perfil/actualizar` | `paciente/perfil` | editar teléfono/email |
| POST `/perfil/password` | — | cambio de contraseña (valida la actual) |
| GET `/configuracion` | `paciente/configuracion` | ajustes de cuenta |

## Seguridad
- Todas las rutas requieren `ROLE_PACIENTE` ([[Seguridad]])
- El controlador resuelve al paciente con `getPacienteAutenticado(Principal)` — imposible operar sobre citas o datos ajenos

## Atributos globales (PacienteGlobalController)
En todas las vistas: `citasPendientesCount`, `proximaCita`, `pacienteGlobal`, `notificacionesGlobal`, `unreadNotifCount`, `resultadosListosCount`.

## Relacionado
- [[Módulo Pacientes]] — la entidad y sus datos
- [[Flujo Completo del Sistema]]
