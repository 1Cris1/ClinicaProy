/* =========================================
   - FUNCIONES JAVASCRIPT DASHBOARD (Control de recarga, pantalla completa e indicador de carga de Power BI)
   ========================================= */

/**
 * Oculta el indicador de carga y muestra el iframe
 * @param {HTMLIFrameElement} iframe - El iframe que se está cargando
 * @param {string} loadingId - ID del elemento de carga
 */
function hideLoading(iframe, loadingId) {
    if (loadingId) {
        const loadingEl = document.getElementById(loadingId);
        if (loadingEl) {
            loadingEl.style.display = 'none';
        }
    }
    if (iframe) {
        iframe.style.display = 'block';
    }
}

/**
 * Recarga el iframe de Power BI
 * @param {HTMLElement} btn - Botón que llamó la función
 */
function reloadIframe(btn) {
    const card = btn.closest('.ad-card, .doc-card, .cx-card, .rc-card');
    if (card) {
        const iframe = card.querySelector('iframe');
        if (iframe) {
            const loadingId = iframe.getAttribute('onload').replace('hideLoading(this, ', '').replace(')', '').replace(/'/g, '');
            const loadingEl = document.getElementById(loadingId);
            if (loadingEl) loadingEl.style.display = '';
            iframe.style.display = 'none';
            iframe.src = iframe.src;
        }
    }
}

/**
 * Activa modo pantalla completa para el iframe
 * @param {HTMLElement} btn - Botón que llamó la función
 */
function toggleFullscreen(btn) {
    const card = btn.closest('.ad-card, .doc-card, .cx-card, .rc-card');
    if (card) {
        const iframe = card.querySelector('iframe');
        if (iframe) {
            if (iframe.requestFullscreen) {
                iframe.requestFullscreen();
            } else if (iframe.webkitRequestFullscreen) {
                iframe.webkitRequestFullscreen();
            } else if (iframe.msRequestFullscreen) {
                iframe.msRequestFullscreen();
            }
        }
    }
}
