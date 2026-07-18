---
tags: [integraciones, moc]
carpeta: modules/integraciones
---

# Integraciones Externas

ClinicX consume **6 APIs externas** + Power BI embebido. Todas viven en `modules/integraciones/service/` y comparten un principio: **si fallan, no rompen el flujo local** (try-catch aislado o async → [[Patrones de Diseño]]).

## Mapa

| Integración | API / Estándar | Para qué | Nota |
|---|---|---|---|
| API Perú | apis.net.pe (RENIEC) | validar DNI en registro | [[API Perú y SUSALUD]] |
| SUSALUD | SUSALUD/RENIEC + caché 24h | datos de seguro del paciente | [[API Perú y SUSALUD]] |
| FHIR | HL7 FHIR R4 (HAPI) | interoperabilidad clínica | [[FHIR]] |
| Google Calendar | OAuth 2.0 | sincronizar citas | [[Google Calendar]] |
| ICD OMS | CIE-11, OAuth client-credentials | diagnósticos estandarizados | [[CIE-11 OMS]] |
| OpenFDA | api.fda.gov | fichas de medicamentos | [[OpenFDA]] |
| Power BI | embed URL | dashboards por rol | [[Power BI]] |
| TEDEF / DIGEMID | datos locales importados | catálogo farmacéutico regulado | [[TEDEF y DIGEMID]] |

## Dónde se usan

- **Registro de paciente** ([[Portal Público]]): API Perú/SUSALUD + FHIR + correo
- **Agendamiento** ([[Rol Recepcionista]]): Google Calendar
- **Consulta médica** ([[Rol Médico]]): CIE-11 (diagnóstico), DIGEMID (medicamentos), OpenFDA (fichas)
- **Dashboards** (todos los roles): Power BI

## Configuración
Tokens y credenciales en `application.properties` ([[Base de Datos y Configuración]]) mediante clases `@ConfigurationProperties`: `ApiPeruConfig`, `IcdConfig`, `PowerBiProperties`. Google usa `credentials.json` + carpeta `tokens/`.
