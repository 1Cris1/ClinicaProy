---
tags: [rol, admin]
controlador: AdminController
ruta-base: /admin
---

# Rol Administrador

Único rol con **CRUD completo sobre todo el sistema**. Controlador: `AdminController` (`/admin`), layout `layout-admin.html` (sidebar de 3 secciones: Principal, Clínica, Sistema).

## Gestión de personas

| Recurso | Rutas | Nota |
|---|---|---|
| Pacientes | `/pacientes` + nuevo/editar/eliminar | crea Usuario (rol 3) + Paciente |
| Médicos | `/medicos` + nuevo/editar/eliminar | **HU 9**: Usuario (rol 2) + Medico con especialidad y sede — `@Transactional` |
| Recepcionistas | `/recepcionistas` + nuevo/editar/eliminar | Usuario rol 4 |
| Usuarios | `/usuarios`, cambiar-rol, toggle-estado | administración transversal |

## Gestión de catálogos ([[Módulo Recursos]])

| Recurso | Rutas | HU |
|---|---|---|
| Especialidades | `/especialidades` + nuevo/editar | **HU 11** |
| Servicios (tarifario) | `/servicios` + nuevo/editar/eliminar | |
| Sedes | `/sedes` + nuevo/editar/eliminar | |
| Promociones | `/promociones` + nuevo | |
| Productos de farmacia | `/productos` + nuevo | HU 7 → [[Módulo Farmacia]] |

## Supervisión
- `/citas` — todas las citas del sistema
- `/reportes` — dashboard [[Power BI]] embebido
- `/susalud` — validaciones de conformidad → [[API Perú y SUSALUD]]
- `/configuracion` — parámetros globales de la clínica
- `/dashboard` — métricas: total pacientes, médicos, citas

## Puntos clave
- Contraseñas siempre con `PasswordEncoder` (BCrypt)
- Entidades construidas con `@Builder` de Lombok
- Roles por ID: Admin=1, Médico=2, Paciente=3, Recepcionista=4
- Módulo de CRISTIAN → [[Equipo y Responsabilidades]]

## Relacionado
- [[Seguridad]]
- [[Rol Laboratorio]] — usa el mismo layout-admin
