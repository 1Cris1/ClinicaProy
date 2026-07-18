---
tags: [modulo, notificaciones, websocket]
carpeta: modules/notificaciones
---

# Módulo Notificaciones

Dos mecanismos complementarios: notificaciones **persistidas** para el paciente (campana en el portal) y notificaciones **en tiempo real** por WebSocket para el médico.

## 1. Persistidas — entidad `Notificacion` (tabla `notificaciones`)

| Campo | Nota |
|---|---|
| id_paciente | FK → [[Módulo Pacientes\|Paciente]] |
| mensaje | VARCHAR(500) |
| icono | Bootstrap icon (`bi-capsule`, `bi-calendar-event`...) |
| fecha | DATETIME |
| leida | BOOLEAN, default false |

Se muestran en el dropdown de la campana del layout del paciente. `PacienteGlobalController` inyecta en **todas** las vistas del paciente: `notificacionesGlobal` (últimas 5) y `unreadNotifCount`.

Casos de uso: receta lista, recordatorio de cita, bienvenida. Ver ejemplos en [[Datos Semilla]].

## 2. Tiempo real — WebSocket STOMP

### `WebSocketConfig`
- Endpoint: **`/ws-laboratorio`** con fallback **SockJS**
- Broker simple con prefijo `/topic`; envíos de app con prefijo `/app`

### `NotificacionService`
`enviarNotificacionResultado(idMedico, mensaje)` publica con `SimpMessagingTemplate` en:

```
/topic/notificaciones/{idMedico}
```

Uso principal: avisar al médico cuando el [[Módulo Laboratorio|laboratorio]] valida resultados, sin recargar la página.

## Relacionado
- [[Stack Tecnológico]] — spring-boot-starter-websocket
- [[Rol Paciente]] / [[Rol Médico]]
