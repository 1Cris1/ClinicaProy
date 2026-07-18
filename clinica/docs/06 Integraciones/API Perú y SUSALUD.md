---
tags: [integracion, identidad]
servicios: ApiPeruService, SusaludService
---

# API Perú y SUSALUD

Validación de **identidad (DNI)** y **datos de seguro** de pacientes peruanos. Dos servicios complementarios.

## `ApiPeruService`
- Proveedor: **apis.net.pe** (wrapper de RENIEC), Bearer token
- `consultarDni(dni)` → `GET {base}/dni?numero={dni}` → nombres y apellidos reales
- Config: `apiperu.token`, `apiperu.base-url` (clase `ApiPeruConfig`)
- Si falla: `{"success": false, "message": ...}`
- Expuesto en `GET /api/v1/external/dni/{dni}` ([[API REST]])

## `SusaludService`
- `consultarDatosCompletos(dni)` → identidad + seguro
- **Caché en memoria de 24 horas** por DNI (reduce llamadas y costo)
- Normaliza camelCase → snake_case para el frontend (`apellidoPaterno` → `apellido_paterno`)
- Defaults si la API no trae seguro: IAFAS "ESSALUD / SIS (Acreditado)", plan "PEAS", estado "ACTIVO"
- Expuesto en `GET /api/identidad/{dni}` (público → [[Portal Público]])

## Dónde impactan

1. **Registro (HU 2)**: el DNI autocompleta nombres y precarga los campos de seguro del [[Módulo Pacientes|Paciente]] (`nombre_iafas`, `tipo_plan`, `estado_seguro`, `fecha_sincronizacion_seguro`).
2. **Panel admin** `/admin/susalud`: validaciones de conformidad ([[Rol Administrador]]).

## Relacionado
- [[Integraciones Externas]]
- [[Historias de Usuario]] — HU 2
