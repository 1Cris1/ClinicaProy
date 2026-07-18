---
tags: [integracion, interoperabilidad]
servicio: FhirService
---

# FHIR

Interoperabilidad clínica con el estándar **HL7 FHIR R4** usando la librería **HAPI FHIR 6.10.0** ([[Stack Tecnológico]]).

## `FhirService`

- Servidor: HAPI FHIR público de pruebas — `http://hapi.fhir.org/baseR4`
- `@PostConstruct` crea el `FhirContext` R4 y el cliente REST
- `syncPatient(paciente)` — crea un recurso **Patient** en el servidor al registrarse un paciente ([[Portal Público]])

## Mapeo Paciente → FHIR Patient

| ClinicX | FHIR |
|---|---|
| DNI | Identifier (system: `http://reniec.gob.pe`) |
| nombres + apellidos | Name (given + family) |
| sexo M/F | administrativeGender |
| fecha_nacimiento | birthDate |
| teléfono / email | Telecom (PHONE / EMAIL) |
| dirección + distrito | Address (line + city, country=PE) |

## Por qué importa
Es el argumento de **interoperabilidad** del proyecto: los datos del paciente quedan en un formato que cualquier sistema de salud del mundo puede consumir. Buen punto para la defensa ([[Guía de Exposición]]).

## Relacionado
- [[Integraciones Externas]]
- [[Módulo Pacientes]]
