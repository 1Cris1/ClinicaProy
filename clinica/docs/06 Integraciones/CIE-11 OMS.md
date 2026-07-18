---
tags: [integracion, diagnosticos]
servicio: IcdService
---

# CIE-11 OMS

Búsqueda de **diagnósticos estandarizados** contra la API oficial de la OMS (Clasificación Internacional de Enfermedades, 11ª revisión).

## `IcdService`

- **OAuth 2.0 Client Credentials**: token desde `https://icdaccessmanagement.who.int/connect/token`
- **Caché de token** con renovación 60 s antes de expirar
- `buscarTermino(q)` → `GET {baseUrl}/search?q={q}` con headers `API-Version: v2`, `Accept-Language: es`
- Config en `IcdConfig` (`icd.api.clientid/clientsecret/tokenurl`); baseUrl default: release CIE-11 2024-01

## Uso en el sistema
Autocompletado de diagnósticos al escribir el historial clínico en la consulta médica ([[Módulo Consultas y Recetas]]). Expuesto en `GET /api/v1/external/cie11/search?q=` ([[API REST]]).

## CIE-10 local (complemento)
Existe además un catálogo **estático** en `src/main/resources/static/data/cie10.json` con 27 diagnósticos frecuentes (cólera, diabetes E11.9, hipertensión I10, migraña...) para autocompletado sin red.

## Relacionado
- [[Integraciones Externas]]
- [[Rol Médico]]
