package com.proyectoclinica.clinica.security;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
    private final CustomAuthenticationSuccessHandler successHandler;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(authz -> authz
                // EXPOSICIÓN RHOMEL: Aquí definimos qué rutas son públicas (permitAll) como el login o registro, y cuáles requieren autenticación obligatoria y un ROL específico.
                .requestMatchers("/css/**", "/js/**", "/img/**", "/images/**").permitAll()
                .requestMatchers("/", "/inicio", "/especialidades", "/medicos", "/servicios", "/promociones", "/sedes", "/blog", "/contacto", "/login", "/registro", "/api/test/users", "/api/password/**", "/api/identidad/**", "/api/colegiatura/**", "/pago/**", "/error").permitAll()
                .requestMatchers("/admin/**").hasAuthority("ROLE_ADMIN")
                .requestMatchers("/medico/**").hasAuthority("ROLE_MEDICO")
                .requestMatchers("/paciente/recetas/descargar/**").hasAnyAuthority("ROLE_PACIENTE", "ROLE_MEDICO")
                .requestMatchers("/paciente/**").hasAuthority("ROLE_PACIENTE")
                .requestMatchers("/recepcionista/**").hasAuthority("ROLE_RECEPCIONISTA")
                .anyRequest().authenticated()
            )
            // EXPOSICIÓN RHOMEL: Explicar que usamos el formLogin de Spring Security. Spring intercepta la petición a '/authenticate' y hace el proceso de login automáticamente sin que nosotros programemos el controlador.
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/authenticate")
                .successHandler(successHandler)
                .failureUrl("/login?error=true")
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/")
                .permitAll()
            );
        return http.build();
    }
}
