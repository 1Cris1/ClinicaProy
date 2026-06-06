package com.proyectoclinica.clinica.modules.integraciones.service;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.rest.api.MethodOutcome;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.hl7.fhir.r4.model.Enumerations;
import org.hl7.fhir.r4.model.Patient;
import org.springframework.stereotype.Service;

/**
 * Servicio para la interoperabilidad con servidores FHIR.
 * Permite sincronizar datos de pacientes con estándares internacionales.
 */
@Service
@Slf4j
public class FhirService {
    private FhirContext ctx;
    private IGenericClient client;
    private final String serverBase = "http://hapi.fhir.org/baseR4";

    @PostConstruct
    public void init() {
        log.info("Inicializando cliente HAPI FHIR en: {}", serverBase);
        this.ctx = FhirContext.forR4();
        this.client = ctx.newRestfulGenericClient(serverBase);
    }

    /**
     * Sincroniza un paciente local con el servidor FHIR global.
     * @param localPaciente Entidad del paciente en nuestra base de datos.
     */
    public void syncPatient(Paciente localPaciente) {
        try {
            log.info("Iniciando sincronización FHIR para DNI: {}", localPaciente.getDni());
            Patient fhirPatient = new Patient();
            
            fhirPatient.addIdentifier()
                    .setSystem("http://reniec.gob.pe")
                    .setValue(localPaciente.getDni());

            fhirPatient.addName()
                    .setFamily(localPaciente.getApellidos())
                    .addGiven(localPaciente.getNombres());

            if (localPaciente.getSexo() != null) {
                String sexo = localPaciente.getSexo().toLowerCase();
                if (sexo.startsWith("m")) {
                    fhirPatient.setGender(Enumerations.AdministrativeGender.MALE);
                } else if (sexo.startsWith("f")) {
                    fhirPatient.setGender(Enumerations.AdministrativeGender.FEMALE);
                } else {
                    fhirPatient.setGender(Enumerations.AdministrativeGender.OTHER);
                }
            }

            if (localPaciente.getFechaNacimiento() != null) {
                java.sql.Date date = java.sql.Date.valueOf(localPaciente.getFechaNacimiento());
                fhirPatient.setBirthDate(date);
            }

            if (localPaciente.getTelefono() != null && !localPaciente.getTelefono().isEmpty()) {
                fhirPatient.addTelecom()
                        .setSystem(org.hl7.fhir.r4.model.ContactPoint.ContactPointSystem.PHONE)
                        .setUse(org.hl7.fhir.r4.model.ContactPoint.ContactPointUse.MOBILE)
                        .setValue(localPaciente.getTelefono());
            }

            if (localPaciente.getEmail() != null && !localPaciente.getEmail().isEmpty()) {
                fhirPatient.addTelecom()
                        .setSystem(org.hl7.fhir.r4.model.ContactPoint.ContactPointSystem.EMAIL)
                        .setUse(org.hl7.fhir.r4.model.ContactPoint.ContactPointUse.HOME)
                        .setValue(localPaciente.getEmail());
            }

            if (localPaciente.getDireccion() != null && !localPaciente.getDireccion().isEmpty()) {
                fhirPatient.addAddress()
                        .addLine(localPaciente.getDireccion())
                        .setCity(localPaciente.getDistrito())
                        .setCountry("PE");
            }

            log.info("Enviando recurso Patient a HAPI FHIR Server...");
            MethodOutcome outcome = client.create()
                    .resource(fhirPatient)
                    .execute();

            if (outcome.getCreated() != null && outcome.getCreated()) {
                log.info("Interoperabilidad Exitosa: Paciente creado en la nube.");
            } else {
                log.info("Sincronización completa. ID Recurso: {}", outcome.getId().getValue());
            }
        } catch (Exception e) {
            log.error("Error en sincronización FHIR: {}", e.getMessage());
        }
    }
}
