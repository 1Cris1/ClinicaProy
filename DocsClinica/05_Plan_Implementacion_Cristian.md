---
tags:
  - exposicion
  - cristian
  - admin
  - seguridad
  - implementacion
relacionado_con:
  - "[[01_Propuesta_Segunda_Exposicion]]"
  - "[[02_Requerimientos_Proxima_Exposicion]]"
---

# Plan de Implementación: Requerimientos de Cristian (Administrador)

## Objetivo 🎯
Blindar y completar el módulo administrativo asignado a Cristian, dotándolo de capacidades analíticas en tiempo real (JPA / Power BI) y un control profundo sobre la seguridad y mantenimiento de la infraestructura de la clínica.

> [!NOTE] Relación de Requerimientos
> Este plan reemplaza la HU 10 (ya expuesta) y oficializa las 3 Historias de Usuario inéditas para Cristian:
> - **HU 15:** Panel de Control y Métricas en Tiempo Real (JPA) + Power BI.
> - **HU X:** Gestión de Servicios Médicos / Tarifario (CRUD).
> - **HU 16 (Nueva):** Seguridad: Bloqueo y Suspensión de Cuentas (Spring Security).

---

## 🛠️ Modificaciones Arquitectónicas

### 1. Métricas del Dashboard (JPA)
- **Problema Actual:** La vista del administrador (`admin/dashboard.html`) tiene tarjetas para métricas, pero Java no le está enviando los datos, dejándolos en 0.
- **Solución:** En `AdminController.java`, dentro de `@GetMapping("/dashboard")`, inyectaremos consultas derivadas de `Spring Data JPA` como `pacienteRepository.count()` y `citaRepository.countByFechaCita(LocalDate.now())`.
- **Exposición:** Se agregará el marcador `// EXPOSICIÓN CRISTIAN:` para demostrar cómo JPA abstrae la necesidad de escribir sentencias SQL manuales complejas (`SELECT COUNT`).

### 2. Gestión de Servicios (Tarifario Médico)
- **Flujo:** Las rutas `/servicios/nuevo`, `/servicios/editar`, `/servicios/eliminar` en `AdminController.java`.
- **Acción:** Se inyectará el guion técnico sobre estos métodos para que Cristian pueda explicar la creación de servicios relacionando entidades y usando el patrón `@Builder`.

### 3. Suspensión de Cuentas (Spring Security) 🚫
- **Backend Core:** Se modificará el archivo `UserDetailsImpl.java` (el núcleo de autenticación). El método `isEnabled()` se actualizará para evaluar `usuario.getEstado() == 1`. Si un administrador cambia esto a `0`, la capa de seguridad de Spring denegará el acceso automáticamente, lanzando un error en el login.
- **Controlador:** Se creará un nuevo endpoint `@GetMapping("/usuarios/toggle-estado")` en `AdminController.java`.
- **Frontend:** En la tabla de usuarios (`admin/usuarios.html`), se agregará un botón visual (Activar/Suspender) que consumirá el endpoint anterior.

---
## 🔄 Estado de la Implementación
🟡 **En Planificación.** Esperando confirmación para iniciar el desarrollo y modificación de la base de código.
