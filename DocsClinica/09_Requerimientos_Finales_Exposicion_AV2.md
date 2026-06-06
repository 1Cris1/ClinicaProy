# 🚀 Requerimientos Finales para Próxima Exposición AV2 (Mapeo de Rutas)

Este documento centraliza los 12 requerimientos oficiales del proyecto. A diferencia de las notas anteriores, aquí se especifica **exactamente la ruta de los archivos Backend y Frontend** para que puedan mostrarle el código en vivo al profesor sin perder tiempo buscando.

---

## 👨‍💻 INTEGRANTE 1: Rhomel (Paciente y Seguridad)

### 1. Autoregistro Seguro de Pacientes
*   **Frontend:** `clinica/src/main/resources/templates/public/registro.html` (Formulario de registro validado).
*   **Backend:** `clinica/src/main/java/com/proyectoclinica/clinica/controller/PublicoController.java` (Buscar el método `@PostMapping("/registro")` que instancia el paciente y usuario en cascada).

### 2. Seguridad y Encriptación de Contraseñas
*   **Backend (Configuración):** `clinica/src/main/java/com/proyectoclinica/clinica/config/SecurityConfig.java` (Mostrar el Bean `passwordEncoder()`).
*   **Backend (Ejecución):** `clinica/src/main/java/com/proyectoclinica/clinica/controller/PublicoController.java` (Mostrar la línea `passwordEncoder.encode(dto.getPassword())`).

### 3. Historial de Citas Propias (Filtro por Sesión)
*   **Frontend:** `clinica/src/main/resources/templates/paciente/citas.html` (La tabla que carga las citas usando Thymeleaf `th:each`).
*   **Backend (Controlador):** `clinica/src/main/java/com/proyectoclinica/clinica/controller/PacienteController.java` (Buscar el método `@GetMapping("/citas")` que recupera el `Principal` del usuario logueado).
*   **Backend (JPA):** `clinica/src/main/java/com/proyectoclinica/clinica/modules/citas/repository/CitaRepository.java` (Buscar el método `findByPacienteId...`).

---

## 👨‍💼 INTEGRANTE 2: Cristian (Administrador)

### 1. Dashboard de Métricas y Power BI
*   **Frontend:** `clinica/src/main/resources/templates/admin/dashboard.html` (Donde se inyectan las métricas y el Iframe de Power BI).
*   **Backend:** `clinica/src/main/java/com/proyectoclinica/clinica/controller/AdminController.java` (Buscar el `@GetMapping("/inicio")` donde se ejecutan los `count()` de JPA y se envían al `model`).

### 2. Suspensión Dinámica de Cuentas (Spring Security)
*   **Frontend:** `clinica/src/main/resources/templates/admin/usuarios.html` (Botón del candado y estado visual).
*   **Backend (Controlador):** `clinica/src/main/java/com/proyectoclinica/clinica/controller/AdminController.java` (Buscar `@PostMapping("/usuarios/toggle-estado")`).
*   **Backend (Core Seguridad):** `clinica/src/main/java/com/proyectoclinica/clinica/security/UserDetailsImpl.java` (Mostrar el método `isEnabled()` que bloquea accesos).

### 3. Gestión del Tarifario (Servicios Médicos)
*   **Frontend:** `clinica/src/main/resources/templates/admin/especialidades.html` (o la vista correspondiente de servicios).
*   **Backend (Controlador):** `clinica/src/main/java/com/proyectoclinica/clinica/controller/AdminController.java` (Buscar los métodos del CRUD de servicios).
*   **Backend (Patrón de Diseño):** `clinica/src/main/java/com/proyectoclinica/clinica/modules/recursos/models/Servicio.java` (Mostrar el uso de la anotación `@Builder` de Lombok para crear servicios).

---

## 🗂️ INTEGRANTE 3: Miguel (Recepcionista)

### 1. Optimización de Consultas (Problema N+1)
*   **Backend (La Solución):** `clinica/src/main/java/com/proyectoclinica/clinica/modules/citas/repository/CitaRepository.java` 
    *   *Qué mostrar:* Buscar el método `findByFechaCitaOrderByHoraCitaAsc` y mostrar la anotación `@EntityGraph(attributePaths = {"paciente", "medico"})`.

### 2. Reagendamiento de Citas (Validación de Turnos)
*   **Frontend:** `clinica/src/main/resources/templates/recepcionista/citas.html` (Modal de Reagendamiento).
*   **Backend:** `clinica/src/main/java/com/proyectoclinica/clinica/controller/RecepcionistaController.java` 
    *   *Qué mostrar:* Buscar el método `@PostMapping("/citas/reagendar")` y la lógica que impide cruces de horarios.

### 3. Carga Asíncrona de Historial Clínico (AJAX / Fetch)
*   **Frontend:** `clinica/src/main/resources/templates/recepcionista/dashboard.html` (Mostrar la función JavaScript `verHistorial()` que consume la API).
*   **Backend:** `clinica/src/main/java/com/proyectoclinica/clinica/controller/RecepcionistaController.java`
    *   *Qué mostrar:* Buscar el método `@GetMapping("/pacientes/{id}/historial")` que usa la anotación `@ResponseBody` para devolver JSON crudo en lugar de una página HTML.

---

## 🩺 INTEGRANTE 4: Jhoan (Médico)

### 1. Gestión de Turnos y Horarios Médicos
*   **Frontend:** `clinica/src/main/resources/templates/doctores/perfil.html` (Formulario interactivo de horarios).
*   **Backend:** `clinica/src/main/java/com/proyectoclinica/clinica/controller/MedicoController.java` 
    *   *Qué mostrar:* Buscar el método `@PostMapping("/horario/actualizar")` que extrae al médico en sesión y aplica un UPDATE (`save()`) a sus campos de horarios.

### 2. Filtro Predictivo en Sala de Espera
*   **Frontend:** `clinica/src/main/resources/templates/doctores/dashboard.html` (La tabla de atenciones del día).
*   **Backend:** `clinica/src/main/java/com/proyectoclinica/clinica/controller/MedicoController.java` (Buscar `@GetMapping("/inicio")` y la inyección de `citasHoy`).
*   **Backend (JPA):** `clinica/src/main/java/com/proyectoclinica/clinica/modules/citas/repository/CitaRepository.java` (Mostrar el método `findByMedicoIdAndFechaCitaOrderByHoraCitaAsc`).

### 3. Mapeo de Recetas y Fármacos (Relación Muchos a Muchos)
*   **Frontend:** `clinica/src/main/resources/templates/doctores/atencion.html` (Interfaz de selección múltiple de medicamentos para la receta).
*   **Backend (Entidades):** `clinica/src/main/java/com/proyectoclinica/clinica/modules/consultas/models/Receta.java` y `MedicamentoPrescrito.java` (Mostrar cómo se conectan usando `@OneToMany` y `cascade = CascadeType.ALL`).
*   **Backend (Controlador):** `clinica/src/main/java/com/proyectoclinica/clinica/controller/MedicoController.java` (Buscar `@PostMapping("/atencion/finalizar")` donde se guarda todo en cascada).
