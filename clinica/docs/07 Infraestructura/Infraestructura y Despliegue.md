---
tags: [infraestructura, docker, despliegue]
---

# Infraestructura y Despliegue

## Docker — SQL Server

`docker/clinica.composer.yaml`:

| Parámetro | Valor |
|---|---|
| Imagen | `mcr.microsoft.com/mssql/server:2019-latest` |
| Contenedor | `clinica_sqlserver` |
| Puerto | **1434** (host) → 1433 (contenedor) |
| Volumen | `sqlserver-data` (persistencia) |
| Healthcheck | cada 10 s, 10 reintentos |
| Init | crea la BD `bd_clinica` al arrancar |

```bash
docker-compose -f docker/clinica.composer.yaml up -d
```

> ⚠️ La contraseña de `sa` está en el YAML y en application.properties. No publicar.

## `start.sh` — menú interactivo

1. **Iniciar todo**: levanta Docker, espera el healthcheck y corre `./mvnw spring-boot:run`
2. Liberar puerto 8080 (mata procesos)
3. `./mvnw test`
4. `./mvnw clean`
5. `./mvnw package`
6. clean + package

## Orden de arranque

```
Docker SQL Server → Spring Boot → Hibernate crea tablas ([[Modelo de Datos]])
→ Flyway (import TEDEF) → Initializers ([[Datos Semilla]]) → app en :8080
```

## Herramientas auxiliares (raíz del proyecto)

| Archivo | Qué hace |
|---|---|
| `load_test.py` | prueba de carga: 200 requests, 50 workers concurrentes contra `/login` y `/registro`; reporta req/s, éxitos, tiempos |
| `BcryptGen.java` | genera hashes BCrypt para insertar usuarios a mano |
| `TestDB.java` | prueba de conectividad JDBC directa a SQL Server |

## Relacionado
- [[Base de Datos y Configuración]]
- [[Stack Tecnológico]]
