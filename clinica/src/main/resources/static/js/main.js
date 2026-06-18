
/* =========================================
   FILE: layout-admin.html
   ========================================= */
(function() {
        const { ref, watch } = Vue;

        if (!document.querySelector('.ad-sidebar')) return;
        /* --- SIDEBAR TOGGLE --- */
        const sidebarOpen = ref(false);

        watch(sidebarOpen, function(val) {
            document.getElementById('sidebar').classList.toggle('show', val);
            document.getElementById('sidebarOverlay').classList.toggle('show', val);
        });

        document.getElementById('sidebarToggle').addEventListener('click', function() {
            sidebarOpen.value = !sidebarOpen.value;
        });
        document.getElementById('sidebarOverlay').addEventListener('click', function() {
            sidebarOpen.value = false;
        });

        /* --- ACTIVE PAGE & TITLE --- */
        var path = window.location.pathname;
        var titles = {
            dashboard: 'Dashboard', pacientes: 'Pacientes', medicos: 'Médicos',
            recepcionistas: 'Recepcionistas', citas: 'Citas', especialidades: 'Especialidades',
            servicios: 'Servicios', sedes: 'Sedes', promociones: 'Promociones',
            reportes: 'Reportes', configuracion: 'Configuración'
        };
        var isRoot = (path === '/admin' || path === '/admin/');
        var activePage = isRoot
            ? 'dashboard'
            : (Object.keys(titles).find(function(p) {
                return p !== 'dashboard' && path.includes('/admin/' + p);
              }) || 'dashboard');

        var titleEl = document.getElementById('pageTitle');
        if (titleEl) titleEl.textContent = titles[activePage] || 'Dashboard';

        document.querySelectorAll('[data-page]').forEach(function(link) {
            if (link.dataset.page === activePage) link.classList.add('active');
            else link.classList.remove('active');
        });

        /* --- TOPBAR BUTTONS --- */
        document.getElementById('notifBtn').addEventListener('click', function() {
            alert('🔔 3 notificaciones pendientes.');
        });
        document.getElementById('msgBtn').addEventListener('click', function() {
            alert('✉️ Sin mensajes nuevos.');
        });

        /* --- TABS & TABLE SEARCH (disponibles para páginas de contenido) --- */
        window.cxSelectTab = function(tabEl, panelAttr) {
            var group = tabEl.closest('.ad-tabs');
            if (group) group.querySelectorAll('.ad-tab').forEach(function(t) { t.classList.remove('active'); });
            tabEl.classList.add('active');
            document.querySelectorAll('[data-tab-panel]').forEach(function(p) {
                p.style.display = (p.dataset.tabPanel === panelAttr || panelAttr === 'all') ? '' : 'none';
            });
        };

        window.cxSearchTable = function(inputEl, tableId) {
            var q = inputEl.value.toLowerCase();
            document.querySelectorAll('#' + tableId + ' tbody tr').forEach(function(row) {
                row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
            });
        };

    })();

/* =========================================
   FILE: layout-medico.html
   ========================================= */
(function() {
        /* ===== Vue 3 Reactivity API — sin createApp, sin compilación de template ===== */
        const { ref, watch } = Vue;

        if (!document.querySelector('.doc-sidebar')) return;
        /* --- SIDEBAR TOGGLE --- */
        const sidebarOpen = ref(false);

        watch(sidebarOpen, function(val) {
            document.getElementById('sidebar').classList.toggle('show', val);
            document.getElementById('sidebarOverlay').classList.toggle('show', val);
        });

        document.getElementById('sidebarToggle').addEventListener('click', function() {
            sidebarOpen.value = !sidebarOpen.value;
        });
        document.getElementById('sidebarOverlay').addEventListener('click', function() {
            sidebarOpen.value = false;
        });

        /* --- ACTIVE PAGE & TITLE --- */
        var path = window.location.pathname;
        var titles = {
            inicio: 'Dashboard', agenda: 'Mi Agenda', consulta: 'Consulta Activa',
            pacientes: 'Mis Pacientes', resultados: 'Resultados', recetas: 'Recetas',
            laboratorio: 'Laboratorio Clínico', perfil: 'Mi Perfil', configuracion: 'Configuración'
        };
        var activePage = Object.keys(titles).find(function(p) {
            return path.includes('/medico/' + p);
        }) || 'inicio';

        var titleEl = document.getElementById('pageTitle');
        if (titleEl) titleEl.textContent = titles[activePage] || 'Dashboard';

        document.querySelectorAll('[data-page]').forEach(function(link) {
            if (link.dataset.page === activePage) link.classList.add('active');
            else link.classList.remove('active');
        });

        /* --- TOPBAR BUTTONS --- */
        document.getElementById('notifBtn').addEventListener('click', function() {
            alert('🔔 2 notificaciones pendientes.');
        });
        document.getElementById('msgBtn').addEventListener('click', function() {
            alert('✉️ Sin mensajes nuevos.');
        });

        /* --- TABS (usable desde páginas de contenido) --- */
        window.cxSelectTab = function(tabEl, panelAttr) {
            var group = tabEl.closest('.doc-tabs');
            if (group) group.querySelectorAll('.doc-tab').forEach(function(t) { t.classList.remove('active'); });
            tabEl.classList.add('active');
            document.querySelectorAll('[data-tab-panel]').forEach(function(p) {
                p.style.display = (p.dataset.tabPanel === panelAttr || panelAttr === 'all') ? '' : 'none';
            });
        };

        /* --- TABLE SEARCH (usable desde páginas de contenido) --- */
        window.cxSearchTable = function(inputEl, tableId) {
            var q = inputEl.value.toLowerCase();
            document.querySelectorAll('#' + tableId + ' tbody tr').forEach(function(row) {
                row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
            });
        };

    })();

/* =========================================
   FILE: layout-paciente.html
   ========================================= */
(function() {
        const { ref, watch } = Vue;

        if (!document.querySelector('.cx-sidebar')) return;
        /* --- SIDEBAR TOGGLE --- */
        const sidebarOpen = ref(false);

        watch(sidebarOpen, function(val) {
            document.getElementById('sidebar').classList.toggle('show', val);
            document.getElementById('sidebarOverlay').classList.toggle('show', val);
        });

        const toggle = document.getElementById('sidebarToggle');
        if (toggle) {
            toggle.addEventListener('click', function() {
                sidebarOpen.value = !sidebarOpen.value;
            });
        }
        
        const overlay = document.getElementById('sidebarOverlay');
        if (overlay) {
            overlay.addEventListener('click', function() {
                sidebarOpen.value = false;
            });
        }

        /* --- ACTIVE PAGE & TITLE --- */
        var path = window.location.pathname;
        var titles = {
            inicio: 'Dashboard', citas: 'Mis Citas', agendar: 'Agendar Cita',
            farmacia: 'Farmacia y Ofertas', resultados: 'Resultados', recetas: 'Recetas Médicas',
            historial: 'Historial Clínico', perfil: 'Mi Perfil', configuracion: 'Configuración'
        };
        var activePage = Object.keys(titles).find(function(p) {
            return path.includes('/paciente/' + p);
        }) || 'inicio';

        var titleEl = document.getElementById('pageTitle');
        if (titleEl) titleEl.textContent = titles[activePage] || 'Dashboard';

        document.querySelectorAll('[data-page]').forEach(function(link) {
            if (link.dataset.page === activePage) link.classList.add('active');
            else link.classList.remove('active');
        });

        /* --- FECHA ACTUAL --- */
        var d = new Date();
        var days = ['domingo','lunes','martes','miércoles','jueves','viernes','sábado'];
        var months = ['enero','febrero','marzo','abril','mayo','junio','julio',
                      'agosto','septiembre','octubre','noviembre','diciembre'];
        var dateStr = days[d.getDay()] + ', ' + d.getDate() + ' de ' + months[d.getMonth()] + ' de ' + d.getFullYear();
        var dateEl = document.getElementById('currentDate') || document.getElementById('currentDateDisplay');
        if (dateEl) dateEl.textContent = dateStr;

        /* --- TOPBAR BUTTONS --- */
        const helpBtn = document.getElementById('helpBtn');
        if (helpBtn) {
            helpBtn.addEventListener('click', function() {
                alert('📞 Comunícate al (01) 610-6666 para soporte.');
            });
        }

        /* --- TABS & TABLE SEARCH --- */
        window.cxSelectTab = function(tabEl, panelAttr) {
            var group = tabEl.closest('.cx-tabs');
            if (group) group.querySelectorAll('.cx-tab').forEach(function(t) { t.classList.remove('active'); });
            tabEl.classList.add('active');
            document.querySelectorAll('[data-tab-panel]').forEach(function(p) {
                p.style.display = (p.dataset.tabPanel === panelAttr || panelAttr === 'all') ? '' : 'none';
            });
        };

        window.cxSearchTable = function(inputEl, tableId) {
            var q = inputEl.value.toLowerCase();
            document.querySelectorAll('#' + tableId + ' tbody tr').forEach(function(row) {
                row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
            });
        };

    })();

/* =========================================
   FILE: layout-public.html
   ========================================= */
(function() {
        const { ref, watch } = Vue;

        /* ===== 1. NAVBAR SCROLL ===== */
        const navbar = document.getElementById('mainNavbar');
        if (navbar) {
            window.addEventListener('scroll', function() {
                navbar.classList.toggle('scrolled', window.scrollY > 30);
            });
        }

        if (!document.getElementById('mainNavbar')) return;
        /* ===== 2. ACTIVE NAV LINK ===== */
        var currentPath = window.location.pathname;
        document.querySelectorAll('.navbar-nav .nav-link').forEach(function(link) {
            var href = link.getAttribute('href');
            if (href && (currentPath === href || (currentPath === '/' && href === '/'))) {
                link.classList.add('active');
            }
        });

        /* ===== 3. SMOOTH SCROLL ===== */
        document.querySelectorAll('a[href^="#"]').forEach(function(anchor) {
            anchor.addEventListener('click', function(e) {
                var target = document.querySelector(anchor.getAttribute('href'));
                if (target) { e.preventDefault(); target.scrollIntoView({ behavior: 'smooth', block: 'start' }); }
            });
        });

        /* ===== 4. SCROLL REVEAL ===== */
        document.querySelectorAll('.card, .row > [class*="col-"], section, .list-group > div').forEach(function(el, i) {
            if (!el.closest('nav') && !el.closest('footer') && !el.classList.contains('reveal')) {
                el.classList.add('reveal', 'reveal-delay-' + Math.min((i % 4) + 1, 6));
            }
        });
        var obs = new IntersectionObserver(function(entries) {
            entries.forEach(function(entry) {
                if (entry.isIntersecting) { entry.target.classList.add('visible'); obs.unobserve(entry.target); }
            });
        }, { threshold: 0.05, rootMargin: '0px 0px -20px 0px' });
        document.querySelectorAll('.reveal').forEach(function(el) { obs.observe(el); });

        /* ===== 5. TESTIMONIOS ===== */
        var testimonials = [
            { text: '"La atención fue rápida y el personal muy amable. Me sentí segura desde que ingresé a la clínica. Gracias por devolverme la sonrisa."', name: 'Camila Palomino', sede: 'Paciente de Sede Surco' },
            { text: '"Excelente servicio de cardiología. El Dr. Ramos me explicó todo con mucha paciencia y profesionalismo. Altamente recomendado."', name: 'Carlos Mendoza', sede: 'Paciente de Sede Lima Centro' },
            { text: '"La atención virtual fue increíble. Pude consultar con mi médico desde casa sin complicaciones. Tecnología de primer nivel."', name: 'María Fernández', sede: 'Paciente de Atención Virtual' }
        ];
        var currentTestimonial = ref(0);

        function updateTestimonial() {
            var t = testimonials[currentTestimonial.value];
            var textEl = document.getElementById('testimonialText');
            var nameEl = document.getElementById('testimonialName');
            var sedeEl = document.getElementById('testimonialSede');
            if (textEl) textEl.textContent = t.text;
            if (nameEl) nameEl.textContent = t.name;
            if (sedeEl) sedeEl.textContent = t.sede;
        }

        watch(currentTestimonial, updateTestimonial);

        var prevBtn = document.getElementById('testimonialPrev');
        var nextBtn = document.getElementById('testimonialNext');
        if (prevBtn) prevBtn.addEventListener('click', function() {
            currentTestimonial.value = (currentTestimonial.value - 1 + testimonials.length) % testimonials.length;
        });
        if (nextBtn) nextBtn.addEventListener('click', function() {
            currentTestimonial.value = (currentTestimonial.value + 1) % testimonials.length;
        });
        setInterval(function() {
            currentTestimonial.value = (currentTestimonial.value + 1) % testimonials.length;
        }, 6000);

        /* ===== 6. SERVICE TABS ===== */
        window.filterServices = function(category) {
            document.querySelectorAll('[data-service-category]').forEach(function(card) {
                var show = (category === 'all' || card.dataset.serviceCategory === category);
                card.classList.toggle('hide-card', !show);
                if (show) {
                    card.style.opacity = '0'; card.style.transform = 'translateY(10px)';
                    setTimeout(function() { card.style.opacity = '1'; card.style.transform = 'translateY(0)'; }, 50);
                }
            });
        };

        /* ===== 7. ESPECIALIDADES FILTER ===== */
        window.filterSpecialties = function() {
            var search = (document.getElementById('specialtySearch')?.value || '').toLowerCase();
            var cat = document.getElementById('specialtyCategoryFilter')?.value || '';
            var typeChecks = Array.from(document.querySelectorAll('[data-filter-type]:checked')).map(function(c) { return c.dataset.filterType; });
            var sedeChecks = Array.from(document.querySelectorAll('[data-filter-sede]:checked')).map(function(c) { return c.dataset.filterSede; });
            document.querySelectorAll('.specialty-item').forEach(function(item) {
                var name = (item.dataset.name || '').toLowerCase();
                var category = item.dataset.category || '';
                var types = (item.dataset.types || '').split(',');
                var sedes = (item.dataset.sedes || '').split(',');
                var show = true;
                if (search && !name.includes(search)) show = false;
                if (cat && category !== cat) show = false;
                if (typeChecks.length > 0 && !typeChecks.some(function(t) { return types.includes(t); })) show = false;
                if (sedeChecks.length > 0 && !sedeChecks.some(function(s) { return sedes.includes(s); })) show = false;
                item.style.display = show ? '' : 'none';
            });
        };
        window.resetSpecialtyFilters = function() {
            var searchEl = document.getElementById('specialtySearch');
            var catEl = document.getElementById('specialtyCategoryFilter');
            if (searchEl) searchEl.value = '';
            if (catEl) catEl.value = '';
            document.querySelectorAll('[data-filter-type],[data-filter-sede]').forEach(function(c) { c.checked = false; });
            window.filterSpecialties();
        };

        /* ===== 8. MÉDICOS FILTER ===== */
        window.filterDoctors = function() {
            var specialty = document.getElementById('doctorSpecialtyFilter')?.value || '';
            var sede = document.getElementById('doctorSedeFilter')?.value || '';
            var visible = 0;
            document.querySelectorAll('[data-doctor-card]').forEach(function(card) {
                var show = (!specialty || card.dataset.specialty === specialty) && (!sede || card.dataset.sede === sede);
                card.style.display = show ? '' : 'none';
                if (show) { visible++; card.style.opacity = '0'; setTimeout(function() { card.style.opacity = '1'; }, 50 * visible); }
            });
            var noRes = document.getElementById('noResultsDoctors');
            if (noRes) noRes.style.display = visible === 0 ? '' : 'none';
        };
        window.resetDoctorFilters = function() {
            var spEl = document.getElementById('doctorSpecialtyFilter');
            var seEl = document.getElementById('doctorSedeFilter');
            if (spEl) spEl.value = '';
            if (seEl) seEl.value = '';
            window.filterDoctors();
        };

        /* ===== 9. STEPPER REGISTRO ===== */
        var currentStep = ref(1);
        var totalSteps = 3;

        function updateStepper() {
            for (var i = 1; i <= totalSteps; i++) {
                var circle  = document.getElementById('stepCircle' + i);
                var wrapper = document.getElementById('stepWrapper' + i);
                var panel   = document.getElementById('stepPanel' + i);
                if (!circle) continue;
                if (i < currentStep.value) {
                    circle.className = 'stepper-circle completed';
                    circle.innerHTML = '<i class="bi bi-check-lg"></i>';
                    if (wrapper) { wrapper.classList.remove('text-white-50'); wrapper.classList.add('text-white'); }
                } else if (i === currentStep.value) {
                    circle.className = 'stepper-circle bg-white text-primary';
                    circle.textContent = i;
                    if (wrapper) { wrapper.classList.remove('text-white-50'); wrapper.classList.add('text-white'); }
                } else {
                    circle.className = 'stepper-circle border border-white';
                    circle.textContent = i;
                    if (wrapper) { wrapper.classList.add('text-white-50'); wrapper.classList.remove('text-white'); }
                }
                if (panel) panel.style.display = (i === currentStep.value) ? '' : 'none';
            }
            var back = document.getElementById('stepperBack');
            var next = document.getElementById('stepperNext');
            if (back) back.style.display = currentStep.value > 1 ? '' : 'none';
            if (next) next.textContent = currentStep.value === totalSteps ? 'Finalizar Registro' : 'Continuar';
        }

        watch(currentStep, updateStepper);

        window.stepperNext = function(e) {
            if (e) e.preventDefault();
            if (currentStep.value < totalSteps) {
                currentStep.value++;
            } else {
                var fa = document.getElementById('registerFormArea');
                if (fa) fa.innerHTML = '<div class="text-center py-5"><i class="bi bi-check-circle-fill text-success" style="font-size:4rem;"></i><h3 class="fw-bold mt-3 mb-2">¡Registro completado!</h3><p class="text-muted mb-4">Tu cuenta ha sido creada. Ya puedes iniciar sesión.</p><a href="/login" class="btn btn-primary rounded-pill px-5 py-2 fw-bold shadow">Iniciar Sesión</a></div>';
            }
        };
        window.stepperBack = function(e) {
            if (e) e.preventDefault();
            if (currentStep.value > 1) currentStep.value--;
        };

    })();

/* =========================================
   FILE: doctores/consulta.html
   ========================================= */
/* HU10: Dispara animación del banner de alergias solo al cargar — una sola vez */
(function() {
    var banner = document.getElementById('allergyBanner');
    if (!banner) return;
    /* Pequeño delay para que el médico vea primero el contexto de la consulta */
    setTimeout(function() {
        banner.classList.add('animate-in');
    }, 350);
})();

/* =========================================
   FILE: doctores/dashboard.html
   ========================================= */
/* Fecha actual — fuera del fragment para ejecutarse tras el render de Thymeleaf */
(function() {
    var el = document.getElementById('docFecha');
    if (el) el.textContent = new Date().toLocaleDateString('es-PE', {
        weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'
    }).replace(/^\w/, function(c) { return c.toUpperCase(); });
})();

/* =========================================
   FILE: paciente/agendar.html
   ========================================= */
(function() {
    if (!document.getElementById('agendarStepper')) return;
    /* ===== Estado con Vue Reactivity ===== */
    const { ref, watch } = Vue;

    let agendarStep = 1;
    let goingBack = false;
    const agendarData = { specialty:'', doctor:'', id_medico:'', sede:'', date:'', time:'' };

    /* ===== Selecciones ===== */
    window.selectSpecialty = function(el) {
        document.querySelectorAll('.specialty-option').forEach(function(o) { o.classList.remove('selected'); });
        el.classList.add('selected');
        agendarData.specialty = el.dataset.specialty;
    };

    window.selectDoctor = function(el) {
        document.querySelectorAll('.doctor-option').forEach(function(o) { o.classList.remove('selected'); });
        el.classList.add('selected');
        agendarData.doctor = el.dataset.doctor;
        agendarData.sede = el.dataset.sede;
        agendarData.id_medico = el.dataset.idMedico;
    };

    window.selectTime = function(el) {
        document.querySelectorAll('.time-slot').forEach(function(b) { b.classList.remove('selected'); });
        el.classList.add('selected');
        agendarData.time = el.textContent.trim();
    };

    /* ===== HU04: Slide Animation entre pasos ===== */
    function slideToStep(fromStep, toStep, backwards) {
        var fromEl = document.querySelector('[data-agendar-step="' + fromStep + '"]');
        var toEl   = document.querySelector('[data-agendar-step="' + toStep + '"]');
        if (!fromEl || !toEl) return;

        var leaveClass  = backwards ? 'step-leave-back' : 'step-leave';
        var enterClass  = backwards ? 'step-enter-back'  : 'step-enter';

        /* 1. Salida del paso actual */
        fromEl.classList.add(leaveClass);
        fromEl.addEventListener('animationend', function onLeave() {
            fromEl.removeEventListener('animationend', onLeave);
            fromEl.classList.remove(leaveClass);
            fromEl.style.display = 'none';

            /* 2. Entrada del nuevo paso */
            toEl.style.display = '';
            toEl.classList.add(enterClass);
            toEl.addEventListener('animationend', function onEnter() {
                toEl.removeEventListener('animationend', onEnter);
                toEl.classList.remove(enterClass);
            });
        }, { once: true });
    }

    function updateAgendarStepper() {
        document.querySelectorAll('.cx-step').forEach(function(s) {
            var step = parseInt(s.dataset.step);
            s.classList.remove('active', 'done');
            if (step < agendarStep) s.classList.add('done');
            else if (step === agendarStep) s.classList.add('active');

            var circle = s.querySelector('.step-circle');
            if (step < agendarStep) circle.innerHTML = '<i class="bi bi-check-lg"></i>';
            else circle.textContent = step;
        });

        document.getElementById('agendarBack').style.display = agendarStep > 1 ? '' : 'none';

        if (agendarStep === 4) {
            var btn = document.getElementById('agendarNext');
            btn.querySelector('.btn-text').innerHTML = '✓ Confirmar Cita';
            document.getElementById('confirmSpec').textContent  = agendarData.specialty;
            document.getElementById('confirmDoc').textContent   = agendarData.doctor;
            document.getElementById('confirmDate').textContent  = agendarData.date || document.getElementById('citaFecha')?.value || '—';
            document.getElementById('confirmTime').textContent  = agendarData.time;
            document.getElementById('confirmSede').textContent  = agendarData.sede;
        } else {
            document.getElementById('agendarNext').querySelector('.btn-text').innerHTML = 'Siguiente <i class="bi bi-arrow-right ms-1"></i>';
        }

        if (agendarStep === 2) document.getElementById('selectedSpecialtyLabel').textContent = agendarData.specialty;
        if (agendarStep === 3) {
            document.getElementById('citaSede').value = agendarData.sede;
            var today = new Date().toISOString().split('T')[0];
            document.getElementById('citaFecha').min  = today;
            document.getElementById('citaFecha').value = today;
        }
    }

    window.agendarNextAction = function() {
        if (agendarStep === 1 && !agendarData.specialty) { alert('Selecciona una especialidad'); return; }
        
        if (agendarStep === 1) {
            // HU04: Filter doctors by specialty
            var visibleCount = 0;
            document.querySelectorAll('.doctor-item').forEach(function(item) {
                if (item.dataset.docSpecialty === agendarData.specialty) {
                    item.style.display = '';
                    visibleCount++;
                } else {
                    item.style.display = 'none';
                }
                // Deselect previously selected doctors when entering step 2
                var opt = item.querySelector('.doctor-option');
                if (opt) opt.classList.remove('selected');
            });
            agendarData.doctor = ''; // Reset selection
            
            var noDocMsg = document.getElementById('noDoctorsMsg');
            if (noDocMsg) noDocMsg.style.display = visibleCount === 0 ? '' : 'none';
        }

        if (agendarStep === 2 && !agendarData.doctor)    { alert('Selecciona un médico'); return; }
        if (agendarStep === 3) {
            agendarData.date = document.getElementById('citaFecha').value;
            if (!agendarData.date) { alert('Selecciona una fecha'); return; }
            if (!agendarData.time) { alert('Selecciona un horario'); return; }
        }

        /* HU05: Si es el paso de confirmación → microinteracción de pago */
        if (agendarStep === 4) {
            if (!document.getElementById('confirmCheck').checked) { alert('Confirma los datos para continuar.'); return; }
            runPaymentAnimation();
            return;
        }

        var fromStep = agendarStep;
        agendarStep++;
        goingBack = false;
        updateAgendarStepper();
        slideToStep(fromStep, agendarStep, false);
    };

    window.agendarPrev = function() {
        if (agendarStep > 1) {
            var fromStep = agendarStep;
            agendarStep--;
            goingBack = true;
            updateAgendarStepper();
            slideToStep(fromStep, agendarStep, true);
        }
    };

    /* ===== HU05: Microinteracción de pago y Envío Real ===== */
    function runPaymentAnimation() {
        var btn = document.getElementById('agendarNext');
        btn.classList.add('loading');

        setTimeout(function() {
            btn.classList.remove('loading');
            btn.classList.add('success-state');
            btn.querySelector('.btn-text').innerHTML = '<i class="bi bi-check-lg check-pop"></i> ¡Procesando Cita!';

            // Enviar formulario real al Spring Boot Controller
            var realForm = document.getElementById('realAgendarForm');
            if(realForm) {
                document.getElementById('hidden_id_medico').value = agendarData.id_medico;
                document.getElementById('hidden_fecha').value = agendarData.date;
                document.getElementById('hidden_hora').value = agendarData.time;
                realForm.submit();
            }

        }, 1600); /* simula 1.6s de procesamiento de la solicitud */
    }
})();

/* =========================================
   FILE: paciente/perfil.html
   ========================================= */
let editing = false;
            function toggleEditProfile() {
                editing = !editing;
                for (let i = 1; i <= 9; i++) {
                    const el = document.getElementById('pf' + i);
                    if (el) el.disabled = !editing;
                }
                document.getElementById('profileSaveArea').style.display = editing ? '' : 'none';
                document.getElementById('editProfileBtn').style.display = editing ? 'none' : '';
            }
            function saveProfile() {
                alert('✅ Perfil actualizado correctamente.');
                toggleEditProfile();
            }

/* =========================================
   FILE: paciente/resultados.html
   ========================================= */
(function() {
    if (!document.getElementById('skeletonBody')) return;
    /* ===== HU13: Vue ref para estado de carga ===== */
    const { ref, watch } = Vue;
    const isLoading = ref(true);

    /* Cuando isLoading pase a false → oculta skeleton, revela filas con stagger */
    watch(isLoading, function(loading) {
        if (!loading) {
            document.getElementById('skeletonBody').style.display = 'none';
            var tbody = document.getElementById('resultBody');
            tbody.style.display = '';

            /* Staggered fade-in: cada fila aparece 80ms después de la anterior */
            var rows = tbody.querySelectorAll('.result-row');
            rows.forEach(function(row, i) {
                setTimeout(function() {
                    row.classList.add('visible');
                }, 80 * i);
            });
        }
    });

    /* Simula carga desde BD — en producción esto sería un fetch() */
    setTimeout(function() {
        isLoading.value = false;
    }, 1200); /* < 2s cumple RNF de respuesta */

    /* ===== Filtro por tipo ===== */
    window.filterResultados = function() {
        var tipo = document.getElementById('filterTipo').value;
        document.querySelectorAll('#resultBody [data-tipo]').forEach(function(row) {
            row.style.display = (!tipo || row.dataset.tipo === tipo) ? '' : 'none';
        });
    };
})();

/* =========================================
   FILE: publico/registro.html
   ========================================= */
document.addEventListener('DOMContentLoaded', function() {
        let currentStep = 1;
        const totalSteps = 3;

        function updateStepper() {
            for (let i = 1; i <= totalSteps; i++) {
                const circle = document.getElementById('stepCircle' + i);
                const wrapper = document.getElementById('stepWrapper' + i);
                const panel = document.getElementById('stepPanel' + i);

                if (!circle) continue;

                if (i < currentStep) {
                    circle.className = 'stepper-circle completed';
                    circle.innerHTML = '<i class="bi bi-check-lg"></i>';
                    if (wrapper) { wrapper.classList.remove('text-white-50'); wrapper.classList.add('text-white'); }
                } else if (i === currentStep) {
                    circle.className = 'stepper-circle bg-white text-primary';
                    circle.textContent = i;
                    if (wrapper) { wrapper.classList.remove('text-white-50'); wrapper.classList.add('text-white'); }
                } else {
                    circle.className = 'stepper-circle border border-white';
                    circle.textContent = i;
                    if (wrapper) { wrapper.classList.add('text-white-50'); wrapper.classList.remove('text-white'); }
                }

                if (panel) panel.style.display = (i === currentStep) ? '' : 'none';
            }
        }

        function goNext(e) {
            e.preventDefault();
            
            // Populating step 3 confirmation panel
            if (currentStep === 2) {
                const nombre = document.getElementById('nombreCompleto')?.value;
                const correo = document.getElementById('correo')?.value;
                
                const step3Panel = document.getElementById('stepPanel3');
                if (step3Panel) {
                    const fwBolds = step3Panel.querySelectorAll('.fw-bold');
                    if (fwBolds.length >= 3) {
                        fwBolds[1].textContent = nombre || 'Pendiente';
                        fwBolds[2].textContent = correo || 'Pendiente';
                    }
                }
            }

            if (currentStep < totalSteps) {
                currentStep++;
                updateStepper();
            }
        }

        function goBack(e) {
            e.preventDefault();
            if (currentStep > 1) {
                currentStep--;
                updateStepper();
            }
        }

        async function finish(e) {
            e.preventDefault();
            
            const termsCheck = document.getElementById('termsCheck');
            if (termsCheck && !termsCheck.checked) {
                alert('Debes aceptar los términos y condiciones para registrarte.');
                return;
            }

            const payload = {
                dni: document.getElementById('numDoc')?.value,
                nombreCompleto: document.getElementById('nombreCompleto')?.value,
                correo: document.getElementById('correo')?.value,
                telefono: document.getElementById('telefono')?.value,
                password: document.getElementById('password')?.value
            };

            try {
                const finishBtn = document.getElementById('stepperFinish');
                if(finishBtn) {
                    finishBtn.disabled = true;
                    finishBtn.textContent = 'Procesando...';
                }

                const response = await fetch('/api/registro', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(payload)
                });
                const data = await response.json();

                if (response.ok && data.exitoso) {
                    const formArea = document.getElementById('registerFormArea');
                    if (formArea) {
                        formArea.innerHTML = '<div class="text-center py-4">' +
                            '<div class="mb-4"><div class="d-inline-flex align-items-center justify-content-center rounded-circle" style="width:80px;height:80px;background:linear-gradient(135deg,#06D6A0,#34D399);"><i class="bi bi-check-lg text-white" style="font-size:2.5rem;"></i></div></div>' +
                            '<h3 class="fw-bold mb-2">¡Registro completado!</h3>' +
                            '<p class="text-muted mb-4">Tu cuenta ha sido creada exitosamente.<br>Ya puedes iniciar sesión.</p>' +
                            '<a href="/login" class="btn btn-primary rounded-pill px-5 py-2 fw-bold shadow">Iniciar Sesión</a>' +
                            '</div>';

                        // Update stepper to completed
                        for (let i = 1; i <= totalSteps; i++) {
                            const circle = document.getElementById('stepCircle' + i);
                            const wrapper = document.getElementById('stepWrapper' + i);
                            if (circle) { circle.className = 'stepper-circle completed'; circle.innerHTML = '<i class="bi bi-check-lg"></i>'; }
                            if (wrapper) { wrapper.classList.remove('text-white-50'); wrapper.classList.add('text-white'); }
                        }
                    }
                } else {
                    alert('❌ Error: ' + (data.mensaje || 'No se pudo registrar la cuenta.'));
                    if(finishBtn) {
                        finishBtn.disabled = false;
                        finishBtn.textContent = 'Finalizar Registro';
                    }
                }
            } catch (error) {
                alert('❌ Error de red al registrar la cuenta.');
                const finishBtn = document.getElementById('stepperFinish');
                if(finishBtn) {
                    finishBtn.disabled = false;
                    finishBtn.textContent = 'Finalizar Registro';
                }
            }
        }

        // Bind buttons
        const next1 = document.getElementById('stepperNext');
        const next2 = document.getElementById('stepperNext2');
        const back1 = document.getElementById('stepperBack');
        const back2 = document.getElementById('stepperBack2');
        const finishBtn = document.getElementById('stepperFinish');

        if (next1) {
            next1.addEventListener('click', function(e) {
                e.preventDefault();
                if (currentStep < totalSteps) {
                    currentStep++;
                    updateStepper();
                }
            });
        }
        if (next2) next2.addEventListener('click', goNext);
        if (back1) back1.addEventListener('click', goBack);
        if (back2) back2.addEventListener('click', goBack);
        if (finishBtn) finishBtn.addEventListener('click', finish);
    });

/* =========================================
   FILE: publico/servicios.html
   ========================================= */
window.selectServiceTab = function(btn, category) {
            /* Actualizar diseño de botones */
            document.querySelectorAll('#serviceTabs button').forEach(function(b) {
                b.classList.remove('btn-dark', 'fw-bold');
                b.classList.add('btn-outline-secondary');
            });
            btn.classList.remove('btn-outline-secondary');
            btn.classList.add('btn-dark', 'fw-bold');
            
            /* Filtrar las tarjetas directamente */
            var cards = document.querySelectorAll('.service-card-wrap');
            cards.forEach(function(card) {
                var show = (category === 'all' || card.dataset.serviceCategory === category);
                card.style.display = show ? '' : 'none';
                
                /* Pequeña animación de entrada si se muestra */
                if (show) {
                    card.style.opacity = '0';
                    card.style.transform = 'translateY(10px)';
                    card.style.transition = 'all 0.3s ease';
                    setTimeout(function() { 
                        card.style.opacity = '1'; 
                        card.style.transform = 'translateY(0)'; 
                    }, 50);
                }
            });
        };

/* =========================================
   FUNCIONES POWER BI - Dashboard
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

/* =========================================
   FILE: layout-recepcionista.html
   ========================================= */
(function() {
    const { ref, watch } = Vue || { ref: (v) => ({value: v}), watch: () => {} };

    if (!document.querySelector('.rc-sidebar')) return;
    
    /* --- SIDEBAR TOGGLE --- */
    const sidebarOpen = ref(false);

    const sidebar = document.getElementById('sidebar');
    const overlay = document.getElementById('sidebarOverlay');
    const toggle = document.getElementById('sidebarToggle');

    if (toggle && sidebar && overlay) {
        watch(sidebarOpen, function(val) {
            if (window.innerWidth < 992) {
                // Mobile behavior: Drawer
                sidebar.classList.toggle('show', val);
                overlay.classList.toggle('show', val);
                document.body.classList.remove('sidebar-collapsed');
            } else {
                // Desktop behavior: Collapse
                document.body.classList.toggle('sidebar-collapsed', !val);
                sidebar.classList.remove('show');
                overlay.classList.remove('show');
            }
        });

        // Sync initial state on desktop
        if (window.innerWidth >= 992) {
            sidebarOpen.value = !document.body.classList.contains('sidebar-collapsed');
        }

        toggle.addEventListener('click', function() {
            sidebarOpen.value = !sidebarOpen.value;
        });

        overlay.addEventListener('click', function() {
            sidebarOpen.value = false;
        });

        // Handle window resize
        window.addEventListener('resize', function() {
            if (window.innerWidth >= 992) {
                sidebar.classList.remove('show');
                overlay.classList.remove('show');
            } else {
                document.body.classList.remove('sidebar-collapsed');
            }
        });
    }

    /* --- ACTIVE PAGE & TITLE --- */
    var path = window.location.pathname;
    var titles = {
        inicio: 'Panel de Recepción',
        citas: 'Agenda de Consultas',
        triaje: 'Registro de Triaje',
        pacientes: 'Directorio de Pacientes',
        medicos: 'Cuerpo Médico',
        pagos: 'Facturación y Pagos',
        perfil: 'Mi Perfil Profesional'
    };
    
    var activePage = Object.keys(titles).find(function(p) {
        return path.includes('/recepcionista/' + p);
    }) || 'inicio';

    document.querySelectorAll('[data-page]').forEach(function(link) {
        if (link.dataset.page === activePage) link.classList.add('active');
        else link.classList.remove('active');
    });

})();

