package com.proyectoclinica.clinica.security;

import java.time.LocalDate;
import com.proyectoclinica.clinica.modules.citas.models.Cita;
import com.proyectoclinica.clinica.modules.citas.repository.CitaRepository;
import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import com.proyectoclinica.clinica.modules.recursos.models.Medico;
import com.proyectoclinica.clinica.modules.seguridad.models.Rol;
import com.proyectoclinica.clinica.modules.paciente.repository.PacienteRepository;
import com.proyectoclinica.clinica.modules.seguridad.repository.UsuarioRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.MedicoRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.EspecialidadRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.SedeRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.ServicioRepository;
import com.proyectoclinica.clinica.modules.seguridad.models.AuditoriaUsuario;
import com.proyectoclinica.clinica.modules.seguridad.repository.AuditoriaUsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;

@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {
    private final UsuarioRepository usuarioRepository;
    private final PacienteRepository pacienteRepository;
    private final MedicoRepository medicoRepository;
    private final EspecialidadRepository especialidadRepository;
    private final SedeRepository sedeRepository;
    private final ServicioRepository servicioRepository;
    private final CitaRepository citaRepository;
    private final AuditoriaUsuarioRepository auditoriaUsuarioRepository;

    @Override
    @Transactional
    public void run(String... args) throws Exception {
        normalizarRoles();
        sincronizarMedicoDesdeUsuario();
        sincronizarPacienteDesdeUsuario();
        crearServiciosSiNoExisten();
        crearCitaPruebaSiNoExiste();
        inicializarAuditoriaPrueba();
    }

    private Integer obtenerIdUsuario(String username) {
        return usuarioRepository.findByUsername(username)
                .map(com.proyectoclinica.clinica.modules.seguridad.models.Usuario::getId)
                .orElse(1); // Default to 1 (admin) if not found
    }

    private void inicializarAuditoriaPrueba() {
        if (auditoriaUsuarioRepository.count() == 0) {
            java.time.LocalDateTime ahora = java.time.LocalDateTime.now();
            
            auditoriaUsuarioRepository.save(AuditoriaUsuario.builder()
                    .username("76390957") // Marlon
                    .idUsuario(obtenerIdUsuario("76390957"))
                    .fechaEvento(ahora.minusMinutes(45))
                    .tipoEvento("LOGIN")
                    .direccionIp("192.168.1.42")
                    .detalles("Inicio de sesión correcto en el portal de Recepción")
                    .build());

            auditoriaUsuarioRepository.save(AuditoriaUsuario.builder()
                    .username("72423413") // Mariana
                    .idUsuario(obtenerIdUsuario("72423413"))
                    .fechaEvento(ahora.minusMinutes(35))
                    .tipoEvento("ACCESO_DATOS")
                    .direccionIp("192.168.1.105")
                    .detalles("Consulta de historial clínico del paciente Jhoan Dangelo")
                    .build());

            auditoriaUsuarioRepository.save(AuditoriaUsuario.builder()
                    .username("76906446") // Cris
                    .idUsuario(obtenerIdUsuario("76906446"))
                    .fechaEvento(ahora.minusMinutes(25))
                    .tipoEvento("LOGIN")
                    .direccionIp("192.168.1.88")
                    .detalles("Inicio de sesión correcto en el portal de Pacientes")
                    .build());

            auditoriaUsuarioRepository.save(AuditoriaUsuario.builder()
                    .username("75592700") // Jhoan
                    .idUsuario(obtenerIdUsuario("75592700"))
                    .fechaEvento(ahora.minusMinutes(20))
                    .tipoEvento("ACCESO_DATOS")
                    .direccionIp("192.168.1.12")
                    .detalles("Visualización de recetas médicas activas")
                    .build());

            auditoriaUsuarioRepository.save(AuditoriaUsuario.builder()
                    .username("76390957") // Marlon
                    .idUsuario(obtenerIdUsuario("76390957"))
                    .fechaEvento(ahora.minusMinutes(15))
                    .tipoEvento("MODIFICACION")
                    .direccionIp("192.168.1.42")
                    .detalles("Registro de triaje para la cita de YORNING JHONATHAN")
                    .build());

            auditoriaUsuarioRepository.save(AuditoriaUsuario.builder()
                    .username("admin") // Admin
                    .idUsuario(obtenerIdUsuario("admin"))
                    .fechaEvento(ahora.minusMinutes(5))
                    .tipoEvento("LOGIN")
                    .direccionIp("127.0.0.1")
                    .detalles("Inicio de sesión correcto en el portal de Administración")
                    .build());

            auditoriaUsuarioRepository.save(AuditoriaUsuario.builder()
                    .username("admin") // Admin
                    .idUsuario(obtenerIdUsuario("admin"))
                    .fechaEvento(ahora.minusMinutes(2))
                    .tipoEvento("ACCESO_DATOS")
                    .direccionIp("127.0.0.1")
                    .detalles("Visualización del reporte Power BI y dashboard de métricas clínicas")
                    .build());

            System.out.println("✅ LOGS DE AUDITORÍA INICIALES CREADOS");
        }
    }

    private void crearCitaPruebaSiNoExiste() {
        var medico = medicoRepository.findByDni("75536222").orElse(null);
        var paciente = pacienteRepository.findByDni("75695332").orElse(null);
        
        if (medico != null && paciente != null) {
            LocalDate hoy = LocalDate.now();
            boolean yaTieneCita = !citaRepository.findByMedicoIdAndFechaCitaOrderByHoraCitaAsc(medico.getId(), hoy).isEmpty();
            
            if (!yaTieneCita) {
                var primerServicio = servicioRepository.findAll().stream().findFirst().orElse(null);
                if (primerServicio != null) {
                    Cita cita = Cita.builder()
                            .fechaCita(hoy)
                            .horaCita("10:00")
                            .motivo("Chequeo preventivo (Prueba)")
                            .estado("En Espera")
                            .medico(medico)
                            .paciente(paciente)
                            .servicio(primerServicio)
                            .fechaRegistro(java.time.LocalDateTime.now())
                            .build();
                    citaRepository.save(cita);
                    System.out.println("✅ CITA DE PRUEBA CREADA para hoy");
                }
            }
        }
    }

    public void sincronizarPacienteDesdeUsuario() {
        var usuarioPaciente = usuarioRepository.findByUsername("75695332").orElse(null);
        if (usuarioPaciente != null && pacienteRepository.findByUsuarioId(usuarioPaciente.getId()).isEmpty()) {
            Paciente paciente = Paciente.builder()
                    .nombres("YORNING JHONATHAN")
                    .apellidos("LEON CUADROS")
                    .dni("75695332")
                    .email(usuarioPaciente.getEmail())
                    .telefono("9215421333")
                    .estado("Activo")
                    .usuario(usuarioPaciente)
                    .build();
            pacienteRepository.save(paciente);
            System.out.println("✅ PACIENTE SINCRONIZADO desde usuario 75695332");
        }
    }

    public void sincronizarMedicoDesdeUsuario() {
        var usuarioMedico = usuarioRepository.findByUsername("75536222").orElse(null);
        if (usuarioMedico != null && medicoRepository.findByUsuarioId(usuarioMedico.getId()).isEmpty()) {
            var primeraEsp = especialidadRepository.findAll().stream().findFirst().orElse(null);
            var primeraSede = sedeRepository.findAll().stream().findFirst().orElse(null);
            if (primeraEsp != null && primeraSede != null) {
                Medico medico = Medico.builder()
                        .nombres("Doctor")
                        .apellidos("Médico")
                        .cmp("12345")
                        .dni("75536222")
                        .especialidad(primeraEsp)
                        .sede(primeraSede)
                        .telefono("999000000")
                        .email(usuarioMedico.getEmail())
                        .duracionCita(30)
                        .estado("Activo")
                        .usuario(usuarioMedico)
                        .build();
                
                medicoRepository.save(medico);
                System.out.println("✅ MÉDICO SINCRONIZADO desde usuario 75536222");
            }
        }
    }

    public void crearServiciosSiNoExisten() {
        if (servicioRepository.count() == 0) {
            var especialidades = especialidadRepository.findAll();
            for (var esp : especialidades) {
                var servicio = com.proyectoclinica.clinica.modules.recursos.models.Servicio.builder()
                        .nombre("Consulta de " + esp.getNombre())
                        .descripcion("Consulta médica en " + esp.getNombre())
                        .precio(new BigDecimal("50.00"))
                        .especialidad(esp)
                        .estado("Activo")
                        .build();
                servicioRepository.save(servicio);
            }
            System.out.println("✅ SERVICIOS CREADOS: " + especialidades.size() + " servicios por especialidad");
        }
    }

    public void normalizarRoles() {
        usuarioRepository.findAll().forEach(usuario -> {
            Rol rol = usuario.getRol();
            if (rol == null && usuario.getIdRol() != null) {
                switch(usuario.getIdRol()) {
                    case 1 -> usuario.setRol(Rol.ROLE_ADMIN);
                    case 2 -> usuario.setRol(Rol.ROLE_MEDICO);
                    case 3 -> usuario.setRol(Rol.ROLE_PACIENTE);
                    case 4 -> usuario.setRol(Rol.ROLE_RECEPCIONISTA);
                }
                usuarioRepository.save(usuario);
            }
        });
        System.out.println("✅ ROLES NORMALIZADOS");
    }
}
