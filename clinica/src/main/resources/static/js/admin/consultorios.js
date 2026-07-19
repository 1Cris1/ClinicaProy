/* =========================================
   (US-27) - CONTROL DE CONSULTORIOS Y PLANO 3D
   ========================================= */
let currentReassignMedicoId = null;

function iniciarReasignacion(btn) {
    const idMedico = btn.getAttribute('data-medico-id');
    const medicoNombre = btn.getAttribute('data-medico-nombre');
    const consultorioActual = btn.getAttribute('data-consultorio');

    currentReassignMedicoId = idMedico;

    // Restablecer estilos de botones de reasignar
    document.querySelectorAll('.btn-reasignar').forEach(b => {
        b.classList.remove('btn-primary');
        b.classList.add('btn-outline-primary');
    });
    // Resaltar botón activo
    btn.classList.remove('btn-outline-primary');
    btn.classList.add('btn-primary');

    // Mostrar el banner en la derecha
    document.getElementById('reasignar-doctor-nombre').innerText = medicoNombre;
    document.getElementById('reasignar-banner').classList.remove('d-none');

    // Limpiar selección previa en el mapa
    document.querySelectorAll('.floor-room').forEach(r => {
        r.classList.remove('selected');
        r.classList.add('pulse-target'); // Hacer parpadear las salas
    });

    // Resaltar el consultorio que tiene asignado actualmente si existe
    if (consultorioActual) {
        const matchedRoom = document.querySelector(`.floor-room[data-room="${consultorioActual}"]`);
        if (matchedRoom) {
            matchedRoom.classList.add('selected');
        }
    }
}

function cancelarReasignacion() {
    currentReassignMedicoId = null;
    document.getElementById('reasignar-banner').classList.add('d-none');
    
    // Restablecer estilos de botones
    document.querySelectorAll('.btn-reasignar').forEach(b => {
        b.classList.remove('btn-primary');
        b.classList.add('btn-outline-primary');
    });

    // Limpiar clases en el mapa
    document.querySelectorAll('.floor-room').forEach(r => {
        r.classList.remove('selected');
        r.classList.remove('pulse-target');
    });
}

function clickRoom3D(el) {
    // Si no estamos en modo reasignación, no hace nada
    if (currentReassignMedicoId === null) {
        return;
    }

    const roomVal = el.getAttribute('data-room');

    // Deseleccionar salas y seleccionar la clickeada
    document.querySelectorAll('.floor-room').forEach(r => r.classList.remove('selected'));
    el.classList.add('selected');

    // Llenar el formulario oculto
    document.getElementById('form-medico-id').value = currentReassignMedicoId;
    document.getElementById('form-consultorio').value = roomVal;

    // Enviar formulario
    document.getElementById('hiddenReassignForm').submit();
}
