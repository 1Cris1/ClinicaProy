---
tags: [flujo, arquitectura]
---

# Flujo Completo del Sistema

El recorrido de punta a punta de un paciente. Es también el guion de demostración en vivo de la exposición ([[Guía de Exposición]]).

```
Registro → Login → Agendamiento → Check-in → Consulta → Receta → Farmacia/Laboratorio → Pago → Feedback
```

## 1. Registro y login — [[Portal Público]]
1. El paciente se registra en `/registro`; el sistema valida su DNI contra [[API Perú y SUSALUD]] y obtiene sus nombres reales y datos de seguro.
2. Se crea el `Usuario` (username = DNI, contraseña BCrypt) y el `Paciente` vinculado 1:1.
3. Se sincroniza el paciente con [[FHIR]] y se envía correo de bienvenida.
4. Login → `CustomAuthenticationSuccessHandler` redirige según rol ([[Seguridad]]).

## 2. Agendamiento — [[Rol Recepcionista]] o [[Rol Paciente]]
1. Se selecciona paciente, médico, fecha, hora y servicio.
2. Validación anti **double-booking**: `existsByMedicoIdAndFechaCitaAndHoraCitaAndEstadoNot(...)`.
3. La [[Módulo Citas|Cita]] nace en estado **Pendiente**.
4. Se dispara la sincronización asíncrona con [[Google Calendar]].

## 3. Check-in — [[Rol Recepcionista]]
El paciente llega físicamente → botón Check-in → estado **Confirmada** (UPDATE simple). El médico lo ve en su sala de espera.

## 4. Consulta — [[Rol Médico]]
1. El médico ve su agenda del día ordenada por hora.
2. En `consulta.html` escribe notas de evolución y añade medicamentos dinámicamente (template HTML clonable, autocompletado contra DIGEMID → [[Módulo Farmacia]]).
3. `completarConsulta()` con `@Transactional`: cita → **Completada**, se crea la [[Módulo Consultas y Recetas|Receta]] + N `MedicamentoPrescrito`. Todo o nada ([[Patrones de Diseño]]).
4. Opcionalmente ordena exámenes → [[Módulo Laboratorio]].

## 5. Post-consulta — [[Rol Paciente]]
- Descarga su receta en PDF (OpenPDF).
- Ve resultados de laboratorio cuando el laboratorio los valida (notificación en tiempo real vía [[Módulo Notificaciones]]).
- Puede comprar en la farmacia online → [[Módulo Farmacia]].
- Deja su valoración → [[Módulo Experiencia]].

## 6. Pago — [[Módulo Facturación]]
El recepcionista registra el pago; `PagoService` genera número de comprobante único (`B001-YYYYMMDD-000001`).

## Ciclo de vida de la Cita

```
Pendiente ──check-in──► Confirmada ──consulta──► Completada
    │                                     
    └──────────► Cancelada / No asistió
```

## Relacionado
- [[Historias de Usuario]] — cada paso corresponde a una HU
- [[Equipo y Responsabilidades]] — cada tramo lo defiende un alumno
