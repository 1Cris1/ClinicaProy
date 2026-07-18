---
tags: [api, rest]
controlador: ApiController
ruta-base: /api/v1
---

# API REST

Endpoints JSON en `ApiController` (`/api/v1`) y `ExternalApiController` (`/api/v1/external`). Alimentan los AJAX del frontend y permiten integración externa.

## Citas → [[Módulo Citas]]
- `GET /citas/hoy` — citas del día
- `GET /citas/medico/{id}?fecha=` — agenda de un médico
- `PATCH /citas/{id}/estado` — `{"estado":"Completada"}`

## Pacientes e historia clínica
- `GET /pacientes/dni/{dni}` — búsqueda por DNI
- `GET /pacientes/{id}/resultados` — resultados de laboratorio
- `GET /historia/paciente/{id}` / `POST /historia` → [[Módulo Consultas y Recetas]]

## Búsquedas externas → [[Integraciones Externas]]
- `GET /external/dni/{dni}` — [[API Perú y SUSALUD]]
- `GET /external/cie11/search?q=` — [[CIE-11 OMS]]
- `GET /external/farmacia/search?q=` — TEDEF ([[TEDEF y DIGEMID]])
- `GET /external/medicamentos/search?q=` — DIGEMID ([[Módulo Farmacia]])
- `GET /external/medicamentos/info?q=` — [[OpenFDA]]

## Farmacia y administración
- `GET /farmacia/productos?q=` — catálogo filtrable
- `GET /admin/stats` — `{citasHoy, atendidosHoy, pacientes, medicos}`
- `GET /admin/health` — estado de servicios

## Otros controladores REST
- **PasswordResetController** `/api/password/*` → [[Recuperación de Contraseña]]
- **ImageController** `POST /upload` — sube imágenes a `static/uploads/` (nombre = UUID + original)
- `POST /paciente/farmacia/comprar` — carrito del paciente ([[Rol Paciente]])

## Relacionado
- [[Seguridad]] — qué endpoints son públicos
