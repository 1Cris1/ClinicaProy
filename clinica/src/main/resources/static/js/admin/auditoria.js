/* =========================================
  (US-26) - VISOR DE AUDITORÍA DE SEGURIDAD
   ========================================= */

function mostrarDetalle(btn) {
    const user = btn.getAttribute('data-user');
    const fecha = btn.getAttribute('data-fecha');
    const tipo = btn.getAttribute('data-tipo');
    const ip = btn.getAttribute('data-ip');
    const detalles = btn.getAttribute('data-detalles');

    document.getElementById('modal-user').textContent = user;
    document.getElementById('modal-fecha').textContent = fecha;
    document.getElementById('modal-ip').textContent = ip;
    
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

function downloadCSV(csv, filename) {
    var csvFile;
    var downloadLink;
    csvFile = new Blob([new Uint8Array([0xEF, 0xBB, 0xBF]), csv], {type: "text/csv;charset=utf-8;"});
    downloadLink = document.createElement("a");
    downloadLink.download = filename;
    downloadLink.href = window.URL.createObjectURL(csvFile);
    downloadLink.style.display = "none";
    document.body.appendChild(downloadLink);
    downloadLink.click();
}

function exportTableToCSV(filename) {
    var csv = [];
    var rows = document.querySelectorAll("#auditoriaTable tr");
    
    for (var i = 0; i < rows.length; i++) {
        var row = [], cols = rows[i].querySelectorAll("td, th");
        
        // Excluir la última columna (acciones de "Ver")
        for (var j = 0; j < cols.length - 1; j++) {
            // Limpiar texto de comas o retornos de carro
            var data = cols[j].innerText.replace(/(\r\n|\n|\r)/gm, "").replace(/(\s\s+)/gm, ' ');
            data = data.replace(/"/g, '""');
            row.push('"' + data + '"');
        }
        csv.push(row.join(","));
    }
    downloadCSV(csv.join("\n"), filename);
}
