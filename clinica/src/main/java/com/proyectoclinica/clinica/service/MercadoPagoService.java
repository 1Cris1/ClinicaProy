package com.proyectoclinica.clinica.service;

import com.mercadopago.MercadoPagoConfig;
import com.mercadopago.client.preference.PreferenceClient;
import com.mercadopago.client.preference.PreferenceItemRequest;
import com.mercadopago.client.preference.PreferenceRequest;
import com.mercadopago.resources.preference.Preference;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Servicio que encapsula la lógica de creación de una Preference de Mercado Pago.
 * Recibe la lista de ítems del carrito, el total, descuentos y un identificador externo (orderId).
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class MercadoPagoService {

    private final com.proyectoclinica.clinica.config.MercadoPagoProperties mercadoPagoProperties;

    /**
     * Crea una Preference a partir de los datos del pedido.
     *
     * @param total          Monto total a pagar (después de aplicar descuentos).
     * @param description    Descripción breve del pedido.
     * @param orderId        Identificador interno de la orden (se guarda como external_reference).
     * @param items          Lista de items (title, quantity, unit_price).
     * @return Preference con el init_point (URL del Checkout).
     */
    public Preference crearPreference(double total, String description, String orderId, List<PreferenceItemRequest> items) {
        try {
            // Configuramos token de acceso
            MercadoPagoConfig.setAccessToken(mercadoPagoProperties.getAccessToken());

            // Construimos las URLs de retorno
            com.mercadopago.client.preference.PreferenceBackUrlsRequest backUrls =
                    com.mercadopago.client.preference.PreferenceBackUrlsRequest.builder()
                            .success("http://localhost:8080/pago/mercado-pago/success")
                            .failure("http://localhost:8080/pago/mercado-pago/failure")
                            .pending("http://localhost:8080/pago/mercado-pago/pending")
                            .build();

            PreferenceRequest request = PreferenceRequest.builder()
                    .items(items)
                    .externalReference(orderId)
                    .backUrls(backUrls)
                    .statementDescriptor("ClinicX") // simple, no special characters, max 13 chars
                    .build();

            PreferenceClient client = new PreferenceClient();
            Preference response = client.create(request);
            log.info("MercadoPago Preference created: id={}, initPoint={}", response.getId(), response.getInitPoint());
            return response;
        } catch (com.mercadopago.exceptions.MPApiException e) {
            String apiResponseContent = e.getApiResponse() != null ? e.getApiResponse().getContent() : "No response body";
            log.error("MercadoPago API Exception: code={}, response={}", e.getApiResponse() != null ? e.getApiResponse().getStatusCode() : "N/A", apiResponseContent, e);
            throw new RuntimeException("Error al comunicarse con Mercado Pago: " + apiResponseContent, e);
        } catch (com.mercadopago.exceptions.MPException e) {
            log.error("MercadoPago Exception", e);
            throw new RuntimeException("Error en Mercado Pago SDK: " + e.getMessage(), e);
        }
    }
}

