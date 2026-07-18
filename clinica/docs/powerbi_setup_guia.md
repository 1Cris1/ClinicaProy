# Guía de Configuración: Nuevo Dashboard ClinicX

Esta guía te ayudará a conectar **Power BI Desktop** a la base de datos de la clínica utilizando las nuevas **Vistas SQL** que he creado. Estas vistas consolidan la información para que sea mucho más fácil crear reportes profesionales.

## 1. Conexión a la Base de Datos

Sigue estos pasos en Power BI Desktop:

1.  Haz clic en **Obtener datos** -> **MySQL database**.
2.  **Servidor**: `localhost` (o `127.0.0.1`)
3.  **Base de datos**: `bd_clinica`
4.  Si te pide credenciales:
    *   **Usuario**: `root`
    *   **Contraseña**: `12345` (según tus archivos de configuración)

## 2. Orígenes de Datos (Vistas Sugeridas)

En el Navegador de Power BI, busca y selecciona las siguientes vistas:

### `v_reporte_citas`
Esta es la vista principal para el análisis operativo.
*   **Campos clave**: `fecha_cita`, `estado_cita`, `especialidad`, `sede`, `medico_apellidos`, `paciente_dni`.
*   **Gráficos recomendados**:
    *   **Gráfico de Anillo**: Citas por `estado_cita`.
    *   **Gráfico de Barras**: Citas por `especialidad`.
    *   **Gráfico de Líneas**: Evolución de citas por `fecha_cita`.

### `v_reporte_pagos`
Ideal para el seguimiento financiero.
*   **Campos clave**: `fecha_pago`, `monto`, `metodo_pago`, `estado_pago`, `servicio_nombre`.
*   **Gráficos recomendados**:
    *   **Tarjeta**: Suma total de `monto`.
    *   **Gráfico de Barras Apiladas**: Ingresos por `metodo_pago`.
    *   **Gráfico de Treemap**: Ingresos por `servicio_nombre`.

## 3. Consejos para un Diseño Premium

*   **Colores**: Usa una paleta profesional (Azules #2563EB, Verdes #059669).
*   **Filtros**: Agrega segmentadores de datos por **Fecha** y **Sede** en la parte superior para que el reporte sea dinámico.
*   **Imágenes**: Puedes usar los logotipos de la clínica en el encabezado.

## 4. Próximos Pasos en el App

Una vez que publiques este mensaje en la web de Power BI, recuerda actualizar la URL en `application.properties` para que se refleje en el sistema.
