---
tags:
  - exposicion
  - rhomel
  - backend
  - frontend
  - implementacion
relacionado_con:
  - "[[01_Propuesta_Segunda_Exposicion]]"
  - "[[02_Requerimientos_Proxima_Exposicion]]"
---

# Plan de Implementación: Requerimientos de Rhomel

## Objetivo 🎯
Blindar técnicamente el módulo del Paciente para la exposición académica de Rhomel, dándole un peso arquitectónico superior a través de la inyección de seguridad (BCrypt), manejo de transacciones en carritos de compra y trazabilidad visual.

> [!NOTE] Relación de Requerimientos
> Este plan implementa directamente los requerimientos asignados a Rhomel en [[01_Propuesta_Segunda_Exposicion]]:
> - **HU 9:** Perfil y Cambio de Contraseña.
> - **HU 7:** Catálogo de Farmacia y Carrito de Compras.
> - **HU 8:** Visualización de Resultados y Recetas.

---

## 🛠️ Modificaciones Arquitectónicas

### 1. `PacienteController.java` (Backend)
- **Inyección de Dependencias:** Se inyectaron `PasswordEncoder` y `UsuarioRepository` para manipular credenciales de forma segura.
- **Cambio de Contraseña Segura:** Creación del endpoint `@PostMapping("/perfil/password")` para comparar contraseñas usando algoritmos de hash y guardar la nueva.
- **Validación Anti-Fraude (Carrito):** Se robusteció `/farmacia/comprar` con una validación de lista vacía, retornando un estado 400 (`Bad Request`) si no hay ítems.
- **Consultas Relacionales (JPA):** Se agregó el método en `PedidoRepository` para traer la lista de pedidos recientes ordenados por fecha.
- **Marcas de Sustentación:** Inyección de comentarios `// EXPOSICIÓN RHOMEL:` en todos los métodos para servir como guion en la defensa del código.

### 2. `perfil.html` (Frontend)
- **Desbloqueo Dinámico:** Creación de la función `togglePacienteEditProfile()` envuelta en un fragmento de Thymeleaf (`th:fragment="scripts"`) para asegurar su carga en el layout global.
- **Formulario de Seguridad:** Nuevo panel exclusivo para cambio de contraseña interactuando con alertas de éxito/error provenientes de Spring Boot.

### 3. `farmacia.html` (Frontend)
- **Dashboard de Pedidos:** Nueva tabla agregada en la parte inferior de la vista para iterar dinámicamente (`th:each`) los registros provenientes de `misPedidos`, mostrando ID, Fechas, Estado y Montos con formato.

---
## 🔄 Estado de la Implementación
🟢 **Completado.** Los cambios ya fueron inyectados en la base de código y validados exitosamente en tiempo real. Para el resumen de la ejecución y resultados, consultar [[04_Resumen_Cambios_Rhomel]].
