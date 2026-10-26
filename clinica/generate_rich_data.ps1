$connString = "Server=localhost\SQLEXPRESS;Database=bd_clinica;Integrated Security=True;Encrypt=True;TrustServerCertificate=True;"
$connection = New-Object System.Data.SqlClient.SqlConnection($connString)

try {
    $connection.Open()
    Write-Host "Conectado a la base de datos."

    # 1. Limpiar todas las tablas transaccionales para regenerar un set de datos grande y consistente
    Write-Host "Limpiando tablas de transacciones..."
    $clearQuery = @"
    DELETE FROM pagos;
    DELETE FROM medicamentos_prescritos;
    DELETE FROM recetas;
    DELETE FROM feedback_paciente;
    DELETE FROM historial_clinico;
    DELETE FROM triaje;
    DELETE FROM citas;
"@
    $clearCmd = New-Object System.Data.SqlClient.SqlCommand($clearQuery, $connection)
    $clearCmd.ExecuteNonQuery() | Out-Null
    Write-Host "Tablas transaccionales limpiadas."

    # 2. Obtener Médicos y Pacientes existentes
    $medicosCmd = New-Object System.Data.SqlClient.SqlCommand("SELECT id_medico, id_especialidad, nombres, apellidos FROM medicos", $connection)
    $medAdapter = New-Object System.Data.SqlClient.SqlDataAdapter($medicosCmd)
    $dtMedicos = New-Object System.Data.DataTable
    $medAdapter.Fill($dtMedicos) | Out-Null

    $pacientesCmd = New-Object System.Data.SqlClient.SqlCommand("SELECT id_paciente FROM pacientes", $connection)
    $pacAdapter = New-Object System.Data.SqlClient.SqlDataAdapter($pacientesCmd)
    $dtPacientes = New-Object System.Data.DataTable
    $pacAdapter.Fill($dtPacientes) | Out-Null

    $diagCmd = New-Object System.Data.SqlClient.SqlCommand("SELECT id_diagnostico, codigo, nombre, categoria FROM codigos_diagnostico", $connection)
    $diagAdapter = New-Object System.Data.SqlClient.SqlDataAdapter($diagCmd)
    $dtDiags = New-Object System.Data.DataTable
    $diagAdapter.Fill($dtDiags) | Out-Null

    $rand = New-Object System.Random

    # Lista de motivos de cita
    $motivos = @("Chequeo general", "Dolor de cabeza recurrente", "Fiebre y tos", "Control de presión arterial", "Control de diabetes", "Dolor de espalda", "Revisión de resultados", "Cansancio extremo", "Infección respiratoria")

    Write-Host "Generando 250 citas simuladas desde Marzo 2026 hasta Julio 2026..."

    for ($i = 1; $i -le 250; $i++) {
        # Seleccionar paciente y médico al azar
        $paciente = $dtPacientes.Rows[$rand.Next(0, $dtPacientes.Rows.Count)]
        $medico = $dtMedicos.Rows[$rand.Next(0, $dtMedicos.Rows.Count)]
        
        $idPaciente = $paciente.id_paciente
        $idMedico = $medico.id_medico
        $idEspecialidad = $medico.id_especialidad

        # Generar fecha entre el 1 de Marzo y el 9 de Julio de 2026
        $diasAtras = $rand.Next(0, 131) # 130 días atrás
        $fechaCita = (Get-Date "2026-07-09").AddDays(-$diasAtras)

        # Generar hora de cita entre 8:00 AM y 5:00 PM (horas enteras o medias horas)
        $horaInt = $rand.Next(8, 18) # 8 a 17
        $minutosInt = $rand.Next(0, 2) * 30 # 0 o 30
        
        $horaFormateada = "{0:D2}:{1:D2}" -f $horaInt, $minutosInt
        $timeSpan = [TimeSpan]::New($horaInt, $minutosInt, 0)
        $fechaHoraProgramada = [DateTime]::new($fechaCita.Year, $fechaCita.Month, $fechaCita.Day).Add($timeSpan)

        # Motivo al azar
        $motivo = $motivos[$rand.Next(0, $motivos.Count)]

        # Registrar cita en la base de datos
        $insCitaQuery = @"
        INSERT INTO citas (fecha_cita, motivo, estado, id_paciente, id_medico, id_servicio, fecha_registro, FechaKey_Cita, FechaKey_Registro, hora_cita)
        VALUES (@fecha_cita, @motivo, 'Completada', @id_paciente, @id_medico, 1, @fecha_reg, @key_cita, @key_reg, @hora_cita);
        SELECT SCOPE_IDENTITY();
"@
        $insCitaCmd = New-Object System.Data.SqlClient.SqlCommand($insCitaQuery, $connection)
        $insCitaCmd.Parameters.AddWithValue("@fecha_cita", $fechaCita.ToString("yyyy-MM-dd")) | Out-Null
        $insCitaCmd.Parameters.AddWithValue("@hora_cita", $horaFormateada) | Out-Null
        $insCitaCmd.Parameters.AddWithValue("@motivo", $motivo) | Out-Null
        $insCitaCmd.Parameters.AddWithValue("@id_paciente", $idPaciente) | Out-Null
        $insCitaCmd.Parameters.AddWithValue("@id_medico", $idMedico) | Out-Null
        $insCitaCmd.Parameters.AddWithValue("@fecha_reg", $fechaHoraProgramada.AddDays(-2)) | Out-Null # Registro 2 días antes
        $insCitaCmd.Parameters.AddWithValue("@key_cita", [int]$fechaCita.ToString("yyyyMMdd")) | Out-Null
        $insCitaCmd.Parameters.AddWithValue("@key_reg", [int]$fechaCita.AddDays(-2).ToString("yyyyMMdd")) | Out-Null
        
        $idCita = $insCitaCmd.ExecuteScalar()

        # Determinar retrasos para triaje y consulta (manteniendo las reglas de picos de hora)
        # Horas pico (11am a 1pm, y 4pm a 6pm) tienen más demora
        $esHoraPico = ($horaInt -ge 11 -and $horaInt -le 13) -or ($horaInt -ge 16 -and $horaInt -le 18)
        
        $minutosAntes = $rand.Next(10, 26) # Llega entre 10 y 25 mins antes de su cita
        $fechaHoraLlegada = $fechaHoraProgramada.AddMinutes(-$minutosAntes)

        $minutosEsperaTotal = 0
        # Cardiología tiene más demora que otras especialidades
        if ($idEspecialidad -eq 1) { 
            # Cardiología
            if ($esHoraPico) {
                $minutosEsperaTotal = $rand.Next(35, 55)
            } else {
                $minutosEsperaTotal = $rand.Next(20, 40)
            }
        } else {
            # Medicina General u otras
            if ($esHoraPico) {
                $minutosEsperaTotal = $rand.Next(25, 45)
            } else {
                $minutosEsperaTotal = $rand.Next(10, 30)
            }
        }
        $fechaHoraAtencion = $fechaHoraLlegada.AddMinutes($minutosEsperaTotal)

        # A. Registrar TRIAJE
        $peso = [math]::Round($rand.NextDouble() * 35 + 55, 1)
        $talla = [math]::Round($rand.NextDouble() * 0.25 + 1.55, 2)
        $temp = [math]::Round($rand.NextDouble() * 1.5 + 36.3, 1)
        $frec = $rand.Next(70, 95)
        $sat = $rand.Next(96, 100)

        $insTriaje = @"
        INSERT INTO triaje (id_cita, peso, talla, presion_arterial, temperatura, frecuencia_cardiaca, saturacion_oxigeno, fecha_registro, FechaKey_Registro)
        VALUES (@id_cita, @peso, @talla, '120/80', @temp, @frec, @sat, @fecha_reg, @fecha_key)
"@
        $triajeCmd = New-Object System.Data.SqlClient.SqlCommand($insTriaje, $connection)
        $triajeCmd.Parameters.AddWithValue("@id_cita", $idCita) | Out-Null
        $triajeCmd.Parameters.AddWithValue("@peso", $peso) | Out-Null
        $triajeCmd.Parameters.AddWithValue("@talla", $talla) | Out-Null
        $triajeCmd.Parameters.AddWithValue("@temp", $temp) | Out-Null
        $triajeCmd.Parameters.AddWithValue("@frec", $frec) | Out-Null
        $triajeCmd.Parameters.AddWithValue("@sat", $sat) | Out-Null
        $triajeCmd.Parameters.AddWithValue("@fecha_reg", $fechaHoraLlegada) | Out-Null
        $triajeCmd.Parameters.AddWithValue("@fecha_key", [int]$fechaHoraLlegada.ToString("yyyyMMdd")) | Out-Null
        $triajeCmd.ExecuteNonQuery() | Out-Null

        # B. Registrar HISTORIAL CLINICO (Diagnósticos e infecciones IAAS)
        # Seleccionar diagnóstico. Daremos una probabilidad de alrededor del 4% a las infecciones IAAS
        $probIAAS = $rand.Next(1, 101)
        $diagFila = $null
        
        if ($probIAAS -le 12) { # 12% de probabilidad de tener IAAS
            # Filtrar solo diagnósticos IAAS
            $diagsIAAS = $dtDiags.Rows | Where-Object { $_.categoria -eq "IAAS" }
            $diagFila = $diagsIAAS[$rand.Next(0, $diagsIAAS.Count)]
        } else {
            # Diagnósticos normales
            $diagsNormales = $dtDiags.Rows | Where-Object { $_.categoria -ne "IAAS" }
            $diagFila = $diagsNormales[$rand.Next(0, $diagsNormales.Count)]
        }

        # Evitar nulos
        if ($null -eq $diagFila) {
            $diagFila = $dtDiags.Rows[0]
        }

        $nombreDiag = $diagFila.nombre
        $codigoDiag = $diagFila.codigo

        $insHistorial = @"
        INSERT INTO historial_clinico (id_paciente, id_cita, fecha_registro, diagnostico, tratamiento, observaciones, FechaKey_Registro)
        VALUES (@id_paciente, @id_cita, @fecha_reg, @diag, 'Indicaciones médicas en receta.', 'Control según evolución.', @fecha_key)
"@
        $historialCmd = New-Object System.Data.SqlClient.SqlCommand($insHistorial, $connection)
        $historialCmd.Parameters.AddWithValue("@id_paciente", $idPaciente) | Out-Null
        $historialCmd.Parameters.AddWithValue("@id_cita", $idCita) | Out-Null
        $historialCmd.Parameters.AddWithValue("@fecha_reg", $fechaHoraAtencion) | Out-Null
        $historialCmd.Parameters.AddWithValue("@diag", "$codigoDiag - $nombreDiag") | Out-Null
        $historialCmd.Parameters.AddWithValue("@fecha_key", [int]$fechaHoraAtencion.ToString("yyyyMMdd")) | Out-Null
        $historialCmd.ExecuteNonQuery() | Out-Null

        # C. Registrar FEEDBACK PACIENTE
        # Puntuación basada en el tiempo real de espera en sala
        $puntuacion = 5
        if ($minutosEsperaTotal -gt 40) {
            $puntuacion = $rand.Next(1, 3) # Detractor (1 o 2)
            $comentario = "Esperé demasiado tiempo para la atención, la sala estaba muy llena."
        } elseif ($minutosEsperaTotal -gt 25) {
            $puntuacion = $rand.Next(3, 5) # Neutral (3 o 4)
            $comentario = "La consulta estuvo excelente, pero hubo demora en el ingreso."
        } else {
            $puntuacion = 5 # Promotor (5)
            $comentario = "Atención excelente, muy puntual y rápida."
        }

        $fechaHoraFeedback = $fechaHoraAtencion.AddHours($rand.Next(1, 4))
        $insFeedback = @"
        INSERT INTO feedback_paciente (id_cita, puntuacion, comentario, fecha_envio)
        VALUES (@id_cita, @puntuacion, @comentario, @fecha_envio)
"@
        $feedbackCmd = New-Object System.Data.SqlClient.SqlCommand($insFeedback, $connection)
        $feedbackCmd.Parameters.AddWithValue("@id_cita", $idCita) | Out-Null
        $feedbackCmd.Parameters.AddWithValue("@puntuacion", $puntuacion) | Out-Null
        $feedbackCmd.Parameters.AddWithValue("@comentario", $comentario) | Out-Null
        $feedbackCmd.Parameters.AddWithValue("@fecha_envio", $fechaHoraFeedback) | Out-Null
        $feedbackCmd.ExecuteNonQuery() | Out-Null
    }

    Write-Host "¡Base de datos cargada con 250 registros realistas e históricos con éxito!"

} catch {
    Write-Error $_.Exception.Message
} finally {
    if ($connection.State -eq "Open") {
        $connection.Close()
    }
}
