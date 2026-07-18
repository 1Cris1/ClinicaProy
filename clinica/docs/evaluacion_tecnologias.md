---
titulo: Evaluación de Tecnologías - Proyecto ClinicX
fecha: 2026-07-05
tags:
  - clinicx
  - tecnologias
  - stack
  - exposicion
---

# 🏥 Evaluación de Tecnologías — Proyecto ClinicX

> [!info] Origen del análisis
> Este documento resume las tecnologías identificadas al contrastar la documentación de la carpeta `docs` con los archivos reales del proyecto: `pom.xml` y `application.properties`.

---

## 1. ⚙️ Backend (núcleo del sistema)

| Tecnología | Dónde se menciona | Para qué se usa |
|---|---|---|
| **Java 24** | Todas las guías de exposición | Lenguaje principal de todo el backend |
| **Spring Boot 4.0.6** | [[Guía de Exposición]] | Framework base: controladores, inyección de dependencias (`@Autowired`), rutas |
| **Spring Security** | [[Guía de Exposición]] (sección "Mata-Preguntas") | Login con DNI, control de acceso por roles (`ROLE_ADMIN`, `ROLE_MEDICO`, `ROLE_PACIENTE`), objeto `Principal` |
| **BCrypt** | [[Guía de Exposición]], explicación alumno 4 | Encriptación irreversible de contraseñas |
| **Spring Data JPA / Hibernate** | Todas las guías | Repositorios (`CitaRepository`, `RecetaRepository`), consultas derivadas, protección contra SQL Injection, `@Transactional` con rollback |
| **Lombok** | [[Guía de Exposición]] (US 11) | Builders para crear entidades sin código repetitivo |

---

## 2. 🎨 Frontend

| Tecnología | Dónde se menciona | Para qué se usa |
|---|---|---|
| **Thymeleaf** | Todas las guías (la más citada) | Plantillas HTML dinámicas: `th:action`, `th:each`, `th:if`, `th:text`, formateo con `#temporals` |
| **Bootstrap** | Explicación alumno 1 | Estilos y componentes visuales (alertas, tablas, modales) |
| **JavaScript / AJAX** | [[Guía de Exposición]], explicación alumno 2 | Validación de CMP en vivo con autocompletado de nombres del médico |

---

## 3. 🔗 Integraciones externas

| Tecnología | Dónde se menciona | Para qué se usa |
|---|---|---|
| **API Perú (RENIEC) vía RestTemplate** | [[Guía de Exposición]] (US 2) | Traer nombres reales del paciente a partir del DNI |
| **HAPI FHIR 6.10 (R4)** | [[Guía de Exposición]] (US 2) | Estándar internacional de interoperabilidad de datos clínicos |
| **SUSALUD** | [[Guía de Exposición]] (US 2) | Validación/reporte al ente regulador peruano |
| **Google Calendar API** | [[guia_exposicion_alumno1]] | Sincronización de citas con el calendario del usuario |
| **Power BI** | [[powerbi_setup_guia]] | Dashboards embebidos por rol usando vistas SQL (`v_reporte_citas`, `v_reporte_pagos`) |
| **TEDEF – Farmacia** | PDF Diccionario TEDEF + `import_farmacia.sql` | Estándar peruano (SUSALUD) para el catálogo de medicamentos |

---

## 4. 📦 Tecnologías reales del proyecto NO mencionadas en los docs

> [!warning] Preparar defensa
> Están en el `pom.xml` pero ningún documento las explica. Si el jurado revisa las dependencias, alguien debe poder defenderlas.

- **SQL Server (mssql-jdbc)** → el driver de base de datos real del proyecto
- **Flyway** → migraciones versionadas de BD (los `.sql` están en `src/main/resources/db/migration`)
- **JasperReports 6.20 + OpenPDF** → generación de reportes/PDFs (receta digital impresa)
- **Spring WebSocket** → comunicación en tiempo real (notificaciones)
- **Spring Mail (Gmail SMTP)** → envío de correos
- **Spring Actuator** → monitoreo del estado de la aplicación
- **Spring Validation** → validación de formularios con anotaciones
- **Thymeleaf Layout Dialect + Extras SpringSecurity6** → plantillas maestras y `sec:authorize` en HTML
- **Maven** → gestor de dependencias y build

---

## 5. 🚨 Inconsistencia detectada: MySQL vs SQL Server

> [!danger] Riesgo para la exposición
> Los documentos dicen **MySQL** en al menos 4 archivos, pero el proyecto realmente usa **SQL Server**.

**Evidencia en el código:**
- `application.properties` línea 2 → `jdbc:sqlserver://localhost:1434;databaseName=bd_clinica`
- `application.properties` línea 20 → dialecto `SQLServerDialect`
- `pom.xml` líneas 56-59 → driver `mssql-jdbc`

**Documentos desactualizados que mencionan MySQL:**
- [guia_exposicion.txt](guia_exposicion.txt)
- [guion_exposicion_final.txt](guion_exposicion_final.txt)
- [[guia_exposicion_alumno1]]
- [[powerbi_setup_guia]] (instruye conectar con "MySQL database" y credenciales `root/12345` que ya no corresponden)

> La configuración real está documentada en [[Base de Datos y Configuración]].

**Acción recomendada:** actualizar todos los docs reemplazando MySQL por SQL Server antes de la exposición. Si dicen "guardamos en MySQL" y el jurado pide ver la conexión, verán SQL Server.

---

## 6. 📋 Resumen del stack completo (para la exposición)

- **Lenguaje:** Java 24
- **Framework:** Spring Boot 4 (Web MVC, Security, Data JPA, Validation, Mail, WebSocket, Actuator)
- **Vistas:** Thymeleaf + Bootstrap + JavaScript/AJAX
- **Base de datos:** SQL Server con Hibernate/JPA y migraciones Flyway
- **Reportería:** Power BI embebido + JasperReports/OpenPDF
- **Integraciones:** API Perú (RENIEC), HAPI FHIR R4, Google Calendar, Gmail SMTP, estándar TEDEF de farmacia
- **Herramientas:** Maven, Lombok, Git

---

## 7. 🔐 Observación de seguridad

> [!caution] Credenciales en texto plano
> La contraseña de la BD y la contraseña de aplicación de Gmail están en texto plano en `application.properties` y en los docs.

- Para un proyecto académico es aceptable, pero si el repo se hace público conviene moverlas a **variables de entorno**.
- Esta misma respuesta sirve como **"mata-pregunta"** si el jurado lo nota: *"Somos conscientes; en producción usaríamos variables de entorno o un gestor de secretos."*

---

## 📎 Documentos relacionados

- [[Stack Tecnológico]] — la versión resumida de este análisis en el vault
- [[Historias de Usuario]]
- [[Guía de Exposición]]
- [[Documentación Académica]]
- [[powerbi_setup_guia]]
