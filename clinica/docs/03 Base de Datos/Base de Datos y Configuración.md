---
tags: [base-de-datos, configuracion]
---

# Base de Datos y Configuración

## SQL Server

| Parámetro | Valor |
|---|---|
| Motor | SQL Server 2019 (contenedor Docker → [[Infraestructura y Despliegue]]) |
| URL | `jdbc:sqlserver://localhost:1434;databaseName=bd_clinica` |
| Base de datos | `bd_clinica` |
| Dialecto | SQLServerDialect |
| DDL | `ddl-auto=update` — Hibernate crea/actualiza tablas desde las entidades ([[Modelo de Datos]]) |
| Pool Hikari | máx 10 conexiones, mín 2 idle, timeout 30 s |

> ⚠️ Las credenciales (usuario `sa` y contraseña) están en `application.properties`. **No subir ese archivo con secretos a repos públicos.**

## application.properties — mapa de secciones

| Sección | Propiedades | Nota relacionada |
|---|---|---|
| Datasource + JPA | url, credenciales, hikari, show-sql | esta nota |
| Thymeleaf | `cache=false` (desarrollo: recarga plantillas sin reiniciar) | [[Stack Tecnológico]] |
| Power BI | `powerbi.base.url`, páginas por rol, tablas de filtro | [[Power BI]] |
| API Perú | `apiperu.token`, `apiperu.base-url` | [[API Perú y SUSALUD]] |
| CIE-11 | `icd.api.clientid/clientsecret/tokenurl` | [[CIE-11 OMS]] |
| Mail | Gmail SMTP puerto 587, STARTTLS, App Password | [[Recuperación de Contraseña]] |

## Migraciones (Flyway)

En `src/main/resources/db/migration/`:

1. **`import_farmacia.sql`** — crea `farmacia_tedef` (30+ columnas) y hace BULK INSERT desde CSV (separador `|`). Índices en `VCODPROD_FAR_003` y `UBIGEO`. ⚠️ La ruta del CSV está hardcodeada: ajustar por ambiente. Ver [[TEDEF y DIGEMID]].
2. **`test-appointment.sql`** — inserta una cita de prueba (paciente DNI 75695332 con médico DNI 75536222, hoy 10:00).

`docs/bd_clinica.sql.tmp` es un placeholder sin DDL real (el esquema vive en las entidades).

## Utilidades de BD en la raíz del proyecto
- `TestDB.java` — prueba de conectividad JDBC directa
- `BcryptGen.java` — genera hashes BCrypt para insertar usuarios a mano

## Relacionado
- [[Datos Semilla]]
- [[Infraestructura y Despliegue]]
