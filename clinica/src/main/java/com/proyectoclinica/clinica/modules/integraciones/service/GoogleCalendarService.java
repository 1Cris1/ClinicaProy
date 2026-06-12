package com.proyectoclinica.clinica.modules.integraciones.service;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.util.DateTime;
import com.google.api.client.util.store.FileDataStoreFactory;
import com.google.api.services.calendar.Calendar;
import com.google.api.services.calendar.CalendarScopes;
import com.google.api.services.calendar.model.Event;
import com.google.api.services.calendar.model.EventDateTime;
import com.proyectoclinica.clinica.modules.citas.models.Cita;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Collections;
import java.util.List;

/**
 * Servicio para gestionar la sincronización con Google Calendar.
 */
@Service
@Slf4j
public class GoogleCalendarService {
    private static final String APPLICATION_NAME = "ClinicX - DiacnosticAnalitic";
    private static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
    private static final String TOKENS_DIRECTORY_PATH = "tokens";
    private static final List<String> SCOPES = Collections.singletonList(CalendarScopes.CALENDAR);
    private static final String CREDENTIALS_FILE_PATH = "/credentials.json";

    private Credential getCredentials(final NetHttpTransport HTTP_TRANSPORT) throws Exception {
        InputStream in = GoogleCalendarService.class.getResourceAsStream(CREDENTIALS_FILE_PATH);
        if (in == null) {
            throw new FileNotFoundException("No se encontró el archivo de credenciales en: " + CREDENTIALS_FILE_PATH);
        }
        GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(in));
        GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(
                HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, SCOPES)
                .setDataStoreFactory(new FileDataStoreFactory(new java.io.File(TOKENS_DIRECTORY_PATH)))
                .setAccessType("offline")
                .build();
        
        LocalServerReceiver receiver = new LocalServerReceiver.Builder().setPort(8888).build();
        return new AuthorizationCodeInstalledApp(flow, receiver).authorize("user");
    }

    public void crearEventoCita(Cita cita) {
        try {
            log.info("Sincronizando cita con Google Calendar para: {} {}", 
                    cita.getPaciente().getNombres(), cita.getPaciente().getApellidos());
            
            final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
            Calendar service = new Calendar.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
                    .setApplicationName(APPLICATION_NAME)
                    .build();
            Event event = new Event()
                    .setSummary("Cita Médica: " + cita.getPaciente().getNombres() + " " + cita.getPaciente().getApellidos())
                    .setLocation("Clínica ClinicX")
                    .setDescription("Consulta: " + (cita.getServicio() != null ? cita.getServicio().getNombre() : "General") + 
                                   "\nMédico: Dr. " + cita.getMedico().getApellidos() +
                                   "\nMotivo: " + (cita.getMotivo() != null ? cita.getMotivo() : "Sin observaciones"));
            
            String horaRaw = cita.getHoraCita().trim(); 
            String horaNormalizada = horaRaw;
            if (horaNormalizada.length() == 5) {
                horaNormalizada += ":00";
            } else if (horaNormalizada.length() == 4) {
                horaNormalizada = "0" + horaNormalizada + ":00";
            }
            
            String startStr = cita.getFechaCita().toString() + "T" + horaNormalizada + "-05:00";
            DateTime startDateTime = new DateTime(startStr);
            event.setStart(new EventDateTime().setDateTime(startDateTime));
            
            long endMillis = startDateTime.getValue() + (30 * 60 * 1000);
            event.setEnd(new EventDateTime().setDateTime(new DateTime(endMillis)));
            
            service.events().insert("primary", event).execute();
            log.info("Evento sincronizado en Google Calendar.");
        } catch (Exception e) {
            log.error("Error sincronizando con Google Calendar: {}", e.getMessage(), e);
        }
    }
}
