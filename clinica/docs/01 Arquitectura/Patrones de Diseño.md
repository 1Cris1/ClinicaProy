---
tags: [arquitectura, patrones]
---

# Patrones de Diseño

Patrones y prácticas usados en ClinicX. Son también las **defensas técnicas** ante preguntas del jurado (ver [[Guía de Exposición]]).

## Patrones estructurales

- **MVC** — separación Vista/Controlador/Modelo → [[Arquitectura General]]
- **Repository Pattern** — Spring Data JPA abstrae el acceso a datos; los repositorios derivan queries del nombre del método (ej. `findByMedicoIdAndFechaCitaOrderByHoraCitaAsc`)
- **Builder (Lombok)** — construcción legible de entidades: `Cita.builder().estado("Pendiente").build()`
- **Inyección de dependencias** — constructor injection / `@Autowired`
- **ControllerAdvice por rol** — `PacienteGlobalController`, `MedicoGlobalController`, etc. inyectan atributos globales (contadores, notificaciones) en todas las vistas de su rol → [[Roles del Sistema]]

## Patrones de comportamiento

### POST-REDIRECT-GET (PRG)
Todos los formularios hacen POST y el controlador responde `redirect:`. Evita el doble envío de datos al recargar con F5.

### @Transactional — la "joya de la corona"
`MedicoController.completarConsulta()` actualiza la [[Módulo Citas|cita]], crea la [[Módulo Consultas y Recetas|receta]] e inserta N medicamentos **en una sola transacción ACID**. Si falla cualquier INSERT, rollback automático: nunca queda una receta sin medicamentos.

### RBAC (Role-Based Access Control)
Spring Security restringe rutas por rol; acceso indebido → 403. Ver [[Seguridad]].

### Aislamiento de integraciones
Las llamadas externas ([[Google Calendar]], [[FHIR]]) van en try-catch aislado o `CompletableFuture.runAsync()`: si la API externa cae, la operación local se completa igual.

## Prácticas de seguridad

- **BCrypt** para todas las contraseñas (nunca texto plano)
- **JPA/Prepared Statements** → inmunidad a SQL Injection
- **Validación por identidad**: el médico solo puede completar sus propias citas; el paciente solo ve sus propios resultados (filtro por `Principal`)

## Concurrencia

- `AtomicInteger` en `PagoService` para numerar comprobantes sin colisiones entre recepcionistas simultáneos → [[Módulo Facturación]]
- `ConcurrentHashMap` para códigos OTP en memoria → [[Recuperación de Contraseña]]
- Caché de 24 h en `SusaludService` → [[API Perú y SUSALUD]]

## Relacionado
- [[Guía de Exposición]] — versión "mata-preguntas" de estos conceptos
