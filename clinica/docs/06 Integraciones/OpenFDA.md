---
tags: [integracion, medicamentos]
servicio: OpenFdaService
---

# OpenFDA

Consulta la **API pública de la FDA** (EE.UU.) para obtener fichas técnicas de medicamentos.

## `OpenFdaService`

- Endpoint: `https://api.fda.gov/drug/label.json`
- `buscarInfoMedicamento(q)` busca por nombre genérico **o** comercial:
  `search=openfda.generic_name:"{q}" OR openfda.brand_name:"{q}"&limit=1`
- Sin autenticación (API pública)

## Campos extraídos

| Campo FDA | Contenido |
|---|---|
| `dosage_and_administration` | instrucciones de dosis |
| `contraindications` | contraindicaciones |
| `warnings` | advertencias |
| `indications_and_usage` | indicaciones |

Fallback: "Información no disponible" si no hay resultados.

## Uso en el sistema
Apoyo al médico al prescribir ([[Módulo Consultas y Recetas]]): complementa el catálogo DIGEMID ([[Módulo Farmacia]]) con información clínica del fármaco. Expuesto en `GET /api/v1/external/medicamentos/info?q=` ([[API REST]]).

## Relacionado
- [[Integraciones Externas]]
