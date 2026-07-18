---
tags: [integracion, regulatorio, farmacia]
---

# TEDEF y DIGEMID

Los dos **catálogos regulatorios peruanos** del sistema farmacéutico. No son APIs en vivo: son datos oficiales **importados a la BD local**.

## TEDEF — Transmisión Electrónica de Datos de Establecimiento Farmacéutico

- Estándar de **SUSALUD/DIGEMID** para que farmacias reporten movimientos de medicamentos electrónicamente.
- Referencia oficial: [DICCIONARIO DE DATOS TEDEF - FARMACIA.pdf](DICCIONARIO%20DE%20DATOS%20TEDEF%20-%20FARMACIA.pdf) (en esta misma carpeta docs/).
- Tabla: `farmacia_tedef` (entidad `FarmaciaTedef`, 30+ columnas: códigos IAFAS, prescriptor, catálogos formato 020/003, códigos DIGEMID, montos, copagos, exoneración IGV, ubigeo, fechas).
- Importación: BULK INSERT desde CSV (separador `|`) vía `import_farmacia.sql` ([[Base de Datos y Configuración]]). Índices en `VCODPROD_FAR_003` y `UBIGEO`.
- Búsqueda: `GET /api/v1/external/farmacia/search?q=` ([[API REST]]).

## DIGEMID — Observatorio de Medicamentos

- DIGEMID = Dirección General de Medicamentos, Insumos y Drogas del Perú.
- Tabla: `digemid_observatorio` (entidad `DigemidObservatorio`): nombre, concentración, forma farmacéutica, presentación, **registro sanitario**.
- `MedicamentoService.buscarMedicamentos(q)` (mínimo 3 caracteres) alimenta el **autocompletado al recetar** ([[Módulo Consultas y Recetas]]).

## Por qué importan
Son el argumento de **cumplimiento normativo** del proyecto: los medicamentos que se recetan y venden existen en los registros oficiales del Perú. Ver [[Guía de Exposición]].

## Relacionado
- [[Módulo Farmacia]]
- [[Integraciones Externas]]
