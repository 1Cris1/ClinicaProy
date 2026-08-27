package com.proyectoclinica.clinica.modules.recursos.service;

import com.proyectoclinica.clinica.modules.recursos.models.Especialidad;
import com.proyectoclinica.clinica.modules.recursos.models.Sede;
import com.proyectoclinica.clinica.modules.recursos.models.Servicio;
import com.proyectoclinica.clinica.modules.recursos.repository.EspecialidadRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.SedeRepository;
import com.proyectoclinica.clinica.modules.recursos.repository.ServicioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CatalogoService {

    private final EspecialidadRepository especialidadRepository;
    private final SedeRepository sedeRepository;
    private final ServicioRepository servicioRepository;

    // === ESPECIALIDADES ===
    public List<Especialidad> listarEspecialidades() {
        return especialidadRepository.findAll();
    }
    
    public long contarEspecialidades() {
        return especialidadRepository.count();
    }

    public void registrarEspecialidad(String nombre, String descripcion, String icono, String color, Boolean estado, String imagenUrl) {
        Especialidad nuevaEspecialidad = Especialidad.builder()
                .nombre(nombre)
                .descripcion(descripcion)
                .icono(icono != null && !icono.isBlank() ? icono : "bi bi-stethoscope")
                .color(color)
                .estado(estado)
                .imagenUrl(imagenUrl)
                .build();
        especialidadRepository.save(nuevaEspecialidad);
    }

    public void editarEspecialidad(Integer id, String nombre, String descripcion, String icono, String color, Boolean estado, String imagenUrl) {
        Especialidad especialidad = especialidadRepository.findById(id).orElseThrow();
        especialidad.setNombre(nombre);
        especialidad.setDescripcion(descripcion);
        especialidad.setIcono(icono != null && !icono.isBlank() ? icono : "bi bi-stethoscope");
        especialidad.setColor(color);
        especialidad.setEstado(estado);
        if (imagenUrl != null && !imagenUrl.isBlank()) {
            especialidad.setImagenUrl(imagenUrl);
        }
        especialidadRepository.save(especialidad);
    }

    // === SERVICIOS ===
    public List<Servicio> listarServicios() {
        return servicioRepository.findAll();
    }
    
    public long contarServicios() {
        return servicioRepository.count();
    }

    public Servicio obtenerServicioPorId(Integer id) {
        return servicioRepository.findById(id).orElse(null);
    }

    public void registrarServicio(String nombre, String descripcion, BigDecimal precio, Integer especialidadId, String estado) {
        Especialidad especialidad = especialidadRepository.findById(especialidadId).orElse(null);
        Servicio nuevoServicio = Servicio.builder()
                .nombre(nombre)
                .descripcion(descripcion)
                .precio(precio)
                .especialidad(especialidad)
                .estado(estado)
                .build();
        servicioRepository.save(nuevoServicio);
    }

    public void editarServicio(Integer id, String nombre, String descripcion, BigDecimal precio, Integer especialidadId, String estado) {
        Servicio servicio = servicioRepository.findById(id).orElseThrow();
        servicio.setNombre(nombre);
        servicio.setDescripcion(descripcion);
        servicio.setPrecio(precio);
        servicio.setEspecialidad(especialidadRepository.findById(especialidadId).orElse(null));
        servicio.setEstado(estado);
        servicioRepository.save(servicio);
    }

    public boolean eliminarServicio(Integer id) {
        try {
            servicioRepository.deleteById(id);
            return true;
        } catch (DataIntegrityViolationException e) {
            return false;
        }
    }

    // === SEDES ===
    public List<Sede> listarSedes() {
        return sedeRepository.findAll();
    }

    public Sede obtenerSedePorId(Integer id) {
        return sedeRepository.findById(id).orElse(null);
    }
    
    public long contarSedes() {
        return sedeRepository.count();
    }

    public void registrarSede(String nombre, String direccion, String distrito, String ciudad, String telefono, String email, String horarioLv, String horarioSabado, String horarioDomingo, Integer numConsultorios, String estado) {
        Sede nuevaSede = Sede.builder()
                .nombre(nombre)
                .direccion(direccion)
                .distrito(distrito)
                .ciudad(ciudad)
                .telefono(telefono)
                .email(email)
                .horarioLv(horarioLv)
                .horarioSabado(horarioSabado)
                .horarioDomingo(horarioDomingo)
                .numConsultorios(numConsultorios)
                .estado(estado)
                .build();
        sedeRepository.save(nuevaSede);
    }

    public void editarSede(Integer id, String nombre, String direccion, String distrito, String ciudad, String telefono, String email, String horarioLv, String horarioSabado, String horarioDomingo, Integer numConsultorios, String estado) {
        Sede sede = sedeRepository.findById(id).orElseThrow();
        sede.setNombre(nombre);
        sede.setDireccion(direccion);
        sede.setDistrito(distrito);
        sede.setCiudad(ciudad);
        sede.setTelefono(telefono);
        sede.setEmail(email);
        sede.setHorarioLv(horarioLv);
        sede.setHorarioSabado(horarioSabado);
        sede.setHorarioDomingo(horarioDomingo);
        sede.setNumConsultorios(numConsultorios);
        sede.setEstado(estado);
        sedeRepository.save(sede);
    }

    public void eliminarSede(Integer id) {
        sedeRepository.deleteById(id);
    }
}
