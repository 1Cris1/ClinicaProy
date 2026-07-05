---
tags: [base-de-datos, modelo]
---

# Modelo de Datos

**28 entidades JPA** en 10 módulos. Todas usan PK autoincremental (IDENTITY). El esquema lo genera Hibernate (`ddl-auto=update`) → [[Base de Datos y Configuración]].

## Mapa de relaciones (diagrama mental)

```
                    Usuario (1:1) ──┬── Administrador
                                    ├── Medico ──── Especialidad ── Servicio
                                    │      │  └──── Sede
                                    └── Paciente ── Sede
                                           │
        ┌──────────┬──────────┬────────────┼───────────┬──────────────┬─────────────┐
        ▼          ▼          ▼            ▼           ▼              ▼             ▼
      Cita      Receta     Pedido        Pago    OrdenLaboratorio  Notificacion  ResultadoLab
     │ │ │        │          │                        │
     │ │ │        ▼          ▼                        ▼
     │ │ │  MedicamentoPrescrito  DetallePedido── Producto   ResultadoDetalle ── ExamenCatalogo
     ▼ ▼ ▼
Triaje HistorialClinico FeedbackPaciente   (1:1 con Cita)
```

## Entidades por módulo

| Módulo | Entidades (tabla) |
|---|---|
| [[Seguridad]] | Usuario (`usuarios`) + enums Rol, EstadoRegistro |
| [[Módulo Pacientes]] | Paciente (`pacientes`) |
| [[Módulo Recursos]] | Medico, Especialidad, Sede, Servicio, Promocion, Administrador, Configuracion |
| [[Módulo Citas]] | Cita (`citas`) |
| [[Módulo Triaje]] | Triaje (`triaje`) |
| [[Módulo Consultas y Recetas]] | HistorialClinico, Receta, MedicamentoPrescrito |
| [[Módulo Experiencia]] | FeedbackPaciente (`feedback_paciente`) |
| [[Módulo Facturación]] | Pago (`pagos`) |
| [[Módulo Farmacia]] | Producto, Pedido, DetallePedido, FarmaciaTedef, DigemidObservatorio |
| [[Módulo Laboratorio]] | ExamenCatalogo, OrdenLaboratorio, ResultadoLaboratorio, ResultadoDetalle |
| [[Módulo Notificaciones]] | Notificacion (`notificaciones`) |

## Relaciones 1:1 (con cascade=ALL)

- **Usuario ↔ Administrador / Medico / Paciente** — un usuario es exactamente uno de los tres perfiles
- **Cita ↔ Triaje / HistorialClinico / FeedbackPaciente** — cada cita puede tener uno de cada

## Cascadas importantes

| Padre | Hijos en cascada | Efecto |
|---|---|---|
| Usuario | Medico/Paciente/Administrador | borrar usuario borra su perfil |
| Cita | Triaje, Historial, Feedback | borrar cita limpia sus satélites |
| Receta | MedicamentoPrescrito (+orphanRemoval) | quitar med de la lista lo elimina de BD |
| Pedido | DetallePedido | pedido y líneas viajan juntos |

## Estrategias de fetch
- **EAGER**: Cita→Paciente/Medico, OrdenLaboratorio→Paciente, ResultadoDetalle→Examen (se necesitan siempre en pantalla)
- **LAZY**: el resto (rendimiento)

## Convenciones
- Estados como VARCHAR con valores en español ("Pendiente", "Activa", "Disponible"...)
- Auditoría temporal: `fecha_registro` / `fecha_creacion` / `fecha_actualizacion` inmutables donde aplica; `ultimo_acceso` en Usuario
- Únicos: DNI (paciente y médico), CMP, código de receta, número de comprobante

## Relacionado
- [[Datos Semilla]] — cómo se puebla al arrancar
- [[Power BI]] — vistas SQL de reporte sobre estas tablas
