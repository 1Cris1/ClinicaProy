---
tags: [academico, requisitos]
fuente: docs/historias_de_usuario.txt
---

# Historias de Usuario

Las **8 HU** del proyecto, en formato ágil (Como… quiero… para…). Cada una tiene dueño en [[Equipo y Responsabilidades]].

| HU | Nombre | Actor | Dueño | Nota técnica |
|---|---|---|---|---|
| **HU 1** | Inicio de Sesión | Todos los usuarios | Rhomel | login con DNI + BCrypt → [[Seguridad]] |
| **HU 2** | Registro Autónomo de Pacientes | Paciente nuevo | Rhomel | validación DNI vía [[API Perú y SUSALUD]] → [[Portal Público]] |
| **HU 3** | Agendamiento de Citas | Recepcionista | Miguel | anti double-booking + [[Google Calendar]] → [[Módulo Citas]] |
| **HU 23** | Check-in (Confirmación de Llegada) | Recepcionista | Miguel | Pendiente → Confirmada → [[Rol Recepcionista]] |
| **HU 9** | Gestión de Médicos | Administrador | Cristian | Usuario + Medico en cadena → [[Rol Administrador]] |
| **HU 11** | Gestión de Especialidades | Administrador | Cristian | catálogo con icono y color → [[Módulo Recursos]] |
| **HU 16** | Agenda Diaria Cronológica | Médico | Jhoan | `OrderByHoraCitaAsc` → [[Rol Médico]] |
| **HU 17** | Evolución Clínica + Receta Digital | Médico | Jhoan | **@Transactional** (ACID) → [[Módulo Consultas y Recetas]] |

## Detalle rápido

- **HU 1** — Autenticarse con DNI y contraseña encriptada; acceso al panel según rol.
- **HU 2** — Crear cuenta sin ir a la clínica, con datos reales de RENIEC.
- **HU 3** — Reservar cupo garantizando que no haya cruce de horarios del médico.
- **HU 23** — Un botón cambia el estado y el médico ve al paciente en sala de espera.
- **HU 9** — Registrar médicos con horarios y especialidad; habilita su agenda.
- **HU 11** — Crear especialidades (nombre, descripción, color) para organizar la oferta.
- **HU 16** — Ver las citas de hoy ordenadas por hora.
- **HU 17** — Redactar la evolución y agregar N medicamentos; se guarda todo o nada.

> Las HU adicionales implementadas pero no documentadas formalmente: laboratorio (HU 5/6 en las explicaciones de alumno 3) y farmacia (HU 7 en alumno 4).

## Relacionado
- [[Flujo Completo del Sistema]] — las HU encadenadas
- [[Documentación Académica]]
