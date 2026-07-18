---
tags: [rol, publico]
controlador: PublicoController
---

# Portal Público

Todo lo accesible **sin autenticación**. Controlador: `PublicoController` (raíz `/`), vistas en `templates/publico/` con `layout-public`.

## Rutas

| Ruta | Vista | Qué muestra |
|---|---|---|
| GET `/` | redirect a login | |
| GET `/login` | `publico/login` | formulario de login → [[Seguridad]] |
| GET/POST `/registro` | `publico/registro` | **HU 2**: auto-registro de pacientes |
| GET `/medicos` | `publico/medicos` | directorio de médicos |
| GET `/especialidades` | `publico/especialidades` | catálogo de especialidades |
| GET `/servicios` | `publico/servicios` | servicios y precios |
| GET `/sedes` | `publico/sedes` | sedes de la clínica |
| GET `/promociones` | `publico/promociones` | promociones vigentes |
| GET `/blog` | `publico/blog` | blog educativo (filtro por categoría) |
| GET `/api/identidad/{dni}` | JSON | consulta DNI en [[API Perú y SUSALUD]] |
| GET `/api/colegiatura/{cmp}` | JSON | validación de CMP (mock) |

## El registro (HU 2) paso a paso

1. El usuario ingresa su DNI → el frontend consulta `/api/identidad/{dni}` y autocompleta nombres y datos de seguro (SUSALUD).
2. Valida la contraseña con regex: **mínimo 8 caracteres, una mayúscula y un carácter especial** (`^(?=.*[A-Z])(?=.*[@#$%^&+=!_\-]).{8,}$`).
3. Detecta DNI duplicado (`DataIntegrityViolationException`).
4. Crea `Usuario` (BCrypt) + `Paciente` → [[Módulo Pacientes]].
5. Sincroniza con [[FHIR]] y envía **correo de bienvenida** HTML (EmailService, asíncrono).
6. Redirige a login.

## Relacionado
- [[Roles del Sistema]]
- [[Recuperación de Contraseña]] — `/api/password/**` también es público
