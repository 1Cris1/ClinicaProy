---
tags: [seguridad]
archivos: security/SecurityConfig.java
---

# Seguridad

Spring Security con autenticación por formulario y **RBAC** (control de acceso por roles). Archivos en `security/`: `SecurityConfig`, `UserDetailsServiceImpl`, `UserDetailsImpl`, `CustomAuthenticationSuccessHandler`, `DataInitializer`.

## Entidad `Usuario` (tabla `usuarios`)

| Campo                                              | Nota                                                |
| -------------------------------------------------- | --------------------------------------------------- |
| username                                           | generalmente el **DNI**                             |
| password                                           | **BCrypt** (cost 10)                                |
| id_rol                                             | 1=Admin, 2=Médico, 3=Paciente, 4=Recepcionista      |
| estado                                             | 1 = activo                                          |
| estado_registro                                    | enum: PENDIENTE / VERIFICADO_WEB / VALIDADO_CLINICA |
| ultimo_acceso, fecha_creacion, fecha_actualizacion | auditoría                                           |

Relaciones 1:1 hacia Administrador / Medico / Paciente (cascade=ALL) → [[Modelo de Datos]].

## Reglas de autorización (SecurityConfig)

```
/admin/**          → ROLE_ADMIN
/medico/**         → ROLE_MEDICO
/paciente/**       → ROLE_PACIENTE
/recepcionista/**  → ROLE_RECEPCIONISTA
/paciente/recetas/descargar/** → PACIENTE o MEDICO
resto autenticado; públicos ↓
```

**Públicos**: estáticos (css/js/img), `/`, `/login`, `/registro`, catálogos ([[Portal Público]]), `/api/password/**`, `/api/identidad/**`, `/api/colegiatura/**`, `/error`.

## Flujo de login

1. Form en `/login` → POST `/authenticate`
2. `UserDetailsServiceImpl` carga el usuario y su rol
3. Éxito → `CustomAuthenticationSuccessHandler` redirige por rol ([[Roles del Sistema]])
4. Error → `/login?error=true` · Logout → `/logout` → `/`

## Decisiones y advertencias

- ⚠️ **CSRF deshabilitado** (`csrf.disable()`) — aceptable en demo académica, habilitar en producción.
- Contraseña de registro con política: 8+ caracteres, mayúscula, carácter especial.
- Defensa en profundidad: además del RBAC por ruta, los controladores validan **propiedad** con `Principal` (el médico solo toca sus citas, el paciente solo ve lo suyo).
- JPA/Prepared Statements → inmune a SQL Injection ([[Patrones de Diseño]]).

## Relacionado
- [[Recuperación de Contraseña]]
- [[Datos Semilla]] — normalización de roles al arrancar
- [[Historias de Usuario]] — HU 1 (login), módulo de RHOMEL
