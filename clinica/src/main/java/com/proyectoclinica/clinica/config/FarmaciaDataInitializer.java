package com.proyectoclinica.clinica.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.proyectoclinica.clinica.modules.farmacia.repository.ProductoRepository;
import com.proyectoclinica.clinica.modules.farmacia.models.Producto;
import java.math.BigDecimal;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Configuration
public class FarmaciaDataInitializer {
    private static final Logger log = LoggerFactory.getLogger(FarmaciaDataInitializer.class);
    @Bean
   public CommandLineRunner initFarmacia(ProductoRepository repository) {
        return args -> {
            if (repository.count() == 0) {
                log.info("Inicializando catálogo de Farmacia por defecto...");
                List<Producto> productos = List.of(
                Producto.builder().nombre("Paracetamol 500mg").descripcion("Caja x 100 tabletas. Analgésico y antipirético.").precio(new BigDecimal("15.50")).precioDescuento(new BigDecimal("12.50")).categoria("Medicamentos Generales").estado("Activo").imagenUrl("https://placehold.co/400x400/DCFCE7/166534?text=Medicina").stock(100).build(),
                Producto.builder().nombre("Ibuprofeno 400mg").descripcion("Caja x 50 cápsulas blandas.").precio(new BigDecimal("22.00")).precioDescuento(null).categoria("Analgésicos").estado("Activo").imagenUrl("https://placehold.co/400x400/DBEAFE/1E40AF?text=Analgésico").stock(50).build(),
                Producto.builder().nombre("Amoxicilina 500mg").descripcion("Caja x 50 cápsulas. Requiere receta médica.").precio(new BigDecimal("35.00")).precioDescuento(new BigDecimal("30.00")).categoria("Antibióticos").estado("Activo").imagenUrl("https://placehold.co/400x400/FEE2E2/991B1B?text=Antibiótico").stock(80).build(),
                Producto.builder().nombre("Vitamina C 1000mg + Zinc").descripcion("Frasco x 100 tabletas efervescentes.").precio(new BigDecimal("45.00")).precioDescuento(new BigDecimal("35.00")).categoria("Vitaminas y Suplementos").estado("Activo").imagenUrl("https://placehold.co/400x400/FEF9C3/854D0E?text=Vitamina").stock(120).build(),
                Producto.builder().nombre("Jarabe para la tos con miel").descripcion("Frasco 120ml. Expectorante adulto.").precio(new BigDecimal("28.00")).precioDescuento(null).categoria("Respiratorio").estado("Activo").imagenUrl("https://placehold.co/400x400/FCE7F3/9D174D?text=Jarabe").stock(40).build(),
                Producto.builder().nombre("Termómetro Digital").descripcion("Termómetro de uso clínico preciso con alarma auditiva.").precio(new BigDecimal("18.00")).precioDescuento(new BigDecimal("14.00")).categoria("Equipos Médicos").estado("Activo").imagenUrl("https://placehold.co/400x400/F3E8FF/6B21A8?text=Salud").stock(15).build()
);
                repository.saveAll(productos);
                log.info("Catálogo de Farmacia creado con éxito ({} productos).", productos.size());
            }
        };
    }   

}
