package com.proyectoclinica.clinica.modules.citas.repository;

import com.proyectoclinica.clinica.modules.citas.models.Cita;
import com.proyectoclinica.clinica.modules.paciente.models.Paciente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.time.LocalDate;
import java.util.List;
public interface CitaRepository extends JpaRepository<Cita, Integer> {
    
    // BÃºsquedas bÃ¡sicas
    // EXPOSICIÃ“N MIGUEL: Se usa @EntityGraph para traer las relaciones de paciente y medico en un solo JOIN FETCH. 
    // Esto resuelve el problema N+1, donde JPA harÃ­a 1 consulta por las citas + N consultas extras para traer los pacientes/medicos.
    @org.springframework.data.jpa.repository.EntityGraph(attributePaths = {"paciente", "medico"})
    List<Cita> findByFechaCitaOrderByHoraCitaAsc(LocalDate fecha);
    
    List<Cita> findByMedicoIdAndFechaCitaOrderByHoraCitaAsc(Integer idMedico, LocalDate fecha);
    List<Cita> findByPacienteIdOrderByFechaCitaDesc(Integer idPaciente);
    List<Cita> findByPacienteIdAndEstadoOrderByFechaCitaDesc(Integer idPaciente, String estado);
    // Conteos rÃ¡pidos
    long countByFechaCita(LocalDate fecha);
    long countByEstadoAndFechaCita(String estado, LocalDate fecha);
    long countByEstado(String estado);
    long countByMedicoIdAndFechaCita(Integer idMedico, LocalDate fecha);
    long countByMedicoIdAndEstadoAndFechaCita(Integer idMedico, String estado, LocalDate fecha);
    
    // Validaciones de Disponibilidad (Conflictos de Horario)
    boolean existsByMedicoIdAndFechaCitaAndHoraCitaAndEstadoNot(Integer idMedico, LocalDate fechaCita, String horaCita, String estadoNot);
    boolean existsByMedicoIdAndFechaCitaAndHoraCitaAndEstadoNotAndIdCitaNot(Integer idMedico, LocalDate fechaCita, String horaCita, String estadoNot, Integer idCitaNot);
    // Consultas para Dashboard y Reportes
    List<Cita> findTop10ByOrderByFechaRegistroDesc();
    long countByFechaCitaBetween(LocalDate start, LocalDate end);
    @Query("SELECT COUNT(c) FROM Cita c WHERE c.medico.id = :idMedico")
    long countPacientesDistintosByMedico(@Param("idMedico") Integer idMedico);
    @Query("SELECT p FROM Paciente p WHERE p.id IN (SELECT DISTINCT c.paciente.id FROM Cita c WHERE c.medico.id = :idMedico)")
    List<Paciente> findPacientesByMedico(@Param("idMedico") Integer idMedico);
    @Query("SELECT c FROM Cita c WHERE c.medico.id = :idMedico AND c.fechaCita >= CURRENT_DATE AND c.estado = 'Pendiente' ORDER BY c.fechaCita ASC, c.horaCita ASC LIMIT 1")
    Cita findSiguienteCitaMedico(@Param("idMedico") Integer idMedico);
    @Query("SELECT COUNT(c) FROM Cita c WHERE c.medico.id = :idMedico AND YEAR(c.fechaCita) = YEAR(CURRENT_DATE) AND MONTH(c.fechaCita) = MONTH(CURRENT_DATE) AND c.estado = 'Completada'")
    long countConsultasMesActual(@Param("idMedico") Integer idMedico);
    @Query("SELECT COUNT(c) FROM Cita c WHERE c.medico.id = :idMedico AND YEAR(c.fechaCita) = YEAR(CURRENT_DATE) AND MONTH(c.fechaCita) = MONTH(CURRENT_DATE) AND c.notasMedicas IS NOT NULL")
    long countNotasMesActual(@Param("idMedico") Integer idMedico);
    @Query("SELECT COUNT(c) FROM Cita c WHERE c.paciente.id = :idPaciente AND YEAR(c.fechaCita) = YEAR(CURRENT_DATE) AND c.estado = 'Completada'")
    long countConsultasAnioActual(@Param("idPaciente") Integer idPaciente);
    @Query("SELECT COUNT(c) FROM Cita c WHERE c.paciente.id = :idPaciente AND (c.estado = 'Pendiente' OR c.estado = 'Confirmada')")
    long countCitasPendientes(@Param("idPaciente") Integer idPaciente);
    @Query("SELECT c FROM Cita c WHERE c.paciente.id = :idPaciente AND c.fechaCita >= CURRENT_DATE AND (c.estado = 'Pendiente' OR c.estado = 'Confirmada') ORDER BY c.fechaCita ASC, c.horaCita ASC LIMIT 1")
    Cita findProximaCita(@Param("idPaciente") Integer idPaciente);
}

