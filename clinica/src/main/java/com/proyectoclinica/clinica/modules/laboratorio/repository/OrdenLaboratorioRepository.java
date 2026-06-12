package com.proyectoclinica.clinica.modules.laboratorio.repository;

import com.proyectoclinica.clinica.modules.laboratorio.models.OrdenLaboratorio;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface OrdenLaboratorioRepository extends JpaRepository<OrdenLaboratorio, Integer> {
    List<OrdenLaboratorio> findByPacienteIdOrderByFechaSolicitudDesc(Integer idPaciente);
    List<OrdenLaboratorio> findByEstado(String estado);
    List<OrdenLaboratorio> findByMedicoIdOrderByFechaSolicitudDesc(Integer idMedico);
}

