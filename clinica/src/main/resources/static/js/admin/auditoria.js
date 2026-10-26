/* =========================================
  (US-26) - VISOR DE AUDITORÍA DE SEGURIDAD
   ========================================= */

function mostrarDetalle(btn) {
    const user = btn.getAttribute('data-user');
    const fecha = btn.getAttribute('data-fecha');
    const tipo = btn.getAttribute('data-tipo');
    const detalles = btn.getAttribute('data-detalles');

    document.getElementById('modal-user').textContent = user;
    document.getElementById('modal-fecha').textContent = fecha;
    
    const badge = document.getElementById('modal-tipo');
    badge.textContent = tipo;
    badge.className = 'badge';
    if (tipo === 'LOGIN') badge.classList.add('bg-success');
    else if (tipo === 'MODIFICACION') badge.classList.add('bg-warning', 'text-dark');
    else if (tipo === 'ELIMINACION') badge.classList.add('bg-danger');
    else if (tipo === 'ACCESO_DATOS') badge.classList.add('bg-info', 'text-dark');
    else badge.classList.add('bg-secondary');

    document.getElementById('modal-detalles').textContent = detalles;

    const modal = new bootstrap.Modal(document.getElementById('detalleModal'));
    modal.show();
}

document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('filtroAuditoriaForm');
    if (form) {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            const url = new URL(form.action);
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            url.search = searchParams.toString();

            const tbody = document.getElementById('tablaAuditoriaBody');
            tbody.innerHTML = '<tr><td colspan="6" class="text-center py-5"><div class="spinner-border text-primary" role="status"></div><p class="mt-2 text-muted">Cargando...</p></td></tr>';

            fetch(url, {
                method: 'GET',
                headers: {
                    'X-Requested-With': 'Fetch'
                }
            })
            .then(response => response.text())
            .then(html => {
                tbody.outerHTML = html;
            })
            .catch(error => console.error('Error fetching data:', error));
        });
    }
});


