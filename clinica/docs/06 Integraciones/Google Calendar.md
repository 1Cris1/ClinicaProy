---
tags: [integracion, calendario]
servicio: GoogleCalendarService
---

# Google Calendar

Sincroniza cada [[Módulo Citas|cita]] agendada con Google Calendar (HU 3).

## Autenticación — OAuth 2.0 (flujo instalado)
- Credenciales: `src/main/resources/credentials.json`
- Tokens persistidos en la carpeta `tokens/` (raíz del proyecto)
- Scope: `CalendarScopes.CALENDAR`
- Receptor local en puerto **8888** para el callback OAuth

## `crearEventoCita(cita)` — el evento generado

```
Resumen:     "Cita Médica: {paciente}"
Ubicación:   "Clínica ClinicX"
Descripción: Consulta: {servicio} / Médico: Dr. {apellido} / Motivo: {motivo}
Inicio:      {fecha}T{hora}:00-05:00  (zona Lima)
Duración:    30 minutos
```

Normaliza la hora "HH:MM" → "HH:MM:SS" con padding.

## Diseño clave: asíncrono y aislado

Se invoca con `CompletableFuture.runAsync()` desde `RecepcionistaController` ([[Rol Recepcionista]]): el agendamiento **nunca espera ni falla** por culpa de Google. Argumento de defensa técnica ([[Patrones de Diseño]]).

## Relacionado
- [[Integraciones Externas]]
- [[Historias de Usuario]] — HU 3, módulo de MIGUEL
