---
tags: [seguridad, email]
archivos: service/PasswordResetService.java, controller/PasswordResetController.java
---

# Recuperación de Contraseña

Flujo **OTP por correo** en 3 pasos, expuesto como API pública (`/api/password/**`, sin autenticación → [[Seguridad]]).

## Endpoints (PasswordResetController)

| Paso | Endpoint | Body |
|---|---|---|
| 1. Solicitar | `POST /api/password/forgot` | `{"email": "..."}` |
| 2. Verificar | `POST /api/password/verify` | `{"email", "code"}` |
| 3. Restablecer | `POST /api/password/reset` | `{"email", "code", "newPassword"}` |

## PasswordResetService — cómo funciona

- Genera un código de **6 dígitos** que **expira en 5 minutos**
- Se guarda en un `ConcurrentHashMap` **en memoria** (no en BD) — se pierde al reiniciar la app, lo cual es aceptable por la corta expiración
- Verificación temporal: `LocalDateTime.now().isAfter(expiration)`
- Tras usarlo se limpia del mapa
- La nueva contraseña se guarda con BCrypt

## Correo enviado

HTML con el código destacado (fondo verde, monoespaciada 32px). Sale por **Gmail SMTP** (puerto 587, STARTTLS, App Password) — configuración en [[Base de Datos y Configuración]].

`EmailService` reutiliza la misma infraestructura para el **correo de bienvenida** del registro ([[Portal Público]]): plantilla azul ClinicX con CTA "Iniciar Sesión Ahora".

## Relacionado
- [[Patrones de Diseño]] — concurrencia con ConcurrentHashMap
