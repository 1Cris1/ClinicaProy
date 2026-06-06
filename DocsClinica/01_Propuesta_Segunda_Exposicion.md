# 🎯 Propuesta de Exposición (Avance 2) - 12 NUEVOS Requerimientos

¡Entendido! Si para este segundo avance el jurado quiere ver **funcionalidades 100% nuevas** que no se hayan tocado en la primera exposición, aquí tienes la distribución exacta.

Tenemos que presentar **12 requerimientos completamente nuevos** (3 por integrante). He revisado el código a fondo y he seleccionado las mejores funcionalidades restantes agrupadas por rol:

---

### 👤 INTEGRANTE 1: Rhomel (Integraciones y Seguridad)
*(Perfil enfocado en conexiones externas y recuperación de datos)*
1. 🆕 **Recuperación de Contraseña:** Flujo de envío de códigos de verificación temporales, evasión de enumeración de usuarios y re-encriptación de contraseñas (`PasswordResetController`).
2. 🆕 **Integración API CIE-11 (OMS):** Consumo del servicio externo para que el médico busque diagnósticos estandarizados a nivel mundial (`IcdService`).
3. 🆕 **Integración API Digemid / TEDEF:** Consumo del repositorio externo para buscar medicamentos validados por el estado peruano en tiempo real (`MedicamentoService`).

### 👤 INTEGRANTE 2: Miguel (Operaciones de Recepción)
*(Perfil enfocado en manejo de dinero y atención presencial)*
1. 🆕 **Módulo de Pagos / Caja:** Manejo de estados transaccionales. Cómo una cita pasa de "Atendida" a "Pagada" para cerrar el flujo económico en recepción.
2. 🆕 **Gestión Manual de Citas:** La lógica de agendamiento cuando el recepcionista crea la cita por llamada telefónica en nombre del paciente.
3. 🆕 **Registro de Pacientes en Counter:** Proceso de creación manual de cuentas de pacientes que se acercan presencialmente a la clínica y no usan el portal web.

### 👤 INTEGRANTE 3: Cristian (Métricas y Reportes Admin)
*(Perfil enfocado en análisis de datos e inteligencia de negocios)*
1. 🆕 **Panel de Control (Dashboard):** Uso de consultas de agregación (`COUNT`, `SUM`) en JPA para traer en tiempo real las citas del día, pacientes totales y atenciones.
2. 🆕 **Integración de Reportes (Power BI):** Explicación de cómo las vistas de administración exponen la metadata y enlazan al servicio de Business Intelligence mediante `application.properties`.
3. 🆕 **Mantenimiento de Sedes y Recepcionistas:** CRUD administrativo para dar de alta nuevas sucursales de la clínica y gestionar a los empleados (roles diferentes al médico).

### 👤 INTEGRANTE 4: Jhoan (Historial y Farmacia Clínica)
*(Perfil enfocado en trazabilidad del paciente y recetario)*
1. 🆕 **Historial Médico Integral:** El endpoint `/api/v1/historia/paciente/{id}` que cruza múltiples tablas para traer todo el récord de citas pasadas y notas de evolución del paciente.
2. 🆕 **Visualización de Recetas (Portal Paciente):** La lógica de cómo el paciente puede acceder a ver y descargar el detalle de los medicamentos que se le recetaron (`PacienteRecetaController`).
3. 🆕 **Catálogo Interno de Farmacia:** Lógica del buscador predictivo para que el médico seleccione productos activos de la farmacia local de la clínica al momento de recetar.

---

> [!NOTE] **Ventaja de esta distribución**
> Con estos 12 requerimientos nuevos, demuestran que el sistema no es un simple sistema de citas, sino un software clínico completo que maneja integraciones externas (OMS/Digemid), dinero (Caja), métricas (Dashboard) e historial médico.
