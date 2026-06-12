package com.proyectoclinica.clinica.modules.notificaciones.service;

import lombok.RequiredArgsConstructor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class NotificacionService {
    private final SimpMessagingTemplate messagingTemplate;

    public void enviarNotificacionResultado(String idMedico, String mensaje) {
        messagingTemplate.convertAndSend("/topic/notificaciones/" + idMedico, mensaje);
    }
}
