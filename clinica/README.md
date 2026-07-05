# 🏥 ClinicX — Sistema de Gestión Clínica Integral

![Java](https://img.shields.io/badge/Java-24-orange?logo=openjdk&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-4.0-6DB33F?logo=springboot&logoColor=white)
![SQL Server](https://img.shields.io/badge/SQL%20Server-2022-CC2927?logo=microsoftsqlserver&logoColor=white)
![Thymeleaf](https://img.shields.io/badge/Thymeleaf-3-005F0F?logo=thymeleaf&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboards-F2C811?logo=powerbi&logoColor=black)
![License](https://img.shields.io/badge/Licencia-Académica-blue)

**ClinicX** es un sistema web integral para la gestión de clínicas privadas: citas médicas, historia clínica electrónica, receta digital, farmacia, laboratorio, triaje, facturación y reportería analítica — con integraciones a estándares de salud peruanos e internacionales (SUSALUD, TEDEF, FHIR, CIE/ICD).

---

## 📌 Características principales

### 👥 Multi-rol con paneles dedicados
| Rol | Funcionalidades |
|---|---|
| 🔑 **Administrador** | Gestión de médicos, recepcionistas, especialidades, sedes, servicios, promociones, productos, usuarios y reportes SUSALUD |
| 🩺 **Médico** | Agenda diaria cronológica, consulta clínica, historial del paciente, receta digital, órdenes de laboratorio |
| 🧾 **Recepcionista** | Agendamiento de citas con prevención de cruces (double booking), check-in de pacientes, pagos y comprobantes |
| 🧍 **Paciente** | Auto-registro con validación RENIEC, agendar citas, ver historial, recetas, resultados de laboratorio y farmacia |
| 🔬 **Laboratorio** | Gestión de órdenes y entrada de resultados de exámenes |

### 🧩 Módulos del sistema
- **📅 Citas** — agendamiento con bloqueo automático de cruces de horario
- **📋 Consultas** — historia clínica electrónica, evolución médica y receta digital transaccional (`@Transactional` + rollback)
- **💊 Farmacia** — catálogo de productos bajo estándar **TEDEF** (SUSALUD) y observatorio **DIGEMID**, pedidos en línea
- **🔬 Laboratorio** — catálogo de exámenes, órdenes médicas y resultados detallados
- **🩹 Triaje** — registro de signos vitales previo a la consulta
- **💰 Facturación** — pagos, métodos de pago y comprobantes
- **🔔 Notificaciones** — en tiempo real vía **WebSockets** + correo (SMTP)
- **⭐ Experiencia** — feedback de pacientes post-atención
- **📊 Reportería** — dashboards **Power BI** embebidos por rol + PDFs con **JasperReports/OpenPDF**

### 🌐 Integraciones externas
| Integración | Propósito |
|---|---|
| 🇵🇪 **API Perú (RENIEC)** | Autocompletar nombres reales del paciente a partir del DNI |
| 🏛️ **SUSALUD** | Reportes al ente regulador de salud peruano |
| 🔄 **HAPI FHIR R4** | Interoperabilidad de datos clínicos bajo estándar internacional HL7 FHIR |
| 🧬 **ICD (OMS)** | Codificación de diagnósticos CIE |
| 💊 **OpenFDA** | Información de medicamentos |
| 📆 **Google Calendar API** | Sincronización de citas con el calendario del usuario |
| 📈 **Power BI** | Dashboards analíticos embebidos con filtros por rol |

---

## 🛠️ Stack tecnológico

| Capa | Tecnologías |
|---|---|
| **Lenguaje** | Java 24 |
| **Framework** | Spring Boot 4 (Web MVC, Security, Data JPA, Validation, Mail, WebSocket, Actuator) |
| **Seguridad** | Spring Security con roles + BCrypt para contraseñas |
| **Vistas** | Thymeleaf (Layout Dialect + Extras SpringSecurity6), Bootstrap, JavaScript/AJAX |
| **Base de datos** | Microsoft SQL Server + Hibernate/JPA + migraciones **Flyway** |
| **Reportes** | JasperReports 6.20, OpenPDF, Power BI embebido |
| **Build** | Maven + Lombok |

---

## 🚀 Instalación y ejecución

### Requisitos previos
- ☕ **JDK 24**
- 🗄️ **SQL Server** (instancia local, puerto `1434`)
- 📦 **Maven 3.9+** (o usar el wrapper `mvnw` incluido)

### Pasos

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/JhoanGP17/clinica.git
   cd clinica
   ```

2. **Crear la base de datos**
   ```sql
   CREATE DATABASE bd_clinica;
   ```
   > Las tablas y datos iniciales se crean automáticamente con **Flyway** al arrancar (scripts en `src/main/resources/db/migration`).

3. **Configurar credenciales** en `src/main/resources/application.properties`:
   ```properties
   spring.datasource.url=jdbc:sqlserver://localhost:1434;databaseName=bd_clinica;encrypt=true;trustServerCertificate=true;
   spring.datasource.username=TU_USUARIO
   spring.datasource.password=TU_CONTRASEÑA
   ```

4. **Ejecutar la aplicación**
   ```bash
   ./mvnw spring-boot:run
   ```

5. Abrir en el navegador: **http://localhost:8080**

---

## 📂 Estructura del proyecto

```
clinica/
├── src/main/java/com/proyectoclinica/clinica/
│   ├── config/            # Configuración (Power BI, WebSocket, API Perú, ICD, seeders)
│   ├── controller/        # Controladores MVC por rol (Admin, Médico, Paciente, Recepción)
│   ├── security/          # Spring Security, autenticación por DNI y handler de roles
│   ├── dto/               # Objetos de transferencia de datos
│   └── modules/           # Módulos de dominio
│       ├── citas/         # Agendamiento y gestión de citas
│       ├── consultas/     # Historia clínica, recetas y medicamentos prescritos
│       ├── farmacia/      # Productos TEDEF, DIGEMID y pedidos
│       ├── laboratorio/   # Exámenes, órdenes y resultados
│       ├── triaje/        # Signos vitales
│       ├── facturacion/   # Pagos y comprobantes
│       ├── notificaciones/# Notificaciones en tiempo real
│       ├── experiencia/   # Feedback de pacientes
│       ├── integraciones/ # API Perú, FHIR, Google Calendar, ICD, OpenFDA, SUSALUD
│       ├── recursos/      # Médicos, sedes, especialidades, servicios, promociones
│       └── seguridad/     # Usuarios, roles y estados
├── src/main/resources/
│   ├── templates/         # Vistas Thymeleaf organizadas por rol
│   ├── db/migration/      # Scripts SQL versionados (Flyway)
│   └── application.properties
├── docs/                  # Documentación del proyecto (Obsidian vault)
└── pom.xml
```

---

## 🔒 Seguridad

- 🔐 Autenticación con **DNI + contraseña** encriptada con **BCrypt**
- 🛡️ Autorización jerárquica por rutas: `/admin/**`, `/medico/**`, `/paciente/**`, `/recepcionista/**`
- 🚫 Protección contra **SQL Injection** mediante consultas parametrizadas de JPA
- 🔁 Patrón **POST-REDIRECT-GET** para evitar doble envío de formularios
- ↩️ Integridad transaccional (**ACID**) con `@Transactional` y rollback automático

---

## 👨‍💻 Equipo de desarrollo

| Integrante | Área |
|---|---|
| **Rhomel** | Seguridad y registro de usuarios |
| **Miguel** | Gestión operativa de citas en recepción |
| **Cristian** | Administración y maestros de datos |
| **Jhoan** | Consultorio clínico y agenda médica |

---

## 📄 Licencia

Proyecto académico desarrollado para el **Curso Integrador II** — uso educativo.
