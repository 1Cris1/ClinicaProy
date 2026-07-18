---
tags: [academico, exposicion]
fuente: guia_exposicion.txt, guia_exposicion_maestra.md, guion_exposicion_final.txt
---

# Guía de Exposición

Síntesis de todo el material de sustentación. Fuentes originales en [[Documentación Académica]].

## La analogía del restaurante 🍽️ (para no programadores)

| Componente | Analogía |
|---|---|
| Vista Thymeleaf | el menú / el plato servido |
| Controller | el mesero — toma la orden |
| Service | el chef — la lógica de negocio |
| Repository | la despensa — los datos |

## Guion de la demo
El [[Flujo Completo del Sistema]] ejecutado en vivo por los 4 integrantes en orden ([[Equipo y Responsabilidades]]): registro → agendamiento → check-in → alta de médico → consulta → receta.

## 🛡️ Mata-preguntas (defensas ante el jurado)

**¿Cómo garantizan el acceso por roles?**
Spring Security con RBAC: cada ruta exige un rol; intento indebido → 403 Acceso Denegado. → [[Seguridad]]

**¿Por qué POST-REDIRECT-GET?**
Evita el doble envío de datos al recargar con F5: el POST responde con redirect y el navegador queda en un GET. → [[Patrones de Diseño]]

**¿Qué es @Transactional y por qué es importante?**
Garantía ACID: en `completarConsulta()` la cita, la receta y los N medicamentos se guardan todos o ninguno; si algo falla hay rollback automático. → [[Módulo Consultas y Recetas]]

**¿Por qué JPA en lugar de SQL puro?**
Seguridad (prepared statements → inmune a SQL Injection), productividad (queries derivadas del nombre del método) y portabilidad de motor de BD.

**¿Cómo evitan el double-booking?**
Consulta de existencia por médico+fecha+hora excluyendo canceladas antes de guardar. → [[Módulo Citas]]

**¿Y si Google Calendar falla?**
La sincronización es asíncrona (`CompletableFuture`) y aislada en try-catch: la cita local se guarda igual. → [[Google Calendar]]

**¿Cómo saben quién está logueado?**
`Principal` de Spring Security en cada método del controlador: el médico solo opera sus citas, el paciente solo ve sus datos.

**¿Cumplen normativa peruana?**
Catálogos oficiales TEDEF y DIGEMID en BD, validación de DNI contra RENIEC, datos de seguro SUSALUD, e interoperabilidad [[FHIR]]. → [[TEDEF y DIGEMID]]

## Relacionado
- [[Historias de Usuario]]
- [[Arquitectura General]]
