---
tags: [arquitectura]
---

# Arquitectura General

ClinicX es un **monolito modular** con arquitectura **MVC** en 4 capas. Cada módulo de negocio vive en su propia carpeta bajo `src/main/java/com/proyectoclinica/clinica/modules/`.

## Las 4 capas

```
Vista (Thymeleaf)  →  Controlador  →  Servicio  →  Repositorio  →  SQL Server
```

| Capa | Anotación | Analogía del restaurante 🍽️ | Ejemplo |
|---|---|---|---|
| Vista | plantilla `.html` | El menú / el plato servido | `paciente/agendar.html` |
| Controlador | `@Controller` | El mesero (toma la orden) | `MedicoController` |
| Servicio | `@Service` | El chef (lógica de negocio) | `CitasService` |
| Repositorio | `@Repository` (JPA) | La despensa (datos) | `CitaRepository` |

> La analogía del restaurante es la que usa el equipo para explicar el sistema a no-programadores. Ver [[Guía de Exposición]].

## Estructura de módulos

```
modules/
├── citas/            → [[Módulo Citas]]
├── consultas/        → [[Módulo Consultas y Recetas]]
├── experiencia/      → [[Módulo Experiencia]]
├── facturacion/      → [[Módulo Facturación]]
├── farmacia/         → [[Módulo Farmacia]]
├── integraciones/    → [[Integraciones Externas]]
├── laboratorio/      → [[Módulo Laboratorio]]
├── notificaciones/   → [[Módulo Notificaciones]]
├── paciente/         → [[Módulo Pacientes]]
├── recursos/         → [[Módulo Recursos]]
├── seguridad/        → [[Seguridad]]
└── triaje/           → [[Módulo Triaje]]
```

Cada módulo contiene sus propias subcarpetas `models/`, `repository/` y `service/`. Los controladores web están centralizados en `controller/` (organizados por rol, ver [[Roles del Sistema]]).

## Decisiones clave

- **Monolito modular** en lugar de microservicios: simplicidad de despliegue para un proyecto académico, pero con fronteras de módulo claras que permitirían separarlo después.
- **JPA/Hibernate con `ddl-auto=update`**: el esquema se genera desde las entidades (ver [[Modelo de Datos]]). Flyway está disponible para migraciones manuales ([[Base de Datos y Configuración]]).
- **Server-side rendering** con Thymeleaf + layouts por rol. Vue.js solo se usa puntualmente (tabla reactiva de resultados de laboratorio).
- **WebSocket STOMP** para notificaciones en tiempo real ([[Módulo Notificaciones]]).
- **Integraciones aisladas en servicios**: si Google Calendar o SUSALUD fallan, no rompen el flujo principal (try-catch aislado + async).

## Relacionado
- [[Stack Tecnológico]]
- [[Patrones de Diseño]]
- [[Flujo Completo del Sistema]]
