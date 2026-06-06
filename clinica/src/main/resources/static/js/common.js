function cargarDatosEspecialidad(btn) {
            document.getElementById('editId').value = btn.getAttribute('data-id');
            document.getElementById('editNombre').value = btn.getAttribute('data-nombre') || '';
            document.getElementById('editDescripcion').value = btn.getAttribute('data-descripcion') || '';
            document.getElementById('editIcono').value = btn.getAttribute('data-icono') || '';
            document.getElementById('editColor').value = btn.getAttribute('data-color') || '#DBEAFE';
            document.getElementById('editEstado').value = btn.getAttribute('data-estado');
            document.getElementById('imagenUrlEdit').value = '';
            document.getElementById('previewEdit').style.display = 'none';
        }

        async function handleUpload(input, hiddenId, previewId) {
            const file = input.files[0];
            if (!file) return;
            
            const formData = new FormData();
            formData.append('file', file);
            
            try {
                const response = await fetch('/upload', { method: 'POST', body: formData });
                const data = await response.json();
                if (data.url) {
                    document.getElementById(hiddenId).value = data.url;
                    document.getElementById(previewId).src = data.url;
                    document.getElementById(previewId).style.display = 'block';
                }
            } catch (e) { alert('Error al subir imagen'); }
        }

        ['uploadAreaNuevo', 'uploadAreaEdit'].forEach(id => {
            const el = document.getElementById(id);
            if (el) {
                el.addEventListener('dragover', e => { e.preventDefault(); el.style.borderColor = '#2563EB'; el.style.background = '#EFF6FF'; });
                el.addEventListener('dragleave', e => { el.style.borderColor = '#ddd'; el.style.background = 'transparent'; });
                el.addEventListener('drop', e => {
                    e.preventDefault();
                    el.style.borderColor = '#ddd';
                    el.style.background = 'transparent';
                    const fileInput = el.nextElementSibling;
                    if (fileInput) { fileInput.files = e.dataTransfer.files; handleUpload(fileInput, el.dataset.hidden, el.dataset.preview); }
                });
            }
        });

function cargarDatosPromocion(btn) {
            document.getElementById('editId').value = btn.getAttribute('data-id') || '';
            document.getElementById('editTitulo').value = btn.getAttribute('data-titulo') || '';
            document.getElementById('editDescripcion').value = btn.getAttribute('data-descripcion') || '';
            document.getElementById('editDescuento').value = btn.getAttribute('data-descuento') || '';
            document.getElementById('editFechaInicio').value = btn.getAttribute('data-fechaInicio') || '';
            document.getElementById('editFechaFin').value = btn.getAttribute('data-fechaFin') || '';
            document.getElementById('editEstado').value = btn.getAttribute('data-estado') || 'Activo';
            const imgUrl = btn.getAttribute('data-imagenUrl') || '';
            document.getElementById('imagenUrlPromoEdit').value = imgUrl;
            const previewDiv = document.getElementById('previewPromoEdit');
            const previewImg = previewDiv.querySelector('img');
            if (imgUrl) {
                previewImg.src = imgUrl;
                previewDiv.style.display = 'block';
            } else {
                previewDiv.style.display = 'none';
            }
        }

        function cargarEliminarPromocion(btn) {
            document.getElementById('eliminarNombre').textContent = btn.getAttribute('data-titulo');
            document.getElementById('btnConfirmarEliminar').href = '/admin/promociones/eliminar?id=' + btn.getAttribute('data-id');
        }

        async function handleUploadPromo(input, hiddenId, previewId) {
            const file = input.files[0];
            if (!file) return;
            
            const formData = new FormData();
            formData.append('file', file);
            
            try {
                const response = await fetch('/upload', { method: 'POST', body: formData });
                const data = await response.json();
                if (data.url) {
                    document.getElementById(hiddenId).value = data.url;
                    const previewDiv = document.getElementById(previewId);
                    previewDiv.querySelector('img').src = data.url;
                    previewDiv.style.display = 'block';
                }
            } catch (e) { alert('Error al subir imagen'); }
        }

        function removeImage(hiddenId, previewId) {
            document.getElementById(hiddenId).value = '';
            document.getElementById(previewId).style.display = 'none';
        }

        ['uploadAreaPromoNuevo', 'uploadAreaPromoEdit'].forEach(id => {
            const el = document.getElementById(id);
            if (el) {
                el.addEventListener('dragover', e => { e.preventDefault(); el.style.borderColor = '#2563EB'; el.style.background = '#EFF6FF'; });
                el.addEventListener('dragleave', e => { el.style.borderColor = '#ddd'; el.style.background = '#fafafa'; });
                el.addEventListener('drop', e => {
                    e.preventDefault();
                    el.style.borderColor = '#ddd';
                    el.style.background = '#fafafa';
                    const fileInput = el.nextElementSibling;
                    if (fileInput) { fileInput.files = e.dataTransfer.files; handleUploadPromo(fileInput, el.id.replace('Area', '').replace('uploadArea', 'imagenUrl'), el.id.replace('Area', '').replace('uploadArea', 'preview')); }
                });
            }
        });

function cargarDatosSede(btn) {
            document.getElementById('editId').value = btn.getAttribute('data-id') || '';
            document.getElementById('editNombre').value = btn.getAttribute('data-nombre') || '';
            document.getElementById('editDireccion').value = btn.getAttribute('data-direccion') || '';
            document.getElementById('editDistrito').value = btn.getAttribute('data-distrito') || '';
            document.getElementById('editCiudad').value = btn.getAttribute('data-ciudad') || '';
            document.getElementById('editTelefono').value = btn.getAttribute('data-telefono') || '';
            document.getElementById('editEmail').value = btn.getAttribute('data-email') || '';
            document.getElementById('editHorarioLv').value = btn.getAttribute('data-horarioLv') || '';
            document.getElementById('editHorarioSabado').value = btn.getAttribute('data-horarioSabado') || '';
            document.getElementById('editHorarioDomingo').value = btn.getAttribute('data-horarioDomingo') || '';
            document.getElementById('editNumConsultorios').value = btn.getAttribute('data-numConsultorios') || '';
            document.getElementById('editEstado').value = btn.getAttribute('data-estado') || 'Activo';
        }

        function cargarEliminarSede(btn) {
            document.getElementById('eliminarNombre').textContent = btn.getAttribute('data-nombre');
            document.getElementById('btnConfirmarEliminar').href = '/admin/sedes/eliminar?id=' + btn.getAttribute('data-id');
        }

function cargarDatosServicio(btn) {
            document.getElementById('editId').value = btn.getAttribute('data-id');
            document.getElementById('editNombre').value = btn.getAttribute('data-nombre') || '';
            document.getElementById('editDescripcion').value = btn.getAttribute('data-descripcion') || '';
            document.getElementById('editPrecio').value = btn.getAttribute('data-precio') || '';
            document.getElementById('editEspecialidad').value = btn.getAttribute('data-especialidad') || '';
            document.getElementById('editEstado').value = btn.getAttribute('data-estado') || 'Activo';
        }

        function cargarEliminarServicio(btn) {
            document.getElementById('eliminarNombre').textContent = btn.getAttribute('data-nombre');
            document.getElementById('btnConfirmarEliminar').href = '/admin/servicios/eliminar?id=' + btn.getAttribute('data-id');
        }

        function agregarMedicamento() {
            console.log('Ejecutando agregarMedicamento...');
            // Intentar con el nuevo ID o el anterior por compatibilidad
            const template = document.getElementById('med-row-template') || document.getElementById('row-template');
            if (!template) {
                console.error('Error: No se encontró el template para la fila de medicamento.');
                return;
            }
            const body = document.getElementById('med-body');
            if (!body) {
                console.error('Error: No se encontró el contenedor med-body.');
                return;
            }
            
            try {
                const clone = template.content.cloneNode(true);
                body.appendChild(clone);
                console.log('Fila añadida correctamente.');
                checkEmptyMeds();
            } catch (e) {
                console.error('Error al clonar el template:', e);
            }
        }

        function checkEmptyMeds() {
            const rows = document.querySelectorAll('.med-row');
            const msg = document.getElementById('no-meds-msg');
            const table = document.getElementById('tablaMedicamentos');
            
            console.log('Verificando filas:', rows.length);
            
            if (msg) {
                if (rows.length > 0) {
                    msg.style.display = 'none';
                    msg.classList.add('d-none');
                } else {
                    msg.style.display = 'block';
                    msg.classList.remove('d-none');
                }
            }
            
            if (table) {
                if (rows.length > 0) {
                    table.style.display = 'table';
                    table.classList.remove('d-none');
                } else {
                    table.style.display = 'none';
                    table.classList.add('d-none');
                }
            }
        }

        // Inicializar
        document.addEventListener('DOMContentLoaded', function() {
            checkEmptyMeds();
        });

let currentStep = 1;
            let selectedSpecialty = "";
            let selectedDoctorId = "";
            let selectedDoctorName = "";
            let selectedDate = "";
            let selectedTimeStr = "";
            let selectedSede = "";
            let selectedDoctorHorarioLv = "";
            let selectedDoctorHorarioSab = "";
            let selectedDoctorDuracion = 30;

            function updateStepper() {
                document.querySelectorAll('.app-step').forEach(step => {
                    const stepNum = parseInt(step.getAttribute('data-step'));
                    const circle = step.querySelector('div');
                    const text = step.querySelector('span');

                    if (stepNum < currentStep) {
                        circle.style.background = 'var(--accent)';
                        circle.style.color = 'white';
                        circle.innerHTML = '<i class="bi bi-check-lg"></i>';
                        text.classList.add('text-primary');
                    } else if (stepNum === currentStep) {
                        circle.style.background = '#8B5CF6';
                        circle.style.color = 'white';
                        circle.innerHTML = stepNum;
                        text.classList.remove('text-muted');
                        text.classList.add('text-dark');
                    } else {
                        circle.style.background = 'var(--bg-light)';
                        circle.style.color = 'var(--text-muted)';
                        circle.innerHTML = stepNum;
                        text.classList.add('text-muted');
                        text.classList.remove('text-dark');
                    }
                });
            }

            function showStep(step) {
                document.querySelectorAll('.agendar-step').forEach(div => div.style.display = 'none');
                const targetStep = document.querySelector(`[data-agendar-step="${step}"]`);
                if (targetStep) targetStep.style.display = 'block';
                
                // Nav buttons
                const backBtn = document.getElementById('agendarBack');
                if (backBtn) backBtn.style.display = step > 1 ? 'block' : 'none';
                
                const nextBtnText = document.querySelector('#agendarNext .btn-text');
                if (nextBtnText) {
                    if (step === 4) {
                        nextBtnText.innerHTML = 'Confirmar Cita <i class="bi bi-check-lg ms-2"></i>';
                    } else {
                        nextBtnText.innerHTML = 'Continuar <i class="bi bi-arrow-right ms-2"></i>';
                    }
                }

                updateStepper();
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }

            function selectSpecialty(el) {
                document.querySelectorAll('.specialty-option').forEach(opt => opt.classList.remove('active'));
                el.classList.add('active');
                
                selectedSpecialty = el.getAttribute('data-specialty') || "";
                document.getElementById('selectedSpecialtyLabel').innerText = selectedSpecialty;
                
                // Filter doctors - more robust comparison
                let count = 0;
                const searchSpec = selectedSpecialty.trim().toLowerCase();
                
                document.querySelectorAll('.doctor-item').forEach(doc => {
                    const docSpec = (doc.getAttribute('data-doc-specialty') || "").trim().toLowerCase();
                    if (docSpec === searchSpec) {
                        doc.style.display = 'block';
                        count++;
                    } else {
                        doc.style.display = 'none';
                    }
                });
                
                document.getElementById('noDoctorsMsg').style.display = count === 0 ? 'block' : 'none';
                
                // Reset selected doctor since specialty changed
                selectedDoctorId = "";
                document.querySelectorAll('.doctor-option').forEach(opt => opt.classList.remove('active'));
                
                // Move to next step auto
                setTimeout(() => {
                    if (currentStep === 1) agendarNextAction();
                }, 350);
            }

            function selectDoctor(el) {
                document.querySelectorAll('.doctor-option').forEach(opt => opt.classList.remove('active'));
                el.classList.add('active');
                
                selectedDoctorId = el.getAttribute('data-id-medico');
                selectedDoctorName = el.getAttribute('data-doctor');
                selectedSede = el.getAttribute('data-sede') || "Sede Principal";
                selectedDoctorHorarioLv = el.getAttribute('data-horariolv');
                selectedDoctorHorarioSab = el.getAttribute('data-horariosab');
                selectedDoctorDuracion = parseInt(el.getAttribute('data-duracion')) || 30;
                
                document.getElementById('citaSede').value = selectedSede;
                document.getElementById('hidden_id_medico').value = selectedDoctorId;
                
                // Regenerate time slots if date is already picked
                let dateVal = document.getElementById('citaFecha')?.value;
                if(dateVal) {
                    generateTimeSlots(dateVal);
                }
                
                setTimeout(() => {
                    if (currentStep === 2) agendarNextAction();
                }, 350);
            }

            function selectTime(el) {
                document.querySelectorAll('.time-slot').forEach(opt => opt.classList.remove('active'));
                el.classList.add('active');
                selectedTimeStr = el.innerText;
                document.getElementById('hidden_hora').value = selectedTimeStr;
            }

            function generateTimeSlots(dateString) {
                const grid = document.getElementById('horariosGrid');
                if(!grid) return;
                
                grid.innerHTML = '';
                
                if (!dateString || !selectedDoctorId) {
                    grid.innerHTML = '<p class="text-muted small">Selecciona un médico y una fecha para ver los horarios disponibles.</p>';
                    return;
                }
                
                // Parse date (yyyy-mm-dd format from input type="date")
                const parts = dateString.split('-');
                if(parts.length !== 3) return;
                const d = new Date(parts[0], parts[1] - 1, parts[2]);
                const day = d.getDay(); // 0 = Sunday, 1 = Monday, 6 = Saturday
                
                if (day === 0) {
                    grid.innerHTML = '<p class="text-danger small fw-bold mb-0 mt-2"><i class="bi bi-calendar-x"></i> No hay atención los domingos.</p>';
                    return;
                }
                
                let scheduleStr = (day === 6) ? selectedDoctorHorarioSab : selectedDoctorHorarioLv;
                
                if (!scheduleStr || scheduleStr === 'No disponible' || scheduleStr === 'null') {
                    grid.innerHTML = '<p class="text-danger small fw-bold mb-0 mt-2"><i class="bi bi-calendar-x"></i> Doctor no disponible en este día.</p>';
                    return;
                }
                
                // Expected format: "07:00 - 13:00"
                const times = scheduleStr.split('-');
                if(times.length !== 2) {
                    grid.innerHTML = '<p class="text-danger small fw-bold mb-0 mt-2"><i class="bi bi-exclamation-triangle"></i> Horario mal configurado.</p>';
                    return;
                }
                
                const startStr = times[0].trim();
                const endStr = times[1].trim();
                
                const startParts = startStr.split(':');
                const endParts = endStr.split(':');
                
                if(startParts.length < 2 || endParts.length < 2) return;
                
                let startMins = parseInt(startParts[0]) * 60 + parseInt(startParts[1]);
                let endMins = parseInt(endParts[0]) * 60 + parseInt(endParts[1]);
                let dur = selectedDoctorDuracion > 0 ? selectedDoctorDuracion : 30;
                
                let currentMins = startMins;
                let html = '';
                
                while(currentMins + dur <= endMins) {
                    let h = Math.floor(currentMins / 60);
                    let m = currentMins % 60;
                    let ampm = h >= 12 ? 'PM' : 'AM';
                    let h12 = h % 12;
                    if(h12 === 0) h12 = 12;
                    let timeFmt = (h12 < 10 ? '0' : '') + h12 + ':' + (m < 10 ? '0' : '') + m + ' ' + ampm;
                    
                    html += '<button class="app-btn py-2 px-3 bg-white text-dark border shadow-sm-hover time-slot" style="font-size:.85rem;" onclick="selectTime(this)">' + timeFmt + '</button>';
                    
                    currentMins += dur;
                }
                
                if(html === '') {
                    grid.innerHTML = '<p class="text-danger small fw-bold mb-0 mt-2"><i class="bi bi-calendar-x"></i> No hay horarios disponibles en este rango.</p>';
                } else {
                    grid.innerHTML = html;
                }
                
                // Clear selected time if it was selected previously
                selectedTimeStr = "";
                if(document.getElementById('hidden_hora')) {
                    document.getElementById('hidden_hora').value = "";
                }
            }
            
            // Listen to Date changes
            const citaFechaInput = document.getElementById('citaFecha');
            if (citaFechaInput) {
                citaFechaInput.addEventListener('change', function() {
                    generateTimeSlots(this.value);
                });
            }

            function agendarPrev() {
                if (currentStep > 1) {
                    currentStep--;
                    showStep(currentStep);
                }
            }

            function agendarNextAction() {
                if (currentStep === 1) {
                    if (!selectedSpecialty) {
                        alert("Por favor selecciona una especialidad."); return;
                    }
                }
                if (currentStep === 2) {
                    if (!selectedDoctorId) {
                        alert("Por favor selecciona un médico."); return;
                    }
                }
                if (currentStep === 3) {
                    selectedDate = document.getElementById('citaFecha').value;
                    if (!selectedDate || !selectedTimeStr) {
                        alert("Por favor selecciona la fecha y hora de tu cita."); return;
                    }
                    // Prepare summary
                    document.getElementById('confirmSpec').innerText = selectedSpecialty;
                    document.getElementById('confirmDoc').innerText = selectedDoctorName;
                    document.getElementById('confirmDate').innerText = selectedDate;
                    document.getElementById('confirmTime').innerText = selectedTimeStr;
                    document.getElementById('confirmSede').innerText = selectedSede;
                    document.getElementById('hidden_fecha').value = selectedDate;
                }

                if (currentStep === 4) {
                    if (!document.getElementById('confirmCheck').checked) {
                        alert("Debes confirmar los datos para programar la cita."); return;
                    }
                    const btn = document.getElementById('agendarNext');
                    btn.disabled = true;
                    btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span> Procesando...';
                    document.getElementById('realAgendarForm').submit();
                    return;
                }

                currentStep++;
                showStep(currentStep);
            }

            document.addEventListener('DOMContentLoaded', () => {
                showStep(1);
            });

document.addEventListener('DOMContentLoaded', function() {
                const now = new Date();
                const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
                const dateEl = document.getElementById('currentDateDisplay');
                if (dateEl) dateEl.innerText = now.toLocaleDateString('es-ES', options);
            });

let carrito = [];
            let carritoModal = null;

            function initFarmacia() {
                const modalEl = document.getElementById('carritoModal');
                if (modalEl) carritoModal = new bootstrap.Modal(modalEl);

                document.querySelectorAll('.btn-add-cart').forEach(btn => {
                    btn.addEventListener('click', function() {
                        const id = parseInt(this.getAttribute('data-id'));
                        const nombre = this.getAttribute('data-nombre');
                        const precio = parseFloat(this.getAttribute('data-precio'));
                        const stock = parseInt(this.getAttribute('data-stock')) || 0;
                        
                        const pIndex = carrito.findIndex(p => p.id === id);
                        if(pIndex > -1) {
                            if (carrito[pIndex].cantidad < stock) {
                                carrito[pIndex].cantidad++;
                            } else {
                                alert('Stock insuficiente: Solo quedan ' + stock + ' unidades.');
                                return;
                            }
                        } else {
                            if (stock > 0) {
                                carrito.push({ id, nombre, precio, cantidad: 1, stock: stock });
                            } else {
                                alert('Producto agotado');
                                return;
                            }
                        }
                        
                        actualizarUI();
                        
                        const icon = this.querySelector('i');
                        const originalClass = icon.className;
                        icon.className = 'bi bi-check-lg';
                        this.classList.replace('bg-primary', 'bg-success');
                        setTimeout(() => {
                            icon.className = originalClass;
                            this.classList.replace('bg-success', 'bg-primary');
                        }, 1000);
                    });
                });
            }

            if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', initFarmacia);
            else initFarmacia();

            function actualizarUI() {
                const countBadge = document.getElementById('cartCount');
                if(!countBadge) return;
                const totalItems = carrito.reduce((sum, item) => sum + item.cantidad, 0);
                if(totalItems > 0) {
                    countBadge.style.display = 'block';
                    countBadge.innerText = totalItems;
                } else countBadge.style.display = 'none';
                renderizarCarrito();
            }

            function abrirCarrito() {
                renderizarCarrito();
                if (carritoModal) carritoModal.show();
            }

            function removeItem(id) {
                carrito = carrito.filter(item => item.id !== id);
                actualizarUI();
            }

            function updateQ(id, d) {
                let p = carrito.find(x => x.id === id);
                if(p) {
                    if (d > 0 && p.cantidad >= p.stock) {
                        alert('No hay más stock disponible');
                        return;
                    }
                    p.cantidad += d;
                    if(p.cantidad <= 0) removeItem(id);
                    actualizarUI();
                }
            }

            function renderizarCarrito() {
                const emptyState = document.getElementById('cartEmptyState');
                const container = document.getElementById('cartItemsContainer');
                const tbody = document.getElementById('cartTableBody');
                const totalSum = document.getElementById('cartTotalSum');
                const btnCheckout = document.getElementById('btnCheckout');
                
                if(!emptyState || !container || !tbody) return;

                if(carrito.length === 0) {
                    emptyState.classList.remove('d-none');
                    container.classList.add('d-none');
                    totalSum.innerText = 'S/ 0.00';
                    btnCheckout.disabled = true;
                } else {
                    emptyState.classList.add('d-none');
                    container.classList.remove('d-none');
                    btnCheckout.disabled = false;
                    
                    let html = '';
                    let total = 0;
                    carrito.forEach(item => {
                        let sub = item.precio * item.cantidad;
                        total += sub;
                        html += `
                        <tr>
                            <td class="px-4 py-3">
                                <h6 class="mb-0 fw-bold" style="font-size:0.9rem;">${item.nombre}</h6>
                                <span class="text-muted small">Precio unit: S/ ${item.precio.toFixed(2)}</span>
                            </td>
                            <td class="text-center">
                                <div class="d-inline-flex align-items-center bg-light rounded-pill p-1">
                                    <button class="btn btn-sm btn-white rounded-circle shadow-xs" style="width:28px; height:28px;" onclick="updateQ(${item.id}, -1)">-</button>
                                    <span class="px-3 fw-bold small">${item.cantidad}</span>
                                    <button class="btn btn-sm btn-white rounded-circle shadow-xs" style="width:28px; height:28px;" onclick="updateQ(${item.id}, 1)">+</button>
                                </div>
                            </td>
                            <td class="text-end fw-bold text-success px-4">S/ ${sub.toFixed(2)}</td>
                            <td class="text-center">
                                <button class="btn btn-link text-danger p-0" onclick="removeItem(${item.id})"><i class="bi bi-trash"></i></button>
                            </td>
                        </tr>`;
                    });
                    tbody.innerHTML = html;
                    totalSum.innerText = 'S/ ' + total.toFixed(2);
                }
            }

            function procesarCompra() {
                const btnCheckout = document.getElementById('btnCheckout');
                if(!btnCheckout) return;
                btnCheckout.disabled = true;
                btnCheckout.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>';

                const payload = {
                    items: carrito.map(i => ({ idProducto: i.id, cantidad: i.cantidad })),
                    notas: document.getElementById('cartNotas').value
                };

                const csrfToken = document.getElementById('csrfToken') ? document.getElementById('csrfToken').value : '';
                const csrfHeader = document.getElementById('csrfHeader') ? document.getElementById('csrfHeader').value : 'X-CSRF-TOKEN';

                let headers = { 'Content-Type': 'application/json' };
                if (csrfToken) headers[csrfHeader] = csrfToken;

                fetch('/paciente/farmacia/comprar', {
                    method: 'POST',
                    headers: headers,
                    body: JSON.stringify(payload)
                })
                .then(r => r.json())
                .then(data => {
                    if(data.success) {
                        if(carritoModal) carritoModal.hide();
                        carrito = [];
                        actualizarUI();
                        const successMsg = document.getElementById('compraExitosaMsg');
                        if (successMsg) {
                            successMsg.classList.remove('d-none');
                            setTimeout(() => successMsg.classList.add('d-none'), 8000);
                        }
                    } else alert(data.message || 'Ocurrió un error');
                })
                .catch(() => alert('Error en servidor.'))
                .finally(() => {
                    btnCheckout.disabled = false;
                    btnCheckout.innerHTML = 'Finalizar Pedido';
                });
            }

function switchTab(tabId) {
                // Hide all panels
                document.getElementById('panel-proximas').style.display = 'none';
                document.getElementById('panel-completadas').style.display = 'none';
                document.getElementById('panel-canceladas').style.display = 'none';
                
                // Reset all buttons style
                ['proximas', 'completadas', 'canceladas'].forEach(id => {
                    const btn = document.getElementById('btn-' + id);
                    btn.style.background = 'transparent';
                    btn.style.color = 'var(--text-muted)';
                });
                
                // Show selected panel
                document.getElementById('panel-' + tabId).style.display = 'block';
                
                // Set active button style
                const activeBtn = document.getElementById('btn-' + tabId);
                activeBtn.style.background = 'var(--primary)';
                activeBtn.style.color = 'white';
            }

            function confirmarCancelacion(idCita) {
                document.getElementById('idCitaModal').value = idCita;
                var myModal = new bootstrap.Modal(document.getElementById('cancelarCitaModal'));
                myModal.show();
            }

let isEditing = false;
            function toggleEditProfile() {
                isEditing = !isEditing;
                const editableInputs = document.querySelectorAll('.editable-field');
                const saveArea = document.getElementById('profileSaveArea');
                const editBtn = document.getElementById('editProfileBtn');
                
                editableInputs.forEach(input => {
                    input.disabled = !isEditing;
                    if (isEditing) {
                        input.style.backgroundColor = '#fff';
                        input.classList.remove('bg-light');
                        input.classList.add('border');
                    } else {
                        input.style.backgroundColor = '';
                        input.classList.add('bg-light');
                        input.classList.remove('border');
                    }
                });
                
                if (isEditing) {
                    saveArea.style.display = 'block';
                    editBtn.style.display = 'none';
                    editableInputs[0].focus();
                } else {
                    saveArea.style.display = 'none';
                    editBtn.style.display = 'inline-block';
                }
            }

function switchRecetaTab(tabId) {
                document.getElementById('panel-activas').style.display = 'none';
                document.getElementById('panel-historial').style.display = 'none';
                
                ['activas', 'historial'].forEach(id => {
                    const btn = document.getElementById('btn-' + id);
                    btn.style.background = 'transparent';
                    btn.style.color = 'var(--text-muted)';
                });
                
                document.getElementById('panel-' + tabId).style.display = 'block';
                const activeBtn = document.getElementById('btn-' + tabId);
                activeBtn.style.background = 'var(--primary)';
                activeBtn.style.color = 'white';
            }

function filtrarPorFecha() {
            var fecha = document.getElementById('fechaFiltro').value;
            window.location.href = '/recepcionista/citas?fecha=' + fecha;
        }

        function checkIn(btn) {
            var id = btn.getAttribute('data-id');
            fetch('/recepcionista/citas/checkin?id=' + id).then(() => window.location.reload());
        }

        function completar(btn) {
            var id = btn.getAttribute('data-id');
            fetch('/recepcionista/citas/completar?id=' + id).then(() => window.location.reload());
        }

        function editarCita(btn) {
            document.getElementById('editIdCita').value = btn.getAttribute('data-id');
            document.getElementById('editFecha').value = btn.getAttribute('data-fecha');
            document.getElementById('editHora').value = btn.getAttribute('data-hora');
            document.getElementById('editEstado').value = btn.getAttribute('data-estado');
            new bootstrap.Modal(document.getElementById('modalEditarCita')).show();
        }

        function cancelarCita(btn) {
            if (confirm('¿Está seguro de cancelar esta cita?')) {
                var id = btn.getAttribute('data-id');
                fetch('/recepcionista/citas/cancelar?id=' + id).then(() => window.location.reload());
            }
        }

function searchTable() {
    let input, table, filter, tr, td, i, j, found;
    
    if (document.getElementById('buscarPaciente')) {
        input = document.getElementById('buscarPaciente');
        table = document.getElementById('tablaPacientes');
    } else if (document.getElementById('buscarMedico')) {
        input = document.getElementById('buscarMedico');
        table = document.getElementById('tablaMedicos');
    } else if (document.getElementById('buscarPago')) {
        input = document.getElementById('buscarPago');
        table = document.getElementById('tablaPagos');
    } else {
        return;
    }

    if (!input || !table) return;
    
    filter = input.value.toLowerCase();
    tr = table.getElementsByTagName('tr');
    
    const filtroEstado = document.getElementById('filtroEstado');
    const estadoValue = filtroEstado ? filtroEstado.value : '';

    for (i = 1; i < tr.length; i++) {
        td = tr[i].getElementsByTagName('td');
        if (td.length === 0) continue;
        
        found = false;
        for (j = 0; j < td.length - 1; j++) {
            if (td[j].textContent.toLowerCase().indexOf(filter) > -1) {
                found = true;
                break;
            }
        }
        
        if (found && estadoValue && document.getElementById('buscarPago')) {
            const estadoCol = td[6]; 
            if (estadoCol && estadoCol.textContent.trim() !== estadoValue) {
                found = false;
            }
        }
        
        tr[i].style.display = found ? '' : 'none';
    }
}

        function editarPaciente(btn) {
            document.getElementById('editId').value = btn.getAttribute('data-id');
            document.getElementById('editNombres').value = btn.getAttribute('data-nombres') || '';
            document.getElementById('editApellidos').value = btn.getAttribute('data-apellidos') || '';
            document.getElementById('editDni').value = btn.getAttribute('data-dni') || '';
            document.getElementById('editEmail').value = btn.getAttribute('data-email') || '';
            document.getElementById('editTelefono').value = btn.getAttribute('data-telefono') || '';
            document.getElementById('editEstadoPac').value = btn.getAttribute('data-estado') || 'Activo';
            new bootstrap.Modal(document.getElementById('modalEditarPaciente')).show();
        }

        function verHistorial(btn) {
            document.getElementById('historialNombre').textContent = btn.getAttribute('data-nombre');
            var id = btn.getAttribute('data-id');
            var tbody = document.getElementById('historialBody');
            tbody.innerHTML = '<tr><td colspan="5" class="text-center py-3"><i class="bi bi hourglass"></i> Cargando...</td></tr>';
            fetch('/recepcionista/pacientes/historial?id=' + id)
                .then(r => r.json())
                .then(data => {
                    if (data.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="5" class="text-center text-muted py-3">No hay citas registradas.</td></tr>';
                    } else {
                        tbody.innerHTML = data.map(c => '<tr><td>' + c.fecha + '</td><td>' + c.hora + '</td><td>' + c.medico + '</td><td>' + c.servicio + '</td><td><span class="rc-badge-status" style="background:' + c.color + ';color:' + c.textColor + ';">' + c.estado + '</span></td></tr>').join('');
                    }
                });
            new bootstrap.Modal(document.getElementById('modalHistorial')).show();
        }

        function anularPago(btn) {
            if (confirm('¿Está seguro de anular este comprobante?')) {
                var id = btn.getAttribute('data-id');
                fetch('/recepcionista/pagos/anular?id=' + id).then(() => window.location.reload());
            }
        }

