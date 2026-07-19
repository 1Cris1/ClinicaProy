package com.proyectoclinica.clinica.service;

import com.proyectoclinica.clinica.modules.seguridad.models.CodigoVerificacion;
import com.proyectoclinica.clinica.modules.seguridad.models.Usuario;
import com.proyectoclinica.clinica.modules.seguridad.repository.CodigoVerificacionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class TwoFactorService {

    private final CodigoVerificacionRepository codigoRepository;
    private final EmailService emailService;

    /**
     * Genera un nuevo código, invalida los anteriores y lo envía por correo.
     */
    public void generarYEnviarCodigo(Usuario usuario) {

        // Invalidar códigos anteriores
        List<CodigoVerificacion> codigosActivos =
                codigoRepository.findByUsuarioAndUsadoFalse(usuario);

        for (CodigoVerificacion codigo : codigosActivos) {
            codigo.setUsado(true);
            codigoRepository.save(codigo);
        }

        // Generar código aleatorio de 6 dígitos
        String codigo = String.format("%06d", new Random().nextInt(1000000));

        CodigoVerificacion nuevoCodigo = CodigoVerificacion.builder()
                .usuario(usuario)
                .codigo(codigo)
                .fechaGeneracion(LocalDateTime.now())
                .fechaExpiracion(LocalDateTime.now().plusMinutes(5))
                .usado(false)
                .build();

        codigoRepository.save(nuevoCodigo);

        emailService.enviarCodigoVerificacion(
                usuario.getEmail(),
                usuario.getUsername(),
                codigo
        );
    }

public boolean validarCodigo(Usuario usuario, String codigo) {

    CodigoVerificacion registro = codigoRepository
            .findByUsuarioAndCodigoAndUsadoFalse(usuario, codigo)
            .orElse(null);

    if (registro == null) {
        return false;
    }

    if (registro.getFechaExpiracion().isBefore(LocalDateTime.now())) {
        return false;
    }

    registro.setUsado(true);
    codigoRepository.save(registro);

    return true;
}

}