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


