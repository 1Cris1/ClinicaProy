package com.proyectoclinica.clinica.modules.laboratorio.repository;

import com.proyectoclinica.clinica.modules.laboratorio.models.ResultadoDetalle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;
@Repository
public interface ResultadoDetalleRepository extends JpaRepository<ResultadoDetalle, Integer> {
    List<ResultadoDetalle> findByOrdenId(Integer idOrden);
    
    @Query("SELECT rd FROM ResultadoDetalle rd JOIN rd.orden o WHERE o.paciente.id = :idPaciente AND rd.examen.id = :idExamen ORDER BY o.fechaSolicitud DESC")
    List<ResultadoDetalle> findHistoricoPacienteExamen(Integer idPaciente, Integer idExamen);
}
