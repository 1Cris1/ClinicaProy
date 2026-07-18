---
tags: [academico, equipo]
---

# Equipo y Responsabilidades

Proyecto desarrollado por **4 alumnos**; cada uno es dueño de un tramo del [[Flujo Completo del Sistema]] y lo defiende en la exposición.

| Integrante | Área | Historias | Código clave |
|---|---|---|---|
| **Rhomel** | Seguridad y Registro | [[Historias de Usuario\|HU 1, HU 2]] | `SecurityConfig`, `UserDetailsServiceImpl`, `ApiPeruService` → [[Seguridad]], [[Portal Público]] |
| **Miguel** | Recepción y Citas | HU 3, HU 23 | `RecepcionistaController`, `GoogleCalendarService` → [[Rol Recepcionista]], [[Google Calendar]] |
| **Cristian** | Administración y Maestros | HU 9, HU 11 | `AdminController` → [[Rol Administrador]], [[Módulo Recursos]] |
| **Jhoan** | Consultorio Clínico | HU 16, HU 17 | `MedicoController` → [[Rol Médico]], [[Módulo Consultas y Recetas]] |

## Orden del storytelling en la demo

```
1. Rhomel   → registra paciente (DNI real) y muestra la contraseña BCrypt en BD
2. Miguel   → agenda cita y hace check-in (Pendiente → Confirmada)
3. Cristian → crea especialidad y registra un médico nuevo
4. Jhoan    → agenda diaria, completa consulta y emite receta digital
```

> La rama actual del repo es `jhoan` — el trabajo del consultorio clínico.

## Relacionado
- [[Guía de Exposición]]
- [[Documentación Académica]]
