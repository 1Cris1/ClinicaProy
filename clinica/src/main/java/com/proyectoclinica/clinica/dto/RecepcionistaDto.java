package com.proyectoclinica.clinica.dto;

import lombok.Getter;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Builder;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RecepcionistaDto {
    private String nombres;
    private String apellidos;
    private String email;
    private String username;
}
