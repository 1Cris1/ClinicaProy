# 🎯 Requerimientos Definitivos para la Exposición Final
*(Lista oficial y ejecutada en código para la sustentación del proyecto Clínica)*

Este documento centraliza los 12 puntos exactos (3 por integrante) que han sido programados, etiquetados con la palabra `EXPOSICIÓN` en el código fuente, y validados en el sistema.

---

### 👨‍💻 INTEGRANTE 1: Rhomel (Portal del Paciente y Seguridad)
*Enfoque: Protección de datos y empoderamiento del paciente.*

1. **Autoregistro Seguro de Pacientes**
   * **Demostración:** Un paciente nuevo se registra desde la web validando su DNI.
   * **Respaldo Técnico:** Explicará cómo se capturan los datos del formulario (`@ModelAttribute`) y se instancian las entidades `Usuario` y `Paciente` en cascada.
2. **Seguridad y Encriptación de Contraseñas**
   * **Demostración:** Mostrará en la base de datos que las claves no son legibles.
   * **Respaldo Técnico:** Sustentará el uso del Bean `BCryptPasswordEncoder` de Spring Security para aplicar el hash seguro a las contraseñas antes de hacer el `save()`.
3. **Historial de Citas Propias**
   * **Demostración:** El paciente ingresa y ve solo sus propias citas.
   * **Respaldo Técnico:** Explicará cómo Spring Security captura la sesión (`Principal`), y cómo JPA usa el ID del usuario logueado para filtrar la información con `findByPacienteId`.

---

### 👨‍💼 INTEGRANTE 2: Cristian (Panel Administrativo y Control)
*Enfoque: Gestión de negocio y métricas.*

1. **Dashboard de Métricas (Inyección de Consultas)**
   * **Demostración:** El administrador ve contadores en vivo de pacientes, médicos y recaudación.
   * **Respaldo Técnico:** Cristian explicará cómo usa métodos de agregación en Spring Data JPA (como `count()` o `@Query` con `SUM`) para enviar métricas calculadas al `Model` de Thymeleaf.
2. **Gestión del Tarifario (Servicios Médicos)**
   * **Demostración:** Registro y edición de los servicios que ofrece la clínica.
   * **Respaldo Técnico:** Sustentará el uso del patrón de diseño `@Builder` de Lombok para crear objetos `Servicio` de manera limpia y profesional en el controlador.
3. **Suspensión Dinámica de Cuentas (Spring Security)**
   * **Demostración:** El administrador "apaga" (suspende) la cuenta de un usuario con un botón.
   * **Respaldo Técnico:** Explicará cómo conectó el campo `estado` de la base de datos con el método `isEnabled()` de la interfaz `UserDetails` de Spring Security para bloquear el acceso en tiempo real.

---

### 👨‍💻 INTEGRANTE 3: Miguel (Operaciones de Recepción)
*Enfoque: Rendimiento de Base de Datos y Flujo Asíncrono.*

1. **Optimización de Consultas (Problema N+1)**
   * **Demostración:** La carga ultra-rápida de la lista de pacientes de hoy en ventanilla.
   * **Respaldo Técnico:** Miguel explicará cómo resolvió la saturación de base de datos usando la anotación `@EntityGraph` para forzar a Hibernate a traer Pacientes y Médicos en un solo `JOIN FETCH`.
2. **Reagendamiento de Citas y Validación de Horarios**
   * **Demostración:** Mover la cita de un paciente a otra hora, demostrando que no se puede si el horario ya está ocupado.
   * **Respaldo Técnico:** Explicará el uso de transacciones y validaciones en base de datos (`existsByMedico...`) para evitar cruces en las agendas de los doctores.
3. **Carga Asíncrona de Historial Clínico (AJAX + JSON)**
   * **Demostración:** Al darle clic a "Historial" en el Dashboard, se abre un modal con los datos sin recargar la página.
   * **Respaldo Técnico:** Sustentará la creación de una API REST con la anotación `@ResponseBody` y cómo JavaScript (`fetch()`) consume ese arreglo JSON dinámicamente.

---

### 👨‍⚕️ INTEGRANTE 4: Jhoan (Atención Clínica y Mapeo Relacional)
*Enfoque: Gestión de consultas y relaciones complejas.*

1. **Gestión de Turnos y Horarios Médicos (Requerimiento de Jurado)**
   * **Demostración:** El médico ingresa a su perfil y actualiza o cancela sus horarios de atención.
   * **Respaldo Técnico:** Explicará el `@PostMapping` que recupera al médico en sesión y ejecuta un `UPDATE` (vía `save()`) sobre los campos `horarioLv` y `horarioSabado`.
2. **Filtro Predictivo en Sala de Espera**
   * **Demostración:** El dashboard del médico muestra solo los pacientes que ya confirmaron su llegada hoy.
   * **Respaldo Técnico:** Defenderá cómo JPA abstrae lógicas complejas usando firmas inteligentes como `findByMedicoIdAndFechaCitaOrderByHoraCitaAsc`.
3. **Mapeo de Recetas y Fármacos (Muchos a Muchos)**
   * **Demostración:** Guardado del listado de medicamentos recetados en una consulta.
   * **Respaldo Técnico:** Jhoan se lucirá explicando cómo las tablas `Receta` y `Medicamento` se conectan mediante la tabla intermedia `RecetaDetalle` usando las anotaciones `@OneToMany` y `@ManyToOne`.
