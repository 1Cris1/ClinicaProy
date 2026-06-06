INSERT INTO citas (fecha_cita, hora_cita, motivo, estado, id_paciente, id_medico, fecha_registro) 
SELECT TOP 1 CAST(GETDATE() AS DATE), '10:00:00', 'Chequeo de rutina', 'Pendiente', p.id_paciente, m.id_medico, GETDATE() 
FROM pacientes p, medicos m 
WHERE p.dni = '75695332' AND m.dni = '75536222';
