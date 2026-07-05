---
tags: [modulo, recursos]
carpeta: modules/recursos
---

# Módulo Recursos

Los **datos maestros** de la clínica: médicos, especialidades, sedes, servicios, promociones, administradores y configuración global. Gestionados principalmente por el [[Rol Administrador]] (HU 9 y HU 11).

## `Medico` (tabla `medicos`)
- Identidad: nombres, apellidos, **dni** (único), **cmp** (colegiatura, único), teléfono, email, foto_url.
- Vínculos: `usuario` 1:1 ([[Seguridad]]), `especialidad` N:1, `sede` N:1.
- Operativa: consultorio, **horario_lv** ("09:00-18:00"), horario_sabado, **duracion_cita** (minutos), satisfaccion (0–5), anio_ingreso, estado (Activo/Inactivo/Licencia).
- Inversas: citas, recetas, ordenesLaboratorio.

**Alta de médico (HU 9)**: primero se crea el `Usuario` (username=DNI, password BCrypt, rol 2) y luego el `Medico` con FK al usuario — dos INSERT encadenados.

## `Especialidad` (tabla `especialidades`)
nombre, descripción, **icono** (Bootstrap Icons, ej. `bi-heart-pulse`), **color** HEX (para la UI), imagen_url, estado. Inversas: médicos, servicios.

## `Sede` (tabla `sedes`)
nombre, dirección, distrito, ciudad, teléfono, email, horarios (LV/sábado/domingo), num_consultorios, estado. Inversas: médicos, pacientes.

## `Servicio` (tabla `servicios`)
nombre, descripción, **precio** DECIMAL(10,2), FK especialidad, estado. Es el tarifario: cada [[Módulo Citas|Cita]] y cada [[Módulo Facturación|Pago]] referencian un servicio.

## `Promocion` (tabla `promociones`)
titulo, descripción, **descuento_porcentaje**, fecha_inicio/fin, estado, imagen_url. Visible en el [[Portal Público]].

## `Administrador` (tabla `administradores`)
nombres, apellidos, cargo, teléfono; 1:1 con Usuario.

## `Configuracion` (tabla `configuracion`) — singleton
nombre_clinica, RUC, dirección, teléfono, email_contacto, logo_url, horario_atencion. Servida por `ConfiguracionService`.

## Datos precargados
4 sedes (Centro Lima, Miraflores, San Isidro, Surco) y 4 especialidades (Medicina General, Pediatría, Ginecología, Cardiología) → [[Datos Semilla]].

## Relacionado
- [[Historias de Usuario]] — HU 9, HU 11
- [[Rol Administrador]]
