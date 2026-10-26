# 🚀 Requerimientos Finales para Próxima Exposición AV3 (Mapeo de Rutas)

Este documento centraliza los 12 requerimientos oficiales del proyecto. A diferencia de las notas anteriores, aquí se especifica **exactamente la ruta de los archivos Backend y Frontend** para que puedan mostrarle el código en vivo al profesor sin perder tiempo buscando.

---

## 👨‍💻 INTEGRANTE 1: Rhomel (Paciente y Seguridad)

### 1. Visualización de Resultados y Recetas

- **Frontend:** clinica/src/main/resources/templates/paciente/resultados.html y
  ecetas.html (o vistas correspondientes).
- **Backend:** clinica/src/main/java/com/proyectoclinica/clinica/controller/PacienteController.java (Explicar las consultas en JPA para cruzar la tabla Paciente con Receta o Consulta, y cómo se pasa esa lista dinámica a Thymeleaf).

### 2. Configuración de Perfil de Usuario

- **Frontend:** clinica/src/main/resources/templates/paciente/perfil.html
- **Backend:** clinica/src/main/java/com/proyectoclinica/clinica/controller/PacienteController.java (Explicar el UPDATE en la base de datos protegiendo campos inmutables como el DNI y volviendo a encriptar la clave si fue modificada).

### 3. Catálogo de Farmacia/Medicamentos

- **Frontend:** clinica/src/main/resources/templates/paciente/farmacia.html (Buscador y catálogo interactivo).
- **Backend:** clinica/src/main/java/com/proyectoclinica/clinica/controller/PacienteController.java y ProductoRepository.java (Explicar el uso de buscadores predictivos o la lógica de listado de productos de la BD).

---

## 👨‍💼 INTEGRANTE 2: Cristian (Administrador)

### 1. Gestión de Productos del Catálogo de Farmacia

- **Frontend:** [productos.html](file:///c:/Users/RYZEN/Desktop/ClinicaProy/clinica/src/main/resources/templates/admin/productos.html) (CRUD completo con formulario modal para registrar y editar medicamentos, integrando la carga directa de archivos desde la computadora sin utilizar URLs externas).
- **Backend:** [AdminController.java](file:///c:/Users/RYZEN/Desktop/ClinicaProy/clinica/src/main/java/com/proyectoclinica/clinica/controller/AdminController.java) (Buscar los métodos `@GetMapping("/productos")` de listado, `@PostMapping("/productos/nuevo")` para registro, `@PostMapping("/productos/editar")` para edición, y `@GetMapping("/productos/eliminar")` para remoción mediante el uso de `ProductoRepository`).

### 2. Suspensión Dinámica de Cuentas (Spring Security)

- **Frontend:** clinica/src/main/resources/templates/admin/usuarios.html (Botón del candado y estado visual).
- **Backend (Controlador):** clinica/src/main/java/com/proyectoclinica/clinica/controller/AdminController.java (Buscar @PostMapping("/usuarios/toggle-estado")).
- **Backend (Core Seguridad):** clinica/src/main/java/com/proyectoclinica/clinica/security/UserDetailsImpl.java (Mostrar el método isEnabled() que bloquea accesos).

### 3. Gestión del Servicios 

- **Frontend:** clinica/src/main/resources/templates/admin/especialidades.html (o la vista correspondiente de servicios).
- **Backend (Controlador):** clinica/src/main/java/com/proyectoclinica/clinica/controller/AdminController.java (Buscar los métodos del CRUD de servicios).
- **Backend (Patrón de Diseño):** clinica/src/main/java/com/proyectoclinica/clinica/modules/recursos/models/Servicio.java (Mostrar el uso de la anotación @Builder de Lombok para crear servicios).

---

## 🗂️ INTEGRANTE 3: Miguel (Recepcionista)
Triaje
- **Frontend:**
  - Formulario de Registro: [triaje.html](file:///c:/Users/RYZEN/Desktop/ClinicaProy/clinica/src/main/resources/templates/recepcionista/triaje.html) (Formulario dinámico con validaciones de rangos saludables para registrar peso, talla, temperatura y presión arterial).
  - Barra Lateral y Estilos: [layout-recepcionista.html](file:///c:/Users/RYZEN/Desktop/ClinicaProy/clinica/src/main/resources/templates/layout-recepcionista.html) y [main.js](file:///c:/Users/RYZEN/Desktop/ClinicaProy/clinica/src/main/resources/static/js/main.js) (Gestión de la navegación y la clase `.active` de la barra lateral).
- **Backend:** [RecepcionistaController.java](file:///c:/Users/RYZEN/Desktop/ClinicaProy/clinica/src/main/java/com/proyectoclinica/clinica/controller/RecepcionistaController.java) (Buscar `@GetMapping("/triaje")` para la carga de citas pendientes y `@PostMapping("/triaje/guardar")` donde se valida e inserta la entidad `Triaje` en la base de datos).

### 2. Reagendamiento de Citas (Validación de Turnos)

- **Frontend:** clinica/src/main/resources/templates/recepcionista/citas.html (Modal de Reagendamiento).
- **Backend:** clinica/src/main/java/com/proyectoclinica/clinica/controller/RecepcionistaController.java
  - _Qué mostrar:_ Buscar el método @PostMapping("/citas/reagendar") y la lógica que impide cruces de horarios.

### 3.  Historial Clínico (AJAX / Fetch)

- **Frontend:** clinica/src/main/resources/templates/recepcionista/dashboard.html (Mostrar la función JavaScript  erHistorial() que consume la API).
- **Backend:** clinica/src/main/java/com/proyectoclinica/clinica/controller/RecepcionistaController.java
  - _Qué mostrar:_ Buscar el método @GetMapping("/pacientes/{id}/historial") que usa la anotación @ResponseBody para devolver JSON crudo en lugar de una página HTML.

---

## 🩺 INTEGRANTE 4: Jhoan (Médico)

### 1. Gestión de Turnos y Horarios Médicos

- **Frontend:** clinica/src/main/resources/templates/doctores/perfil.html (Formulario interactivo de horarios).
- **Backend:** clinica/src/main/java/com/proyectoclinica/clinica/controller/MedicoController.java
  - _Qué mostrar:_ Buscar el método @PostMapping("/horario/actualizar") que extrae al médico en sesión y aplica un UPDATE (save()) a sus campos de horarios.

### 2. Historial de Recetas Emitidas

- **Frontend:** clinica/src/main/resources/templates/doctores/recetas.html (Vista histórica de las recetas prescritas por el doctor).
- **Backend:** clinica/src/main/java/com/proyectoclinica/clinica/controller/MedicoController.java (Buscar `@GetMapping("/recetas")` donde se consultan recetas emitidas por el médico autenticado usando `recetaRepository`).

### 3. Mapeo de Recetas y Fármacos (Relación Muchos a Muchos)

- **Frontend:** clinica/src/main/resources/templates/doctores/consulta.html (Interfaz de selección múltiple de medicamentos para la receta).
- **Backend (Entidades):** clinica/src/main/java/com/proyectoclinica/clinica/modules/consultas/models/Receta.java y MedicamentoPrescrito.java (Mostrar cómo se conectan usando @OneToMany y cascade = CascadeType.ALL).
- **Backend (Controlador):** clinica/src/main/java/com/proyectoclinica/clinica/controller/MedicoController.java (Buscar @PostMapping("/atencion/finalizar") donde se guarda todo en cascada).
