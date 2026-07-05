---
tags: [arquitectura, dependencias]
---

# Stack Tecnológico

Definido en [pom.xml](../../pom.xml). Proyecto Maven: `com.proyectoclinica:clinica:0.0.1-SNAPSHOT`.

## Núcleo

| Tecnología | Versión | Rol |
|---|---|---|
| Spring Boot | **4.0.6** | Framework base |
| Java | **24** | Lenguaje |
| SQL Server (mssql-jdbc) | 2019 | Base de datos → [[Base de Datos y Configuración]] |
| Thymeleaf + layout-dialect 3.4.0 | — | Vistas server-side |
| Lombok | — | Reduce boilerplate (`@Builder`, `@Data`) |

## Starters de Spring Boot

- `web` — MVC y REST
- `data-jpa` — ORM Hibernate → [[Modelo de Datos]]
- `security` + `thymeleaf-extras-springsecurity6` → [[Seguridad]]
- `mail` — correos por Gmail SMTP → [[Recuperación de Contraseña]]
- `websocket` — STOMP/SockJS → [[Módulo Notificaciones]]
- `validation`, `actuator`, `devtools`, `test`
- `configuration-processor` — soporte `@ConfigurationProperties` (ej. [[Power BI]])

## Librerías especializadas

| Librería | Versión | Para qué | Nota relacionada |
|---|---|---|---|
| HAPI FHIR (base, structures-r4, client) | 6.10.0 | Interoperabilidad HL7 FHIR R4 | [[FHIR]] |
| Google API Client + Calendar v3 | 2.2.0 | Sincronizar citas | [[Google Calendar]] |
| JasperReports | 6.20.0 | PDF de resultados de laboratorio | [[Módulo Laboratorio]] |
| OpenPDF | 1.3.30 | PDF de recetas | [[Módulo Consultas y Recetas]] |
| Flyway | — | Migraciones SQL | [[Base de Datos y Configuración]] |

## Frontend

- **Bootstrap 5.3.2** + Bootstrap Icons (CDN)
- CSS propio por rol: `admin.css`, `medico.css`, `paciente.css`, `recepcionista.css`, `common.css`
- **Vue.js** (local, `vue.min.js`) — solo en la tabla reactiva de resultados del paciente
- JS propio: `main.js`, `common.js`

## Relacionado
- [[Arquitectura General]]
- [[Infraestructura y Despliegue]]
- [[evaluacion_tecnologias]] — análisis detallado docs vs código real (incluye la inconsistencia MySQL→SQL Server y tecnologías sin defensa preparada)
