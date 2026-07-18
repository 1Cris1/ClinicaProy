---
tags: [base-de-datos, initializers]
---

# Datos Semilla

Al arrancar la app, una cadena de **initializers** (`CommandLineRunner`) puebla la BD si está vacía. Viven en `config/` y `security/`.

## `DataInitializer` (security) — el principal

1. **Normaliza roles**: mapea `idRol` 1–4 al enum Rol ([[Seguridad]])
2. **Médico de prueba**: DNI `75536222`, CMP 12345, citas de 30 min
3. **Paciente de prueba**: DNI `75695332` (Yorning Jhonathan León Cuadros)
4. **Servicios**: crea "Consulta de {especialidad}" a S/ 50 por cada especialidad
5. **Cita de prueba** para hoy a las 10:00 entre ambos

> 💡 Estos dos DNI son las cuentas demo para probar todo el sistema.

## `SedeEspecialidadDataInitializer`
- **4 sedes**: Clínica Centro Lima (Av. Arenales 1256), Miraflores (Av. Larco 890), San Isidro (Av. Javier Prado 2150), Surco (Av. El Derby 250)
- **4 especialidades** con icono y color: Medicina General (#2563EB), Pediatría (#059669), Ginecología (#DB2777), Cardiología (#DC2626)

→ [[Módulo Recursos]]

## `FarmaciaDataInitializer`
6 productos: Paracetamol 500mg (S/15.50→12.50), Ibuprofeno 400mg, Amoxicilina 500mg, Vitamina C+Zinc, Jarabe para la tos, Termómetro digital. → [[Módulo Farmacia]]

## `LaboratorioDataInitializer` (@Order(10))
- Catálogo: Glucosa Basal (70–110 mg/dL), Hemoglobina (13.5–17.5 g/dL), Colesterol Total (0–200 mg/dL)
- 2 órdenes validadas de prueba, una con **glucosa 145 (anormal)** para demostrar el marcado de rangos. → [[Módulo Laboratorio]]

## `RecetaDataInitializer`
- **R-2026-0412** (Activa): Atorvastatina 20mg + Losartán 50mg
- **R-2026-0215** (Finalizada): Amoxicilina 500mg c/8h × 7 días

→ [[Módulo Consultas y Recetas]]

## `NotificacionDataInitializer`
3 notificaciones para el paciente demo: receta lista (no leída), recordatorio de cita (no leída), bienvenida (leída). → [[Módulo Notificaciones]]

## Relacionado
- [[Base de Datos y Configuración]]
- [[Infraestructura y Despliegue]] — el orden: Docker SQL Server primero, luego la app crea todo
