---
tags: [rol, laboratorio]
controlador: LaboratorioController
ruta-base: /laboratorio
---

# Rol Laboratorio

Puesto de trabajo del **laboratorista**. Controlador: `LaboratorioController` (`/laboratorio`), en `modules/laboratorio/controller/`. Usa `layout-admin.html` (acceso administrativo, no tiene rol dedicado en [[Seguridad]]).

## Rutas

| Ruta | Vista | Qué hace |
|---|---|---|
| GET `/gestion` | `laboratorio/gestion` | listado de órdenes de laboratorio |
| GET `/orden/{id}` | `laboratorio/entrada-datos` | ingreso de valores por examen |
| POST `/orden/actualizar-estado` | JSON | cambia estado de la orden |
| GET `/orden/{id}/pdf` | PDF | reporte JasperReports → [[Módulo Laboratorio]] |

## Flujo de trabajo

```
Orden "Pendiente de toma" → "En proceso" → ingresar valores → "Validado" → "Entregado"
```

Al validar, se notifica al médico solicitante por WebSocket ([[Módulo Notificaciones]]) y el resultado aparece como "Disponible" en el portal del paciente ([[Rol Paciente]]).

## Relacionado
- [[Módulo Laboratorio]] — entidades y servicio
- [[Datos Semilla]] — catálogo y órdenes de prueba
