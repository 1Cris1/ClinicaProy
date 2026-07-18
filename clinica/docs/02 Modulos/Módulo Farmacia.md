---
tags: [modulo, farmacia]
carpeta: modules/farmacia
---

# Módulo Farmacia

Doble propósito: **e-commerce interno** (el paciente compra productos) y **catálogos regulatorios peruanos** (TEDEF/DIGEMID) para prescripción.

## Parte 1 — Tienda

### `Producto` (tabla `productos`)
nombre, descripción, **precio** y precio_descuento, categoría (Medicamentos, Vitaminas, Equipos...), **stock**, estado (Disponible/Agotado/Discontinuado), imagen_url.

### `Pedido` (tabla `pedidos`) + `DetallePedido` (tabla `detalles_pedido`)
- Pedido: FK paciente, fecha, **total**, estado (Pendiente → Confirmado → En preparación → Listo → Entregado / Cancelado), notas.
- Detalle: FK pedido + producto, cantidad, **precio_unitario congelado al momento de la compra**, subtotal.

**Flujo de compra**: `POST /paciente/farmacia/comprar` (JSON desde el carrito en `paciente/farmacia.html`) → crea Pedido + Detalles y calcula el total en backend. Ver [[Rol Paciente]].

El admin gestiona el catálogo en `/admin/productos` (HU 7) → [[Rol Administrador]].

## Parte 2 — Catálogos regulatorios

### `DigemidObservatorio` (tabla `digemid_observatorio`)
Medicamentos autorizados por DIGEMID: nombre_producto, concentración, forma_farmaceutica, presentación, registro_sanitario.

`MedicamentoService.buscarMedicamentos(q)` — búsqueda case-insensitive, **mínimo 3 caracteres**; alimenta el autocompletado de medicamentos al recetar ([[Módulo Consultas y Recetas]]).

### `FarmaciaTedef` (tabla `farmacia_tedef`)
Tabla maestra del formato **TEDEF 2026** (30+ columnas: códigos IAFAS, prescriptor, catálogo 020/003, montos, copagos, IGV, ubigeo...). Importada por BULK INSERT desde CSV vía Flyway (`import_farmacia.sql`), con índices en `VCODPROD_FAR_003` y `UBIGEO`. Ver [[TEDEF y DIGEMID]].

## Búsquedas expuestas por [[API REST]]
- `/api/v1/external/farmacia/search?q=` → FarmaciaTedef
- `/api/v1/external/medicamentos/search?q=` → DigemidObservatorio
- `/api/v1/farmacia/productos?q=` → catálogo de tienda
- `/api/v1/external/medicamentos/info?q=` → ficha [[OpenFDA]]

## Relacionado
- [[Datos Semilla]] — 6 productos iniciales (Paracetamol, Ibuprofeno...)
- [[Historias de Usuario]] — HU 7
