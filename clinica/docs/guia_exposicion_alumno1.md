# 🎓 GUÍA DE EXPOSICIÓN - ALUMNO 1: RECEPCIÓN Y CITAS
Este documento ha sido estructurado siguiendo estrictamente las instrucciones de la pizarra del profesor para la sustentación del código fuente del proyecto **ClinicX**.

---

## 📋 Resumen del Reparto del Expositor
* **Rol en la Aplicación:** Recepcionista.
* **Historias de Usuario a cargo (2):**
  1. **HU 1: Agendamiento de Citas** (Registrar nueva cita).
  2. **HU 2: Confirmación de Llegada (Check-in)** (Registrar llegada física del paciente).
* **Estructura Requerida por la Pizarra:**
  * **Historias de Usuario (Requerimientos):** Qué es y por qué existe.
  * **Funcionalidad (Datos y Detalles):** Cómo funciona la lógica y flujos de datos.
  * **Front End (HTML/Thymeleaf):** Código de la interfaz y su comunicación.
  * **Back End (API):** Controlador, lógica en Java y endpoints REST/MVC.
  * **Base de Datos:** Entidades JPA, tablas, llaves primarias/foráneas y relaciones.

---

## 1. 📅 HISTORIA DE USUARIO 1: Agendamiento de Citas (Nueva Cita)

### A. Requerimiento (¿Por qué existe?)
> *"Como recepcionista, quiero registrar una nueva cita médica para un paciente con un especialista determinado en una fecha y hora específicas, a fin de organizar la atención diaria de la clínica y asegurar un cupo de atención."*

### B. Funcionalidad (Lógica de Negocio, Flujo de Datos y Detalle)
1. **Captura de Datos:** El sistema recibe el identificador del paciente (`pacienteId`), el médico especialista (`medicoId`), la fecha (`fecha`), la hora (`hora`), el servicio opcional (`servicioId`), y observaciones adicionales (`observaciones`).
2. **Validaciones en Base de Datos:** 
   * Se recupera la entidad completa del paciente y del médico usando sus respectivos repositorios.
   * Si no se especifica un servicio, se le asigna por defecto el Servicio de Consulta General (ID 1) para evitar que la base de datos quede vacía o lance errores de integridad (`null`).
3. **Instanciación y Creación:** Se construye la entidad `Cita` utilizando el patrón **Builder** de Lombok, asignando automáticamente el estado inicial de la cita como `"Pendiente"` y la marca de tiempo de registro (`fechaRegistro`).
4. **Integración Externa (Sincronización):** Tras persistir la cita, el backend intenta sincronizar el evento en Google Calendar del médico mediante `googleCalendarService.crearEventoCita(nuevaCita)`.
   > 💡 **Detalle técnico clave (try-catch):** Esta llamada de integración está envuelta en un bloque `try-catch` aislado. Si la API de Google falla (por ejemplo, por corte de internet), el sistema atrapa el error (`log.warn`) y **continúa con el registro**, impidiendo que la aplicación web se caiga o falle para el usuario.
5. **Feedback Dinámico:** Redirecciona a la agenda con el parámetro `?success=agendado` que dispara una alerta visual de éxito en la interfaz.

---

### C. Código Fuente: Front End (HTML / Thymeleaf)
* **Archivo:** [citas.html](file:///c:/Users/RYZEN/Desktop/ClinicaProy/clinica/src/main/resources/templates/recepcionista/citas.html)
* **Fragmento Clave (Modal de Nueva Cita, Líneas 153-200):**

```html
<!-- Modal Nueva Cita -->
<div class="modal fade" id="modalNuevaCita" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold">Registrar Nueva Cita</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <!-- FORMULARIO CON ENDPOINT DE DESTINO POST -->
                <form th:action="@{/recepcionista/citas/nuevo}" method="post">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Paciente</label>
                            <select name="pacienteId" class="form-select" required>
                                <option value="">Seleccionar paciente...</option>
                                <!-- ITERACIÓN DINÁMICA DE PACIENTES -->
                                <option th:each="p : ${pacientes}" 
                                        th:value="${p.id}" 
                                        th:text="${p.nombres + ' ' + p.apellidos + ' - DNI: ' + p.dni}"></option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Médico</label>
                            <select name="medicoId" class="form-select" required>
                                <option value="">Seleccionar médico...</option>
                                <!-- ITERACIÓN DINÁMICA DE MÉDICOS -->
                                <option th:each="m : ${medicos}" 
                                        th:value="${m.id}" 
                                        th:text="${'Dr. ' + m.nombres + ' ' + m.apellidos}"></option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Fecha</label>
                            <input name="fecha" type="date" class="form-control" required th:value="${fechaSeleccionada}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Hora</label>
                            <input name="hora" type="time" class="form-control" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Servicio</label>
                            <select name="servicioId" class="form-select">
                                <option value="">Seleccionar servicio...</option>
                                <option th:each="s : ${servicios}" th:value="${s.id}" th:text="${s.nombre}"></option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label small fw-bold">Observaciones</label>
                            <textarea name="observaciones" class="form-control" rows="2" placeholder="Observaciones adicionales"></textarea>
                        </div>
                    </div>
            </div>
            <div class="modal-footer border-0 pt-0">
                <button class="btn btn-outline-secondary rounded-pill px-3 btn-sm" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn rounded-pill px-4 fw-bold btn-sm" style="background:#8B5CF6;color:#fff;">Registrar Cita</button>
            </div>
                </form>
        </div>
    </div>
</div>
```

#### 📌 Explicación para Exponer del Front End:
* **`th:action="@{/recepcionista/citas/nuevo}"`:** Es una anotación de Thymeleaf que genera dinámicamente la URL absoluta para el procesamiento del formulario en el servidor. Utiliza el método **POST** por seguridad y para enviar datos complejos.
* **`th:each="p : ${pacientes}"`:** Actúa como un bucle *foreach*. Itera sobre la lista de pacientes (`List<Paciente>`) enviada por el controlador y dibuja una etiqueta `<option>` para cada registro de forma dinámica.
* **`th:value="${p.id}"`:** Inyecta dinámicamente el identificador primario del registro de la base de datos en el atributo `value`, asegurando que al enviar el formulario se envíe la clave única del registro.

---

### D. Código Fuente: Back End (API en Spring Boot)
* **Archivo:** [RecepcionistaController.java](file:///c:/Users/RYZEN/Desktop/ClinicaProy/clinica/src/main/java/com/proyectoclinica/clinica/controller/RecepcionistaController.java)
* **Fragmento Clave (Método `nuevaCita`, Líneas 121-158):**

```java
@PostMapping("/citas/nuevo")
public String nuevaCita(@RequestParam Integer pacienteId,
                      @RequestParam Integer medicoId,
                      @RequestParam String fecha,
                      @RequestParam String hora,
                      @RequestParam(required = false) Integer servicioId,
                      @RequestParam(required = false) String observaciones) {
    try {
        // 1. Recuperación de las entidades referenciadas
        Paciente paciente = pacienteRepository.findById(pacienteId).orElse(null);
        Medico medico = medicoRepository.findById(medicoId).orElse(null);
        Servicio servicio = (servicioId != null) 
                ? servicioRepository.findById(servicioId).orElse(servicioRepository.findById(1).orElse(null))
                : servicioRepository.findById(1).orElse(null);

        // 2. Validación de existencia
        if (paciente != null && medico != null && servicio != null) {
            // 3. Construcción del objeto utilizando Lombok Builder
            Cita nuevaCita = Cita.builder()
                    .paciente(paciente)
                    .medico(medico)
                    .servicio(servicio)
                    .fechaCita(LocalDate.parse(fecha))
                    .horaCita(hora)
                    .estado("Pendiente")
                    .motivo(observaciones)
                    .fechaRegistro(LocalDateTime.now())
                    .build();
            
            // 4. Guardar en Base de Datos usando JPA
            citaRepository.save(nuevaCita);
            
            // 5. Integración con API externa (Google Calendar)
            try {
                googleCalendarService.crearEventoCita(nuevaCita);
            } catch (Exception e) {
                log.warn("Error sync calendar: {}", e.getMessage());
            }
            
            return "redirect:/recepcionista/citas?fecha=" + fecha + "&success=agendado";
        }
    } catch (Exception e) {
        log.error("Error agendando cita", e);
    }
    return "redirect:/recepcionista/citas?error=internal_error";
}
```

#### 📌 Explicación para Exponer del Back End:
* **`@PostMapping` / `@RequestParam`:** Son etiquetas (Anotaciones) de Spring. `@PostMapping` asocia el método a peticiones HTTP de tipo POST, mientras que `@RequestParam` captura directamente los parámetros que viajan dentro del cuerpo del formulario HTML y los inyecta en variables Java.
* **`pacienteRepository.findById(...).orElse(null)`:** Es una consulta segura implementada en Spring Data JPA. Si el ID no existe en la base de datos, en lugar de lanzar una excepción que congele el servidor, devuelve `null` de forma segura.
* **`citaRepository.save(nuevaCita)`:** Ejecuta una sentencia `INSERT INTO` en segundo plano mapeando el objeto de forma automática hacia la base de datos relacional.

---

## 2. 🚶 HISTORIA DE USUARIO 2: Confirmación de Llegada (Check-in)

### A. Requerimiento (¿Por qué existe?)
> *"Como recepcionista, quiero registrar la llegada física de un paciente a las instalaciones de la clínica (Check-in), para actualizar el estado de su cita programada de 'Pendiente' a 'Confirmada' y que el médico sepa automáticamente en su panel que el paciente ya está esperando en sala."*

### B. Funcionalidad (Lógica de Negocio y Flujo de Datos)
1. **Detección del Paciente:** En el panel de recepción ("Control de Llegadas"), el sistema lista las citas programadas para el día de hoy.
2. **Acción de Check-in:** Al hacer clic en el botón "Check-in", se envía el identificador único `idCita` al backend.
3. **Cambio de Estado:** El servidor carga la cita correspondiente y altera el campo `estado` de la cita a `"Confirmada"`.
4. **Impacto en el Flujo de la Clínica:** 
   * En la recepción, el contador estadístico de `"Sala de Espera"` aumenta en 1.
   * El paciente aparece automáticamente listado en la pantalla de la sala de espera y en el **Monitor del Médico** en tiempo real como paciente listo para ser llamado a consulta.

---

### C. Código Fuente: Front End (HTML / Thymeleaf)
* **Archivo:** [dashboard.html](file:///c:/Users/RYZEN/Desktop/ClinicaProy/clinica/src/main/resources/templates/recepcionista/dashboard.html)
* **Fragmento Clave (Líneas 109-117):**

```html
<td class="pe-4 text-center">
    <!-- CONDICIONAL: SOLO MUESTRA EL BOTÓN SI EL ESTADO ES 'PENDIENTE' -->
    <form th:if="${cita.estado == 'Pendiente'}" 
          th:action="@{/recepcionista/citas/checkin}" 
          method="post" 
          class="d-inline">
        <!-- IDENTIFICADOR OCULTO DE LA CITA -->
        <input type="hidden" name="idCita" th:value="${cita.idCita}">
        <button type="submit" class="btn btn-primary btn-sm rounded-pill px-3 fw-bold shadow-sm" style="font-size: 0.7rem;">
            Check-in <i class="bi bi-arrow-right-short"></i>
        </button>
    </form>
    <!-- SI YA HIZO CHECK-IN, MUESTRA EL ESTADO PROCESADO -->
    <span th:if="${cita.estado != 'Pendiente'}" class="text-success fw-bold small">
        <i class="bi bi-check-all"></i> Procesado
    </span>
</td>
```

#### 📌 Explicación para Exponer del Front End:
* **`th:if="${cita.estado == 'Pendiente'}"`:** Condicional de Thymeleaf que evalúa el estado del registro. Si la cita ya está confirmada o completada, el botón de "Check-in" desaparece por completo del DOM y en su lugar se renderiza el texto "Procesado", impidiendo así un doble registro o errores en el flujo de caja/sala de espera.
* **`<input type="hidden" name="idCita" th:value="${cita.idCita}">`:** Es un input invisible para el usuario final. Almacena la llave primaria de la cita y la envía de forma transparente al backend cuando se envía el formulario.

---

### D. Código Fuente: Back End (API en Spring Boot)
* **Archivo:** [RecepcionistaController.java](file:///c:/Users/RYZEN/Desktop/ClinicaProy/clinica/src/main/java/com/proyectoclinica/clinica/controller/RecepcionistaController.java)
* **Fragmento Clave (Método `checkIn`, Líneas 92-100):**

```java
@PostMapping("/citas/checkin")
public String checkIn(@RequestParam Integer idCita) {
    // 1. Busca la cita en la BD de forma segura
    Cita cita = citaRepository.findById(idCita).orElse(null);
    
    // 2. Valida la existencia y que el estado sea el inicial "Pendiente"
    if (cita != null && "Pendiente".equals(cita.getEstado())) {
        // 3. Cambia el estado a "Confirmada" (sala de espera)
        cita.setEstado("Confirmada");
        
        // 4. Guarda el cambio en la BD (ejecuta un UPDATE)
        citaRepository.save(cita);
    }
    
    // 5. Redirecciona al inicio del panel de recepción
    return "redirect:/recepcionista/inicio";
}
```

#### 📌 Explicación para Exponer del Back End:
* **`cita.setEstado("Confirmada")`:** Actualiza el estado en memoria de la entidad Java.
* **`citaRepository.save(cita)`:** Spring Data JPA es inteligente: al detectar que la entidad `Cita` ya cuenta con una clave primaria asignada (`idCita`), en lugar de ejecutar una instrucción `INSERT`, realiza automáticamente una consulta SQL **`UPDATE`** afectando únicamente los campos modificados.

---

## 3. 🗄️ BASE DE DATOS (Estructura de Entidad y Relaciones)

El mapeo de base de datos se maneja mediante **Hibernate (JPA)**, el cual genera automáticamente la estructura en la base de datos relacional (MySQL/PostgreSQL).

* **Archivo:** [Cita.java](file:///c:/Users/RYZEN/Desktop/ClinicaProy/clinica/src/main/java/com/proyectoclinica/clinica/modules/citas/models/Cita.java)
* **Fragmento Mapeo Relacional (JPA):**

```java
@Entity
@Table(name = "citas")
public class Cita {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_cita")
    private Integer idCita;  // Llave Primaria (Auto-incremental)

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_paciente", nullable = false)
    private Paciente paciente; // Llave Foránea hacia la tabla 'pacientes'

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_medico", nullable = false)
    private Medico medico;     // Llave Foránea hacia la tabla 'medicos'

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_servicio", nullable = false)
    private Servicio servicio; // Llave Foránea hacia la tabla 'servicios'

    @Column(name = "fecha_cita", nullable = false)
    private LocalDate fechaCita;

    @Column(name = "hora_cita", nullable = false)
    private String horaCita; 

    @Column(name = "estado", length = 50)
    private String estado = "Pendiente"; // Atributo clave del flujo
}
```

### 📌 Explicación para Exponer de la Base de Datos:
1. **Mapeo de Tablas (`@Table(name = "citas")`):** Esta clase representa una tabla física en la base de datos llamada `citas`. Cada instancia de la clase es un registro (fila) de esa tabla.
2. **Llave Primaria (`@Id`):** `idCita` es la llave primaria (**Primary Key**), mapeada como autoincremental en SQL (`GenerationType.IDENTITY`).
3. **Llave Foránea y Relación Muchos-a-Uno (`@ManyToOne` / `@JoinColumn`):** 
   * **Muchos-a-Uno (`@ManyToOne`):** Indica que *muchas* citas pueden pertenecer al *mismo* paciente o al *mismo* médico.
   * **`@JoinColumn(name = "id_paciente")`:** Define físicamente la columna de clave foránea (**Foreign Key**) en la tabla de citas, la cual apunta y enlaza directamente con la clave primaria de la tabla `pacientes`.
4. **Estrategia de Carga (`FetchType.EAGER` vs `FetchType.LAZY`):**
   * **`EAGER` (Paciente/Médico):** Carga los datos del paciente y el médico inmediatamente cuando se consulta la cita. Esto es vital para renderizar la lista rápida de citas de hoy en recepción sin hacer múltiples consultas adicionales.
   * **`LAZY` (Servicio):** Carga perezosa. Solo trae los datos del servicio si el código de Java lo solicita explícitamente (`cita.getServicio()`), ahorrando ancho de banda y mejorando el rendimiento de la aplicación.

---

## 💡 Defensa ante Preguntas del Profesor (Mata-Preguntas)

* **¿Por qué la arquitectura por Módulos (Monolito Modular)?**
  * *Respuesta:* "Separamos el código en carpetas independientes (`citas`, `pacientes`, `facturacion`) para mantener una **alta cohesión** (el código relacionado está junto) y un **bajo acoplamiento** (los módulos apenas dependen entre sí). Esto nos da los beneficios de orden de los microservicios sin la complejidad ni la lentitud de red de tener múltiples servidores."
* **¿Qué hace `@Builder`?**
  * *Respuesta:* "Es un patrón de diseño implementado con Lombok que nos permite construir objetos complejos de forma sumamente legible y segura en una sola línea de código, evitando constructores gigantescos propensos a errores."
* **¿Por qué usamos Spring Data JPA (`citaRepository.save`) en lugar de consultas SQL nativas (`INSERT INTO`)?**
  * *Respuesta:* "Por seguridad y productividad. JPA sanitiza y parametriza automáticamente las entradas de datos, anulando cualquier intento de ataque por **Inyección SQL**. Además, nos permite programar en POO (Programación Orientada a Objetos) sin escribir SQL repetitivo."
