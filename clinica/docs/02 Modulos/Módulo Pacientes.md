---
tags: [modulo, pacientes]
carpeta: modules/paciente
---

# Módulo Pacientes

La entidad `Paciente` es el **centro de gravedad del modelo de datos**: casi todos los módulos apuntan a ella (ver [[Modelo de Datos]]).

## Entidad `Paciente` (tabla `pacientes`)

**Identidad**: dni (único, 8 dígitos), nombres, apellidos, fecha_nacimiento, sexo, teléfono, email, dirección, distrito.

**Datos clínicos**: tipo_sangre, alergias (TEXT), enfermedades_cronicas (TEXT), antecedente (TEXT), contacto_emergencia + telefono_emergencia.

**Seguro (integración [[API Perú y SUSALUD]])**: seguro, nombre_iafas, tipo_plan, estado_seguro, fecha_sincronizacion_seguro.

**Vínculos**: `id_usuario` FK 1:1 → Usuario ([[Seguridad]]), `id_sede` FK opcional → Sede.

## Relaciones salientes (1:N)

| Colección | Módulo |
|---|---|
| citas | [[Módulo Citas]] |
| historiales, recetas | [[Módulo Consultas y Recetas]] |
| pedidos | [[Módulo Farmacia]] |
| pagos | [[Módulo Facturación]] |
| ordenesLaboratorio, resultadosLaboratorio | [[Módulo Laboratorio]] |
| notificaciones | [[Módulo Notificaciones]] |

## Cómo nace un paciente

1. **Auto-registro** (HU 2, [[Portal Público]]): valida DNI contra [[API Perú y SUSALUD]], crea Usuario+Paciente, sincroniza con [[FHIR]], envía correo de bienvenida.
2. **Por recepcionista**: alta rápida sin usuario web ([[Rol Recepcionista]]).
3. **Por administrador**: CRUD completo con usuario ([[Rol Administrador]]).

## Autogestión ([[Rol Paciente]])

El paciente puede actualizar teléfono/email, cambiar contraseña (validando la actual), agendar/cancelar citas, ver recetas y resultados, y comprar en farmacia.

## Relacionado
- [[Historias de Usuario]] — HU 2
- [[Roles del Sistema]]
