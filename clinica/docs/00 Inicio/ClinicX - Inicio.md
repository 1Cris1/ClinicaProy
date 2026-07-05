---
tags: [moc, inicio]
proyecto: ClinicX
---

# 🏥 ClinicX — Segundo Cerebro del Proyecto

**ClinicX** es un sistema de gestión clínica desarrollado en **Spring Boot 4 (Java 24)** con **SQL Server** y **Thymeleaf**. Proyecto académico de 4 integrantes ([[Equipo y Responsabilidades]]).

> Esta es la nota central del vault. Todo el conocimiento del proyecto está conectado desde aquí.

## 🗺️ Mapas de contenido

### Arquitectura y diseño
- [[Arquitectura General]] — MVC, monolito modular, capas
- [[Stack Tecnológico]] — dependencias y versiones (pom.xml)
- [[Patrones de Diseño]] — Builder, PRG, RBAC, @Transactional
- [[Flujo Completo del Sistema]] — el recorrido paciente → recepción → médico → receta
- [[evaluacion_tecnologias]] — auditoría docs vs código (⚠️ inconsistencia MySQL/SQL Server)

### Módulos de negocio
- [[Módulo Citas]] — corazón del sistema
- [[Módulo Consultas y Recetas]] — evolución clínica + receta digital
- [[Módulo Pacientes]]
- [[Módulo Recursos]] — médicos, especialidades, sedes, servicios
- [[Módulo Farmacia]] — catálogo, pedidos, TEDEF/DIGEMID
- [[Módulo Laboratorio]] — órdenes, resultados, PDF Jasper
- [[Módulo Facturación]] — pagos y comprobantes
- [[Módulo Triaje]] — signos vitales
- [[Módulo Notificaciones]] — WebSocket + campana del paciente
- [[Módulo Experiencia]] — feedback post-consulta

### Datos
- [[Modelo de Datos]] — las 28 entidades y sus relaciones
- [[Base de Datos y Configuración]] — SQL Server, Hikari, Flyway
- [[Datos Semilla]] — initializers que pueblan la BD al arrancar

### Actores y accesos
- [[Roles del Sistema]] — los 4 roles + público
- [[Rol Paciente]] · [[Rol Médico]] · [[Rol Recepcionista]] · [[Rol Administrador]] · [[Rol Laboratorio]]
- [[Portal Público]] — login, registro, catálogo público
- [[API REST]] — endpoints /api/v1
- [[Seguridad]] — Spring Security, BCrypt, reglas por ruta
- [[Recuperación de Contraseña]] — flujo OTP por correo

### Integraciones externas
- [[Integraciones Externas]] — mapa general
- [[API Perú y SUSALUD]] — validación de DNI y seguros
- [[FHIR]] — interoperabilidad HL7
- [[Google Calendar]] — sincronización de citas
- [[CIE-11 OMS]] — diagnósticos estandarizados
- [[OpenFDA]] — información de medicamentos
- [[Power BI]] — dashboards embebidos
- [[TEDEF y DIGEMID]] — normativa farmacéutica peruana

### Operación
- [[Infraestructura y Despliegue]] — Docker, start.sh, pruebas de carga

### Material académico
- [[Documentación Académica]] — índice de todos los documentos de exposición
- [[Historias de Usuario]] — las 8 HU del proyecto
- [[Equipo y Responsabilidades]] — quién hizo qué
- [[Guía de Exposición]] — storytelling y mata-preguntas

## ⚡ Datos rápidos

| Aspecto | Valor |
|---|---|
| Backend | Spring Boot 4.0.6, Java 24 |
| Base de datos | SQL Server 2019 (Docker, puerto 1434), BD `bd_clinica` |
| Frontend | Thymeleaf + Bootstrap 5 + Vue.js (puntual) |
| Seguridad | Spring Security + BCrypt |
| Entidades JPA | 28 en 10 módulos |
| Controladores | 15 (~90 rutas) |
| Roles | Admin, Médico, Paciente, Recepcionista |
| Rama actual | `jhoan` |
