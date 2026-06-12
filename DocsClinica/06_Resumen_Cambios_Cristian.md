---
tags:
  - exposicion
  - cristian
  - admin
  - seguridad
  - demostracion
relacionado_con:
  - "[[05_Plan_Implementacion_Cristian]]"
---

# 🚀 Resumen de Cambios: Cristian (Admin)

Este documento detalla todas las funcionalidades implementadas y estructuradas para el bloque del Administrador. **Debe ser utilizado como la guía oficial para la demostración en vivo de Cristian.**

## 1. Métricas en Tiempo Real y Power BI (HU 15)
El Panel de Control (`/dashboard`) ahora está totalmente vivo.
*   **Consultas JPA Agregadas:** Se inyectaron comandos puros de Spring Data JPA (`count()` y `countByFechaCita()`) que traducen la lógica a SQL por detrás. Ahora las tarjetas superiores muestran el total exacto de pacientes, médicos, citas del día y citas pendientes en tiempo real.
*   **Power BI Configurado:** El `iframe` central está conectado exitosamente leyendo la URL segura desde `application.properties`.

## 2. Gestión Operativa de Servicios Médicos (Tarifario)
El flujo completo de mantenimiento (`CRUD`) de Servicios fue etiquetado para su exposición.
*   Cristian podrá mostrar cómo se instancia la clase `Servicio` usando el patrón `@Builder` de Lombok, lo que permite un código súper limpio al momento de registrar nuevos servicios médicos y sus precios.

## 3. Seguridad Perimetral: Bloqueo de Cuentas (HU 16) 🔒
Este es el "Plato Fuerte" de la exposición de Cristian. Se integró una validación profunda con Spring Security:
*   **Modificación del Core de Seguridad:** El archivo `UserDetailsImpl.java` fue sobreescrito. Su método interno `isEnabled()` ahora extrae dinámicamente la columna `estado` de la base de datos.
*   **Panel Visual:** En la pestaña "Usuarios" del administrador, se agregó una nueva columna de estado (`ACTIVO` / `SUSPENDIDO`) y un botón rojo del candado.
*   **Demostración:** Cuando Cristian le da clic a "Suspender" a cualquier usuario, el estado baja a `0`. Si ese usuario intenta iniciar sesión inmediatamente después, el framework `Spring Security` lo interceptará y le denegará el acceso antes siquiera de evaluar la contraseña.

## 📖 Guion de Sustentación en Código
Para facilitar la exposición, se han inyectado los marcadores clave `// EXPOSICIÓN CRISTIAN:` en el código fuente. Cristian solo debe buscar esa palabra clave en su IDE (Ctrl+F) para saltar automáticamente a:
1. Las métricas JPA en `AdminController.java`.
2. La inyección de properties para Power BI.
3. El uso del `@Builder` en el CRUD de servicios.
4. El endpoint de seguridad `@PostMapping("/usuarios/toggle-estado")`.

> [!TIP] Demostración en Vivo recomendada
> 1. Iniciar sesión como Administrador (DNI 10000000).
> 2. Mostrar cómo el Dashboard carga con números reales de la BD en las tarjetas superiores.
> 3. Ir a **Gestión de Usuarios**, buscar un paciente de prueba e inhabilitarlo (clic en el candado rojo).
> 4. Cerrar sesión e intentar entrar con el paciente suspendido para mostrar el bloqueo en vivo por Spring Security.
> 4. Cerrar sesión e intentar entrar con el paciente suspendido para mostrar el bloqueo en vivo por Spring Security.

### 📍 Ubicación en el Código (Para mostrar al Profesor)
Si el profesor pide ver el código de tu módulo, debes mostrarle los siguientes archivos:

**1. Para el Dashboard de Métricas y Power BI:**
*   **Backend:** `clinica/src/main/java/com/proyectoclinica/clinica/controller/AdminController.java` (Buscar `@GetMapping("/inicio")` donde se ejecutan los `count()` y se inyecta la URL de Power BI).
*   **Frontend:** `clinica/src/main/resources/templates/admin/dashboard.html`

**2. Para la Gestión del Tarifario (Patrón @Builder):**
*   **Backend:** `clinica/src/main/java/com/proyectoclinica/clinica/modules/recursos/models/Servicio.java` (Mostrar la anotación `@Builder` de Lombok).
*   **Backend:** `clinica/src/main/java/com/proyectoclinica/clinica/controller/AdminController.java` (Mostrar cómo se usa el builder al crear un nuevo servicio).

**3. Para la Suspensión Dinámica de Cuentas (Spring Security):**
*   **Backend (Lógica de Bloqueo):** `clinica/src/main/java/com/proyectoclinica/clinica/security/UserDetailsImpl.java` (Mostrar el método `isEnabled()`).
*   **Backend (Controlador):** `clinica/src/main/java/com/proyectoclinica/clinica/controller/AdminController.java` (Buscar `@PostMapping("/usuarios/toggle-estado")`).
