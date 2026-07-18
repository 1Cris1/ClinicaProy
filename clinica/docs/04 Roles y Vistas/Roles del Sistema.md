---
tags: [roles, moc]
---

# Roles del Sistema

4 roles autenticados + acceso público. El rol vive en `Usuario.idRol` y se mapea al enum `Rol` ([[Seguridad]]).

| Rol | ID | Ruta base | Redirect post-login | Nota |
|---|---|---|---|---|
| ROLE_ADMIN | 1 | `/admin/**` | `/admin/inicio` | [[Rol Administrador]] |
| ROLE_MEDICO | 2 | `/medico/**` | `/medico/inicio` | [[Rol Médico]] |
| ROLE_PACIENTE | 3 | `/paciente/**` | `/paciente/inicio` | [[Rol Paciente]] |
| ROLE_RECEPCIONISTA | 4 | `/recepcionista/**` | `/recepcionista/inicio` | [[Rol Recepcionista]] |
| (anónimo) | — | `/`, `/login`, `/registro`, catálogos | — | [[Portal Público]] |
| (laboratorio) | — | `/laboratorio/**` | — | [[Rol Laboratorio]] |

La redirección la hace `CustomAuthenticationSuccessHandler` tras el login.

## Patrón de arquitectura por rol

Cada rol tiene:
1. **Controlador** (`AdminController`, `MedicoController`...) con su ruta base
2. **ControllerAdvice global** (`*GlobalController`) que inyecta atributos en todas sus vistas — contadores de citas, notificaciones, datos del usuario para el sidebar
3. **Layout Thymeleaf** propio (`layout-admin.html`, `layout-medico.html`, `layout-paciente.html`, `layout-recepcionista.html`) con sidebar, topbar y estilos dedicados
4. **CSS propio** (`admin.css`, `medico.css`, `paciente.css`, `recepcionista.css`)

## Atributos globales por rol (ControllerAdvice)

| Rol | Atributos inyectados |
|---|---|
| Paciente | citasPendientesCount, proximaCita, pacienteGlobal, notificacionesGlobal (últimas 5), unreadNotifCount, resultadosListosCount |
| Médico | citasHoyCount, medicoGlobal |
| Recepcionista | recepcionistaGlobal (DTO), citasHoyGlobalCount |
| Admin | totalPacientesGlobal, totalCitasGlobal |

## Relacionado
- [[Seguridad]] — reglas de autorización por ruta
- [[API REST]] — endpoints sin vista
