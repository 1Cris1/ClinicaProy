-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;
-- bd_clinica.dbo.catalogo_examenes definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.catalogo_examenes;

CREATE TABLE bd_clinica.dbo.catalogo_examenes (
	id_examen int IDENTITY(1,1) NOT NULL,
	categoria varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	nombre varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	precio numeric(10,2) NOT NULL,
	rango_max numeric(10,2) NULL,
	rango_min numeric(10,2) NULL,
	unidad_medida varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__catalogo__D16A231D9ED80379 PRIMARY KEY (id_examen)
);


-- bd_clinica.dbo.configuracion definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.configuracion;

CREATE TABLE bd_clinica.dbo.configuracion (
	id_config int IDENTITY(1,1) NOT NULL,
	direccion varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	email_contacto varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	horario_atencion varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	logo_url varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	nombre_clinica varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ruc varchar(11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	telefono varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__configur__8F0A1FB24169EB0F PRIMARY KEY (id_config)
);


-- bd_clinica.dbo.digemid_observatorio definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.digemid_observatorio;

CREATE TABLE bd_clinica.dbo.digemid_observatorio (
	id_medicamento int NOT NULL,
	concentracion varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	forma_farmaceutica varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	nombre_producto varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	presentacion varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	registro_sanitario varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__digemid___2588C032881B770C PRIMARY KEY (id_medicamento)
);


-- bd_clinica.dbo.especialidades definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.especialidades;

CREATE TABLE bd_clinica.dbo.especialidades (
	id_especialidad int IDENTITY(1,1) NOT NULL,
	color varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	descripcion text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	estado bit NULL,
	icono varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	imagen_url varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	nombre varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__especial__C1D1376373EDD2CC PRIMARY KEY (id_especialidad)
);


-- bd_clinica.dbo.farmacia_tedef definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.farmacia_tedef;

CREATE TABLE bd_clinica.dbo.farmacia_tedef (
	id int IDENTITY(1,1) NOT NULL,
	dfecrecep_pq datetime2 NULL,
	ubigeo varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	vcodcatalogo_far_003 varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	vcodcatalogo_far_020 varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	vcodiafas_fac varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	vcodigemid_far_020 varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	vcodipress_fac varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	vcodprod_far_003 varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	vcodprod_far_020 varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	vcopagoprodfar_far numeric(38,2) NULL,
	vcorrpresta_ate int NULL,
	vcorrprodfarate_far int NULL,
	vdiagasocprodfar_far varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	vmontncubfar_far numeric(38,2) NULL,
	vmontprodfar_far numeric(38,2) NULL,
	vmontunisimp_far numeric(38,2) NULL,
	vndocpago_fac varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	vnunmventprod_far numeric(38,2) NULL,
	vprodexenigv_far varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	vtdocpago_fac varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	vtprod_far_003 varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	vtunidisp_far int NULL,
	CONSTRAINT PK__farmacia__3213E83F43C479AE PRIMARY KEY (id)
);


-- bd_clinica.dbo.productos definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.productos;

CREATE TABLE bd_clinica.dbo.productos (
	id_producto int IDENTITY(1,1) NOT NULL,
	categoria varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	descripcion text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	estado varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	imagen_url varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	nombre varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	precio numeric(10,2) NOT NULL,
	precio_descuento numeric(10,2) NULL,
	stock int NOT NULL,
	CONSTRAINT PK__producto__FF341C0D1D4D43E8 PRIMARY KEY (id_producto)
);


-- bd_clinica.dbo.promociones definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.promociones;

CREATE TABLE bd_clinica.dbo.promociones (
	id_promocion int IDENTITY(1,1) NOT NULL,
	descripcion text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	descuento_porcentaje numeric(5,2) NULL,
	estado varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	fecha_fin date NULL,
	fecha_inicio date NULL,
	imagen_url varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	titulo varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__promocio__F89308E078457439 PRIMARY KEY (id_promocion)
);


-- bd_clinica.dbo.sedes definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.sedes;

CREATE TABLE bd_clinica.dbo.sedes (
	id_sede int IDENTITY(1,1) NOT NULL,
	ciudad varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	direccion varchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	distrito varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	email varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	estado varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	horario_domingo varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	horario_lv varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	horario_sabado varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	nombre varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	num_consultorios int NULL,
	telefono varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__sedes__D693504B1F9F2EE8 PRIMARY KEY (id_sede)
);


-- bd_clinica.dbo.usuarios definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.usuarios;

CREATE TABLE bd_clinica.dbo.usuarios (
	id_usuario int IDENTITY(1,1) NOT NULL,
	email varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	estado int NULL,
	estado_registro varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	fecha_actualizacion datetime2 NULL,
	fecha_creacion datetime2 NULL,
	id_rol int NOT NULL,
	password varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ultimo_acceso datetime2 NULL,
	username varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__usuarios__4E3E04AD0E4B4029 PRIMARY KEY (id_usuario)
);
ALTER TABLE bd_clinica.dbo.usuarios WITH NOCHECK ADD CONSTRAINT CK__usuarios__estado__6754599E CHECK (([estado_registro]='VALIDADO_CLINICA' OR [estado_registro]='VERIFICADO_WEB' OR [estado_registro]='PENDIENTE'));


-- bd_clinica.dbo.administradores definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.administradores;

CREATE TABLE bd_clinica.dbo.administradores (
	id_admin int IDENTITY(1,1) NOT NULL,
	apellidos varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	cargo varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	nombres varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	telefono varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	id_usuario int NULL,
	CONSTRAINT PK__administ__89472E950B193AFB PRIMARY KEY (id_admin),
	CONSTRAINT FK28dj1ai3f8gnqhjuns8dnamrp FOREIGN KEY (id_usuario) REFERENCES bd_clinica.dbo.usuarios(id_usuario)
);
 CREATE UNIQUE NONCLUSTERED INDEX UKili2w8lisc96c9d1mxjqfr3hy ON bd_clinica.dbo.administradores (  id_usuario ASC  )  
	 WHERE  ([id_usuario] IS NOT NULL)
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- bd_clinica.dbo.codigos_verificacion definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.codigos_verificacion;

CREATE TABLE bd_clinica.dbo.codigos_verificacion (
	id_codigo int IDENTITY(1,1) NOT NULL,
	id_usuario int NOT NULL,
	codigo varchar(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	fecha_generacion datetime2 NOT NULL,
	fecha_expiracion datetime2 NOT NULL,
	usado bit DEFAULT 0 NOT NULL,
	CONSTRAINT PK__codigos___F32CBC52011CF311 PRIMARY KEY (id_codigo),
	CONSTRAINT FK_codigos_usuario FOREIGN KEY (id_usuario) REFERENCES bd_clinica.dbo.usuarios(id_usuario)
);


-- bd_clinica.dbo.medicos definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.medicos;

CREATE TABLE bd_clinica.dbo.medicos (
	id_medico int IDENTITY(1,1) NOT NULL,
	anio_ingreso int NULL,
	apellidos varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	cmp varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	consultorio varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dni varchar(8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	duracion_cita int NULL,
	email varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	estado varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	foto_url varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	horario_lv varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	horario_sabado varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	nombres varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	satisfaccion float NULL,
	telefono varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	id_especialidad int NOT NULL,
	id_sede int NOT NULL,
	id_usuario int NULL,
	sexo varchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__medicos__E038EB43D83EC594 PRIMARY KEY (id_medico),
	CONSTRAINT UK2yosdd43vtocveswoh9jauktn UNIQUE (cmp),
	CONSTRAINT UKs6hkfx3ekk3ydeddlrtliim3 UNIQUE (dni),
	CONSTRAINT FK2nylr0i1cc447kekjgtxvd7he FOREIGN KEY (id_especialidad) REFERENCES bd_clinica.dbo.especialidades(id_especialidad),
	CONSTRAINT FKatn6f5du9s9drp4xrumfq758n FOREIGN KEY (id_sede) REFERENCES bd_clinica.dbo.sedes(id_sede),
	CONSTRAINT FKhei0g6fy15d5komevfsk1qepe FOREIGN KEY (id_usuario) REFERENCES bd_clinica.dbo.usuarios(id_usuario)
);
 CREATE UNIQUE NONCLUSTERED INDEX UKhjg0rokcxaikrg2o78ta08n4k ON bd_clinica.dbo.medicos (  id_usuario ASC  )  
	 WHERE  ([id_usuario] IS NOT NULL)
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- bd_clinica.dbo.pacientes definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.pacientes;

CREATE TABLE bd_clinica.dbo.pacientes (
	id_paciente int IDENTITY(1,1) NOT NULL,
	alergias text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	antecedente text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	apellidos varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	contacto_emergencia varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	direccion varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	distrito varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dni varchar(8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	email varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	enfermedades_cronicas text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	estado varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	estado_seguro varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	fecha_nacimiento date NULL,
	fecha_sincronizacion_seguro datetime2 NULL,
	nombre_iafas varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	nombres varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	seguro varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	sexo varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	telefono varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	telefono_emergencia varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	tipo_plan varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	tipo_sangre varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	id_sede int NULL,
	id_usuario int NULL,
	CONSTRAINT PK__paciente__2C2C72BBCAE63C27 PRIMARY KEY (id_paciente),
	CONSTRAINT UKhol387x0ourgruynyqewdhv37 UNIQUE (dni),
	CONSTRAINT FK1ttqhi685p1fcdtmdqk2tmibf FOREIGN KEY (id_sede) REFERENCES bd_clinica.dbo.sedes(id_sede),
	CONSTRAINT FK34je9ip2cpgvy3m4ove9lmmqk FOREIGN KEY (id_usuario) REFERENCES bd_clinica.dbo.usuarios(id_usuario)
);
 CREATE UNIQUE NONCLUSTERED INDEX UKsukacb4bsdvdccsqxuulbindo ON bd_clinica.dbo.pacientes (  id_usuario ASC  )  
	 WHERE  ([id_usuario] IS NOT NULL)
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- bd_clinica.dbo.pedidos definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.pedidos;

CREATE TABLE bd_clinica.dbo.pedidos (
	id_pedido int IDENTITY(1,1) NOT NULL,
	estado varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	fecha_pedido datetime2 NOT NULL,
	notas text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	total numeric(10,2) NOT NULL,
	id_paciente int NOT NULL,
	CONSTRAINT PK__pedidos__6FF01489B74CDA69 PRIMARY KEY (id_pedido),
	CONSTRAINT FK7vh1e470cxt7rfftxpuocw4pg FOREIGN KEY (id_paciente) REFERENCES bd_clinica.dbo.pacientes(id_paciente)
);


-- bd_clinica.dbo.recetas definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.recetas;

CREATE TABLE bd_clinica.dbo.recetas (
	id_receta int IDENTITY(1,1) NOT NULL,
	codigo varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	estado varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	fecha_emision date NOT NULL,
	id_medico int NOT NULL,
	id_paciente int NOT NULL,
	CONSTRAINT PK__recetas__11DB53ABBCB9A2F7 PRIMARY KEY (id_receta),
	CONSTRAINT UKk66bi2y38bujljmbd41kywfaf UNIQUE (codigo),
	CONSTRAINT FKpolqpy5hp3sbupx8fyl8saqvc FOREIGN KEY (id_medico) REFERENCES bd_clinica.dbo.medicos(id_medico),
	CONSTRAINT FKr3jlidi7wq4ieicy5v0terktl FOREIGN KEY (id_paciente) REFERENCES bd_clinica.dbo.pacientes(id_paciente)
);


-- bd_clinica.dbo.resultados_laboratorio definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.resultados_laboratorio;

CREATE TABLE bd_clinica.dbo.resultados_laboratorio (
	id_resultado int IDENTITY(1,1) NOT NULL,
	estado varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	fecha_examen date NULL,
	fecha_vencimiento date NULL,
	nombre_examen varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	orden varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	sede_laboratorio varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	tipo_examen varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	id_paciente int NOT NULL,
	CONSTRAINT PK__resultad__33A42B30BF801BB1 PRIMARY KEY (id_resultado),
	CONSTRAINT FKeex2l73shghwue0fadxiwqp9t FOREIGN KEY (id_paciente) REFERENCES bd_clinica.dbo.pacientes(id_paciente)
);


-- bd_clinica.dbo.servicios definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.servicios;

CREATE TABLE bd_clinica.dbo.servicios (
	id_servicio int IDENTITY(1,1) NOT NULL,
	descripcion text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	estado varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	nombre varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	precio numeric(10,2) NOT NULL,
	id_especialidad int NOT NULL,
	CONSTRAINT PK__servicio__6FD07FDC9953E8AA PRIMARY KEY (id_servicio),
	CONSTRAINT FKd8f0uudvtfj4yx1j83ktgve2b FOREIGN KEY (id_especialidad) REFERENCES bd_clinica.dbo.especialidades(id_especialidad)
);


-- bd_clinica.dbo.citas definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.citas;

CREATE TABLE bd_clinica.dbo.citas (
	id_cita int IDENTITY(1,1) NOT NULL,
	estado varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	fecha_cita date NOT NULL,
	fecha_registro datetime2 NULL,
	hora_cita varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	motivo varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	notas_medicas text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	id_medico int NOT NULL,
	id_paciente int NOT NULL,
	id_servicio int NOT NULL,
	CONSTRAINT PK__citas__6AEC3C09F3287EA8 PRIMARY KEY (id_cita),
	CONSTRAINT FKa6jbqxi4v5ij2jdlgrmwnt94o FOREIGN KEY (id_paciente) REFERENCES bd_clinica.dbo.pacientes(id_paciente),
	CONSTRAINT FKgkqud4y6clhys6560jdbv7o8x FOREIGN KEY (id_medico) REFERENCES bd_clinica.dbo.medicos(id_medico),
	CONSTRAINT FKki9gpfg4aaytghofi4n3h69qu FOREIGN KEY (id_servicio) REFERENCES bd_clinica.dbo.servicios(id_servicio)
);


-- bd_clinica.dbo.detalles_pedido definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.detalles_pedido;

CREATE TABLE bd_clinica.dbo.detalles_pedido (
	id_detalle int IDENTITY(1,1) NOT NULL,
	cantidad int NOT NULL,
	precio_unitario numeric(10,2) NOT NULL,
	subtotal numeric(10,2) NOT NULL,
	id_pedido int NOT NULL,
	id_producto int NOT NULL,
	CONSTRAINT PK__detalles__4F1332DEF526FF8F PRIMARY KEY (id_detalle),
	CONSTRAINT FKpswk4x0p0wk0myw3f7penop0q FOREIGN KEY (id_producto) REFERENCES bd_clinica.dbo.productos(id_producto),
	CONSTRAINT FKrvkloxugyfhcls33cvc1no8rm FOREIGN KEY (id_pedido) REFERENCES bd_clinica.dbo.pedidos(id_pedido)
);


-- bd_clinica.dbo.feedback_paciente definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.feedback_paciente;

CREATE TABLE bd_clinica.dbo.feedback_paciente (
	id_feedback int IDENTITY(1,1) NOT NULL,
	comentario text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	fecha_envio datetime2 NULL,
	puntuacion int NULL,
	id_cita int NOT NULL,
	CONSTRAINT PK__feedback__36BC863052CE5F63 PRIMARY KEY (id_feedback),
	CONSTRAINT UKtr5xonovcxnxqcvh62tmb8o7 UNIQUE (id_cita),
	CONSTRAINT FKs0s75k1ysvs90o46ak7580wc4 FOREIGN KEY (id_cita) REFERENCES bd_clinica.dbo.citas(id_cita)
);


-- bd_clinica.dbo.historial_clinico definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.historial_clinico;

CREATE TABLE bd_clinica.dbo.historial_clinico (
	id_historial int IDENTITY(1,1) NOT NULL,
	diagnostico text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	fecha_registro datetime2 NULL,
	observaciones varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	tratamiento varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	id_cita int NOT NULL,
	id_paciente int NOT NULL,
	CONSTRAINT PK__historia__76E6C5020C592730 PRIMARY KEY (id_historial),
	CONSTRAINT UKojuyt4yrdpt1vce62nr4tcsa4 UNIQUE (id_cita),
	CONSTRAINT FK28unvimp70tydia45akqd28ct FOREIGN KEY (id_cita) REFERENCES bd_clinica.dbo.citas(id_cita),
	CONSTRAINT FKa8o66akff4jgwb7v2w0j295cd FOREIGN KEY (id_paciente) REFERENCES bd_clinica.dbo.pacientes(id_paciente)
);


-- bd_clinica.dbo.medicamentos_prescritos definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.medicamentos_prescritos;

CREATE TABLE bd_clinica.dbo.medicamentos_prescritos (
	id_medicamento_prescrito int IDENTITY(1,1) NOT NULL,
	dosis varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	duracion varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	frecuencia varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	instrucciones varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	nombre varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	id_receta int NOT NULL,
	CONSTRAINT PK__medicame__287DC962E41E6B77 PRIMARY KEY (id_medicamento_prescrito),
	CONSTRAINT FKmr34kww2dofstu7fh23yun4b0 FOREIGN KEY (id_receta) REFERENCES bd_clinica.dbo.recetas(id_receta)
);


-- bd_clinica.dbo.notificaciones definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.notificaciones;

CREATE TABLE bd_clinica.dbo.notificaciones (
	id int IDENTITY(1,1) NOT NULL,
	fecha datetime2 NULL,
	icono varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	leida bit NOT NULL,
	mensaje varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	id_paciente int NOT NULL,
	CONSTRAINT PK__notifica__3213E83F5C4EA9BD PRIMARY KEY (id),
	CONSTRAINT FKrsmaiu8canesgrc1uln96ur46 FOREIGN KEY (id_paciente) REFERENCES bd_clinica.dbo.pacientes(id_paciente)
);


-- bd_clinica.dbo.ordenes_laboratorio definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.ordenes_laboratorio;

CREATE TABLE bd_clinica.dbo.ordenes_laboratorio (
	id_orden int IDENTITY(1,1) NOT NULL,
	estado varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	fecha_solicitud datetime2 NULL,
	observaciones_tecnicas text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	prioridad varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	id_medico int NOT NULL,
	id_paciente int NOT NULL,
	CONSTRAINT PK__ordenes___DD5B8F33EF6DC11E PRIMARY KEY (id_orden),
	CONSTRAINT FKopd6emtqbcsqj05tthoqu5whr FOREIGN KEY (id_paciente) REFERENCES bd_clinica.dbo.pacientes(id_paciente),
	CONSTRAINT FKr3ocmhsrxeogrkdq67l97e6a4 FOREIGN KEY (id_medico) REFERENCES bd_clinica.dbo.medicos(id_medico)
);


-- bd_clinica.dbo.pagos definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.pagos;

CREATE TABLE bd_clinica.dbo.pagos (
	id_pago int IDENTITY(1,1) NOT NULL,
	estado varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	fecha_pago datetime2 NULL,
	metodo_pago varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	monto numeric(10,2) NOT NULL,
	numero_comprobante varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	observaciones text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	tipo_comprobante varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	id_paciente int NULL,
	id_servicio int NULL,
	CONSTRAINT PK__pagos__0941B074711A6455 PRIMARY KEY (id_pago),
	CONSTRAINT FK14hbvb0jpr21t214auiyqh3sm FOREIGN KEY (id_paciente) REFERENCES bd_clinica.dbo.pacientes(id_paciente),
	CONSTRAINT FKsnp345nyw4xgsvvv7oo42d9gl FOREIGN KEY (id_servicio) REFERENCES bd_clinica.dbo.servicios(id_servicio)
);


-- bd_clinica.dbo.resultados_detalle definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.resultados_detalle;

CREATE TABLE bd_clinica.dbo.resultados_detalle (
	id_detalle int IDENTITY(1,1) NOT NULL,
	observaciones text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	unidad varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	valor numeric(10,2) NULL,
	id_examen int NOT NULL,
	id_orden int NOT NULL,
	CONSTRAINT PK__resultad__4F1332DEE203C11C PRIMARY KEY (id_detalle),
	CONSTRAINT FK32op9l23j35ag8q7m47oxqroi FOREIGN KEY (id_examen) REFERENCES bd_clinica.dbo.catalogo_examenes(id_examen),
	CONSTRAINT FKqxvbtwbh2rge52t6arwwulk9y FOREIGN KEY (id_orden) REFERENCES bd_clinica.dbo.ordenes_laboratorio(id_orden)
);


-- bd_clinica.dbo.triaje definition

-- Drop table

-- DROP TABLE bd_clinica.dbo.triaje;

CREATE TABLE bd_clinica.dbo.triaje (
	id_triaje int IDENTITY(1,1) NOT NULL,
	fecha_registro datetime2 NULL,
	frecuencia_cardiaca int NULL,
	peso numeric(5,2) NULL,
	presion_arterial varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	saturacion_oxigeno int NULL,
	talla numeric(3,2) NULL,
	temperatura numeric(4,2) NULL,
	id_cita int NOT NULL,
	CONSTRAINT PK__triaje__F2A884C82A6D4A98 PRIMARY KEY (id_triaje),
	CONSTRAINT UKm2qcjgdlbopfymkuf43mw4vc0 UNIQUE (id_cita),
	CONSTRAINT FKbpbf3oam9fwxfda2l5qkj5rtg FOREIGN KEY (id_cita) REFERENCES bd_clinica.dbo.citas(id_cita)
);

INSERT INTO bd_clinica.dbo.administradores (apellidos,cargo,nombres,telefono,id_usuario) VALUES
	 (N'General',N'Jefe de Sistemas',N'Administrador',NULL,NULL),
	 (N'General',N'Jefe de Sistemas',N'Administrador',NULL,NULL),
	 (N'Principal',N'Jefe de TI',N'Administrador',N'999999999',7);
INSERT INTO bd_clinica.dbo.catalogo_examenes (categoria,nombre,precio,rango_max,rango_min,unidad_medida) VALUES
	 (N'Bioquímica',N'Glucosa Basal',15.00,110.00,70.00,N'mg/dL'),
	 (N'Hematología',N'Hemoglobina',25.00,17.50,13.50,N'g/dL'),
	 (N'Perfil Lipídico',N'Colesterol Total',20.00,200.00,0.00,NULL);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Programada','2026-11-15','2026-07-15 05:31:44.6566667',N'10:00',N'Dolor',N'',14,96,3),
	 (N'Completada','2026-05-01','2026-07-15 05:31:44.6766667',N'08:00',N'Dolor',N'',6,63,5),
	 (N'Completada','2026-04-04','2026-07-15 05:31:44.6800000',N'08:00',N'Chequeo',N'',1,118,1),
	 (N'Completada','2026-02-15','2026-07-15 05:31:44.6866667',N'14:00',N'Seguimiento',N'',3,123,2),
	 (N'Programada','2026-09-19','2026-07-15 05:31:44.6933333',N'15:00',N'Consulta',N'',34,98,4),
	 (N'Cancelada','2026-02-25','2026-07-15 05:31:44.6966667',N'11:00',N'Consulta',N'',6,123,5),
	 (N'Completada','2026-04-26','2026-07-15 05:31:44.7033333',N'09:00',N'Seguimiento',N'',2,107,1),
	 (N'Completada','2026-02-27','2026-07-15 05:31:44.7066667',N'08:00',N'Dolor',N'',17,243,6),
	 (N'Completada','2026-03-24','2026-07-15 05:31:44.7133333',N'16:00',N'Control',N'',36,51,6),
	 (N'Completada','2026-02-16','2026-07-15 05:31:44.7166667',N'11:00',N'Chequeo',N'',15,14,4);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-01-01','2026-07-15 05:31:44.7200000',N'14:00',N'Seguimiento',N'',12,89,1),
	 (N'Completada','2026-06-06','2026-07-15 05:31:44.7266667',N'11:00',N'Control',N'',4,292,3),
	 (N'Completada','2026-05-19','2026-07-15 05:31:44.7300000',N'09:00',N'Chequeo',N'',45,236,15),
	 (N'Completada','2026-03-23','2026-07-15 05:31:44.7333333',N'15:00',N'Dolor',N'',1,84,1),
	 (N'Completada','2026-01-25','2026-07-15 05:31:44.7366667',N'15:00',N'Consulta',N'',7,207,6),
	 (N'Programada','2026-12-19','2026-07-15 05:31:44.7400000',N'09:00',N'Chequeo',N'',1,87,1),
	 (N'Completada','2026-06-01','2026-07-15 05:31:44.7433333',N'16:00',N'Dolor',N'',4,236,3),
	 (N'Completada','2026-01-08','2026-07-15 05:31:44.7466667',N'14:00',N'Consulta',N'',19,279,8),
	 (N'Completada','2026-05-11','2026-07-15 05:31:44.7500000',N'09:00',N'Evaluación',N'',38,277,8),
	 (N'Completada','2026-02-15','2026-07-15 05:31:44.7566667',N'14:00',N'Consulta',N'',31,177,14);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Programada','2026-10-15','2026-07-15 05:31:44.7600000',N'16:00',N'Seguimiento',N'',16,184,5),
	 (N'Completada','2026-04-05','2026-07-15 05:31:44.7633333',N'11:00',N'Consulta',N'',16,156,5),
	 (N'Completada','2026-03-04','2026-07-15 05:31:44.7700000',N'16:00',N'Control',N'',12,182,1),
	 (N'Completada','2026-01-04','2026-07-15 05:31:44.7733333',N'08:00',N'Dolor',N'',17,266,6),
	 (N'Completada','2026-02-06','2026-07-15 05:31:44.7766667',N'11:00',N'Dolor',N'',35,44,5),
	 (N'Completada','2026-02-15','2026-07-15 05:31:44.7833333',N'10:00',N'Seguimiento',N'',3,157,2),
	 (N'Completada','2026-01-11','2026-07-15 05:31:44.7866667',N'09:00',N'Dolor',N'',12,181,1),
	 (N'Completada','2026-05-14','2026-07-15 05:31:44.7900000',N'08:00',N'Consulta',N'',19,176,8),
	 (N'Completada','2026-02-27','2026-07-15 05:31:44.7933333',N'09:00',N'Control',N'',2,155,1),
	 (N'Programada','2026-11-15','2026-07-15 05:31:44.8000000',N'09:00',N'Chequeo',N'',42,234,14);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-01-08','2026-07-15 05:31:44.8166667',N'09:00',N'Consulta',N'',8,150,7),
	 (N'Completada','2026-03-17','2026-07-15 05:31:44.8200000',N'10:00',N'Control',N'',16,24,5),
	 (N'Completada','2026-06-13','2026-07-15 05:31:44.8266667',N'16:00',N'Chequeo',N'',4,248,3),
	 (N'Completada','2026-06-04','2026-07-15 05:31:44.8300000',N'15:00',N'Seguimiento',N'',9,188,8),
	 (N'Programada','2026-11-28','2026-07-15 05:31:44.8333333',N'08:00',N'Consulta',N'',16,248,5),
	 (N'Completada','2026-03-17','2026-07-15 05:31:44.8366667',N'11:00',N'Consulta',N'',37,11,7),
	 (N'Completada','2026-05-13','2026-07-15 05:31:44.8400000',N'15:00',N'Control',N'',33,182,3),
	 (N'Completada','2026-02-07','2026-07-15 05:31:44.8466667',N'10:00',N'Evaluación',N'',8,51,7),
	 (N'Completada','2026-03-28','2026-07-15 05:31:44.8500000',N'10:00',N'Consulta',N'',36,40,6),
	 (N'Programada','2026-10-11','2026-07-15 05:31:44.8533333',N'11:00',N'Chequeo',N'',14,297,3);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-06-05','2026-07-15 05:31:44.8600000',N'09:00',N'Consulta',N'',2,198,1),
	 (N'Completada','2026-04-24','2026-07-15 05:31:44.8633333',N'16:00',N'Dolor',N'',25,260,12),
	 (N'Completada','2026-03-31','2026-07-15 05:31:44.8666667',N'10:00',N'Dolor',N'',6,224,5),
	 (N'Completada','2026-06-16','2026-07-15 05:31:44.8733333',N'09:00',N'Control',N'',15,147,4),
	 (N'Programada','2026-10-18','2026-07-15 05:31:44.8766667',N'09:00',N'Chequeo',N'',2,231,1),
	 (N'Completada','2026-06-27','2026-07-15 05:31:44.8800000',N'15:00',N'Seguimiento',N'',34,269,4),
	 (N'Programada','2026-09-16','2026-07-15 05:31:44.8833333',N'10:00',N'Seguimiento',N'',38,195,8),
	 (N'Completada','2026-05-30','2026-07-15 05:31:44.8866667',N'14:00',N'Dolor',N'',3,289,2),
	 (N'Completada','2026-01-27','2026-07-15 05:31:44.8900000',N'16:00',N'Dolor',N'',2,263,1),
	 (N'Completada','2026-03-23','2026-07-15 05:31:44.8933333',N'11:00',N'Evaluación',N'',17,56,6);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-02-21','2026-07-15 05:31:44.8966667',N'08:00',N'Seguimiento',N'',34,272,4),
	 (N'Completada','2026-05-04','2026-07-15 05:31:44.9000000',N'09:00',N'Dolor',N'',21,260,10),
	 (N'Completada','2026-05-14','2026-07-15 05:31:44.9066667',N'08:00',N'Dolor',N'',38,122,8),
	 (N'Completada','2026-03-03','2026-07-15 05:31:44.9100000',N'11:00',N'Seguimiento',N'',9,222,8),
	 (N'Completada','2026-04-19','2026-07-15 05:31:44.9100000',N'15:00',N'Control',N'',5,238,4),
	 (N'Programada','2026-09-29','2026-07-15 05:31:44.9133333',N'14:00',N'Seguimiento',N'',25,142,12),
	 (N'Completada','2026-05-17','2026-07-15 05:31:44.9166667',N'10:00',N'Evaluación',N'',32,291,2),
	 (N'Completada','2026-06-23','2026-07-15 05:31:44.9200000',N'11:00',N'Chequeo',N'',5,31,4),
	 (N'Completada','2026-01-09','2026-07-15 05:31:44.9266667',N'16:00',N'Chequeo',N'',34,162,4),
	 (N'Completada','2026-02-26','2026-07-15 05:31:44.9300000',N'11:00',N'Control',N'',5,83,4);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-01-15','2026-07-15 05:31:44.9333333',N'10:00',N'Chequeo',N'',36,198,6),
	 (N'Completada','2026-06-27','2026-07-15 05:31:44.9333333',N'14:00',N'Consulta',N'',17,5,6),
	 (N'Completada','2026-04-28','2026-07-15 05:31:44.9366667',N'14:00',N'Consulta',N'',9,156,8),
	 (N'Programada','2026-12-30','2026-07-15 05:31:44.9400000',N'11:00',N'Control',N'',21,97,10),
	 (N'Completada','2026-01-12','2026-07-15 05:31:44.9433333',N'15:00',N'Seguimiento',N'',3,157,2),
	 (N'Cancelada','2026-03-30','2026-07-15 05:31:44.9466667',N'15:00',N'Control',N'',21,127,10),
	 (N'Completada','2026-02-28','2026-07-15 05:31:44.9500000',N'16:00',N'Chequeo',N'',6,278,5),
	 (N'Completada','2026-01-21','2026-07-15 05:31:44.9500000',N'11:00',N'Seguimiento',N'',17,281,6),
	 (N'Completada','2026-05-01','2026-07-15 05:31:44.9533333',N'15:00',N'Seguimiento',N'',2,104,1),
	 (N'Cancelada','2026-05-12','2026-07-15 05:31:44.9533333',N'14:00',N'Seguimiento',N'',15,107,4);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-01-30','2026-07-15 05:31:44.9600000',N'09:00',N'Evaluación',N'',16,42,5),
	 (N'Completada','2026-05-15','2026-07-15 05:31:44.9600000',N'16:00',N'Dolor',N'',20,199,9),
	 (N'Completada','2026-01-31','2026-07-15 05:31:44.9633333',N'10:00',N'Control',N'',1,10,1),
	 (N'Programada','2026-12-29','2026-07-15 05:31:44.9666667',N'14:00',N'Seguimiento',N'',10,81,9),
	 (N'Completada','2026-05-28','2026-07-15 05:31:44.9700000',N'15:00',N'Evaluación',N'',12,33,1),
	 (N'Programada','2026-11-10','2026-07-15 05:31:44.9733333',N'14:00',N'Evaluación',N'',15,152,4),
	 (N'Completada','2026-02-28','2026-07-15 05:31:44.9733333',N'09:00',N'Control',N'',39,57,9),
	 (N'Completada','2026-02-01','2026-07-15 05:31:44.9800000',N'09:00',N'Seguimiento',N'',12,195,1),
	 (N'Completada','2026-04-22','2026-07-15 05:31:44.9833333',N'09:00',N'Dolor',N'',18,241,7),
	 (N'Programada','2026-12-14','2026-07-15 05:31:44.9933333',N'10:00',N'Dolor',N'',35,262,5);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-01-19','2026-07-15 05:31:45.0033333',N'11:00',N'Evaluación',N'',21,144,10),
	 (N'Completada','2026-05-14','2026-07-15 05:31:45.0133333',N'11:00',N'Dolor',N'',1,122,1),
	 (N'Completada','2026-04-25','2026-07-15 05:31:45.0233333',N'14:00',N'Chequeo',N'',34,30,4),
	 (N'Programada','2026-09-30','2026-07-15 05:31:45.0333333',N'09:00',N'Chequeo',N'',4,286,3),
	 (N'Completada','2026-06-12','2026-07-15 05:31:45.0433333',N'08:00',N'Seguimiento',N'',2,211,1),
	 (N'Completada','2026-05-26','2026-07-15 05:31:45.0500000',N'15:00',N'Dolor',N'',33,225,3),
	 (N'Completada','2026-01-25','2026-07-15 05:31:45.0600000',N'15:00',N'Chequeo',N'',35,169,5),
	 (N'Completada','2026-06-08','2026-07-15 05:31:45.0666667',N'15:00',N'Seguimiento',N'',16,195,5),
	 (N'Cancelada','2026-01-08','2026-07-15 05:31:45.0733333',N'09:00',N'Dolor',N'',12,255,1),
	 (N'Completada','2026-04-05','2026-07-15 05:31:45.0800000',N'14:00',N'Control',N'',3,254,2);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Programada','2026-10-13','2026-07-15 05:31:45.0866667',N'10:00',N'Consulta',N'',34,138,4),
	 (N'Completada','2026-03-03','2026-07-15 05:31:45.0900000',N'09:00',N'Seguimiento',N'',4,234,3),
	 (N'Completada','2026-01-15','2026-07-15 05:31:45.0966667',N'10:00',N'Evaluación',N'',34,20,4),
	 (N'Completada','2026-02-16','2026-07-15 05:31:45.1000000',N'08:00',N'Chequeo',N'',13,242,2),
	 (N'Completada','2026-05-28','2026-07-15 05:31:45.1066667',N'11:00',N'Dolor',N'',35,188,5),
	 (N'Completada','2026-02-17','2026-07-15 05:31:45.1133333',N'08:00',N'Evaluación',N'',5,264,4),
	 (N'Completada','2026-02-10','2026-07-15 05:31:45.1200000',N'09:00',N'Control',N'',12,177,1),
	 (N'Completada','2026-05-27','2026-07-15 05:31:45.1200000',N'15:00',N'Evaluación',N'',19,48,8),
	 (N'Completada','2026-02-17','2026-07-15 05:31:45.1266667',N'09:00',N'Chequeo',N'',3,196,2),
	 (N'Completada','2026-04-01','2026-07-15 05:31:45.1300000',N'09:00',N'Control',N'',2,108,1);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-04-04','2026-07-15 05:31:45.1333333',N'16:00',N'Evaluación',N'',15,63,4),
	 (N'Completada','2026-05-19','2026-07-15 05:31:45.1333333',N'15:00',N'Seguimiento',N'',3,63,2),
	 (N'Completada','2026-02-25','2026-07-15 05:31:45.1400000',N'08:00',N'Consulta',N'',6,115,5),
	 (N'Completada','2026-03-23','2026-07-15 05:31:45.1433333',N'09:00',N'Seguimiento',N'',4,80,3),
	 (N'Completada','2026-02-07','2026-07-15 05:31:45.1466667',N'15:00',N'Chequeo',N'',39,113,9),
	 (N'Completada','2026-06-06','2026-07-15 05:31:45.1500000',N'15:00',N'Dolor',N'',16,128,5),
	 (N'Completada','2026-04-14','2026-07-15 05:31:45.1566667',N'09:00',N'Chequeo',N'',2,122,1),
	 (N'Completada','2026-03-04','2026-07-15 05:31:45.1600000',N'09:00',N'Control',N'',5,230,4),
	 (N'Completada','2026-04-07','2026-07-15 05:31:45.1700000',N'10:00',N'Consulta',N'',12,284,1),
	 (N'Completada','2026-02-16','2026-07-15 05:31:45.1800000',N'11:00',N'Consulta',N'',20,149,9);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-01-09','2026-07-15 05:31:45.1900000',N'16:00',N'Consulta',N'',38,26,8),
	 (N'Completada','2026-06-19','2026-07-15 05:31:45.1933333',N'16:00',N'Consulta',N'',2,217,1),
	 (N'Completada','2026-01-23','2026-07-15 05:31:45.2000000',N'08:00',N'Evaluación',N'',31,82,14),
	 (N'Completada','2026-03-14','2026-07-15 05:31:45.2066667',N'15:00',N'Seguimiento',N'',12,11,1),
	 (N'Completada','2026-04-28','2026-07-15 05:31:45.2100000',N'14:00',N'Consulta',N'',2,216,1),
	 (N'Completada','2026-06-26','2026-07-15 05:31:45.2200000',N'10:00',N'Consulta',N'',12,68,1),
	 (N'Completada','2026-05-31','2026-07-15 05:31:45.2233333',N'10:00',N'Evaluación',N'',32,143,2),
	 (N'Programada','2026-10-27','2026-07-15 05:31:45.2300000',N'11:00',N'Dolor',N'',37,18,7),
	 (N'Completada','2026-03-06','2026-07-15 05:31:45.2333333',N'09:00',N'Dolor',N'',2,300,1),
	 (N'Completada','2026-05-31','2026-07-15 05:31:45.2366667',N'09:00',N'Control',N'',5,271,4);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-01-19','2026-07-15 05:31:45.2433333',N'16:00',N'Chequeo',N'',19,200,8),
	 (N'Completada','2026-06-28','2026-07-15 05:31:45.2500000',N'15:00',N'Control',N'',37,31,7),
	 (N'Programada','2026-11-15','2026-07-15 05:31:45.2533333',N'09:00',N'Consulta',N'',32,40,2),
	 (N'Completada','2026-04-02','2026-07-15 05:31:45.2566667',N'08:00',N'Seguimiento',N'',3,285,2),
	 (N'Completada','2026-03-04','2026-07-15 05:31:45.2600000',N'08:00',N'Dolor',N'',14,142,3),
	 (N'Completada','2026-03-24','2026-07-15 05:31:45.2666667',N'08:00',N'Chequeo',N'',39,217,9),
	 (N'Completada','2026-05-03','2026-07-15 05:31:45.2700000',N'10:00',N'Consulta',N'',18,111,7),
	 (N'Completada','2026-02-20','2026-07-15 05:31:45.2733333',N'16:00',N'Chequeo',N'',7,73,6),
	 (N'Programada','2026-12-28','2026-07-15 05:31:45.2800000',N'14:00',N'Dolor',N'',2,258,1),
	 (N'Completada','2026-01-11','2026-07-15 05:31:45.2833333',N'11:00',N'Control',N'',12,47,1);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-03-09','2026-07-15 05:31:45.2866667',N'15:00',N'Consulta',N'',24,30,11),
	 (N'Programada','2026-11-03','2026-07-15 05:31:45.2900000',N'11:00',N'Control',N'',32,133,2),
	 (N'Completada','2026-04-07','2026-07-15 05:31:45.2933333',N'09:00',N'Dolor',N'',7,235,6),
	 (N'Completada','2026-01-22','2026-07-15 05:31:45.2966667',N'14:00',N'Control',N'',39,84,9),
	 (N'Cancelada','2026-01-01','2026-07-15 05:31:45.3000000',N'08:00',N'Chequeo',N'',19,71,8),
	 (N'Completada','2026-01-22','2026-07-15 05:31:45.3066667',N'10:00',N'Control',N'',5,243,4),
	 (N'Completada','2026-02-04','2026-07-15 05:31:45.3100000',N'16:00',N'Consulta',N'',1,107,1),
	 (N'Cancelada','2026-01-31','2026-07-15 05:31:45.3100000',N'15:00',N'Seguimiento',N'',33,16,3),
	 (N'Completada','2026-02-06','2026-07-15 05:31:45.3133333',N'10:00',N'Control',N'',32,88,2),
	 (N'Programada','2026-12-22','2026-07-15 05:31:45.3200000',N'08:00',N'Control',N'',29,284,13);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Programada','2026-10-17','2026-07-15 05:31:45.3233333',N'11:00',N'Consulta',N'',18,22,7),
	 (N'Completada','2026-05-04','2026-07-15 05:31:45.3300000',N'08:00',N'Evaluación',N'',38,264,8),
	 (N'Completada','2026-04-04','2026-07-15 05:31:45.3333333',N'14:00',N'Chequeo',N'',3,114,2),
	 (N'Cancelada','2026-04-07','2026-07-15 05:31:45.3366667',N'10:00',N'Consulta',N'',36,292,6),
	 (N'Completada','2026-05-01','2026-07-15 05:31:45.3433333',N'11:00',N'Chequeo',N'',18,227,7),
	 (N'Completada','2026-06-18','2026-07-15 05:31:45.3500000',N'08:00',N'Consulta',N'',1,223,1),
	 (N'Programada','2026-09-01','2026-07-15 05:31:45.3533333',N'15:00',N'Dolor',N'',3,172,2),
	 (N'Programada','2026-09-13','2026-07-15 05:31:45.3566667',N'09:00',N'Seguimiento',N'',6,3,5),
	 (N'Programada','2026-12-22','2026-07-15 05:31:45.3600000',N'08:00',N'Chequeo',N'',1,231,1),
	 (N'Completada','2026-01-07','2026-07-15 05:31:45.3666667',N'15:00',N'Chequeo',N'',1,34,1);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Programada','2026-11-24','2026-07-15 05:31:45.3700000',N'09:00',N'Chequeo',N'',37,194,7),
	 (N'Completada','2026-01-15','2026-07-15 05:31:45.3733333',N'14:00',N'Control',N'',40,107,10),
	 (N'Completada','2026-05-21','2026-07-15 05:31:45.3766667',N'16:00',N'Consulta',N'',13,192,2),
	 (N'Completada','2026-01-01','2026-07-15 05:31:45.3800000',N'11:00',N'Evaluación',N'',5,254,4),
	 (N'Completada','2026-06-07','2026-07-15 05:31:45.3833333',N'16:00',N'Chequeo',N'',13,130,2),
	 (N'Completada','2026-01-27','2026-07-15 05:31:45.3900000',N'14:00',N'Dolor',N'',7,137,6),
	 (N'Completada','2026-05-26','2026-07-15 05:31:45.3933333',N'16:00',N'Chequeo',N'',2,44,1),
	 (N'Completada','2026-06-11','2026-07-15 05:31:45.3966667',N'09:00',N'Evaluación',N'',3,120,2),
	 (N'Completada','2026-05-05','2026-07-15 05:31:45.4000000',N'09:00',N'Consulta',N'',12,107,1),
	 (N'Completada','2026-02-12','2026-07-15 05:31:45.4066667',N'10:00',N'Control',N'',6,250,5);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Programada','2026-10-31','2026-07-15 05:31:45.4100000',N'16:00',N'Dolor',N'',20,268,9),
	 (N'Completada','2026-03-08','2026-07-15 05:31:45.4133333',N'14:00',N'Control',N'',31,160,14),
	 (N'Completada','2026-05-22','2026-07-15 05:31:45.4200000',N'15:00',N'Control',N'',33,93,3),
	 (N'Completada','2026-05-17','2026-07-15 05:31:45.4266667',N'15:00',N'Seguimiento',N'',13,99,2),
	 (N'Completada','2026-01-25','2026-07-15 05:31:45.4300000',N'09:00',N'Dolor',N'',8,242,7),
	 (N'Completada','2026-01-13','2026-07-15 05:31:45.4333333',N'11:00',N'Dolor',N'',3,167,2),
	 (N'Completada','2026-02-20','2026-07-15 05:31:45.4400000',N'09:00',N'Chequeo',N'',9,183,8),
	 (N'Completada','2026-05-30','2026-07-15 05:31:45.4433333',N'08:00',N'Control',N'',1,61,1),
	 (N'Programada','2026-11-03','2026-07-15 05:31:45.4466667',N'10:00',N'Evaluación',N'',5,7,4),
	 (N'Programada','2026-10-30','2026-07-15 05:31:45.4500000',N'11:00',N'Control',N'',2,294,1);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-06-16','2026-07-15 05:31:45.4533333',N'11:00',N'Control',N'',2,53,1),
	 (N'Completada','2026-06-06','2026-07-15 05:31:45.4566667',N'09:00',N'Evaluación',N'',7,55,6),
	 (N'Completada','2026-03-26','2026-07-15 05:31:45.4600000',N'14:00',N'Seguimiento',N'',32,12,2),
	 (N'Completada','2026-01-24','2026-07-15 05:31:45.4666667',N'09:00',N'Control',N'',32,17,2),
	 (N'Completada','2026-06-11','2026-07-15 05:31:45.4700000',N'10:00',N'Evaluación',N'',1,90,1),
	 (N'Completada','2026-06-17','2026-07-15 05:31:45.4766667',N'11:00',N'Evaluación',N'',25,66,12),
	 (N'Completada','2026-02-22','2026-07-15 05:31:45.4800000',N'16:00',N'Chequeo',N'',3,11,2),
	 (N'Completada','2026-02-12','2026-07-15 05:31:45.4833333',N'10:00',N'Control',N'',3,271,2),
	 (N'Cancelada','2026-05-30','2026-07-15 05:31:45.4866667',N'14:00',N'Evaluación',N'',4,263,3),
	 (N'Programada','2026-12-31','2026-07-15 05:31:45.4900000',N'08:00',N'Control',N'',36,261,6);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Cancelada','2026-01-31','2026-07-15 05:33:07.7300000',N'10:00',N'Evaluación',N'',37,261,7),
	 (N'Completada','2026-05-14','2026-07-15 05:33:07.7333333',N'11:00',N'Interconsulta',N'',13,133,2),
	 (N'Completada','2026-06-23','2026-07-15 05:33:07.7400000',N'15:00',N'Evaluación',N'',14,63,3),
	 (N'Completada','2026-01-24','2026-07-15 05:33:07.7433333',N'10:00',N'Control',N'',35,266,5),
	 (N'Completada','2026-01-21','2026-07-15 05:33:07.7466667',N'14:00',N'Control',N'',5,293,4),
	 (N'Completada','2026-01-05','2026-07-15 05:33:07.7500000',N'08:00',N'Consulta',N'',11,2,10),
	 (N'Programada','2026-10-06','2026-07-15 05:33:07.7566667',N'14:00',N'Dolor',N'',34,1,4),
	 (N'Cancelada','2026-06-04','2026-07-15 05:33:07.7600000',N'11:00',N'Seguimiento',N'',28,235,13),
	 (N'Completada','2026-05-04','2026-07-15 05:33:07.7633333',N'08:00',N'Chequeo',N'',32,178,2),
	 (N'Completada','2026-04-26','2026-07-15 05:33:07.7700000',N'16:00',N'Chequeo',N'',12,223,1);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-01-26','2026-07-15 05:33:07.7733333',N'16:00',N'Seguimiento',N'',32,166,2),
	 (N'Completada','2026-02-06','2026-07-15 05:33:07.7766667',N'10:00',N'Seguimiento',N'',14,59,3),
	 (N'Completada','2026-06-09','2026-07-15 05:33:07.7800000',N'08:00',N'Consulta',N'',32,90,2),
	 (N'Completada','2026-06-19','2026-07-15 05:33:07.7833333',N'15:00',N'Evaluación',N'',26,226,12),
	 (N'Programada','2026-12-26','2026-07-15 05:33:07.7866667',N'10:00',N'Chequeo',N'',1,100,1),
	 (N'Completada','2026-02-03','2026-07-15 05:33:07.7900000',N'14:00',N'Interconsulta',N'',7,163,6),
	 (N'Cancelada','2026-01-13','2026-07-15 05:33:07.7966667',N'15:00',N'Chequeo',N'',38,135,8),
	 (N'Cancelada','2026-01-31','2026-07-15 05:33:07.8000000',N'14:00',N'Consulta',N'',1,62,1),
	 (N'Completada','2026-05-21','2026-07-15 05:33:07.8033333',N'15:00',N'Control',N'',1,117,1),
	 (N'Completada','2026-03-09','2026-07-15 05:33:07.8066667',N'10:00',N'Control',N'',16,113,5);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-05-16','2026-07-15 05:33:07.8100000',N'14:00',N'Evaluación',N'',12,35,1),
	 (N'Completada','2026-04-04','2026-07-15 05:33:07.8133333',N'11:00',N'Seguimiento',N'',12,89,1),
	 (N'Completada','2026-05-01','2026-07-15 05:33:07.8166667',N'09:00',N'Evaluación',N'',1,117,1),
	 (N'Programada','2026-09-18','2026-07-15 05:33:07.8200000',N'14:00',N'Dolor',N'',21,264,10),
	 (N'Completada','2026-06-08','2026-07-15 05:33:07.8266667',N'15:00',N'Consulta',N'',4,290,3),
	 (N'Completada','2026-05-19','2026-07-15 05:33:07.8300000',N'16:00',N'Chequeo',N'',27,110,12),
	 (N'Completada','2026-04-08','2026-07-15 05:33:07.8333333',N'08:00',N'Consulta',N'',23,129,11),
	 (N'Programada','2026-11-28','2026-07-15 05:33:07.8366667',N'14:00',N'Dolor',N'',1,97,1),
	 (N'Programada','2026-11-17','2026-07-15 05:33:07.8400000',N'16:00',N'Interconsulta',N'',14,292,3),
	 (N'Completada','2026-06-14','2026-07-15 05:33:07.8433333',N'16:00',N'Interconsulta',N'',13,243,2);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Programada','2026-12-30','2026-07-15 05:33:07.8466667',N'15:00',N'Control',N'',16,135,5),
	 (N'Completada','2026-06-07','2026-07-15 05:33:07.8500000',N'14:00',N'Seguimiento',N'',25,67,12),
	 (N'Completada','2026-02-18','2026-07-15 05:33:07.8533333',N'15:00',N'Chequeo',N'',1,222,1),
	 (N'Completada','2026-05-07','2026-07-15 05:33:07.8566667',N'08:00',N'Control',N'',21,80,10),
	 (N'Completada','2026-04-20','2026-07-15 05:33:07.8666667',N'08:00',N'Dolor',N'',18,86,7),
	 (N'Completada','2026-06-10','2026-07-15 05:33:07.8700000',N'10:00',N'Evaluación',N'',12,236,1),
	 (N'Completada','2026-03-24','2026-07-15 05:33:07.8733333',N'14:00',N'Consulta',N'',3,17,2),
	 (N'Completada','2026-04-18','2026-07-15 05:33:07.8766667',N'10:00',N'Dolor',N'',7,288,6),
	 (N'Completada','2026-02-22','2026-07-15 05:33:07.8800000',N'11:00',N'Evaluación',N'',4,30,3),
	 (N'Completada','2026-04-18','2026-07-15 05:33:07.8833333',N'11:00',N'Dolor',N'',34,93,4);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Programada','2026-10-12','2026-07-15 05:33:07.8866667',N'08:00',N'Control',N'',19,272,8),
	 (N'Completada','2026-02-07','2026-07-15 05:33:07.8900000',N'09:00',N'Chequeo',N'',33,240,3),
	 (N'Programada','2026-11-17','2026-07-15 05:33:07.8900000',N'15:00',N'Consulta',N'',13,169,2),
	 (N'Completada','2026-05-07','2026-07-15 05:33:07.8933333',N'10:00',N'Interconsulta',N'',1,184,1),
	 (N'Completada','2026-06-09','2026-07-15 05:33:07.9000000',N'15:00',N'Dolor',N'',37,261,7),
	 (N'Completada','2026-06-25','2026-07-15 05:33:07.9033333',N'09:00',N'Chequeo',N'',20,61,9),
	 (N'Completada','2026-01-20','2026-07-15 05:33:07.9066667',N'10:00',N'Control',N'',2,79,1),
	 (N'Completada','2026-01-16','2026-07-15 05:33:07.9100000',N'16:00',N'Consulta',N'',5,44,4),
	 (N'Programada','2026-09-27','2026-07-15 05:33:07.9133333',N'10:00',N'Interconsulta',N'',32,297,2),
	 (N'Completada','2026-06-14','2026-07-15 05:33:07.9200000',N'15:00',N'Seguimiento',N'',13,132,2);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-01-08','2026-07-15 05:33:07.9233333',N'08:00',N'Consulta',N'',13,129,2),
	 (N'Completada','2026-02-15','2026-07-15 05:33:07.9266667',N'15:00',N'Control',N'',5,47,4),
	 (N'Programada','2026-11-19','2026-07-15 05:33:07.9300000',N'16:00',N'Evaluación',N'',12,200,1),
	 (N'Programada','2026-11-17','2026-07-15 05:33:07.9333333',N'15:00',N'Dolor',N'',24,278,11),
	 (N'Completada','2026-02-01','2026-07-15 05:33:07.9366667',N'15:00',N'Chequeo',N'',10,291,9),
	 (N'Completada','2026-03-25','2026-07-15 05:33:07.9400000',N'14:00',N'Consulta',N'',37,4,7),
	 (N'Cancelada','2026-01-25','2026-07-15 05:33:07.9433333',N'11:00',N'Chequeo',N'',28,254,13),
	 (N'Completada','2026-06-20','2026-07-15 05:33:07.9466667',N'09:00',N'Evaluación',N'',14,182,3),
	 (N'Programada','2026-12-07','2026-07-15 05:33:07.9500000',N'16:00',N'Dolor',N'',1,121,1),
	 (N'Programada','2026-09-03','2026-07-15 05:33:07.9533333',N'10:00',N'Seguimiento',N'',6,122,5);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-06-12','2026-07-15 05:33:07.9566667',N'11:00',N'Consulta',N'',37,231,7),
	 (N'Completada','2026-04-27','2026-07-15 05:33:07.9600000',N'08:00',N'Control',N'',18,134,7),
	 (N'Completada','2026-03-10','2026-07-15 05:33:07.9666667',N'15:00',N'Evaluación',N'',12,220,1),
	 (N'Programada','2026-12-08','2026-07-15 05:33:07.9666667',N'14:00',N'Control',N'',36,294,6),
	 (N'Cancelada','2026-02-19','2026-07-15 05:33:07.9700000',N'08:00',N'Seguimiento',N'',34,116,4),
	 (N'Cancelada','2026-01-05','2026-07-15 05:33:07.9733333',N'09:00',N'Control',N'',4,227,3),
	 (N'Cancelada','2026-03-29','2026-07-15 05:33:07.9800000',N'11:00',N'Chequeo',N'',28,152,13),
	 (N'Completada','2026-01-29','2026-07-15 05:33:07.9833333',N'08:00',N'Control',N'',14,282,3),
	 (N'Completada','2026-06-01','2026-07-15 05:33:07.9900000',N'11:00',N'Chequeo',N'',20,294,9),
	 (N'Completada','2026-04-12','2026-07-15 05:33:07.9900000',N'08:00',N'Dolor',N'',4,279,3);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-02-12','2026-07-15 05:33:07.9966667',N'09:00',N'Dolor',N'',9,22,8),
	 (N'Completada','2026-02-18','2026-07-15 05:33:08.0000000',N'10:00',N'Dolor',N'',39,104,9),
	 (N'Completada','2026-04-17','2026-07-15 05:33:08.0033333',N'08:00',N'Dolor',N'',34,82,4),
	 (N'Completada','2026-04-20','2026-07-15 05:33:08.0066667',N'15:00',N'Dolor',N'',18,287,7),
	 (N'Completada','2026-02-22','2026-07-15 05:33:08.0100000',N'15:00',N'Chequeo',N'',13,280,2),
	 (N'Completada','2026-05-19','2026-07-15 05:33:08.0100000',N'14:00',N'Seguimiento',N'',32,275,2),
	 (N'Completada','2026-03-10','2026-07-15 05:33:08.0133333',N'08:00',N'Dolor',N'',2,205,1),
	 (N'Completada','2026-03-17','2026-07-15 05:33:08.0166667',N'09:00',N'Seguimiento',N'',1,135,1),
	 (N'Completada','2026-06-18','2026-07-15 05:33:08.0200000',N'16:00',N'Control',N'',17,61,6),
	 (N'Completada','2026-04-15','2026-07-15 05:33:08.0233333',N'16:00',N'Interconsulta',N'',37,116,7);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-01-13','2026-07-15 05:33:08.0266667',N'15:00',N'Chequeo',N'',10,86,9),
	 (N'Completada','2026-01-22','2026-07-15 05:33:08.0300000',N'14:00',N'Chequeo',N'',1,3,1),
	 (N'Completada','2026-06-24','2026-07-15 05:33:08.0333333',N'16:00',N'Seguimiento',N'',5,257,4),
	 (N'Completada','2026-04-22','2026-07-15 05:33:08.0333333',N'16:00',N'Control',N'',18,154,7),
	 (N'Cancelada','2026-06-26','2026-07-15 05:33:08.0400000',N'08:00',N'Chequeo',N'',36,255,6),
	 (N'Completada','2026-04-30','2026-07-15 05:33:08.0400000',N'16:00',N'Evaluación',N'',34,199,4),
	 (N'Completada','2026-02-24','2026-07-15 05:33:08.0433333',N'08:00',N'Evaluación',N'',36,189,6),
	 (N'Completada','2026-04-02','2026-07-15 05:33:08.0466667',N'09:00',N'Interconsulta',N'',6,7,5),
	 (N'Cancelada','2026-04-11','2026-07-15 05:33:08.0500000',N'09:00',N'Control',N'',35,300,5),
	 (N'Programada','2026-12-02','2026-07-15 05:33:08.0500000',N'16:00',N'Evaluación',N'',22,140,11);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-06-06','2026-07-15 05:33:08.0533333',N'15:00',N'Evaluación',N'',1,136,1),
	 (N'Programada','2026-12-24','2026-07-15 05:33:08.0566667',N'10:00',N'Control',N'',5,155,4),
	 (N'Completada','2026-05-05','2026-07-15 05:33:08.0600000',N'16:00',N'Dolor',N'',12,218,1),
	 (N'Completada','2026-02-01','2026-07-15 05:33:08.0633333',N'15:00',N'Seguimiento',N'',33,95,3),
	 (N'Completada','2026-06-06','2026-07-15 05:33:08.0666667',N'10:00',N'Consulta',N'',37,184,7),
	 (N'Completada','2026-05-27','2026-07-15 05:33:08.0700000',N'15:00',N'Evaluación',N'',3,155,2),
	 (N'Cancelada','2026-01-07','2026-07-15 05:33:08.0733333',N'08:00',N'Chequeo',N'',15,118,4),
	 (N'Completada','2026-02-07','2026-07-15 05:33:08.0833333',N'14:00',N'Consulta',N'',31,293,14),
	 (N'Programada','2026-10-17','2026-07-15 05:33:08.0866667',N'15:00',N'Interconsulta',N'',6,43,5),
	 (N'Completada','2026-04-19','2026-07-15 05:33:08.0900000',N'15:00',N'Interconsulta',N'',35,260,5);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-02-10','2026-07-15 05:33:08.0933333',N'10:00',N'Dolor',N'',13,7,2),
	 (N'Completada','2026-06-30','2026-07-15 05:33:08.0966667',N'15:00',N'Consulta',N'',1,34,1),
	 (N'Completada','2026-01-29','2026-07-15 05:33:08.1000000',N'16:00',N'Consulta',N'',13,234,2),
	 (N'Completada','2026-05-12','2026-07-15 05:33:08.1066667',N'15:00',N'Dolor',N'',1,37,1),
	 (N'Programada','2026-11-16','2026-07-15 05:33:08.1100000',N'10:00',N'Consulta',N'',15,194,4),
	 (N'Completada','2026-02-28','2026-07-15 05:33:08.1100000',N'15:00',N'Chequeo',N'',10,259,9),
	 (N'Completada','2026-05-06','2026-07-15 05:33:08.1133333',N'16:00',N'Interconsulta',N'',5,70,4),
	 (N'Completada','2026-04-02','2026-07-15 05:33:08.1166667',N'15:00',N'Chequeo',N'',25,168,12),
	 (N'Completada','2026-01-06','2026-07-15 05:33:08.1200000',N'11:00',N'Evaluación',N'',3,273,2),
	 (N'Completada','2026-06-09','2026-07-15 05:33:08.1233333',N'11:00',N'Seguimiento',N'',15,164,4);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Programada','2026-11-21','2026-07-15 05:33:08.1266667',N'15:00',N'Evaluación',N'',20,95,9),
	 (N'Cancelada','2026-04-25','2026-07-15 05:33:08.1300000',N'16:00',N'Interconsulta',N'',14,259,3),
	 (N'Cancelada','2026-04-03','2026-07-15 05:33:08.1300000',N'11:00',N'Consulta',N'',5,197,4),
	 (N'Cancelada','2026-05-14','2026-07-15 05:33:08.1333333',N'14:00',N'Dolor',N'',2,295,1),
	 (N'Programada','2026-10-29','2026-07-15 05:33:08.1400000',N'11:00',N'Seguimiento',N'',33,282,3),
	 (N'Completada','2026-02-08','2026-07-15 05:33:08.1400000',N'15:00',N'Dolor',N'',1,245,1),
	 (N'Completada','2026-03-02','2026-07-15 05:33:08.1466667',N'16:00',N'Seguimiento',N'',13,274,2),
	 (N'Completada','2026-04-07','2026-07-15 05:33:08.1500000',N'09:00',N'Chequeo',N'',30,17,13),
	 (N'Programada','2026-10-10','2026-07-15 05:33:08.1500000',N'09:00',N'Interconsulta',N'',34,108,4),
	 (N'Completada','2026-06-22','2026-07-15 05:33:08.1533333',N'10:00',N'Chequeo',N'',3,227,2);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Programada','2026-09-05','2026-07-15 05:33:08.1566667',N'16:00',N'Seguimiento',N'',24,113,11),
	 (N'Completada','2026-01-02','2026-07-15 05:33:08.1600000',N'08:00',N'Chequeo',N'',13,53,2),
	 (N'Completada','2026-05-25','2026-07-15 05:33:08.1633333',N'15:00',N'Interconsulta',N'',2,222,1),
	 (N'Completada','2026-02-05','2026-07-15 05:33:08.1666667',N'15:00',N'Dolor',N'',13,265,2),
	 (N'Programada','2026-11-20','2026-07-15 05:33:08.1700000',N'11:00',N'Evaluación',N'',32,286,2),
	 (N'Completada','2026-04-12','2026-07-15 05:33:08.1766667',N'08:00',N'Evaluación',N'',6,60,5),
	 (N'Programada','2026-10-25','2026-07-15 05:33:08.1800000',N'15:00',N'Consulta',N'',8,164,7),
	 (N'Completada','2026-04-15','2026-07-15 05:33:08.1833333',N'15:00',N'Consulta',N'',7,241,6),
	 (N'Completada','2026-06-29','2026-07-15 05:33:08.1866667',N'11:00',N'Control',N'',2,49,1),
	 (N'Completada','2026-01-04','2026-07-15 05:33:08.1900000',N'15:00',N'Seguimiento',N'',7,33,6);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-06-19','2026-07-15 05:33:08.1933333',N'09:00',N'Interconsulta',N'',32,142,2),
	 (N'Completada','2026-02-21','2026-07-15 05:33:08.1966667',N'08:00',N'Evaluación',N'',1,226,1),
	 (N'Completada','2026-06-03','2026-07-15 05:33:08.2000000',N'09:00',N'Dolor',N'',45,260,15),
	 (N'Completada','2026-06-30','2026-07-15 05:33:08.2066667',N'14:00',N'Dolor',N'',6,30,5),
	 (N'Programada','2026-10-26','2026-07-15 05:33:08.2066667',N'09:00',N'Dolor',N'',35,73,5),
	 (N'Completada','2026-03-10','2026-07-15 05:33:08.2100000',N'11:00',N'Seguimiento',N'',31,179,14),
	 (N'Completada','2026-01-06','2026-07-15 05:33:08.2133333',N'09:00',N'Chequeo',N'',34,198,4),
	 (N'Completada','2026-05-22','2026-07-15 05:33:08.2166667',N'15:00',N'Seguimiento',N'',5,103,4),
	 (N'Completada','2026-06-30','2026-07-15 05:33:08.2200000',N'08:00',N'Consulta',N'',1,39,1),
	 (N'Completada','2026-02-16','2026-07-15 05:33:08.2233333',N'15:00',N'Dolor',N'',24,298,11);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-05-05','2026-07-15 05:33:08.2266667',N'10:00',N'Chequeo',N'',34,168,4),
	 (N'Completada','2026-06-01','2026-07-15 05:33:08.2300000',N'15:00',N'Chequeo',N'',17,152,6),
	 (N'Completada','2026-02-28','2026-07-15 05:33:08.2333333',N'09:00',N'Dolor',N'',35,52,5),
	 (N'Completada','2026-02-09','2026-07-15 05:33:08.2333333',N'16:00',N'Chequeo',N'',2,259,1),
	 (N'Completada','2026-05-01','2026-07-15 05:33:08.2366667',N'16:00',N'Interconsulta',N'',2,1,1),
	 (N'Completada','2026-03-09','2026-07-15 05:33:08.2400000',N'11:00',N'Interconsulta',N'',17,11,6),
	 (N'Completada','2026-05-20','2026-07-15 05:33:08.2433333',N'11:00',N'Interconsulta',N'',32,239,2),
	 (N'Completada','2026-06-19','2026-07-15 05:33:08.2466667',N'14:00',N'Dolor',N'',1,251,1),
	 (N'Completada','2026-02-20','2026-07-15 05:33:08.2500000',N'11:00',N'Evaluación',N'',28,299,13),
	 (N'Completada','2026-02-11','2026-07-15 05:33:08.2500000',N'10:00',N'Seguimiento',N'',5,225,4);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Programada','2026-09-05','2026-07-15 05:33:08.2533333',N'15:00',N'Chequeo',N'',4,44,3),
	 (N'Completada','2026-06-30','2026-07-15 05:33:08.2566667',N'11:00',N'Evaluación',N'',13,154,2),
	 (N'Programada','2026-09-10','2026-07-15 05:33:08.2600000',N'08:00',N'Evaluación',N'',32,225,2),
	 (N'Completada','2026-06-28','2026-07-15 05:33:08.2600000',N'09:00',N'Seguimiento',N'',37,78,7),
	 (N'Programada','2026-09-19','2026-07-15 05:33:08.2633333',N'14:00',N'Control',N'',1,122,1),
	 (N'Completada','2026-04-07','2026-07-15 05:33:08.2666667',N'09:00',N'Interconsulta',N'',1,209,1),
	 (N'Completada','2026-03-17','2026-07-15 05:33:08.2700000',N'15:00',N'Interconsulta',N'',5,184,4),
	 (N'Cancelada','2026-06-01','2026-07-15 05:33:08.2733333',N'10:00',N'Chequeo',N'',24,17,11),
	 (N'Programada','2026-12-27','2026-07-15 05:33:08.2800000',N'14:00',N'Chequeo',N'',8,188,7),
	 (N'Completada','2026-06-19','2026-07-15 05:33:08.2800000',N'09:00',N'Control',N'',36,169,6);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-04-15','2026-07-15 05:33:08.2866667',N'11:00',N'Seguimiento',N'',13,78,2),
	 (N'Completada','2026-05-24','2026-07-15 05:33:08.2866667',N'08:00',N'Evaluación',N'',38,147,8),
	 (N'Completada','2026-05-14','2026-07-15 05:33:08.2900000',N'08:00',N'Evaluación',N'',14,103,3),
	 (N'Completada','2026-02-20','2026-07-15 05:33:08.2933333',N'10:00',N'Evaluación',N'',16,39,5),
	 (N'Completada','2026-02-09','2026-07-15 05:33:08.2933333',N'09:00',N'Chequeo',N'',11,123,10),
	 (N'Completada','2026-03-07','2026-07-15 05:33:08.3000000',N'09:00',N'Control',N'',6,183,5),
	 (N'Completada','2026-02-17','2026-07-15 05:33:08.3000000',N'16:00',N'Control',N'',11,102,10),
	 (N'Cancelada','2026-02-22','2026-07-15 05:33:08.3066667',N'08:00',N'Control',N'',34,201,4),
	 (N'Completada','2026-04-30','2026-07-15 05:33:08.3066667',N'10:00',N'Control',N'',39,201,9),
	 (N'Completada','2026-01-29','2026-07-15 05:33:08.3100000',N'11:00',N'Evaluación',N'',4,112,3);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Programada','2026-09-18','2026-07-15 05:33:08.3133333',N'16:00',N'Interconsulta',N'',3,213,2),
	 (N'Cancelada','2026-01-05','2026-07-15 05:33:08.3166667',N'08:00',N'Evaluación',N'',16,54,5),
	 (N'Programada','2026-12-21','2026-07-15 05:33:08.3200000',N'11:00',N'Chequeo',N'',11,50,10),
	 (N'Programada','2026-11-26','2026-07-15 05:33:08.3233333',N'09:00',N'Evaluación',N'',36,112,6),
	 (N'Completada','2026-01-19','2026-07-15 05:33:08.3300000',N'16:00',N'Evaluación',N'',14,85,3),
	 (N'Programada','2026-11-30','2026-07-15 05:33:08.3333333',N'09:00',N'Seguimiento',N'',15,262,4),
	 (N'Cancelada','2026-04-28','2026-07-15 05:33:08.3366667',N'16:00',N'Evaluación',N'',25,277,12),
	 (N'Completada','2026-01-25','2026-07-15 05:33:08.3400000',N'15:00',N'Interconsulta',N'',23,208,11),
	 (N'Completada','2026-04-15','2026-07-15 05:33:08.3433333',N'10:00',N'Interconsulta',N'',6,236,5),
	 (N'Completada','2026-02-03','2026-07-15 05:33:08.3466667',N'10:00',N'Chequeo',N'',12,170,1);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-02-14','2026-07-15 05:34:13.4200000',N'11:00',N'Control',N'',10,204,9),
	 (N'Completada','2026-03-09','2026-07-15 05:34:13.4233333',N'08:00',N'Seguimiento',N'',32,207,2),
	 (N'Cancelada','2026-03-07','2026-07-15 05:34:13.4266667',N'08:00',N'Revisión',N'',33,185,3),
	 (N'Completada','2026-06-17','2026-07-15 05:34:13.4300000',N'09:00',N'Consulta',N'',9,200,8),
	 (N'Completada','2026-01-19','2026-07-15 05:34:13.4366667',N'14:00',N'Interconsulta',N'',28,139,13),
	 (N'Programada','2026-09-19','2026-07-15 05:34:13.4400000',N'09:00',N'Consulta',N'',23,183,11),
	 (N'Programada','2026-10-21','2026-07-15 05:34:13.4433333',N'16:00',N'Chequeo',N'',18,98,7),
	 (N'Programada','2026-11-16','2026-07-15 05:34:13.4500000',N'14:00',N'Interconsulta',N'',27,259,12),
	 (N'Completada','2026-06-16','2026-07-15 05:34:13.4533333',N'11:00',N'Control',N'',4,6,3),
	 (N'Completada','2026-06-26','2026-07-15 05:34:13.4566667',N'11:00',N'Chequeo',N'',13,85,2);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-01-12','2026-07-15 05:34:13.4600000',N'11:00',N'Control',N'',39,294,9),
	 (N'Completada','2026-02-28','2026-07-15 05:34:13.4633333',N'11:00',N'Dolor',N'',4,75,3),
	 (N'Completada','2026-05-18','2026-07-15 05:34:13.4700000',N'08:00',N'Consulta',N'',6,251,5),
	 (N'Completada','2026-03-14','2026-07-15 05:34:13.4766667',N'10:00',N'Control',N'',15,78,4),
	 (N'Programada','2026-09-29','2026-07-15 05:34:13.4800000',N'08:00',N'Control',N'',4,131,3),
	 (N'Completada','2026-04-23','2026-07-15 05:34:13.4833333',N'09:00',N'Revisión',N'',12,77,1),
	 (N'Programada','2026-12-08','2026-07-15 05:34:13.4900000',N'16:00',N'Consulta',N'',12,144,1),
	 (N'Completada','2026-04-01','2026-07-15 05:34:13.4933333',N'15:00',N'Interconsulta',N'',3,236,2),
	 (N'Completada','2026-05-12','2026-07-15 05:34:13.4966667',N'14:00',N'Seguimiento',N'',45,48,15),
	 (N'Programada','2026-11-13','2026-07-15 05:34:13.5000000',N'09:00',N'Evaluación',N'',12,48,1);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-02-10','2026-07-15 05:34:13.5033333',N'11:00',N'Evaluación',N'',5,258,4),
	 (N'Cancelada','2026-06-18','2026-07-15 05:34:13.5100000',N'14:00',N'Dolor',N'',1,218,1),
	 (N'Cancelada','2026-05-05','2026-07-15 05:34:13.5133333',N'09:00',N'Seguimiento',N'',1,241,1),
	 (N'Completada','2026-02-21','2026-07-15 05:34:13.5166667',N'16:00',N'Interconsulta',N'',9,194,8),
	 (N'Completada','2026-02-17','2026-07-15 05:34:13.5200000',N'14:00',N'Seguimiento',N'',1,51,1),
	 (N'Completada','2026-01-14','2026-07-15 05:34:13.5233333',N'09:00',N'Interconsulta',N'',1,139,1),
	 (N'Completada','2026-06-27','2026-07-15 05:34:13.5266667',N'16:00',N'Interconsulta',N'',7,194,6),
	 (N'Completada','2026-03-14','2026-07-15 05:34:13.5300000',N'08:00',N'Chequeo',N'',8,52,7),
	 (N'Completada','2026-01-17','2026-07-15 05:34:13.5366667',N'10:00',N'Control',N'',1,22,1),
	 (N'Completada','2026-04-24','2026-07-15 05:34:13.5400000',N'11:00',N'Chequeo',N'',2,17,1);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-02-03','2026-07-15 05:34:13.5433333',N'15:00',N'Control',N'',36,102,6),
	 (N'Completada','2026-01-20','2026-07-15 05:34:13.5466667',N'11:00',N'Dolor',N'',3,280,2),
	 (N'Completada','2026-01-16','2026-07-15 05:34:13.5500000',N'14:00',N'Revisión',N'',13,218,2),
	 (N'Completada','2026-05-18','2026-07-15 05:34:13.5566667',N'10:00',N'Seguimiento',N'',14,84,3),
	 (N'Completada','2026-06-01','2026-07-15 05:34:13.5600000',N'11:00',N'Consulta',N'',16,235,5),
	 (N'Completada','2026-01-09','2026-07-15 05:34:13.5633333',N'08:00',N'Control',N'',4,146,3),
	 (N'Completada','2026-05-08','2026-07-15 05:34:13.5666667',N'15:00',N'Dolor',N'',29,165,13),
	 (N'Completada','2026-05-10','2026-07-15 05:34:13.5700000',N'16:00',N'Dolor',N'',18,162,7),
	 (N'Completada','2026-01-22','2026-07-15 05:34:13.5733333',N'08:00',N'Control',N'',12,161,1),
	 (N'Cancelada','2026-06-30','2026-07-15 05:34:13.5766667',N'11:00',N'Consulta',N'',37,48,7);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-01-12','2026-07-15 05:34:13.5800000',N'09:00',N'Interconsulta',N'',19,262,8),
	 (N'Completada','2026-06-15','2026-07-15 05:34:13.5866667',N'15:00',N'Control',N'',12,164,1),
	 (N'Completada','2026-02-07','2026-07-15 05:34:13.5900000',N'08:00',N'Dolor',N'',14,253,3),
	 (N'Completada','2026-02-08','2026-07-15 05:34:13.5933333',N'11:00',N'Seguimiento',N'',14,183,3),
	 (N'Programada','2026-10-15','2026-07-15 05:34:13.5966667',N'14:00',N'Dolor',N'',37,52,7),
	 (N'Completada','2026-05-01','2026-07-15 05:34:13.6000000',N'09:00',N'Seguimiento',N'',32,54,2),
	 (N'Programada','2026-09-17','2026-07-15 05:34:13.6033333',N'10:00',N'Revisión',N'',2,62,1),
	 (N'Completada','2026-01-30','2026-07-15 05:34:13.6100000',N'08:00',N'Evaluación',N'',7,176,6),
	 (N'Programada','2026-10-04','2026-07-15 05:34:13.6100000',N'09:00',N'Seguimiento',N'',32,115,2),
	 (N'Cancelada','2026-05-01','2026-07-15 05:34:13.6166667',N'14:00',N'Control',N'',36,199,6);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-03-15','2026-07-15 05:34:13.6200000',N'09:00',N'Dolor',N'',12,108,1),
	 (N'Completada','2026-03-12','2026-07-15 05:34:13.6233333',N'10:00',N'Interconsulta',N'',30,224,13),
	 (N'Completada','2026-05-19','2026-07-15 05:34:13.6300000',N'08:00',N'Chequeo',N'',17,89,6),
	 (N'Completada','2026-02-17','2026-07-15 05:34:13.6400000',N'09:00',N'Revisión',N'',32,225,2),
	 (N'Completada','2026-05-11','2026-07-15 05:34:13.6466667',N'16:00',N'Dolor',N'',41,100,14),
	 (N'Completada','2026-02-24','2026-07-15 05:34:13.6500000',N'16:00',N'Seguimiento',N'',19,169,8),
	 (N'Completada','2026-02-09','2026-07-15 05:34:13.6566667',N'11:00',N'Interconsulta',N'',3,197,2),
	 (N'Completada','2026-05-10','2026-07-15 05:34:13.6600000',N'10:00',N'Dolor',N'',33,121,3),
	 (N'Completada','2026-01-29','2026-07-15 05:34:13.6666667',N'15:00',N'Dolor',N'',4,112,3),
	 (N'Completada','2026-02-17','2026-07-15 05:34:13.6700000',N'09:00',N'Consulta',N'',21,6,10);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-04-17','2026-07-15 05:34:13.6733333',N'16:00',N'Chequeo',N'',24,13,11),
	 (N'Programada','2026-12-16','2026-07-15 05:34:13.6766667',N'11:00',N'Dolor',N'',20,179,9),
	 (N'Completada','2026-01-17','2026-07-15 05:34:13.6800000',N'14:00',N'Revisión',N'',33,300,3),
	 (N'Completada','2026-01-28','2026-07-15 05:34:13.6866667',N'11:00',N'Dolor',N'',15,130,4),
	 (N'Cancelada','2026-03-24','2026-07-15 05:34:13.6900000',N'09:00',N'Consulta',N'',1,181,1),
	 (N'Programada','2026-09-07','2026-07-15 05:34:13.6966667',N'08:00',N'Control',N'',5,114,4),
	 (N'Cancelada','2026-02-20','2026-07-15 05:34:13.7000000',N'08:00',N'Chequeo',N'',4,9,3),
	 (N'Completada','2026-03-23','2026-07-15 05:34:13.7033333',N'11:00',N'Consulta',N'',18,253,7),
	 (N'Completada','2026-06-28','2026-07-15 05:34:13.7100000',N'16:00',N'Dolor',N'',32,285,2),
	 (N'Cancelada','2026-05-01','2026-07-15 05:34:13.7133333',N'16:00',N'Control',N'',20,239,9);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-06-24','2026-07-15 05:34:13.7166667',N'15:00',N'Dolor',N'',4,231,3),
	 (N'Completada','2026-05-13','2026-07-15 05:34:13.7200000',N'14:00',N'Dolor',N'',23,151,11),
	 (N'Programada','2026-12-22','2026-07-15 05:34:13.7233333',N'14:00',N'Consulta',N'',8,135,7),
	 (N'Completada','2026-03-22','2026-07-15 05:34:13.7300000',N'10:00',N'Seguimiento',N'',40,72,10),
	 (N'Completada','2026-05-01','2026-07-15 05:34:14.0500000',N'11:00',N'Control',N'',27,16,12),
	 (N'Completada','2026-06-03','2026-07-15 05:34:14.0566667',N'11:00',N'Revisión',N'',34,160,4),
	 (N'Programada','2026-12-18','2026-07-15 05:34:14.0700000',N'16:00',N'Chequeo',N'',7,15,6),
	 (N'Completada','2026-01-05','2026-07-15 05:34:14.0733333',N'16:00',N'Consulta',N'',12,216,1),
	 (N'Completada','2026-04-04','2026-07-15 05:34:14.0800000',N'10:00',N'Chequeo',N'',23,48,11),
	 (N'Completada','2026-01-31','2026-07-15 05:34:14.0833333',N'08:00',N'Revisión',N'',13,206,2);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-05-02','2026-07-15 05:34:14.0866667',N'11:00',N'Interconsulta',N'',24,89,11),
	 (N'Completada','2026-02-14','2026-07-15 05:34:14.0866667',N'11:00',N'Interconsulta',N'',32,179,2),
	 (N'Cancelada','2026-03-19','2026-07-15 05:34:14.0900000',N'16:00',N'Consulta',N'',12,18,1),
	 (N'Cancelada','2026-04-07','2026-07-15 05:34:14.0933333',N'15:00',N'Control',N'',1,248,1),
	 (N'Completada','2026-06-25','2026-07-15 05:34:14.1000000',N'10:00',N'Consulta',N'',5,155,4),
	 (N'Cancelada','2026-04-18','2026-07-15 05:34:14.1000000',N'08:00',N'Revisión',N'',16,69,5),
	 (N'Completada','2026-05-14','2026-07-15 05:34:14.1033333',N'15:00',N'Interconsulta',N'',1,143,1),
	 (N'Completada','2026-01-19','2026-07-15 05:34:14.1100000',N'09:00',N'Revisión',N'',33,233,3),
	 (N'Cancelada','2026-05-22','2026-07-15 05:34:14.1133333',N'15:00',N'Seguimiento',N'',37,99,7),
	 (N'Completada','2026-04-23','2026-07-15 05:34:14.1166667',N'14:00',N'Chequeo',N'',11,91,10);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Programada','2026-10-19','2026-07-15 05:34:14.1200000',N'11:00',N'Dolor',N'',21,228,10),
	 (N'Completada','2026-01-11','2026-07-15 05:34:14.1300000',N'08:00',N'Revisión',N'',23,146,11),
	 (N'Completada','2026-06-25','2026-07-15 05:34:14.1333333',N'11:00',N'Consulta',N'',12,214,1),
	 (N'Programada','2026-09-09','2026-07-15 05:34:14.1366667',N'09:00',N'Seguimiento',N'',4,181,3),
	 (N'Completada','2026-03-01','2026-07-15 05:34:14.1400000',N'10:00',N'Chequeo',N'',15,114,4),
	 (N'Programada','2026-11-06','2026-07-15 05:34:14.1466667',N'09:00',N'Chequeo',N'',31,24,14),
	 (N'Completada','2026-04-12','2026-07-15 05:34:14.1500000',N'09:00',N'Dolor',N'',9,134,8),
	 (N'Completada','2026-06-26','2026-07-15 05:34:14.1533333',N'09:00',N'Dolor',N'',23,149,11),
	 (N'Completada','2026-04-24','2026-07-15 05:34:14.1600000',N'14:00',N'Consulta',N'',3,40,2),
	 (N'Completada','2026-06-19','2026-07-15 05:34:14.1666667',N'09:00',N'Dolor',N'',35,82,5);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Cancelada','2026-02-06','2026-07-15 05:34:14.1700000',N'08:00',N'Revisión',N'',33,88,3),
	 (N'Completada','2026-03-03','2026-07-15 05:34:14.1733333',N'14:00',N'Consulta',N'',6,248,5),
	 (N'Programada','2026-09-26','2026-07-15 05:34:14.1766667',N'08:00',N'Revisión',N'',6,166,5),
	 (N'Programada','2026-09-18','2026-07-15 05:34:14.1800000',N'15:00',N'Seguimiento',N'',14,52,3),
	 (N'Completada','2026-06-29','2026-07-15 05:34:14.1833333',N'16:00',N'Dolor',N'',37,3,7),
	 (N'Completada','2026-01-18','2026-07-15 05:34:14.1900000',N'10:00',N'Seguimiento',N'',40,258,10),
	 (N'Completada','2026-03-29','2026-07-15 05:34:14.1900000',N'08:00',N'Evaluación',N'',5,127,4),
	 (N'Completada','2026-01-20','2026-07-15 05:34:14.1966667',N'09:00',N'Dolor',N'',13,37,2),
	 (N'Completada','2026-03-31','2026-07-15 05:34:14.2000000',N'14:00',N'Seguimiento',N'',2,72,1),
	 (N'Completada','2026-04-20','2026-07-15 05:34:14.2033333',N'08:00',N'Chequeo',N'',15,99,4);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-06-17','2026-07-15 05:34:14.2066667',N'15:00',N'Control',N'',1,154,1),
	 (N'Completada','2026-06-24','2026-07-15 05:34:14.2100000',N'11:00',N'Interconsulta',N'',3,168,2),
	 (N'Completada','2026-01-11','2026-07-15 05:34:14.2133333',N'09:00',N'Dolor',N'',11,45,10),
	 (N'Cancelada','2026-02-19','2026-07-15 05:34:14.2200000',N'11:00',N'Evaluación',N'',2,270,1),
	 (N'Programada','2026-12-28','2026-07-15 05:34:14.2233333',N'08:00',N'Seguimiento',N'',12,65,1),
	 (N'Completada','2026-02-22','2026-07-15 05:34:14.2266667',N'08:00',N'Dolor',N'',18,18,7),
	 (N'Completada','2026-01-11','2026-07-15 05:34:14.2300000',N'08:00',N'Consulta',N'',34,234,4),
	 (N'Programada','2026-10-23','2026-07-15 05:34:14.2333333',N'16:00',N'Chequeo',N'',19,242,8),
	 (N'Completada','2026-05-07','2026-07-15 05:34:14.2366667',N'16:00',N'Chequeo',N'',3,188,2),
	 (N'Completada','2026-04-04','2026-07-15 05:34:14.2400000',N'15:00',N'Chequeo',N'',2,188,1);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Cancelada','2026-02-15','2026-07-15 05:34:14.2433333',N'09:00',N'Consulta',N'',39,58,9),
	 (N'Completada','2026-02-28','2026-07-15 05:34:14.2500000',N'16:00',N'Seguimiento',N'',2,70,1),
	 (N'Completada','2026-05-03','2026-07-15 05:34:14.2533333',N'08:00',N'Revisión',N'',15,292,4),
	 (N'Completada','2026-01-22','2026-07-15 05:34:14.2566667',N'16:00',N'Consulta',N'',35,15,5),
	 (N'Completada','2026-01-17','2026-07-15 05:34:14.2600000',N'14:00',N'Control',N'',36,274,6),
	 (N'Completada','2026-06-20','2026-07-15 05:34:14.2633333',N'14:00',N'Seguimiento',N'',32,197,2),
	 (N'Completada','2026-02-21','2026-07-15 05:34:14.2666667',N'10:00',N'Seguimiento',N'',2,132,1),
	 (N'Programada','2026-11-07','2026-07-15 05:34:14.2733333',N'08:00',N'Chequeo',N'',15,73,4),
	 (N'Completada','2026-03-12','2026-07-15 05:34:14.2800000',N'10:00',N'Consulta',N'',1,265,1),
	 (N'Completada','2026-06-03','2026-07-15 05:34:14.2833333',N'16:00',N'Chequeo',N'',34,196,4);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-01-17','2026-07-15 05:34:14.2866667',N'15:00',N'Consulta',N'',13,289,2),
	 (N'Completada','2026-06-23','2026-07-15 05:34:14.2900000',N'14:00',N'Revisión',N'',10,174,9),
	 (N'Completada','2026-02-07','2026-07-15 05:34:14.2966667',N'10:00',N'Control',N'',12,286,1),
	 (N'Completada','2026-04-23','2026-07-15 05:34:14.3000000',N'08:00',N'Chequeo',N'',37,131,7),
	 (N'Completada','2026-05-24','2026-07-15 05:34:14.3033333',N'16:00',N'Consulta',N'',4,117,3),
	 (N'Completada','2026-04-12','2026-07-15 05:34:14.3066667',N'10:00',N'Revisión',N'',37,232,7),
	 (N'Programada','2026-10-12','2026-07-15 05:34:14.3100000',N'08:00',N'Chequeo',N'',18,278,7),
	 (N'Programada','2026-12-28','2026-07-15 05:34:14.3133333',N'08:00',N'Evaluación',N'',38,223,8),
	 (N'Programada','2026-10-25','2026-07-15 05:34:14.3166667',N'16:00',N'Revisión',N'',16,61,5),
	 (N'Completada','2026-06-27','2026-07-15 05:34:14.3200000',N'11:00',N'Control',N'',1,277,1);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Cancelada','2026-02-14','2026-07-15 05:34:14.3233333',N'16:00',N'Interconsulta',N'',18,69,7),
	 (N'Programada','2026-12-12','2026-07-15 05:34:14.3266667',N'15:00',N'Seguimiento',N'',33,209,3),
	 (N'Completada','2026-03-12','2026-07-15 05:34:14.3333333',N'14:00',N'Interconsulta',N'',4,168,3),
	 (N'Completada','2026-06-21','2026-07-15 05:34:14.3366667',N'15:00',N'Control',N'',3,18,2),
	 (N'Cancelada','2026-03-01','2026-07-15 05:34:14.3400000',N'15:00',N'Dolor',N'',39,91,9),
	 (N'Completada','2026-05-30','2026-07-15 05:34:14.3433333',N'11:00',N'Consulta',N'',16,278,5),
	 (N'Completada','2026-01-26','2026-07-15 05:34:14.3500000',N'16:00',N'Interconsulta',N'',15,194,4),
	 (N'Completada','2026-03-19','2026-07-15 05:34:14.3533333',N'08:00',N'Control',N'',20,50,9),
	 (N'Completada','2026-01-01','2026-07-15 05:34:14.3600000',N'16:00',N'Dolor',N'',1,160,1),
	 (N'Completada','2026-02-10','2026-07-15 05:34:14.3633333',N'08:00',N'Chequeo',N'',12,203,1);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Programada','2026-09-21','2026-07-15 05:34:14.3666667',N'08:00',N'Revisión',N'',12,91,1),
	 (N'Completada','2026-06-21','2026-07-15 05:34:14.3700000',N'10:00',N'Evaluación',N'',18,23,7),
	 (N'Completada','2026-01-30','2026-07-15 05:34:14.3733333',N'16:00',N'Dolor',N'',34,51,4),
	 (N'Completada','2026-03-03','2026-07-15 05:34:14.3800000',N'15:00',N'Control',N'',15,133,4),
	 (N'Completada','2026-05-12','2026-07-15 05:34:14.3833333',N'11:00',N'Chequeo',N'',12,210,1),
	 (N'Completada','2026-04-28','2026-07-15 05:34:14.3833333',N'15:00',N'Dolor',N'',9,101,8),
	 (N'Programada','2026-11-10','2026-07-15 05:34:14.3866667',N'15:00',N'Interconsulta',N'',5,59,4),
	 (N'Programada','2026-10-17','2026-07-15 05:34:14.3900000',N'11:00',N'Evaluación',N'',10,42,9),
	 (N'Completada','2026-04-19','2026-07-15 05:34:14.3933333',N'09:00',N'Interconsulta',N'',15,101,4),
	 (N'Programada','2026-10-06','2026-07-15 05:34:14.4000000',N'09:00',N'Revisión',N'',38,104,8);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-03-05','2026-07-15 05:34:14.4000000',N'14:00',N'Evaluación',N'',33,134,3),
	 (N'Completada','2026-06-17','2026-07-15 05:34:14.4066667',N'14:00',N'Control',N'',8,236,7),
	 (N'Completada','2026-02-24','2026-07-15 05:34:14.4100000',N'15:00',N'Consulta',N'',34,137,4),
	 (N'Completada','2026-06-29','2026-07-15 05:34:14.4166667',N'16:00',N'Dolor',N'',14,28,3),
	 (N'Completada','2026-05-16','2026-07-15 05:34:14.4200000',N'09:00',N'Consulta',N'',3,288,2),
	 (N'Programada','2026-09-13','2026-07-15 05:34:14.4233333',N'14:00',N'Interconsulta',N'',15,188,4),
	 (N'Completada','2026-06-16','2026-07-15 05:34:14.4300000',N'11:00',N'Dolor',N'',20,168,9),
	 (N'Completada','2026-04-11','2026-07-15 05:34:14.4333333',N'09:00',N'Seguimiento',N'',35,124,5),
	 (N'Completada','2026-01-31','2026-07-15 05:34:14.4366667',N'09:00',N'Seguimiento',N'',13,117,2),
	 (N'Completada','2026-03-16','2026-07-15 05:34:14.4400000',N'16:00',N'Consulta',N'',19,3,8);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-03-01','2026-07-15 05:34:14.4466667',N'15:00',N'Seguimiento',N'',14,257,3),
	 (N'Cancelada','2026-03-08','2026-07-15 05:34:14.4500000',N'14:00',N'Dolor',N'',20,149,9),
	 (N'Completada','2026-02-02','2026-07-15 05:34:14.4533333',N'08:00',N'Seguimiento',N'',35,113,5),
	 (N'Programada','2026-11-03','2026-07-15 05:34:14.4566667',N'10:00',N'Revisión',N'',12,56,1),
	 (N'Completada','2026-02-17','2026-07-15 05:34:14.4600000',N'09:00',N'Revisión',N'',33,285,3),
	 (N'Completada','2026-05-02','2026-07-15 05:34:14.4666667',N'09:00',N'Chequeo',N'',15,209,4),
	 (N'Completada','2026-06-28','2026-07-15 05:34:14.4700000',N'08:00',N'Revisión',N'',4,110,3),
	 (N'Programada','2026-12-08','2026-07-15 05:34:14.4733333',N'11:00',N'Seguimiento',N'',38,194,8),
	 (N'Completada','2026-01-11','2026-07-15 05:34:14.4766667',N'10:00',N'Interconsulta',N'',4,67,3),
	 (N'Programada','2026-09-05','2026-07-15 05:34:14.4800000',N'16:00',N'Interconsulta',N'',26,254,12);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-01-17','2026-07-15 05:35:20.4033333',N'14:00',N'Interconsulta',N'',1,228,1),
	 (N'Completada','2026-03-14','2026-07-15 05:35:20.4100000',N'11:00',N'Chequeo',N'',45,184,15),
	 (N'Programada','2026-11-19','2026-07-15 05:35:20.4133333',N'15:00',N'Seguimiento',N'',35,97,5),
	 (N'Completada','2026-01-07','2026-07-15 05:35:20.4200000',N'10:00',N'Control',N'',3,135,2),
	 (N'Completada','2026-06-16','2026-07-15 05:35:20.4233333',N'15:00',N'Dolor',N'',29,268,13),
	 (N'Completada','2026-01-01','2026-07-15 05:35:20.4266667',N'14:00',N'Consulta',N'',13,29,2),
	 (N'Completada','2026-05-14','2026-07-15 05:35:20.4300000',N'11:00',N'Control',N'',38,270,8),
	 (N'Completada','2026-06-21','2026-07-15 05:35:20.4400000',N'10:00',N'Consulta',N'',17,8,6),
	 (N'Completada','2026-04-28','2026-07-15 05:35:20.4500000',N'09:00',N'Interconsulta',N'',8,30,7),
	 (N'Completada','2026-05-26','2026-07-15 05:35:20.4533333',N'10:00',N'Chequeo',N'',36,238,6);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-01-30','2026-07-15 05:35:20.4600000',N'14:00',N'Control',N'',1,281,1),
	 (N'Completada','2026-03-18','2026-07-15 05:35:20.4633333',N'11:00',N'Revisión',N'',13,75,2),
	 (N'Cancelada','2026-01-31','2026-07-15 05:35:20.4666667',N'15:00',N'Revisión',N'',2,260,1),
	 (N'Completada','2026-02-02','2026-07-15 05:35:20.4733333',N'11:00',N'Dolor',N'',20,200,9),
	 (N'Completada','2026-03-02','2026-07-15 05:35:20.4766667',N'09:00',N'Control',N'',13,293,2),
	 (N'Programada','2026-11-02','2026-07-15 05:35:20.4800000',N'11:00',N'Interconsulta',N'',7,36,6),
	 (N'Completada','2026-05-24','2026-07-15 05:35:20.4866667',N'08:00',N'Evaluación',N'',34,84,4),
	 (N'Completada','2026-05-03','2026-07-15 05:35:20.4900000',N'15:00',N'Seguimiento',N'',32,234,2),
	 (N'Completada','2026-03-01','2026-07-15 05:35:20.4966667',N'14:00',N'Interconsulta',N'',2,289,1),
	 (N'Completada','2026-05-22','2026-07-15 05:35:20.5000000',N'15:00',N'Chequeo',N'',4,289,3);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Cancelada','2026-04-06','2026-07-15 05:35:20.5033333',N'14:00',N'Consulta',N'',5,160,4),
	 (N'Completada','2026-05-02','2026-07-15 05:35:20.5100000',N'14:00',N'Dolor',N'',5,273,4),
	 (N'Cancelada','2026-05-31','2026-07-15 05:35:20.5133333',N'10:00',N'Interconsulta',N'',9,22,8),
	 (N'Cancelada','2026-06-06','2026-07-15 05:35:20.5200000',N'14:00',N'Interconsulta',N'',14,199,3),
	 (N'Completada','2026-06-29','2026-07-15 05:35:20.5233333',N'15:00',N'Control',N'',21,72,10),
	 (N'Completada','2026-01-19','2026-07-15 05:35:20.5300000',N'11:00',N'Chequeo',N'',1,42,1),
	 (N'Cancelada','2026-03-08','2026-07-15 05:35:20.5333333',N'09:00',N'Evaluación',N'',8,189,7),
	 (N'Completada','2026-05-10','2026-07-15 05:35:20.5400000',N'14:00',N'Seguimiento',N'',6,90,5),
	 (N'Completada','2026-04-13','2026-07-15 05:35:20.5433333',N'10:00',N'Control',N'',15,30,4),
	 (N'Completada','2026-02-18','2026-07-15 05:35:20.5466667',N'10:00',N'Interconsulta',N'',3,69,2);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-05-29','2026-07-15 05:35:20.5533333',N'14:00',N'Evaluación',N'',1,126,1),
	 (N'Completada','2026-05-31','2026-07-15 05:35:20.5600000',N'16:00',N'Consulta',N'',35,192,5),
	 (N'Completada','2026-05-27','2026-07-15 05:35:20.5633333',N'15:00',N'Dolor',N'',32,177,2),
	 (N'Completada','2026-06-22','2026-07-15 05:35:20.5666667',N'11:00',N'Seguimiento',N'',15,196,4),
	 (N'Completada','2026-05-31','2026-07-15 05:35:20.5700000',N'14:00',N'Dolor',N'',6,291,5),
	 (N'Completada','2026-05-27','2026-07-15 05:35:20.5766667',N'14:00',N'Chequeo',N'',17,138,6),
	 (N'Programada','2026-11-14','2026-07-15 05:35:20.5800000',N'08:00',N'Revisión',N'',21,277,10),
	 (N'Cancelada','2026-04-06','2026-07-15 05:35:20.5866667',N'15:00',N'Chequeo',N'',27,292,12),
	 (N'Completada','2026-01-20','2026-07-15 05:35:20.5900000',N'15:00',N'Seguimiento',N'',14,301,3),
	 (N'Completada','2026-03-15','2026-07-15 05:35:20.5966667',N'16:00',N'Dolor',N'',13,150,2);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-05-13','2026-07-15 05:35:20.6000000',N'08:00',N'Revisión',N'',16,74,5),
	 (N'Programada','2026-09-12','2026-07-15 05:35:20.6033333',N'09:00',N'Consulta',N'',38,49,8),
	 (N'Completada','2026-04-06','2026-07-15 05:35:20.6100000',N'11:00',N'Chequeo',N'',2,218,1),
	 (N'Completada','2026-06-01','2026-07-15 05:35:20.6166667',N'16:00',N'Interconsulta',N'',25,143,12),
	 (N'Completada','2026-02-23','2026-07-15 05:35:20.6233333',N'15:00',N'Chequeo',N'',3,11,2),
	 (N'Completada','2026-05-17','2026-07-15 05:35:20.6266667',N'11:00',N'Interconsulta',N'',17,28,6),
	 (N'Completada','2026-04-04','2026-07-15 05:35:20.6300000',N'09:00',N'Seguimiento',N'',17,62,6),
	 (N'Completada','2026-05-29','2026-07-15 05:35:20.6366667',N'10:00',N'Control',N'',40,218,10),
	 (N'Completada','2026-05-12','2026-07-15 05:35:20.6400000',N'16:00',N'Seguimiento',N'',1,235,1),
	 (N'Programada','2026-10-28','2026-07-15 05:35:20.6433333',N'08:00',N'Seguimiento',N'',9,80,8);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-06-03','2026-07-15 05:35:20.6500000',N'09:00',N'Chequeo',N'',32,114,2),
	 (N'Completada','2026-05-31','2026-07-15 05:35:20.6533333',N'14:00',N'Consulta',N'',4,174,3),
	 (N'Cancelada','2026-03-29','2026-07-15 05:35:20.6566667',N'15:00',N'Dolor',N'',19,216,8),
	 (N'Cancelada','2026-01-29','2026-07-15 05:35:20.6600000',N'11:00',N'Consulta',N'',13,36,2),
	 (N'Programada','2026-12-05','2026-07-15 05:35:20.6633333',N'09:00',N'Seguimiento',N'',18,157,7),
	 (N'Cancelada','2026-01-31','2026-07-15 05:35:20.6700000',N'10:00',N'Consulta',N'',32,242,2),
	 (N'Cancelada','2026-01-24','2026-07-15 05:35:20.6700000',N'15:00',N'Dolor',N'',4,8,3),
	 (N'Programada','2026-11-23','2026-07-15 05:35:20.6733333',N'15:00',N'Interconsulta',N'',3,209,2),
	 (N'Programada','2026-09-05','2026-07-15 05:35:20.6766667',N'10:00',N'Dolor',N'',10,89,9),
	 (N'Completada','2026-03-05','2026-07-15 05:35:20.6866667',N'14:00',N'Seguimiento',N'',15,287,4);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-02-21','2026-07-15 05:38:41.8266667',N'10:00',N'Consulta',N'',4,248,3),
	 (N'Cancelada','2026-02-04','2026-07-15 05:38:41.8333333',N'15:00',N'Dolor',N'',32,141,2),
	 (N'Completada','2026-05-03','2026-07-15 05:38:41.8400000',N'11:00',N'Interconsulta',N'',2,123,1),
	 (N'Completada','2026-04-26','2026-07-15 05:38:41.8433333',N'15:00',N'Seguimiento',N'',12,260,1),
	 (N'Programada','2026-12-01','2026-07-15 05:38:41.8466667',N'14:00',N'Chequeo',N'',3,266,2),
	 (N'Cancelada','2026-02-10','2026-07-15 05:38:41.8500000',N'08:00',N'Control anual',N'',2,40,1),
	 (N'Completada','2026-04-11','2026-07-15 05:38:41.8533333',N'15:00',N'Control',N'',18,40,7),
	 (N'Programada','2026-10-23','2026-07-15 05:38:41.8566667',N'11:00',N'Interconsulta',N'',5,119,4),
	 (N'Cancelada','2026-06-15','2026-07-15 05:38:41.8566667',N'10:00',N'Control anual',N'',3,183,2),
	 (N'Completada','2026-02-27','2026-07-15 05:38:41.8600000',N'10:00',N'Consulta',N'',1,122,1);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-01-17','2026-07-15 05:38:41.8666667',N'16:00',N'Dolor',N'',7,84,6),
	 (N'Completada','2026-05-12','2026-07-15 05:38:41.8700000',N'11:00',N'Revisión',N'',17,301,6),
	 (N'Completada','2026-02-27','2026-07-15 05:38:41.8733333',N'10:00',N'Control',N'',4,283,3),
	 (N'Completada','2026-06-20','2026-07-15 05:38:41.8733333',N'08:00',N'Revisión',N'',15,57,4),
	 (N'Completada','2026-01-07','2026-07-15 05:38:41.8800000',N'09:00',N'Control anual',N'',36,293,6),
	 (N'Completada','2026-06-06','2026-07-15 05:38:41.8833333',N'08:00',N'Seguimiento',N'',13,89,2),
	 (N'Completada','2026-01-30','2026-07-15 05:38:41.8866667',N'16:00',N'Consulta',N'',34,8,4),
	 (N'Completada','2026-04-15','2026-07-15 05:38:41.8900000',N'09:00',N'Evaluación',N'',13,187,2),
	 (N'Programada','2026-10-21','2026-07-15 05:38:41.8933333',N'09:00',N'Revisión',N'',1,235,1),
	 (N'Completada','2026-01-10','2026-07-15 05:38:41.9000000',N'11:00',N'Control',N'',4,147,3);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-04-23','2026-07-15 05:38:41.9033333',N'15:00',N'Evaluación',N'',12,48,1),
	 (N'Completada','2026-01-11','2026-07-15 05:38:41.9066667',N'08:00',N'Chequeo',N'',4,63,3),
	 (N'Completada','2026-01-16','2026-07-15 05:38:41.9100000',N'16:00',N'Dolor',N'',17,291,6),
	 (N'Cancelada','2026-06-19','2026-07-15 05:38:41.9133333',N'16:00',N'Evaluación',N'',9,168,8),
	 (N'Programada','2026-12-11','2026-07-15 05:38:41.9166667',N'16:00',N'Revisión',N'',35,69,5),
	 (N'Completada','2026-02-07','2026-07-15 05:38:41.9200000',N'08:00',N'Revisión',N'',14,111,3),
	 (N'Completada','2026-06-12','2026-07-15 05:38:41.9233333',N'08:00',N'Consulta',N'',2,24,1),
	 (N'Cancelada','2026-06-27','2026-07-15 05:38:41.9266667',N'11:00',N'Control anual',N'',10,43,9),
	 (N'Completada','2026-01-15','2026-07-15 05:38:41.9300000',N'16:00',N'Consulta',N'',3,81,2),
	 (N'Completada','2026-02-23','2026-07-15 05:38:41.9400000',N'15:00',N'Seguimiento',N'',7,11,6);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-01-03','2026-07-15 05:38:41.9500000',N'15:00',N'Consulta',N'',20,254,9),
	 (N'Completada','2026-03-05','2026-07-15 05:38:41.9600000',N'10:00',N'Dolor',N'',1,88,1),
	 (N'Completada','2026-06-04','2026-07-15 05:38:41.9633333',N'08:00',N'Dolor',N'',2,211,1),
	 (N'Completada','2026-06-02','2026-07-15 05:38:41.9700000',N'16:00',N'Interconsulta',N'',1,151,1),
	 (N'Completada','2026-01-14','2026-07-15 05:38:41.9733333',N'15:00',N'Consulta',N'',9,130,8),
	 (N'Completada','2026-03-08','2026-07-15 05:38:41.9766667',N'15:00',N'Interconsulta',N'',33,95,3),
	 (N'Cancelada','2026-03-12','2026-07-15 05:38:41.9800000',N'09:00',N'Revisión',N'',23,208,11),
	 (N'Programada','2026-10-08','2026-07-15 05:38:41.9866667',N'11:00',N'Revisión',N'',38,189,8),
	 (N'Programada','2026-10-10','2026-07-15 05:38:41.9900000',N'08:00',N'Interconsulta',N'',24,238,11),
	 (N'Completada','2026-04-11','2026-07-15 05:38:41.9933333',N'14:00',N'Revisión',N'',26,240,12);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-02-26','2026-07-15 05:38:41.9966667',N'15:00',N'Control',N'',16,122,5),
	 (N'Programada','2026-12-14','2026-07-15 05:38:42.0000000',N'09:00',N'Revisión',N'',37,21,7),
	 (N'Cancelada','2026-03-11','2026-07-15 05:38:42.0000000',N'08:00',N'Chequeo',N'',36,16,6),
	 (N'Completada','2026-06-29','2026-07-15 05:38:42.0033333',N'14:00',N'Interconsulta',N'',24,51,11),
	 (N'Programada','2026-12-27','2026-07-15 05:38:42.0100000',N'09:00',N'Control anual',N'',1,240,1),
	 (N'Completada','2026-04-09','2026-07-15 05:38:42.0100000',N'16:00',N'Control anual',N'',10,294,9),
	 (N'Cancelada','2026-06-21','2026-07-15 05:38:42.0133333',N'14:00',N'Control anual',N'',2,279,1),
	 (N'Completada','2026-04-03','2026-07-15 05:38:42.0166667',N'11:00',N'Dolor',N'',2,186,1),
	 (N'Programada','2026-12-27','2026-07-15 05:38:42.0200000',N'10:00',N'Seguimiento',N'',40,279,10),
	 (N'Programada','2026-11-24','2026-07-15 05:38:42.0266667',N'15:00',N'Chequeo',N'',3,6,2);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-03-16','2026-07-15 05:38:42.0300000',N'08:00',N'Chequeo',N'',42,146,14),
	 (N'Programada','2026-12-21','2026-07-15 05:38:42.0333333',N'15:00',N'Control anual',N'',1,274,1),
	 (N'Completada','2026-06-14','2026-07-15 05:38:42.0366667',N'16:00',N'Consulta',N'',4,132,3),
	 (N'Cancelada','2026-05-13','2026-07-15 05:38:42.0400000',N'10:00',N'Seguimiento',N'',12,232,1),
	 (N'Completada','2026-01-22','2026-07-15 05:38:42.0433333',N'16:00',N'Chequeo',N'',1,118,1),
	 (N'Completada','2026-01-02','2026-07-15 05:38:42.0500000',N'15:00',N'Dolor',N'',36,197,6),
	 (N'Completada','2026-06-26','2026-07-15 05:38:42.0500000',N'08:00',N'Control anual',N'',32,228,2),
	 (N'Completada','2026-01-18','2026-07-15 05:38:42.0566667',N'14:00',N'Interconsulta',N'',34,274,4),
	 (N'Completada','2026-02-09','2026-07-15 05:38:42.0600000',N'09:00',N'Dolor',N'',30,85,13),
	 (N'Completada','2026-02-12','2026-07-15 05:38:42.0633333',N'15:00',N'Control anual',N'',32,139,2);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-05-12','2026-07-15 05:38:42.0666667',N'08:00',N'Revisión',N'',2,87,1),
	 (N'Completada','2026-02-07','2026-07-15 05:38:42.0700000',N'08:00',N'Interconsulta',N'',17,294,6),
	 (N'Completada','2026-03-05','2026-07-15 05:38:42.0766667',N'14:00',N'Control anual',N'',1,144,1),
	 (N'Programada','2026-10-23','2026-07-15 05:38:42.0800000',N'10:00',N'Seguimiento',N'',11,232,10),
	 (N'Completada','2026-05-27','2026-07-15 05:38:42.0833333',N'11:00',N'Control',N'',13,287,2),
	 (N'Completada','2026-05-15','2026-07-15 05:38:42.0866667',N'14:00',N'Consulta',N'',33,24,3),
	 (N'Completada','2026-05-09','2026-07-15 05:38:42.0900000',N'09:00',N'Consulta',N'',8,69,7),
	 (N'Completada','2026-04-25','2026-07-15 05:38:42.0966667',N'16:00',N'Consulta',N'',32,72,2),
	 (N'Cancelada','2026-04-23','2026-07-15 05:38:42.1000000',N'15:00',N'Control',N'',12,29,1),
	 (N'Cancelada','2026-03-04','2026-07-15 05:38:42.1033333',N'14:00',N'Control',N'',18,150,7);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-05-26','2026-07-15 05:38:42.1066667',N'08:00',N'Control',N'',32,98,2),
	 (N'Completada','2026-05-31','2026-07-15 05:38:42.1100000',N'15:00',N'Chequeo',N'',14,188,3),
	 (N'Programada','2026-10-29','2026-07-15 05:38:42.1133333',N'15:00',N'Seguimiento',N'',2,136,1),
	 (N'Completada','2026-03-28','2026-07-15 05:38:42.1166667',N'15:00',N'Revisión',N'',16,99,5),
	 (N'Programada','2026-11-27','2026-07-15 05:38:42.1166667',N'15:00',N'Chequeo',N'',9,165,8),
	 (N'Completada','2026-04-15','2026-07-15 05:38:42.1200000',N'11:00',N'Evaluación',N'',2,229,1),
	 (N'Completada','2026-02-02','2026-07-15 05:38:42.1233333',N'11:00',N'Control anual',N'',4,123,3),
	 (N'Completada','2026-03-16','2026-07-15 05:38:42.1266667',N'09:00',N'Control anual',N'',1,2,1),
	 (N'Completada','2026-06-24','2026-07-15 05:38:42.1300000',N'16:00',N'Consulta',N'',16,115,5),
	 (N'Completada','2026-05-07','2026-07-15 05:38:42.1333333',N'10:00',N'Seguimiento',N'',12,293,1);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-05-30','2026-07-15 05:38:42.1366667',N'16:00',N'Chequeo',N'',18,70,7),
	 (N'Completada','2026-06-23','2026-07-15 05:38:42.1400000',N'15:00',N'Chequeo',N'',4,173,3),
	 (N'Completada','2026-06-29','2026-07-15 05:38:42.1400000',N'09:00',N'Dolor',N'',3,88,2),
	 (N'Completada','2026-06-20','2026-07-15 05:38:42.1466667',N'16:00',N'Dolor',N'',2,2,1),
	 (N'Completada','2026-05-10','2026-07-15 05:38:42.1533333',N'08:00',N'Interconsulta',N'',13,7,2),
	 (N'Completada','2026-02-04','2026-07-15 05:38:42.1566667',N'15:00',N'Interconsulta',N'',4,200,3),
	 (N'Completada','2026-02-25','2026-07-15 05:38:42.1600000',N'09:00',N'Control anual',N'',13,241,2),
	 (N'Completada','2026-02-24','2026-07-15 05:38:42.1633333',N'16:00',N'Evaluación',N'',9,80,8),
	 (N'Programada','2026-12-10','2026-07-15 05:38:42.1700000',N'16:00',N'Evaluación',N'',29,53,13),
	 (N'Programada','2026-11-14','2026-07-15 05:38:42.1733333',N'14:00',N'Control',N'',2,128,1);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-02-25','2026-07-15 05:38:42.1766667',N'08:00',N'Control',N'',35,242,5),
	 (N'Cancelada','2026-02-06','2026-07-15 05:38:42.1800000',N'08:00',N'Control',N'',35,62,5),
	 (N'Completada','2026-01-02','2026-07-15 05:38:42.1833333',N'15:00',N'Dolor',N'',8,91,7),
	 (N'Completada','2026-06-03','2026-07-15 05:38:42.1866667',N'15:00',N'Dolor',N'',35,204,5),
	 (N'Completada','2026-05-11','2026-07-15 05:38:42.1900000',N'16:00',N'Interconsulta',N'',35,67,5),
	 (N'Completada','2026-04-18','2026-07-15 05:38:42.1966667',N'14:00',N'Control anual',N'',5,62,4),
	 (N'Cancelada','2026-03-29','2026-07-15 05:38:42.2000000',N'08:00',N'Revisión',N'',2,34,1),
	 (N'Completada','2026-01-13','2026-07-15 05:38:42.2033333',N'08:00',N'Consulta',N'',17,286,6),
	 (N'Completada','2026-05-29','2026-07-15 05:38:42.2066667',N'16:00',N'Seguimiento',N'',7,183,6),
	 (N'Completada','2026-02-22','2026-07-15 05:38:42.2100000',N'16:00',N'Revisión',N'',10,232,9);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Programada','2026-10-25','2026-07-15 05:38:42.2166667',N'14:00',N'Chequeo',N'',9,273,8),
	 (N'Cancelada','2026-01-02','2026-07-15 05:38:42.2200000',N'11:00',N'Chequeo',N'',36,27,6),
	 (N'Completada','2026-01-23','2026-07-15 05:38:42.2233333',N'14:00',N'Interconsulta',N'',33,172,3),
	 (N'Completada','2026-03-24','2026-07-15 05:38:42.2266667',N'10:00',N'Consulta',N'',12,74,1),
	 (N'Completada','2026-05-18','2026-07-15 05:38:42.2300000',N'10:00',N'Dolor',N'',12,127,1),
	 (N'Cancelada','2026-03-12','2026-07-15 05:38:42.2333333',N'11:00',N'Interconsulta',N'',12,91,1),
	 (N'Completada','2026-02-25','2026-07-15 05:38:42.2333333',N'10:00',N'Chequeo',N'',35,93,5),
	 (N'Programada','2026-09-20','2026-07-15 05:38:42.2366667',N'16:00',N'Consulta',N'',16,150,5),
	 (N'Completada','2026-01-21','2026-07-15 05:38:42.2400000',N'14:00',N'Control',N'',19,38,8),
	 (N'Cancelada','2026-03-03','2026-07-15 05:38:42.2433333',N'16:00',N'Interconsulta',N'',17,156,6);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-02-03','2026-07-15 05:38:42.2466667',N'16:00',N'Evaluación',N'',16,23,5),
	 (N'Programada','2026-10-23','2026-07-15 05:38:42.2500000',N'08:00',N'Control',N'',32,298,2),
	 (N'Completada','2026-06-03','2026-07-15 05:38:42.2566667',N'15:00',N'Seguimiento',N'',33,69,3),
	 (N'Completada','2026-02-25','2026-07-15 05:38:42.2600000',N'10:00',N'Consulta',N'',17,254,6),
	 (N'Cancelada','2026-06-07','2026-07-15 05:38:42.2666667',N'09:00',N'Revisión',N'',36,228,6),
	 (N'Completada','2026-02-11','2026-07-15 05:38:42.2700000',N'11:00',N'Control',N'',22,221,11),
	 (N'Completada','2026-01-18','2026-07-15 05:38:42.2733333',N'10:00',N'Control',N'',6,123,5),
	 (N'Programada','2026-09-20','2026-07-15 05:38:42.2733333',N'15:00',N'Seguimiento',N'',10,95,9),
	 (N'Completada','2026-05-01','2026-07-15 05:38:42.2766667',N'08:00',N'Evaluación',N'',36,113,6),
	 (N'Completada','2026-05-22','2026-07-15 05:38:42.2800000',N'10:00',N'Control',N'',34,98,4);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-02-14','2026-07-15 05:38:42.2833333',N'11:00',N'Control',N'',8,150,7),
	 (N'Programada','2026-11-21','2026-07-15 05:38:42.2900000',N'10:00',N'Control',N'',38,236,8),
	 (N'Completada','2026-04-29','2026-07-15 05:38:42.2900000',N'10:00',N'Control anual',N'',14,258,3),
	 (N'Completada','2026-03-10','2026-07-15 05:38:42.2933333',N'11:00',N'Interconsulta',N'',13,159,2),
	 (N'Completada','2026-01-03','2026-07-15 05:38:42.2966667',N'15:00',N'Evaluación',N'',38,11,8),
	 (N'Cancelada','2026-04-06','2026-07-15 05:38:42.3000000',N'11:00',N'Chequeo',N'',2,66,1),
	 (N'Completada','2026-01-23','2026-07-15 05:38:42.3000000',N'11:00',N'Control anual',N'',19,112,8),
	 (N'Completada','2026-06-04','2026-07-15 05:38:42.3066667',N'11:00',N'Chequeo',N'',3,237,2),
	 (N'Completada','2026-05-25','2026-07-15 05:38:42.3100000',N'09:00',N'Seguimiento',N'',13,8,2),
	 (N'Completada','2026-01-20','2026-07-15 05:38:42.3133333',N'08:00',N'Dolor',N'',14,299,3);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-06-04','2026-07-15 05:38:42.3166667',N'11:00',N'Control',N'',8,152,7),
	 (N'Completada','2026-06-29','2026-07-15 05:38:42.3200000',N'14:00',N'Seguimiento',N'',15,61,4),
	 (N'Completada','2026-04-20','2026-07-15 05:38:42.3200000',N'10:00',N'Chequeo',N'',15,64,4),
	 (N'Programada','2026-12-29','2026-07-15 05:38:42.3266667',N'09:00',N'Dolor',N'',17,161,6),
	 (N'Cancelada','2026-02-08','2026-07-15 05:38:42.3300000',N'14:00',N'Evaluación',N'',4,116,3),
	 (N'Programada','2026-09-05','2026-07-15 05:38:42.3333333',N'10:00',N'Revisión',N'',15,110,4),
	 (N'Completada','2026-05-10','2026-07-15 05:38:42.3366667',N'08:00',N'Control',N'',19,35,8),
	 (N'Programada','2026-10-05','2026-07-15 05:38:42.3400000',N'09:00',N'Consulta',N'',34,271,4),
	 (N'Completada','2026-04-15','2026-07-15 05:38:42.3466667',N'14:00',N'Consulta',N'',32,4,2),
	 (N'Completada','2026-02-26','2026-07-15 05:38:42.3500000',N'10:00',N'Evaluación',N'',12,135,1);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-02-05','2026-07-15 05:38:42.3533333',N'10:00',N'Control anual',N'',17,272,6),
	 (N'Completada','2026-03-31','2026-07-15 05:38:42.3566667',N'16:00',N'Interconsulta',N'',4,49,3),
	 (N'Cancelada','2026-02-27','2026-07-15 05:38:42.3600000',N'11:00',N'Dolor',N'',34,106,4),
	 (N'Completada','2026-04-09','2026-07-15 05:38:42.3633333',N'09:00',N'Control',N'',36,293,6),
	 (N'Completada','2026-04-24','2026-07-15 05:38:42.3666667',N'14:00',N'Evaluación',N'',13,120,2),
	 (N'Completada','2026-03-06','2026-07-15 05:38:42.3733333',N'15:00',N'Seguimiento',N'',2,131,1),
	 (N'Completada','2026-03-24','2026-07-15 05:38:42.3766667',N'14:00',N'Revisión',N'',13,118,2),
	 (N'Completada','2026-05-06','2026-07-15 05:38:42.3800000',N'10:00',N'Revisión',N'',7,50,6),
	 (N'Cancelada','2026-03-20','2026-07-15 05:38:42.3833333',N'10:00',N'Control',N'',25,250,12),
	 (N'Completada','2026-06-05','2026-07-15 05:38:42.3900000',N'10:00',N'Consulta',N'',36,77,6);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Cancelada','2026-03-31','2026-07-15 05:38:42.3900000',N'10:00',N'Revisión',N'',22,75,11),
	 (N'Completada','2026-05-05','2026-07-15 05:38:42.3933333',N'09:00',N'Control',N'',14,64,3),
	 (N'Completada','2026-05-23','2026-07-15 05:38:42.3966667',N'15:00',N'Control anual',N'',3,258,2),
	 (N'Completada','2026-02-22','2026-07-15 05:38:42.4000000',N'15:00',N'Dolor',N'',17,42,6),
	 (N'Completada','2026-01-24','2026-07-15 05:38:42.4033333',N'16:00',N'Seguimiento',N'',1,5,1),
	 (N'Completada','2026-02-09','2026-07-15 05:38:42.4100000',N'08:00',N'Seguimiento',N'',4,212,3),
	 (N'Completada','2026-06-24','2026-07-15 05:38:42.4100000',N'09:00',N'Evaluación',N'',1,138,1),
	 (N'Programada','2026-11-12','2026-07-15 05:38:42.4133333',N'15:00',N'Chequeo',N'',5,97,4),
	 (N'Completada','2026-01-27','2026-07-15 05:38:42.4200000',N'11:00',N'Interconsulta',N'',21,252,10),
	 (N'Completada','2026-03-26','2026-07-15 05:38:42.4233333',N'15:00',N'Consulta',N'',36,215,6);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Programada','2026-10-22','2026-07-15 05:38:42.4266667',N'14:00',N'Seguimiento',N'',32,168,2),
	 (N'Completada','2026-06-23','2026-07-15 05:38:42.4300000',N'10:00',N'Interconsulta',N'',1,108,1),
	 (N'Completada','2026-03-21','2026-07-15 05:38:42.4333333',N'14:00',N'Dolor',N'',8,265,7),
	 (N'Completada','2026-04-30','2026-07-15 05:38:42.4366667',N'14:00',N'Chequeo',N'',33,118,3),
	 (N'Programada','2026-09-13','2026-07-15 05:38:42.4433333',N'15:00',N'Control',N'',39,218,9),
	 (N'Completada','2026-04-30','2026-07-15 05:38:42.4500000',N'10:00',N'Seguimiento',N'',17,34,6),
	 (N'Programada','2026-09-03','2026-07-15 05:38:42.4533333',N'08:00',N'Control',N'',20,51,9),
	 (N'Programada','2026-11-22','2026-07-15 05:38:42.4566667',N'08:00',N'Seguimiento',N'',35,32,5),
	 (N'Completada','2026-01-28','2026-07-15 05:38:42.4600000',N'09:00',N'Seguimiento',N'',7,169,6),
	 (N'Completada','2026-01-06','2026-07-15 05:38:42.4633333',N'14:00',N'Seguimiento',N'',15,154,4);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-02-02','2026-07-15 05:38:42.4700000',N'11:00',N'Consulta',N'',38,209,8),
	 (N'Completada','2026-01-21','2026-07-15 05:38:42.4766667',N'08:00',N'Control',N'',33,192,3),
	 (N'Programada','2026-12-14','2026-07-15 05:38:42.4800000',N'08:00',N'Chequeo',N'',33,75,3),
	 (N'Cancelada','2026-04-28','2026-07-15 05:38:42.4833333',N'09:00',N'Control anual',N'',3,280,2),
	 (N'Completada','2026-06-15','2026-07-15 05:38:42.4866667',N'08:00',N'Revisión',N'',13,111,2),
	 (N'Completada','2026-02-24','2026-07-15 05:38:42.4900000',N'15:00',N'Evaluación',N'',3,266,2),
	 (N'Programada','2026-12-28','2026-07-15 05:38:42.4933333',N'15:00',N'Chequeo',N'',17,155,6),
	 (N'Completada','2026-03-12','2026-07-15 05:38:42.4966667',N'11:00',N'Seguimiento',N'',8,224,7),
	 (N'Completada','2026-04-23','2026-07-15 05:38:42.5000000',N'14:00',N'Chequeo',N'',22,161,11),
	 (N'Completada','2026-04-14','2026-07-15 05:38:42.5033333',N'09:00',N'Revisión',N'',4,235,3);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-04-14','2026-07-15 05:38:42.5066667',N'08:00',N'Chequeo',N'',3,203,2),
	 (N'Completada','2026-06-28','2026-07-15 05:38:42.5100000',N'10:00',N'Chequeo',N'',1,63,1),
	 (N'Completada','2026-05-09','2026-07-15 05:38:42.5133333',N'14:00',N'Chequeo',N'',30,274,13),
	 (N'Completada','2026-05-24','2026-07-15 05:38:42.5166667',N'09:00',N'Control',N'',17,174,6),
	 (N'Completada','2026-04-19','2026-07-15 05:38:42.5200000',N'08:00',N'Control anual',N'',5,51,4),
	 (N'Completada','2026-06-26','2026-07-15 05:38:42.5233333',N'09:00',N'Control anual',N'',32,191,2),
	 (N'Cancelada','2026-06-09','2026-07-15 05:38:42.5266667',N'08:00',N'Dolor',N'',1,87,1),
	 (N'Completada','2026-03-28','2026-07-15 05:38:42.5300000',N'11:00',N'Dolor',N'',15,206,4),
	 (N'Completada','2026-01-01','2026-07-15 05:38:42.5333333',N'16:00',N'Control anual',N'',12,28,1),
	 (N'Completada','2026-01-14','2026-07-15 05:38:42.5366667',N'16:00',N'Interconsulta',N'',5,231,4);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-05-30','2026-07-15 05:38:42.5400000',N'16:00',N'Interconsulta',N'',22,81,11),
	 (N'Completada','2026-01-10','2026-07-15 05:38:42.5433333',N'11:00',N'Consulta',N'',35,147,5),
	 (N'Completada','2026-06-25','2026-07-15 05:38:42.5466667',N'14:00',N'Consulta',N'',4,156,3),
	 (N'Completada','2026-05-31','2026-07-15 05:38:42.5500000',N'16:00',N'Control',N'',3,141,2),
	 (N'Completada','2026-04-04','2026-07-15 05:38:42.5533333',N'08:00',N'Dolor',N'',3,273,2),
	 (N'Completada','2026-02-26','2026-07-15 05:38:42.5566667',N'16:00',N'Control anual',N'',12,60,1),
	 (N'Completada','2026-04-03','2026-07-15 05:38:42.5600000',N'08:00',N'Control',N'',1,247,1),
	 (N'Programada','2026-09-22','2026-07-15 05:38:42.5633333',N'10:00',N'Seguimiento',N'',7,101,6),
	 (N'Completada','2026-03-08','2026-07-15 05:38:42.5666667',N'15:00',N'Evaluación',N'',1,287,1),
	 (N'Programada','2026-11-21','2026-07-15 05:38:42.5700000',N'16:00',N'Evaluación',N'',13,199,2);
INSERT INTO bd_clinica.dbo.citas (estado,fecha_cita,fecha_registro,hora_cita,motivo,notas_medicas,id_medico,id_paciente,id_servicio) VALUES
	 (N'Completada','2026-04-15','2026-07-19 02:34:57.2066667',N'09:00',N'Control médico',N'Paciente estable. Se prescribe tratamiento.',34,1,4),
	 (N'Completada','2026-07-20','2026-07-19 02:34:57.2066667',N'10:30',N'Seguimiento',N'Buena evolución clínica.',34,1,4),
	 (N'Pendiente','2026-08-17','2026-07-19 00:34:11.4197382',N'04:00 PM',NULL,NULL,6,1,1);
INSERT INTO bd_clinica.dbo.codigos_verificacion (id_usuario,codigo,fecha_generacion,fecha_expiracion,usado) VALUES
	 (9,N'725433','2026-07-16 21:46:26.7277810','2026-07-16 21:51:26.7277810',1),
	 (9,N'719474','2026-07-16 21:49:14.1340638','2026-07-16 21:54:14.1340638',1),
	 (9,N'212789','2026-07-16 21:53:40.6433949','2026-07-16 21:58:40.6433949',1),
	 (9,N'743512','2026-07-16 22:02:09.8916928','2026-07-16 22:07:09.8916928',1),
	 (9,N'464578','2026-07-16 22:06:31.8214258','2026-07-16 22:11:31.8214258',1),
	 (9,N'853998','2026-07-16 22:16:43.7889020','2026-07-16 22:21:43.7889020',1),
	 (9,N'994204','2026-07-16 22:21:41.8531410','2026-07-16 22:26:41.8531410',1),
	 (9,N'016346','2026-07-16 22:26:56.7845908','2026-07-16 22:31:56.7845908',1),
	 (7,N'486924','2026-07-17 00:40:58.1169668','2026-07-17 00:45:58.1169668',1),
	 (8,N'982474','2026-07-17 00:46:02.9410938','2026-07-17 00:51:02.9410938',1);
INSERT INTO bd_clinica.dbo.codigos_verificacion (id_usuario,codigo,fecha_generacion,fecha_expiracion,usado) VALUES
	 (355,N'132363','2026-07-17 00:48:45.6330235','2026-07-17 00:53:45.6330235',1),
	 (8,N'241598','2026-07-17 00:50:36.9806720','2026-07-17 00:55:36.9806720',1),
	 (8,N'168028','2026-07-17 01:12:01.4813363','2026-07-17 01:17:01.4813363',1),
	 (8,N'055857','2026-07-17 01:21:43.9381437','2026-07-17 01:26:43.9381437',1),
	 (8,N'437720','2026-07-17 01:30:41.6052642','2026-07-17 01:35:41.6052642',1),
	 (8,N'467778','2026-07-17 01:31:57.6551697','2026-07-17 01:36:57.6551697',1),
	 (8,N'219144','2026-07-17 01:56:37.7329041','2026-07-17 02:01:37.7329041',1),
	 (8,N'596876','2026-07-17 12:11:43.1711254','2026-07-17 12:16:43.1711254',1),
	 (8,N'332479','2026-07-17 12:15:14.6345943','2026-07-17 12:20:14.6345943',1),
	 (8,N'159635','2026-07-17 12:18:36.9581213','2026-07-17 12:23:36.9581213',1);
INSERT INTO bd_clinica.dbo.codigos_verificacion (id_usuario,codigo,fecha_generacion,fecha_expiracion,usado) VALUES
	 (8,N'464940','2026-07-17 13:38:24.9162701','2026-07-17 13:43:24.9162701',1),
	 (8,N'277598','2026-07-17 13:42:45.2524421','2026-07-17 13:47:45.2524421',1),
	 (8,N'164904','2026-07-17 14:03:07.3431306','2026-07-17 14:08:07.3431306',1),
	 (8,N'893631','2026-07-17 19:18:31.4423829','2026-07-17 19:23:31.4423829',1),
	 (8,N'716179','2026-07-17 19:25:33.6760071','2026-07-17 19:30:33.6760071',1),
	 (7,N'184441','2026-07-17 19:32:23.8043013','2026-07-17 19:37:23.8043013',1),
	 (8,N'093741','2026-07-18 20:13:57.2244051','2026-07-18 20:18:57.2244051',1),
	 (8,N'802706','2026-07-18 20:47:35.5069606','2026-07-18 20:52:35.5069606',1),
	 (8,N'011468','2026-07-18 21:01:52.0818845','2026-07-18 21:06:52.0818845',1),
	 (8,N'167429','2026-07-18 21:25:19.9659833','2026-07-18 21:30:19.9659833',1);
INSERT INTO bd_clinica.dbo.codigos_verificacion (id_usuario,codigo,fecha_generacion,fecha_expiracion,usado) VALUES
	 (8,N'613689','2026-07-18 22:38:17.5100185','2026-07-18 22:43:17.5100185',1),
	 (8,N'690844','2026-07-19 00:31:46.6373057','2026-07-19 00:36:46.6373057',1),
	 (7,N'905880','2026-07-19 01:12:06.4415457','2026-07-19 01:17:06.4415457',1);
INSERT INTO bd_clinica.dbo.especialidades (color,descripcion,estado,icono,imagen_url,nombre) VALUES
	 (N'#2563EB',N'Atención primaria.',1,N'bi-hospital-fill',N'https://placehold.co/400x300/DBEAFE/1E40AF?text=Medicina+General',N'Medicina General'),
	 (N'#059669',N'Cuidado de niños.',1,N'bi-balloon-heart-fill',N'https://placehold.co/400x300/D1FAE5/065F46?text=Pediatría',N'Pediatría'),
	 (N'#DB2777',N'Salud femenina.',1,N'bi-person-hearts',N'https://placehold.co/400x300/FCE7F3/9D174D?text=Ginecología',N'Ginecología'),
	 (N'#DC2626',N'Salud del corazón.',1,N'bi-heart-pulse-fill',N'https://placehold.co/400x300/FEE2E2/991B1B?text=Cardiología',N'Cardiología'),
	 (N'#6C63FF',N'Especialidad del sistema nervioso.',1,N'bi-cpu-fill',N'https://placehold.co/400x300/6C63FF/FFFFFF',N'Neurología'),
	 (N'#00ACC1',N'Especialidad de huesos y articulaciones.',1,N'bi-bandaid-fill',N'https://placehold.co/400x300/00ACC1/FFFFFF',N'Traumatología'),
	 (N'#FF7043',N'Especialidad de piel y anexos.',1,N'bi-droplet-fill',N'https://placehold.co/400x300/FF7043/FFFFFF',N'Dermatología'),
	 (N'#5C6BC0',N'Especialidad de la visión.',1,N'bi-eye-fill',N'https://placehold.co/400x300/5C6BC0/FFFFFF',N'Oftalmología'),
	 (N'#43A047',N'Especialidad hormonal.',1,N'bi-clipboard2-pulse-fill',N'https://placehold.co/400x300/43A047/FFFFFF',N'Endocrinología'),
	 (N'#EF5350',N'Oídos, nariz y garganta.',1,N'bi-ear-fill',N'https://placehold.co/400x300/EF5350/FFFFFF',N'Otorrinolaringología');
INSERT INTO bd_clinica.dbo.especialidades (color,descripcion,estado,icono,imagen_url,nombre) VALUES
	 (N'#1E88E5',N'Especialidad del aparato urinario y sistema reproductor masculino.',1,N'bi-gender-male',N'https://placehold.co/400x300/1E88E5/FFFFFF?text=Urología',N'Urología'),
	 (N'#26A69A',N'Especialidad de enfermedades del aparato respiratorio.',1,N'bi-lungs-fill',N'https://placehold.co/400x300/26A69A/FFFFFF?text=Neumología',N'Neumología'),
	 (N'#8E24AA',N'Especialidad de enfermedades articulares y autoinmunes.',1,N'bi-person-walking',N'https://placehold.co/400x300/8E24AA/FFFFFF?text=Reumatología',N'Reumatología'),
	 (N'#FB8C00',N'Especialidad del aparato digestivo.',1,N'bi-capsule',N'https://placehold.co/400x300/FB8C00/FFFFFF?text=Gastroenterología',N'Gastroenterología'),
	 (N'#D81B60',N'Especialidad para el diagnóstico y tratamiento del cáncer.',1,N'bi-shield-plus',N'https://placehold.co/400x300/D81B60/FFFFFF?text=Oncología',N'Oncología');
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',3),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',3),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',4),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',4),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',5),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',5),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',6),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',6),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',7),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',7);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',8),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',8),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',9),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',9),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',10),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',10),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',11),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',11),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',12),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',12);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',13),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',13),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',14),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',14),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',15),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',15),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',16),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',16),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',17),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',17);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',18),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',18),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',19),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',19),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',20),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',20),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',21),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',21),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',22),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',22);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',23),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',23),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',24),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',24),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',25),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',25),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',26),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',26),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',27),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',27);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',28),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',28),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',29),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',29),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',30),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',30),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',31),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',31),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',32),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',32);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',33),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',33),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',34),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',34),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',35),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',35),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',36),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',36),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',37),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',37);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',38),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',38),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',39),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',39),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',40),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',40),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',41),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',41),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',42),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',42);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',43),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',43),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',44),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',44),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',45),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',45),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',46),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',46),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',47),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',47);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',48),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',48),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',49),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',49),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',50),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',50),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',51),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',51),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',52),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',52);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',53),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',53),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',54),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',54),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',55),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',55),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',56),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',56),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',57),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',57);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',58),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',58),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',59),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',59),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',60),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',60),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',61),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',61),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',62),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',62);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',63),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',63),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',64),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',64),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',65),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',65),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',66),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',66),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',67),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',67);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',68),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',68),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',69),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',69),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',70),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',70),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',71),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',71),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',72),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',72);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',73),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',73),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',74),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',74),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',75),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',75),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',76),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',76),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',77),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',77);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',78),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',78),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',79),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',79),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',80),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',80),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',81),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',81),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',82),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',82);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',83),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',83),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',84),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',84),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',85),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',85),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',86),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',86),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',87),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',87);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',88),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',88),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',89),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',89),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',90),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',90),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',91),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',91),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',92),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',92);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',93),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',93),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',94),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',94),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',95),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',95),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',96),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',96),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',97),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',97);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',98),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',98),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',99),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',99),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',100),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',100),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',101),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',101),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',102),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',102);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',103),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',103),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',104),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',104),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',105),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',105),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',106),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',106),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',107),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',107);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',108),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',108),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',109),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',109),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',110),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',110),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',111),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',111),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',112),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',112);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',113),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',113),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',114),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',114),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',115),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',115),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',116),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',116),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',117),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',117);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',118),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',118),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',119),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',119),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',120),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',120),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',121),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',121),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',122),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',122);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',123),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',123),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',124),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',124),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',125),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',125),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',126),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',126),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',127),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',127);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',128),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',128),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',129),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',129),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',130),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',130),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',131),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',131),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',132),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',132);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',133),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',133),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',134),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',134),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',135),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',135),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',136),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',136),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',137),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',137);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',138),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',138),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',139),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',139),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',140),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',140),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',141),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',141),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',142),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',142);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',143),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',143),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',144),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',144),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',145),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',145),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',146),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',146),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',147),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',147);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',148),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',148),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',149),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',149),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',150),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',150),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',151),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',151),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',152),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',152);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',153),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',153),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',154),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',154),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',155),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',155),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',156),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',156),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',157),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',157);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',158),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',158),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',159),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',159),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',160),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',160),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',161),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',161),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',162),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',162);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',163),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',163),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',164),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',164),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',165),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',165),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',166),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',166),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',167),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',167);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',168),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',168),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',169),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',169),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',170),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',170),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',171),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',171),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',172),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',172);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',173),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',173),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',174),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',174),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',175),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',175),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',176),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',176),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',177),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',177);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',178),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',178),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',179),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',179),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',180),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',180),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',181),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',181),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',182),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',182);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',183),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',183),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',184),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',184),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',185),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',185),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',186),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',186),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',187),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',187);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',188),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',188),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',189),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',189),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',190),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',190),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',191),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',191),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',192),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',192);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',193),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',193),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',194),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',194),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',195),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',195),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',196),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',196),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',197),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',197);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',198),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',198),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',199),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',199),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',200),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',200),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',201),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',201),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',202),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',202);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',203),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',203),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',204),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',204),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',205),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',205),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',206),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',206),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',207),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',207);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',208),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',208),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',209),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',209),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',210),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',210),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',211),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',211),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',212),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',212);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',213),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',213),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',214),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',214),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',215),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',215),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',216),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',216),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',217),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',217);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',218),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',218),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',219),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',219),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',220),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',220),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',221),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',221),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',222),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',222);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',223),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',223),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',224),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',224),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',225),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',225),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',226),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',226),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',227),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',227);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',228),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',228),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',229),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',229),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',230),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',230),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',231),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',231),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',232),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',232);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',233),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',233),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',234),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',234),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',235),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',235),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',236),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',236),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',237),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',237);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',238),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',238),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',239),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',239),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',240),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',240),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',241),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',241),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',242),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',242);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',243),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',243),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',244),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',244),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',245),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',245),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',246),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',246),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',247),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',247);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',248),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',248),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',249),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',249),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',250),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',250),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',251),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',251),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',252),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',252);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',253),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',253),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',254),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',254),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',255),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',255),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',256),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',256),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',257),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',257);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',258),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',258),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',259),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',259),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',260),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',260),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',261),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',261),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',262),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',262);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',263),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',263),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',264),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',264),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',265),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',265),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',266),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',266),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',267),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',267);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',268),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',268),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',269),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',269),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',270),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',270),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',271),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',271),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',272),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',272);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',273),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',273),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',274),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',274),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',275),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',275),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',276),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',276),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',277),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',277);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',278),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',278),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',279),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',279),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',280),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',280),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',281),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',281),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',282),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',282);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',283),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',283),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',284),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',284),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',285),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',285),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',286),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',286),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',287),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',287);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',288),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',288),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',289),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',289),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',290),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',290),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',291),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',291),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',292),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',292);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',293),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',293),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',294),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',294),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',295),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',295),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',296),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',296),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',297),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',297);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',298),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',298),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',299),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',299),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',300),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',300),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',301),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',301),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',302),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',302);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',303),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',303),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',304),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',304),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',305),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',305),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',306),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',306),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',307),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',307);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',308),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',308),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',309),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',309),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',310),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',310),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',311),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',311),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',312),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',312);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',313),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',313),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',314),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',314),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',315),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',315),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',316),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',316),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',317),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',317);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',318),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',318),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',319),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',319),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',320),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',320),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',321),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',321),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',322),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',322);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',323),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',323),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',324),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',324),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',325),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',325),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',326),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',326),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',327),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',327);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',328),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',328),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',329),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',329),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',330),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',330),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',331),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',331),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',332),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',332);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',333),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',333),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',334),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',334),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',335),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',335),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',336),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',336),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',337),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',337);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',338),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',338),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',339),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',339),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',340),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',340),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',341),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',341),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',342),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',342);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',343),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',343),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',344),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',344),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',345),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',345),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',346),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',346),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',347),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',347);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',348),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',348),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',349),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',349),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',350),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',350),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',351),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',351),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',352),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',352);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',353),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',353),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',354),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',354),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',355),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',355),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',356),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',356),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',357),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',357);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',358),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',358),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',359),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',359),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',360),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',360),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',361),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',361),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',362),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',362);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',363),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',363),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',364),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',364),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',365),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',365),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',366),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',366),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',367),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',367);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',368),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',368),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',369),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',369),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',370),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',370),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',371),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',371),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',372),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',372);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',373),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',373),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',374),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',374),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',375),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',375),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',376),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',376),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',377),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',377);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',378),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',378),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',379),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',379),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',380),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',380),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',381),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',381),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',382),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',382);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',383),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',383),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',384),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',384),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',385),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',385),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',386),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',386),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',387),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',387);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',388),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',388),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',389),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',389),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',390),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',390),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',391),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',391),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',392),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',392);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',393),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',393),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',394),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',394),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',395),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',395),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',396),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',396),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',397),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',397);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',398),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',398),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',399),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',399),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',400),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',400),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',401),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',401),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',402),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',402);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',403),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',403),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',404),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',404),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',405),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',405),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',406),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',406),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',407),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',407);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',408),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',408),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',409),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',409),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',410),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',410),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',411),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',411),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',412),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',412);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',413),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',413),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',414),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',414),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',415),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',415),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',416),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',416),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',417),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',417);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',418),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',418),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',419),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',419),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',420),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',420),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',421),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',421),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',422),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',422);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',423),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',423),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',424),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',424),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',425),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',425),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',426),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',426),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',427),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',427);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',428),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',428),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',429),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',429),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',430),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',430),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',431),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',431),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',432),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',432);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',433),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',433),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',434),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',434),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',435),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',435),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',436),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',436),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',437),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',437);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',438),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',438),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',439),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',439),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',440),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',440),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',441),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',441),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',442),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',442);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',443),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',443),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',444),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',444),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',445),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',445),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',446),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',446),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',447),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',447);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',448),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',448),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',449),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',449),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',450),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',450),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',451),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',451),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',452),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',452);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',453),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',453),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',454),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',454),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',455),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',455),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',456),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',456),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',457),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',457);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',458),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',458),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',459),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',459),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',460),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',460),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',461),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',461),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',462),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',462);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',463),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',463),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',464),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',464),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',465),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',465),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',466),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',466),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',467),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',467);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',468),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',468),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',469),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',469),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',470),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',470),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',471),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',471),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',472),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',472);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',473),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',473),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',474),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',474),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',475),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',475),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',476),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',476),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',477),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',477);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',478),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',478),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',479),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',479),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',480),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',480),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',481),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',481),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',482),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',482);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',483),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',483),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',484),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',484),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',485),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',485),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',486),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',486),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',487),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',487);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',488),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',488),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',489),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',489),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',490),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',490),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',491),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',491),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',492),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',492);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',493),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',493),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',494),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',494),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',495),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',495),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',496),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',496),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',497),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',497);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',498),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',498),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',499),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',499),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',500),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',500),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',501),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',501),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',502),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',502);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',503),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',503),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',504),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',504),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',505),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',505),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',506),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',506),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',507),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',507);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',508),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',508),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',509),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',509),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',510),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',510),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',511),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',511),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',512),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',512);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',513),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',513),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',514),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',514),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',515),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',515),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',516),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',516),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',517),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',517);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',518),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',518),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',519),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',519),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',520),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',520),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',521),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',521),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',522),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',522);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',523),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',523),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',524),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',524),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',525),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',525),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',526),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',526),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',527),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',527);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',528),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',528),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',529),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',529),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',530),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',530),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',531),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',531),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',532),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',532);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',533),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',533),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',534),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',534),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',535),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',535),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',536),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',536),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',537),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',537);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',538),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',538),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',539),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',539),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',540),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',540),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',541),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',541),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',542),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',542);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',543),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',543),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',544),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',544),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',545),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',545),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',546),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',546),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',547),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',547);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',548),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',548),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',549),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',549),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',550),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',550),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',551),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',551),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',552),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',552);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',553),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',553),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',554),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',554),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',555),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',555),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',556),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',556),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',557),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',557);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',558),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',558),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',559),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',559),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',560),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',560),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',561),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',561),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',562),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',562);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',563),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',563),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',564),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',564),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',565),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',565),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',566),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',566),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',567),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',567);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',568),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',568),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',569),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',569),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',570),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',570),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',571),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',571),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',572),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',572);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',573),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',573),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',574),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',574),
	 (N'50 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Diclofenaco',575),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',575),
	 (N'1 tableta',N'30 días',N'Cada 24 horas',N'Tomar por la mañana',N'Multivitamínico',576),
	 (N'1000 UI',N'30 días',N'Cada 24 horas',N'Después del desayuno',N'Vitamina D',576),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',577),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',577);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',578),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',578),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',579),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',579),
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',580),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',580),
	 (N'500 mg',N'7 días',N'Cada 8 horas',N'Completar tratamiento',N'Amoxicilina',581),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Si presenta dolor',N'Paracetamol',581),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',582),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',582);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'50 mg',N'30 días',N'Cada 24 horas',N'Control de presión',N'Losartán',583),
	 (N'850 mg',N'30 días',N'Cada 12 horas',N'Con alimentos',N'Metformina',583),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',584),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',584),
	 (N'500 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol',585),
	 (N'400 mg',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Ibuprofeno',585),
	 (N'20 mg',N'14 días',N'Cada 24 horas',N'Antes del desayuno',N'Omeprazol',586),
	 (N'500 mg',N'3 días',N'Cada 8 horas',N'Si hay dolor',N'Paracetamol',586),
	 (N'250 mg',N'5 días',N'Cada 12 horas',N'Después de alimentos',N'Naproxeno',587),
	 (N'20 mg',N'5 días',N'Cada 24 horas',N'Protector gástrico',N'Omeprazol',587);
INSERT INTO bd_clinica.dbo.medicamentos_prescritos (dosis,duracion,frecuencia,instrucciones,nombre,id_receta) VALUES
	 (N'1 tableta',N'5 días',N'Cada 8 horas',N'Después de los alimentos',N'Paracetamol 500 mg',588),
	 (N'1 tableta',N'3 días',N'Cada 12 horas',N'Tomar con abundante agua',N'Ibuprofeno 400 mg',588),
	 (N'1 cápsula',N'7 días',N'Cada 8 horas',N'Completar el tratamiento',N'Amoxicilina 500 mg',589),
	 (N'1 tableta',N'5 días',N'Cada 24 horas',N'Preferentemente por la noche',N'Loratadina 10 mg',589);
INSERT INTO bd_clinica.dbo.medicos (anio_ingreso,apellidos,cmp,consultorio,dni,duracion_cita,email,estado,foto_url,horario_lv,horario_sabado,nombres,satisfaccion,telefono,id_especialidad,id_sede,id_usuario,sexo) VALUES
	 (2019,N'Bautista Huamani',N'CMP31443',N'101',N'75010877',30,N'rbautista@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Rhomel',4.8,N'987654321',1,1,9,N'M'),
	 (2021,N'Ramírez Salas',N'CMP45871',N'201',N'75010878',30,N'jramirez@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'José',4.0,N'999111111',1,1,10,N'M'),
	 (2020,N'Paredes Soto',N'CMP46215',N'202',N'75010879',30,N'aparedes@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Andrea',4.8,N'999222222',2,2,11,N'F'),
	 (2019,N'Torres León',N'CMP47832',N'203',N'75010880',30,N'mtorres@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Miguel',4.9,N'999333333',3,3,12,N'M'),
	 (2022,N'Herrera Díaz',N'CMP48564',N'204',N'75010881',30,N'lherrera@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Lucía',4.7,N'999444444',4,4,13,N'F'),
	 (2018,N'Espinoza Ruiz',N'CMP49211',N'205',N'75010882',30,N'cespinoza@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Carlos',4.9,N'999555555',5,1,14,N'M'),
	 (2020,N'Flores Vega',N'CMP50311',N'206',N'75010883',30,N'mflores@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'María',4.9,N'999666111',6,2,15,N'F'),
	 (2018,N'Vargas León',N'CMP50312',N'207',N'75010884',30,N'rvargas@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Ricardo',4.8,N'999666222',7,3,16,N'M'),
	 (2021,N'Salas Ruiz',N'CMP50313',N'208',N'75010885',30,N'csalas@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Carmen',4.7,N'999666333',8,4,17,N'F'),
	 (2019,N'Gutiérrez Díaz',N'CMP50314',N'209',N'75010886',30,N'pgutierrez@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Pedro',4.9,N'999666444',9,1,18,N'M');
INSERT INTO bd_clinica.dbo.medicos (anio_ingreso,apellidos,cmp,consultorio,dni,duracion_cita,email,estado,foto_url,horario_lv,horario_sabado,nombres,satisfaccion,telefono,id_especialidad,id_sede,id_usuario,sexo) VALUES
	 (2022,N'Medina Soto',N'CMP50315',N'210',N'75010887',30,N'dmedina@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Daniel',4.8,N'999666555',10,2,19,N'M'),
	 (2017,N'Rojas Castillo',N'CMP50316',N'211',N'75010888',30,N'jrojas@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Javier',4.9,N'999666666',1,3,20,N'M'),
	 (2023,N'Castillo Paredes',N'CMP50317',N'212',N'75010889',30,N'ncastillo@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Natalia',4.8,N'999666777',2,4,21,N'F'),
	 (2020,N'Quispe Romero',N'CMP50318',N'213',N'75010890',30,N'lquispe@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Luis',4.7,N'999666888',3,1,22,N'M'),
	 (2021,N'Sánchez Herrera',N'CMP50319',N'214',N'75010891',30,N'asanchez@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Ana',4.9,N'999666999',4,2,23,N'F'),
	 (2019,N'Cabrera Molina',N'CMP50320',N'215',N'75010892',30,N'fcabrera@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Fernando',4.8,N'999667000',5,3,24,N'M'),
	 (2019,N'Valdivia Rojas',N'CMP50321',N'216',N'75010893',30,N'avaldivia@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Alberto',4.9,N'999667001',6,4,25,N'M'),
	 (2021,N'Mendoza Salazar',N'CMP50322',N'217',N'75010894',30,N'pmendoza@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Patricia',4.8,N'999667002',7,1,26,N'F'),
	 (2018,N'Guzmán Pérez',N'CMP50323',N'218',N'75010895',30,N'jguzman@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Jorge',4.9,N'999667003',8,2,27,N'M'),
	 (2022,N'Campos León',N'CMP50324',N'219',N'75010896',30,N'rcampos@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Rosa',4.8,N'999667004',9,3,28,N'F');
INSERT INTO bd_clinica.dbo.medicos (anio_ingreso,apellidos,cmp,consultorio,dni,duracion_cita,email,estado,foto_url,horario_lv,horario_sabado,nombres,satisfaccion,telefono,id_especialidad,id_sede,id_usuario,sexo) VALUES
	 (2020,N'Benites Soto',N'CMP50325',N'220',N'75010897',30,N'mbenites@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Miguel',4.7,N'999667005',10,4,29,N'M'),
	 (2019,N'Aguilar Torres',N'CMP50326',N'221',N'75010898',30,N'caguilar@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Claudia',4.9,N'999667006',11,1,30,N'F'),
	 (2017,N'Villanueva Díaz',N'CMP50327',N'222',N'75010899',30,N'fvillanueva@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Felipe',4.8,N'999667007',11,2,31,N'M'),
	 (2023,N'López Herrera',N'CMP50328',N'223',N'75010900',30,N'slopez@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Sandra',4.9,N'999667008',11,3,32,N'F'),
	 (2020,N'Rodríguez Castro',N'CMP50329',N'224',N'75010901',30,N'drodriguez@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Diego',4.8,N'999667009',12,4,33,N'M'),
	 (2019,N'García Paredes',N'CMP50330',N'225',N'75010902',30,N'lgarcia@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Lucía',4.9,N'999667010',12,1,34,N'F'),
	 (2022,N'Paredes Romero',N'CMP50331',N'226',N'75010903',30,N'eparedes@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Eduardo',4.7,N'999667011',12,2,35,N'M'),
	 (2018,N'Vargas Salinas',N'CMP50332',N'227',N'75010904',30,N'hvargas@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Hugo',4.8,N'999667012',13,3,36,N'M'),
	 (2021,N'Espinoza Cueva',N'CMP50333',N'228',N'75010905',30,N'jespinoza@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Julia',4.9,N'999667013',13,4,37,N'F'),
	 (2020,N'Márquez Silva',N'CMP50334',N'229',N'75010906',30,N'amarquez@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Antonio',4.8,N'999667014',13,1,38,N'M');
INSERT INTO bd_clinica.dbo.medicos (anio_ingreso,apellidos,cmp,consultorio,dni,duracion_cita,email,estado,foto_url,horario_lv,horario_sabado,nombres,satisfaccion,telefono,id_especialidad,id_sede,id_usuario,sexo) VALUES
	 (2019,N'Castro Ríos',N'CMP50335',N'230',N'75010907',30,N'tcastro@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Teresa',4.9,N'999667015',14,2,39,N'F'),
	 (2020,N'Ríos Mendoza',N'CMP50336',N'231',N'75010908',30,N'rrios@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Roberto',4.8,N'999667016',2,3,40,N'M'),
	 (2019,N'Morales Soto',N'CMP50337',N'232',N'75010909',30,N'imorales@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Isabel',4.9,N'999667017',3,4,41,N'F'),
	 (2021,N'Gómez León',N'CMP50338',N'233',N'75010910',30,N'agomez@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Arturo',4.8,N'999667018',4,1,42,N'M'),
	 (2022,N'Ruiz Herrera',N'CMP50339',N'234',N'75010911',30,N'mruiz@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Mónica',4.9,N'999667019',5,2,43,N'F'),
	 (2018,N'Flores Castro',N'CMP50340',N'235',N'75010912',30,N'dflores@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'David',4.8,N'999667020',6,3,44,N'M'),
	 (2020,N'Campos Ruiz',N'CMP50341',N'236',N'75010913',30,N'pcampos@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Paola',4.9,N'999667021',7,4,45,N'F'),
	 (2019,N'Vega Torres',N'CMP50342',N'237',N'75010914',30,N'svega@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Sergio',4.8,N'999667022',8,1,46,N'M'),
	 (2021,N'Gutiérrez Díaz',N'CMP50343',N'238',N'75010915',30,N'cgutierrez@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Carolina',4.9,N'999667023',9,2,47,N'F'),
	 (2017,N'Salazar Rojas',N'CMP50344',N'239',N'75010916',30,N'vsalazar@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Víctor',4.8,N'999667024',10,3,48,N'M');
INSERT INTO bd_clinica.dbo.medicos (anio_ingreso,apellidos,cmp,consultorio,dni,duracion_cita,email,estado,foto_url,horario_lv,horario_sabado,nombres,satisfaccion,telefono,id_especialidad,id_sede,id_usuario,sexo) VALUES
	 (2020,N'García Vargas',N'CMP50345',N'240',N'75010917',30,N'egarcia@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Elena',4.9,N'999667025',14,4,49,N'F'),
	 (2018,N'Ramírez Peña',N'CMP50346',N'241',N'75010918',30,N'lramirez@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Luis',4.8,N'999667026',14,1,50,N'M'),
	 (2022,N'Castillo Flores',N'CMP50347',N'242',N'75010919',30,N'mcastillo@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'María',4.9,N'999667027',15,2,51,N'F'),
	 (2021,N'Navarro Cueva',N'CMP50348',N'243',N'75010920',30,N'jnavarro@clinicx.com',N'Activo',NULL,N'08:00 - 17:00',N'08:00 - 13:00',N'Javier',4.8,N'999667028',15,3,52,N'M'),
	 (2019,N'Ortiz Salas',N'CMP50349',N'244',N'75010921',30,N'fortiz@clinicx.com',N'Activo',NULL,N'09:00 - 18:00',N'08:00 - 14:00',N'Francisca',4.9,N'999667029',15,4,53,N'F');
INSERT INTO bd_clinica.dbo.notificaciones (fecha,icono,leida,mensaje,id_paciente) VALUES
	 ('2026-07-14 16:28:30.5978560',N'bi-capsule',0,N'Tu receta para Losartán está lista para descargar.',1),
	 ('2026-07-14 14:43:35.6870799',N'bi-calendar-event',0,N'Recordatorio: Mañana tienes una cita en Sede Central.',1),
	 ('2026-07-13 16:43:42.4443428',N'bi-person-check',1,N'Bienvenido a ClinicX, VICTOR HUGO!',1);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (NULL,NULL,N'SANCA TACO',NULL,N'',N'',N'75010866',NULL,NULL,N'Activo',N'ACTIVO',NULL,'2026-07-13 00:27:24.9975034',N'ESSALUD / SIS (Acreditado)',N'VICTOR HUGO',NULL,NULL,N'999999999',NULL,N'PEAS - Plan Esencial de Aseguramiento',NULL,NULL,8),
	 (N'Ninguna',N'Ninguno',N'Díaz Flores',N'Familiar',N'Av. Los Olivos 123',N'Ate',N'75010922',N'ana.diaz0@outlook.com',N'Ninguna',N'Activo',N'Activo','1960-11-24','2026-07-15 05:12:48.3700000',N'SIS',N'Ana',N'SIS',N'F',N'950000000',N'960000000',N'Plan Integral',N'O-',3,54),
	 (N'Ninguna',N'Ninguno',N'Ramírez García',N'Familiar',N'Av. Los Olivos 123',N'San Isidro',N'75010923',N'fernando.ramirez1@hotmail.com',N'Ninguna',N'Activo',N'Activo','2008-10-11','2026-07-15 05:12:48.3966667',N'SIS',N'Fernando',N'SIS',N'M',N'950000001',N'960000001',N'Plan Integral',N'AB+',1,55),
	 (N'Ninguna',N'Ninguno',N'Salazar Vargas',N'Familiar',N'Av. Los Olivos 123',N'San Borja',N'75010924',N'natalia.salazar2@gmail.com',N'Ninguna',N'Activo',N'Activo','2004-02-04','2026-07-15 05:12:48.4033333',N'Particular',N'Natalia',N'Particular',N'F',N'950000002',N'960000002',N'Premium',N'B+',3,56),
	 (N'Ninguna',N'Ninguno',N'Quispe Romero',N'Familiar',N'Av. Los Olivos 123',N'La Molina',N'75010925',N'diego.quispe3@outlook.com',N'Ninguna',N'Activo',N'Activo','2000-12-10','2026-07-15 05:12:48.4133333',N'Particular',N'Diego',N'Particular',N'M',N'950000003',N'960000003',N'Premium',N'AB+',4,57),
	 (N'Ninguna',N'Ninguno',N'Pérez Flores',N'Familiar',N'Av. Los Olivos 123',N'Ate',N'75010926',N'andrea.perez4@yahoo.com',N'Ninguna',N'Activo',N'Activo','2004-07-18','2026-07-15 05:12:48.4233333',N'EsSalud',N'Andrea',N'EsSalud',N'F',N'950000004',N'960000004',N'Regular',N'A+',1,58),
	 (N'Ninguna',N'Ninguno',N'García Pérez',N'Familiar',N'Av. Los Olivos 123',N'San Miguel',N'75010927',N'arturo.garcia5@hotmail.com',N'Ninguna',N'Activo',N'Activo','1974-05-27','2026-07-15 05:12:48.4300000',N'Particular',N'Arturo',N'Particular',N'M',N'950000005',N'960000005',N'Premium',N'A+',2,59),
	 (N'Ninguna',N'Ninguno',N'Castillo Flores',N'Familiar',N'Av. Los Olivos 123',N'Miraflores',N'75010928',N'patricia.castillo6@yahoo.com',N'Ninguna',N'Activo',N'Activo','1966-03-04','2026-07-15 05:12:48.4366667',N'EsSalud',N'Patricia',N'EsSalud',N'F',N'950000006',N'960000006',N'Regular',N'B+',2,60),
	 (N'Ninguna',N'Ninguno',N'León Castillo',N'Familiar',N'Av. Los Olivos 123',N'San Miguel',N'75010929',N'sergio.leon7@icloud.com',N'Ninguna',N'Activo',N'Activo','1962-04-20','2026-07-15 05:12:48.4400000',N'EsSalud',N'Sergio',N'EsSalud',N'M',N'950000007',N'960000007',N'Regular',N'O-',4,61),
	 (N'Ninguna',N'Ninguno',N'Flores Vargas',N'Familiar',N'Av. Los Olivos 123',N'Ate',N'75010930',N'isabel.flores8@yahoo.com',N'Ninguna',N'Activo',N'Activo','1970-04-29','2026-07-15 05:12:48.4500000',N'EsSalud',N'Isabel',N'EsSalud',N'F',N'950000008',N'960000008',N'Regular',N'O-',3,62);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Torres Castillo',N'Familiar',N'Av. Los Olivos 123',N'Lince',N'75010931',N'antonio.torres9@gmail.com',N'Ninguna',N'Activo',N'Activo','1991-05-20','2026-07-15 05:12:48.4566667',N'SIS',N'Antonio',N'SIS',N'M',N'950000009',N'960000009',N'Plan Integral',N'AB+',2,63),
	 (N'Ninguna',N'Ninguno',N'Torres Vargas',N'Familiar',N'Av. Los Olivos 123',N'San Isidro',N'75010932',N'maria.torres10@icloud.com',N'Ninguna',N'Activo',N'Activo','1979-11-19','2026-07-15 05:12:48.4633333',N'SIS',N'María',N'SIS',N'F',N'950000010',N'960000010',N'Plan Integral',N'O-',2,64),
	 (N'Ninguna',N'Ninguno',N'Pérez Vargas',N'Familiar',N'Av. Los Olivos 123',N'San Isidro',N'75010933',N'david.perez11@hotmail.com',N'Ninguna',N'Activo',N'Activo','1961-04-23','2026-07-15 05:12:48.4700000',N'SIS',N'David',N'SIS',N'M',N'950000011',N'960000011',N'Plan Integral',N'A+',3,65),
	 (N'Ninguna',N'Ninguno',N'Mendoza Ruiz',N'Familiar',N'Av. Los Olivos 123',N'San Miguel',N'75010934',N'paola.mendoza12@gmail.com',N'Ninguna',N'Activo',N'Activo','1976-03-08','2026-07-15 05:12:48.4766667',N'Particular',N'Paola',N'Particular',N'F',N'950000012',N'960000012',N'Premium',N'O+',4,66),
	 (N'Ninguna',N'Ninguno',N'Pérez Quispe',N'Familiar',N'Av. Los Olivos 123',N'San Isidro',N'75010935',N'diego.perez13@outlook.com',N'Ninguna',N'Activo',N'Activo','1963-09-25','2026-07-15 05:12:48.4833333',N'SIS',N'Diego',N'SIS',N'M',N'950000013',N'960000013',N'Plan Integral',N'AB+',1,67),
	 (N'Ninguna',N'Ninguno',N'Castillo García',N'Familiar',N'Av. Los Olivos 123',N'Lince',N'75010936',N'ana.castillo14@icloud.com',N'Ninguna',N'Activo',N'Activo','1978-11-20','2026-07-15 05:12:48.4933333',N'EsSalud',N'Ana',N'EsSalud',N'F',N'950000014',N'960000014',N'Regular',N'A+',4,68),
	 (N'Ninguna',N'Ninguno',N'Rojas Ramírez',N'Familiar',N'Av. Los Olivos 123',N'Ate',N'75010937',N'luis.rojas15@icloud.com',N'Ninguna',N'Activo',N'Activo','1966-07-07','2026-07-15 05:12:48.5033333',N'SIS',N'Luis',N'SIS',N'M',N'950000015',N'960000015',N'Plan Integral',N'O+',4,69),
	 (N'Ninguna',N'Ninguno',N'León Romero',N'Familiar',N'Av. Los Olivos 123',N'Surco',N'75010938',N'sandra.leon16@outlook.com',N'Ninguna',N'Activo',N'Activo','1991-01-12','2026-07-15 05:12:48.5100000',N'Particular',N'Sandra',N'Particular',N'F',N'950000016',N'960000016',N'Premium',N'O-',1,70),
	 (N'Ninguna',N'Ninguno',N'Pérez Ramírez',N'Familiar',N'Av. Los Olivos 123',N'San Miguel',N'75010939',N'alberto.perez17@outlook.com',N'Ninguna',N'Activo',N'Activo','2008-03-07','2026-07-15 05:12:48.5233333',N'EsSalud',N'Alberto',N'EsSalud',N'M',N'950000017',N'960000017',N'Regular',N'AB+',2,71),
	 (N'Ninguna',N'Ninguno',N'Torres Vargas',N'Familiar',N'Av. Los Olivos 123',N'San Miguel',N'75010940',N'andrea.torres18@outlook.com',N'Ninguna',N'Activo',N'Activo','1974-12-26','2026-07-15 05:12:48.5300000',N'SIS',N'Andrea',N'SIS',N'F',N'950000018',N'960000018',N'Plan Integral',N'O+',4,72);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Salazar Romero',N'Familiar',N'Av. Los Olivos 123',N'San Miguel',N'75010941',N'david.salazar19@hotmail.com',N'Ninguna',N'Activo',N'Activo','1967-10-02','2026-07-15 05:12:48.5400000',N'SIS',N'David',N'SIS',N'M',N'950000019',N'960000019',N'Plan Integral',N'B+',4,73),
	 (N'Ninguna',N'Ninguno',N'Mendoza Vargas',N'Familiar',N'Av. Los Olivos 123',N'Surco',N'75010942',N'patricia.mendoza20@icloud.com',N'Ninguna',N'Activo',N'Activo','1969-01-04','2026-07-15 05:12:48.5500000',N'Particular',N'Patricia',N'Particular',N'F',N'950000020',N'960000020',N'Premium',N'A+',1,74),
	 (N'Ninguna',N'Ninguno',N'León Rojas',N'Familiar',N'Av. Los Olivos 123',N'San Isidro',N'75010943',N'antonio.leon21@icloud.com',N'Ninguna',N'Activo',N'Activo','2007-05-23','2026-07-15 05:12:48.5600000',N'EsSalud',N'Antonio',N'EsSalud',N'M',N'950000021',N'960000021',N'Regular',N'O-',3,75),
	 (N'Ninguna',N'Ninguno',N'Salazar León',N'Familiar',N'Av. Los Olivos 123',N'San Isidro',N'75010944',N'andrea.salazar22@yahoo.com',N'Ninguna',N'Activo',N'Activo','1981-03-11','2026-07-15 05:12:48.5700000',N'Particular',N'Andrea',N'Particular',N'F',N'950000022',N'960000022',N'Premium',N'O-',1,76),
	 (N'Ninguna',N'Ninguno',N'Quispe Ruiz',N'Familiar',N'Av. Los Olivos 123',N'Miraflores',N'75010945',N'eduardo.quispe23@icloud.com',N'Ninguna',N'Activo',N'Activo','1983-11-18','2026-07-15 05:12:48.5800000',N'Particular',N'Eduardo',N'Particular',N'M',N'950000023',N'960000023',N'Premium',N'O+',3,77),
	 (N'Ninguna',N'Ninguno',N'Pérez Campos',N'Familiar',N'Av. Los Olivos 123',N'La Molina',N'75010946',N'claudia.perez24@icloud.com',N'Ninguna',N'Activo',N'Activo','1967-04-06','2026-07-15 05:12:48.5900000',N'EsSalud',N'Claudia',N'EsSalud',N'F',N'950000024',N'960000024',N'Regular',N'O-',1,78),
	 (N'Ninguna',N'Ninguno',N'García Quispe',N'Familiar',N'Av. Los Olivos 123',N'San Miguel',N'75010947',N'jorge.garcia25@outlook.com',N'Ninguna',N'Activo',N'Activo','1968-04-11','2026-07-15 05:12:48.6000000',N'SIS',N'Jorge',N'SIS',N'M',N'950000025',N'960000025',N'Plan Integral',N'AB+',2,79),
	 (N'Ninguna',N'Ninguno',N'Vargas Salazar',N'Familiar',N'Av. Los Olivos 123',N'La Molina',N'75010948',N'ana.vargas26@outlook.com',N'Ninguna',N'Activo',N'Activo','1980-04-24','2026-07-15 05:12:48.6100000',N'Particular',N'Ana',N'Particular',N'F',N'950000026',N'960000026',N'Premium',N'AB+',4,80),
	 (N'Ninguna',N'Ninguno',N'Díaz Ramírez',N'Familiar',N'Av. Los Olivos 123',N'La Molina',N'75010949',N'pedro.diaz27@outlook.com',N'Ninguna',N'Activo',N'Activo','1989-08-08','2026-07-15 05:12:48.6166667',N'SIS',N'Pedro',N'SIS',N'M',N'950000027',N'960000027',N'Plan Integral',N'B+',2,81),
	 (N'Ninguna',N'Ninguno',N'Quispe León',N'Familiar',N'Av. Los Olivos 123',N'San Isidro',N'75010950',N'julia.quispe28@hotmail.com',N'Ninguna',N'Activo',N'Activo','2006-11-05','2026-07-15 05:12:48.6300000',N'EsSalud',N'Julia',N'EsSalud',N'F',N'950000028',N'960000028',N'Regular',N'AB+',3,82);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Pérez Romero',N'Familiar',N'Av. Los Olivos 123',N'Ate',N'75010951',N'javier.perez29@outlook.com',N'Ninguna',N'Activo',N'Activo','1978-01-29','2026-07-15 05:12:48.6533333',N'Particular',N'Javier',N'Particular',N'M',N'950000029',N'960000029',N'Premium',N'AB+',4,83),
	 (N'Ninguna',N'Ninguno',N'Pérez Romero',N'Familiar',N'Av. Primavera 456',N'Miraflores',N'75010952',N'maria.perez30@gmail.com',N'Ninguna',N'Activo',N'Activo','1965-09-13','2026-07-15 05:14:24.2933333',N'SIS',N'María',N'SIS',N'F',N'950000030',N'960000030',N'Plan Integral',N'AB+',2,84),
	 (N'Ninguna',N'Ninguno',N'Flores Mendoza',N'Familiar',N'Av. Primavera 456',N'San Isidro',N'75010953',N'diego.flores31@yahoo.com',N'Ninguna',N'Activo',N'Activo','1965-08-05','2026-07-15 05:14:24.3100000',N'SIS',N'Diego',N'SIS',N'M',N'950000031',N'960000031',N'Plan Integral',N'AB+',3,85),
	 (N'Ninguna',N'Ninguno',N'Mendoza Díaz',N'Familiar',N'Av. Primavera 456',N'Surco',N'75010954',N'elena.mendoza32@icloud.com',N'Ninguna',N'Activo',N'Activo','1970-02-12','2026-07-15 05:14:24.3166667',N'SIS',N'Elena',N'SIS',N'F',N'950000032',N'960000032',N'Plan Integral',N'O+',2,86),
	 (N'Ninguna',N'Ninguno',N'Torres Pérez',N'Familiar',N'Av. Primavera 456',N'Miraflores',N'75010955',N'miguel.torres33@hotmail.com',N'Ninguna',N'Activo',N'Activo','1999-12-09','2026-07-15 05:14:24.3266667',N'SIS',N'Miguel',N'SIS',N'M',N'950000033',N'960000033',N'Plan Integral',N'B+',3,87),
	 (N'Ninguna',N'Ninguno',N'Pérez Salazar',N'Familiar',N'Av. Primavera 456',N'Miraflores',N'75010956',N'carmen.perez34@icloud.com',N'Ninguna',N'Activo',N'Activo','1979-01-23','2026-07-15 05:14:24.3333333',N'SIS',N'Carmen',N'SIS',N'F',N'950000034',N'960000034',N'Plan Integral',N'A+',4,88),
	 (N'Ninguna',N'Ninguno',N'Rojas Torres',N'Familiar',N'Av. Primavera 456',N'Surco',N'75010957',N'david.rojas35@hotmail.com',N'Ninguna',N'Activo',N'Activo','1992-10-21','2026-07-15 05:14:24.3500000',N'Particular',N'David',N'Particular',N'M',N'950000035',N'960000035',N'Premium',N'AB+',1,89),
	 (N'Ninguna',N'Ninguno',N'Ruiz León',N'Familiar',N'Av. Primavera 456',N'Ate',N'75010958',N'elena.ruiz36@gmail.com',N'Ninguna',N'Activo',N'Activo','1982-02-04','2026-07-15 05:14:24.3700000',N'SIS',N'Elena',N'SIS',N'F',N'950000036',N'960000036',N'Plan Integral',N'AB+',2,90),
	 (N'Ninguna',N'Ninguno',N'Ramírez García',N'Familiar',N'Av. Primavera 456',N'San Isidro',N'75010959',N'jorge.ramirez37@gmail.com',N'Ninguna',N'Activo',N'Activo','1962-01-23','2026-07-15 05:14:24.3933333',N'EsSalud',N'Jorge',N'EsSalud',N'M',N'950000037',N'960000037',N'Regular',N'AB+',4,91),
	 (N'Ninguna',N'Ninguno',N'Ruiz Campos',N'Familiar',N'Av. Primavera 456',N'San Isidro',N'75010960',N'elena.ruiz38@outlook.com',N'Ninguna',N'Activo',N'Activo','1976-03-03','2026-07-15 05:14:24.4100000',N'SIS',N'Elena',N'SIS',N'F',N'950000038',N'960000038',N'Plan Integral',N'AB+',1,92);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Vargas García',N'Familiar',N'Av. Primavera 456',N'Surco',N'75010961',N'sergio.vargas39@gmail.com',N'Ninguna',N'Activo',N'Activo','1993-07-09','2026-07-15 05:14:24.4200000',N'EsSalud',N'Sergio',N'EsSalud',N'M',N'950000039',N'960000039',N'Regular',N'A+',3,93),
	 (N'Ninguna',N'Ninguno',N'Pérez León',N'Familiar',N'Av. Primavera 456',N'San Miguel',N'75010962',N'patricia.perez40@hotmail.com',N'Ninguna',N'Activo',N'Activo','1962-05-06','2026-07-15 05:14:24.4300000',N'EsSalud',N'Patricia',N'EsSalud',N'F',N'950000040',N'960000040',N'Regular',N'O+',2,94),
	 (N'Ninguna',N'Ninguno',N'Vargas Pérez',N'Familiar',N'Av. Primavera 456',N'Miraflores',N'75010963',N'sergio.vargas41@yahoo.com',N'Ninguna',N'Activo',N'Activo','1982-11-23','2026-07-15 05:14:24.4366667',N'Particular',N'Sergio',N'Particular',N'M',N'950000041',N'960000041',N'Premium',N'O+',2,95),
	 (N'Ninguna',N'Ninguno',N'León Torres',N'Familiar',N'Av. Primavera 456',N'Ate',N'75010964',N'paola.leon42@gmail.com',N'Ninguna',N'Activo',N'Activo','1964-06-14','2026-07-15 05:14:24.4466667',N'Particular',N'Paola',N'Particular',N'F',N'950000042',N'960000042',N'Premium',N'AB+',1,96),
	 (N'Ninguna',N'Ninguno',N'Rojas Torres',N'Familiar',N'Av. Primavera 456',N'La Molina',N'75010965',N'luis.rojas43@gmail.com',N'Ninguna',N'Activo',N'Activo','1997-06-19','2026-07-15 05:14:24.4500000',N'EsSalud',N'Luis',N'EsSalud',N'M',N'950000043',N'960000043',N'Regular',N'B+',1,97),
	 (N'Ninguna',N'Ninguno',N'Torres Romero',N'Familiar',N'Av. Primavera 456',N'Miraflores',N'75010966',N'sandra.torres44@hotmail.com',N'Ninguna',N'Activo',N'Activo','2003-08-24','2026-07-15 05:14:24.4600000',N'Particular',N'Sandra',N'Particular',N'F',N'950000044',N'960000044',N'Premium',N'O+',1,98),
	 (N'Ninguna',N'Ninguno',N'Flores Campos',N'Familiar',N'Av. Primavera 456',N'Lince',N'75010967',N'luis.flores45@yahoo.com',N'Ninguna',N'Activo',N'Activo','1960-07-05','2026-07-15 05:14:24.4666667',N'Particular',N'Luis',N'Particular',N'M',N'950000045',N'960000045',N'Premium',N'AB+',4,99),
	 (N'Ninguna',N'Ninguno',N'Quispe Vargas',N'Familiar',N'Av. Primavera 456',N'San Isidro',N'75010968',N'maria.quispe46@yahoo.com',N'Ninguna',N'Activo',N'Activo','1986-09-30','2026-07-15 05:14:24.4733333',N'EsSalud',N'María',N'EsSalud',N'F',N'950000046',N'960000046',N'Regular',N'O+',3,100),
	 (N'Ninguna',N'Ninguno',N'Vargas Mendoza',N'Familiar',N'Av. Primavera 456',N'Ate',N'75010969',N'jorge.vargas47@hotmail.com',N'Ninguna',N'Activo',N'Activo','1985-07-01','2026-07-15 05:14:24.4800000',N'SIS',N'Jorge',N'SIS',N'M',N'950000047',N'960000047',N'Plan Integral',N'O-',3,101),
	 (N'Ninguna',N'Ninguno',N'León Campos',N'Familiar',N'Av. Primavera 456',N'San Borja',N'75010970',N'isabel.leon48@yahoo.com',N'Ninguna',N'Activo',N'Activo','1961-10-11','2026-07-15 05:14:24.4866667',N'Particular',N'Isabel',N'Particular',N'F',N'950000048',N'960000048',N'Premium',N'O+',1,102);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Ruiz Ramírez',N'Familiar',N'Av. Primavera 456',N'Lince',N'75010971',N'antonio.ruiz49@icloud.com',N'Ninguna',N'Activo',N'Activo','1988-08-04','2026-07-15 05:14:24.4900000',N'EsSalud',N'Antonio',N'EsSalud',N'M',N'950000049',N'960000049',N'Regular',N'O+',4,103),
	 (N'Ninguna',N'Ninguno',N'Mendoza Flores',N'Familiar',N'Av. Primavera 456',N'La Molina',N'75010972',N'ana.mendoza50@gmail.com',N'Ninguna',N'Activo',N'Activo','1982-12-21','2026-07-15 05:14:24.4966667',N'SIS',N'Ana',N'SIS',N'F',N'950000050',N'960000050',N'Plan Integral',N'AB+',1,104),
	 (N'Ninguna',N'Ninguno',N'Torres Díaz',N'Familiar',N'Av. Primavera 456',N'Surco',N'75010973',N'roberto.torres51@icloud.com',N'Ninguna',N'Activo',N'Activo','1987-01-11','2026-07-15 05:14:24.5100000',N'SIS',N'Roberto',N'SIS',N'M',N'950000051',N'960000051',N'Plan Integral',N'O-',2,105),
	 (N'Ninguna',N'Ninguno',N'Pérez Pérez',N'Familiar',N'Av. Primavera 456',N'San Borja',N'75010974',N'ana.perez52@icloud.com',N'Ninguna',N'Activo',N'Activo','1960-02-23','2026-07-15 05:14:24.5166667',N'EsSalud',N'Ana',N'EsSalud',N'F',N'950000052',N'960000052',N'Regular',N'O+',3,106),
	 (N'Ninguna',N'Ninguno',N'Castillo Ruiz',N'Familiar',N'Av. Primavera 456',N'Surco',N'75010975',N'javier.castillo53@outlook.com',N'Ninguna',N'Activo',N'Activo','2007-01-03','2026-07-15 05:14:24.5233333',N'EsSalud',N'Javier',N'EsSalud',N'M',N'950000053',N'960000053',N'Regular',N'B+',2,107),
	 (N'Ninguna',N'Ninguno',N'Castillo Vargas',N'Familiar',N'Av. Primavera 456',N'Ate',N'75010976',N'carolina.castillo54@icloud.com',N'Ninguna',N'Activo',N'Activo','2007-05-27','2026-07-15 05:14:24.5366667',N'EsSalud',N'Carolina',N'EsSalud',N'F',N'950000054',N'960000054',N'Regular',N'O-',1,108),
	 (N'Ninguna',N'Ninguno',N'Torres Vargas',N'Familiar',N'Av. Primavera 456',N'Lince',N'75010977',N'carlos.torres55@yahoo.com',N'Ninguna',N'Activo',N'Activo','1968-02-29','2026-07-15 05:14:24.5533333',N'EsSalud',N'Carlos',N'EsSalud',N'M',N'950000055',N'960000055',N'Regular',N'O-',2,109),
	 (N'Ninguna',N'Ninguno',N'Salazar García',N'Familiar',N'Av. Primavera 456',N'San Borja',N'75010978',N'elena.salazar56@outlook.com',N'Ninguna',N'Activo',N'Activo','1979-08-20','2026-07-15 05:14:24.5700000',N'Particular',N'Elena',N'Particular',N'F',N'950000056',N'960000056',N'Premium',N'A+',4,110),
	 (N'Ninguna',N'Ninguno',N'Díaz Ramírez',N'Familiar',N'Av. Primavera 456',N'La Molina',N'75010979',N'arturo.diaz57@icloud.com',N'Ninguna',N'Activo',N'Activo','2000-06-08','2026-07-15 05:14:24.5800000',N'Particular',N'Arturo',N'Particular',N'M',N'950000057',N'960000057',N'Premium',N'AB+',2,111),
	 (N'Ninguna',N'Ninguno',N'Salazar Campos',N'Familiar',N'Av. Primavera 456',N'Surco',N'75010980',N'teresa.salazar58@outlook.com',N'Ninguna',N'Activo',N'Activo','1967-11-06','2026-07-15 05:14:24.5900000',N'EsSalud',N'Teresa',N'EsSalud',N'F',N'950000058',N'960000058',N'Regular',N'A+',2,112);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Rojas Romero',N'Familiar',N'Av. Primavera 456',N'Surco',N'75010981',N'antonio.rojas59@gmail.com',N'Ninguna',N'Activo',N'Activo','1987-08-14','2026-07-15 05:14:24.6000000',N'EsSalud',N'Antonio',N'EsSalud',N'M',N'950000059',N'960000059',N'Regular',N'O-',3,113),
	 (N'Ninguna',N'Ninguno',N'León Pérez',N'Familiar',N'Av. Javier Prado 789',N'San Borja',N'75010982',N'paola.leon60@outlook.com',N'Ninguna',N'Activo',N'Activo','1978-08-19','2026-07-15 05:15:30.3433333',N'Particular',N'Paola',N'Particular',N'F',N'950000060',N'960000060',N'Premium',N'A+',2,114),
	 (N'Ninguna',N'Ninguno',N'Ramírez Romero',N'Familiar',N'Av. Javier Prado 789',N'Ate',N'75010983',N'sergio.ramirez61@outlook.com',N'Ninguna',N'Activo',N'Activo','2000-03-23','2026-07-15 05:15:30.3500000',N'Particular',N'Sergio',N'Particular',N'M',N'950000061',N'960000061',N'Premium',N'B+',3,115),
	 (N'Ninguna',N'Ninguno',N'Romero Flores',N'Familiar',N'Av. Javier Prado 789',N'La Molina',N'75010984',N'claudia.romero62@gmail.com',N'Ninguna',N'Activo',N'Activo','1978-01-21','2026-07-15 05:15:30.3600000',N'EsSalud',N'Claudia',N'EsSalud',N'F',N'950000062',N'960000062',N'Regular',N'AB+',4,116),
	 (N'Ninguna',N'Ninguno',N'Ruiz Flores',N'Familiar',N'Av. Javier Prado 789',N'San Borja',N'75010985',N'antonio.ruiz63@outlook.com',N'Ninguna',N'Activo',N'Activo','2002-05-06','2026-07-15 05:15:30.3666667',N'Particular',N'Antonio',N'Particular',N'M',N'950000063',N'960000063',N'Premium',N'A+',1,117),
	 (N'Ninguna',N'Ninguno',N'Ramírez Torres',N'Familiar',N'Av. Javier Prado 789',N'Surco',N'75010986',N'carmen.ramirez64@icloud.com',N'Ninguna',N'Activo',N'Activo','1965-09-20','2026-07-15 05:15:30.3766667',N'EsSalud',N'Carmen',N'EsSalud',N'F',N'950000064',N'960000064',N'Regular',N'AB+',1,118),
	 (N'Ninguna',N'Ninguno',N'Romero Ramírez',N'Familiar',N'Av. Javier Prado 789',N'Miraflores',N'75010987',N'arturo.romero65@icloud.com',N'Ninguna',N'Activo',N'Activo','1989-10-22','2026-07-15 05:15:30.3833333',N'Particular',N'Arturo',N'Particular',N'M',N'950000065',N'960000065',N'Premium',N'AB+',3,119),
	 (N'Ninguna',N'Ninguno',N'Pérez Torres',N'Familiar',N'Av. Javier Prado 789',N'Surco',N'75010988',N'paola.perez66@icloud.com',N'Ninguna',N'Activo',N'Activo','1966-07-01','2026-07-15 05:15:30.3900000',N'SIS',N'Paola',N'SIS',N'F',N'950000066',N'960000066',N'Plan Integral',N'A+',3,120),
	 (N'Ninguna',N'Ninguno',N'León Ruiz',N'Familiar',N'Av. Javier Prado 789',N'Miraflores',N'75010989',N'fernando.leon67@hotmail.com',N'Ninguna',N'Activo',N'Activo','2006-05-02','2026-07-15 05:15:30.3966667',N'EsSalud',N'Fernando',N'EsSalud',N'M',N'950000067',N'960000067',N'Regular',N'O+',1,121),
	 (N'Ninguna',N'Ninguno',N'Torres Díaz',N'Familiar',N'Av. Javier Prado 789',N'San Borja',N'75010990',N'patricia.torres68@outlook.com',N'Ninguna',N'Activo',N'Activo','1973-05-03','2026-07-15 05:15:30.4000000',N'SIS',N'Patricia',N'SIS',N'F',N'950000068',N'960000068',N'Plan Integral',N'O+',2,122);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Díaz Campos',N'Familiar',N'Av. Javier Prado 789',N'Surco',N'75010991',N'luis.diaz69@yahoo.com',N'Ninguna',N'Activo',N'Activo','1986-07-24','2026-07-15 05:15:30.4066667',N'SIS',N'Luis',N'SIS',N'M',N'950000069',N'960000069',N'Plan Integral',N'O+',4,123),
	 (N'Ninguna',N'Ninguno',N'León Ramírez',N'Familiar',N'Av. Javier Prado 789',N'La Molina',N'75010992',N'isabel.leon70@gmail.com',N'Ninguna',N'Activo',N'Activo','1984-08-26','2026-07-15 05:15:30.4100000',N'Particular',N'Isabel',N'Particular',N'F',N'950000070',N'960000070',N'Premium',N'B+',1,124),
	 (N'Ninguna',N'Ninguno',N'Rojas Díaz',N'Familiar',N'Av. Javier Prado 789',N'San Isidro',N'75010993',N'miguel.rojas71@yahoo.com',N'Ninguna',N'Activo',N'Activo','1972-07-26','2026-07-15 05:15:30.4166667',N'SIS',N'Miguel',N'SIS',N'M',N'950000071',N'960000071',N'Plan Integral',N'A+',1,125),
	 (N'Ninguna',N'Ninguno',N'Mendoza Flores',N'Familiar',N'Av. Javier Prado 789',N'La Molina',N'75010994',N'maria.mendoza72@outlook.com',N'Ninguna',N'Activo',N'Activo','1964-04-04','2026-07-15 05:15:30.4233333',N'EsSalud',N'María',N'EsSalud',N'F',N'950000072',N'960000072',N'Regular',N'A+',1,126),
	 (N'Ninguna',N'Ninguno',N'León Castillo',N'Familiar',N'Av. Javier Prado 789',N'La Molina',N'75010995',N'pedro.leon73@gmail.com',N'Ninguna',N'Activo',N'Activo','1979-03-18','2026-07-15 05:15:30.4266667',N'EsSalud',N'Pedro',N'EsSalud',N'M',N'950000073',N'960000073',N'Regular',N'O+',1,127),
	 (N'Ninguna',N'Ninguno',N'Vargas Pérez',N'Familiar',N'Av. Javier Prado 789',N'Miraflores',N'75010996',N'lucia.vargas74@icloud.com',N'Ninguna',N'Activo',N'Activo','1998-10-21','2026-07-15 05:15:30.4333333',N'SIS',N'Lucía',N'SIS',N'F',N'950000074',N'960000074',N'Plan Integral',N'AB+',4,128),
	 (N'Ninguna',N'Ninguno',N'Ramírez Quispe',N'Familiar',N'Av. Javier Prado 789',N'San Isidro',N'75010997',N'alberto.ramirez75@hotmail.com',N'Ninguna',N'Activo',N'Activo','1991-07-07','2026-07-15 05:15:30.4433333',N'EsSalud',N'Alberto',N'EsSalud',N'M',N'950000075',N'960000075',N'Regular',N'O+',3,129),
	 (N'Ninguna',N'Ninguno',N'Campos Pérez',N'Familiar',N'Av. Javier Prado 789',N'Ate',N'75010998',N'isabel.campos76@yahoo.com',N'Ninguna',N'Activo',N'Activo','1992-09-25','2026-07-15 05:15:30.4500000',N'Particular',N'Isabel',N'Particular',N'F',N'950000076',N'960000076',N'Premium',N'AB+',2,130),
	 (N'Ninguna',N'Ninguno',N'García Pérez',N'Familiar',N'Av. Javier Prado 789',N'San Borja',N'75010999',N'roberto.garcia77@hotmail.com',N'Ninguna',N'Activo',N'Activo','1992-08-03','2026-07-15 05:15:30.4600000',N'EsSalud',N'Roberto',N'EsSalud',N'M',N'950000077',N'960000077',N'Regular',N'A+',3,131),
	 (N'Ninguna',N'Ninguno',N'Rojas Torres',N'Familiar',N'Av. Javier Prado 789',N'San Borja',N'75011000',N'maria.rojas78@outlook.com',N'Ninguna',N'Activo',N'Activo','1991-03-26','2026-07-15 05:15:30.4700000',N'EsSalud',N'María',N'EsSalud',N'F',N'950000078',N'960000078',N'Regular',N'O+',2,132);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Campos Flores',N'Familiar',N'Av. Javier Prado 789',N'Miraflores',N'75011001',N'diego.campos79@icloud.com',N'Ninguna',N'Activo',N'Activo','1970-05-28','2026-07-15 05:15:30.4766667',N'Particular',N'Diego',N'Particular',N'M',N'950000079',N'960000079',N'Premium',N'A+',1,133),
	 (N'Ninguna',N'Ninguno',N'Ramírez Torres',N'Familiar',N'Av. Javier Prado 789',N'San Miguel',N'75011002',N'andrea.ramirez80@outlook.com',N'Ninguna',N'Activo',N'Activo','1983-06-07','2026-07-15 05:15:30.4966667',N'Particular',N'Andrea',N'Particular',N'F',N'950000080',N'960000080',N'Premium',N'A+',3,134),
	 (N'Ninguna',N'Ninguno',N'García Pérez',N'Familiar',N'Av. Javier Prado 789',N'Miraflores',N'75011003',N'pedro.garcia81@outlook.com',N'Ninguna',N'Activo',N'Activo','1998-08-03','2026-07-15 05:15:30.5100000',N'EsSalud',N'Pedro',N'EsSalud',N'M',N'950000081',N'960000081',N'Regular',N'AB+',1,135),
	 (N'Ninguna',N'Ninguno',N'Mendoza Salazar',N'Familiar',N'Av. Javier Prado 789',N'La Molina',N'75011004',N'claudia.mendoza82@outlook.com',N'Ninguna',N'Activo',N'Activo','2003-11-10','2026-07-15 05:15:30.5200000',N'EsSalud',N'Claudia',N'EsSalud',N'F',N'950000082',N'960000082',N'Regular',N'O-',2,136),
	 (N'Ninguna',N'Ninguno',N'Salazar Salazar',N'Familiar',N'Av. Javier Prado 789',N'Lince',N'75011005',N'arturo.salazar83@icloud.com',N'Ninguna',N'Activo',N'Activo','1984-02-16','2026-07-15 05:15:30.5300000',N'SIS',N'Arturo',N'SIS',N'M',N'950000083',N'960000083',N'Plan Integral',N'AB+',3,137),
	 (N'Ninguna',N'Ninguno',N'Ramírez Campos',N'Familiar',N'Av. Javier Prado 789',N'San Isidro',N'75011006',N'maria.ramirez84@gmail.com',N'Ninguna',N'Activo',N'Activo','1960-07-22','2026-07-15 05:15:30.5366667',N'EsSalud',N'María',N'EsSalud',N'F',N'950000084',N'960000084',N'Regular',N'A+',3,138),
	 (N'Ninguna',N'Ninguno',N'García Ramírez',N'Familiar',N'Av. Javier Prado 789',N'San Borja',N'75011007',N'pedro.garcia85@hotmail.com',N'Ninguna',N'Activo',N'Activo','1966-03-13','2026-07-15 05:15:30.5433333',N'EsSalud',N'Pedro',N'EsSalud',N'M',N'950000085',N'960000085',N'Regular',N'B+',2,139),
	 (N'Ninguna',N'Ninguno',N'Vargas Díaz',N'Familiar',N'Av. Javier Prado 789',N'Ate',N'75011008',N'natalia.vargas86@yahoo.com',N'Ninguna',N'Activo',N'Activo','1999-02-02','2026-07-15 05:15:30.5500000',N'SIS',N'Natalia',N'SIS',N'F',N'950000086',N'960000086',N'Plan Integral',N'O+',2,140),
	 (N'Ninguna',N'Ninguno',N'Romero Flores',N'Familiar',N'Av. Javier Prado 789',N'Ate',N'75011009',N'javier.romero87@yahoo.com',N'Ninguna',N'Activo',N'Activo','1971-09-05','2026-07-15 05:15:30.5633333',N'Particular',N'Javier',N'Particular',N'M',N'950000087',N'960000087',N'Premium',N'B+',4,141),
	 (N'Ninguna',N'Ninguno',N'Rojas Díaz',N'Familiar',N'Av. Javier Prado 789',N'San Isidro',N'75011010',N'carolina.rojas88@outlook.com',N'Ninguna',N'Activo',N'Activo','1965-12-12','2026-07-15 05:15:30.5700000',N'SIS',N'Carolina',N'SIS',N'F',N'950000088',N'960000088',N'Plan Integral',N'A+',3,142);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Ramírez García',N'Familiar',N'Av. Javier Prado 789',N'La Molina',N'75011011',N'arturo.ramirez89@gmail.com',N'Ninguna',N'Activo',N'Activo','2008-02-17','2026-07-15 05:15:30.5800000',N'EsSalud',N'Arturo',N'EsSalud',N'M',N'950000089',N'960000089',N'Regular',N'AB+',4,143),
	 (N'Ninguna',N'Ninguno',N'Campos Rojas',N'Familiar',N'Av. Arequipa 1000',N'San Isidro',N'75011012',N'andrea.campos90@outlook.com',N'Ninguna',N'Activo',N'Activo','2008-07-08','2026-07-15 05:17:45.0766667',N'EsSalud',N'Andrea',N'EsSalud',N'F',N'950000090',N'960000090',N'Regular',N'AB+',2,144),
	 (N'Ninguna',N'Ninguno',N'Vargas Pérez',N'Familiar',N'Av. Arequipa 1000',N'Surco',N'75011013',N'alberto.vargas91@yahoo.com',N'Ninguna',N'Activo',N'Activo','1988-12-11','2026-07-15 05:17:45.0900000',N'SIS',N'Alberto',N'SIS',N'M',N'950000091',N'960000091',N'Plan Integral',N'O+',2,145),
	 (N'Ninguna',N'Ninguno',N'Rojas Romero',N'Familiar',N'Av. Arequipa 1000',N'Lince',N'75011014',N'paola.rojas92@outlook.com',N'Ninguna',N'Activo',N'Activo','1973-05-25','2026-07-15 05:17:45.0966667',N'EsSalud',N'Paola',N'EsSalud',N'F',N'950000092',N'960000092',N'Regular',N'AB+',1,146),
	 (N'Ninguna',N'Ninguno',N'Vargas Pérez',N'Familiar',N'Av. Arequipa 1000',N'San Miguel',N'75011015',N'luis.vargas93@icloud.com',N'Ninguna',N'Activo',N'Activo','2001-03-19','2026-07-15 05:17:45.1066667',N'EsSalud',N'Luis',N'EsSalud',N'M',N'950000093',N'960000093',N'Regular',N'O-',3,147),
	 (N'Ninguna',N'Ninguno',N'Díaz Rojas',N'Familiar',N'Av. Arequipa 1000',N'Miraflores',N'75011016',N'natalia.diaz94@hotmail.com',N'Ninguna',N'Activo',N'Activo','2009-01-06','2026-07-15 05:17:45.1133333',N'Particular',N'Natalia',N'Particular',N'F',N'950000094',N'960000094',N'Premium',N'B+',2,148),
	 (N'Ninguna',N'Ninguno',N'Ramírez Ruiz',N'Familiar',N'Av. Arequipa 1000',N'San Miguel',N'75011017',N'fernando.ramirez95@icloud.com',N'Ninguna',N'Activo',N'Activo','1975-07-29','2026-07-15 05:17:45.1200000',N'Particular',N'Fernando',N'Particular',N'M',N'950000095',N'960000095',N'Premium',N'O+',3,149),
	 (N'Ninguna',N'Ninguno',N'Pérez León',N'Familiar',N'Av. Arequipa 1000',N'Ate',N'75011018',N'patricia.perez96@hotmail.com',N'Ninguna',N'Activo',N'Activo','1967-04-19','2026-07-15 05:17:45.1266667',N'Particular',N'Patricia',N'Particular',N'F',N'950000096',N'960000096',N'Premium',N'A+',4,150),
	 (N'Ninguna',N'Ninguno',N'Rojas Díaz',N'Familiar',N'Av. Arequipa 1000',N'Lince',N'75011019',N'antonio.rojas97@icloud.com',N'Ninguna',N'Activo',N'Activo','1977-06-16','2026-07-15 05:17:45.1333333',N'EsSalud',N'Antonio',N'EsSalud',N'M',N'950000097',N'960000097',N'Regular',N'O-',1,151),
	 (N'Ninguna',N'Ninguno',N'Ruiz Ramírez',N'Familiar',N'Av. Arequipa 1000',N'Ate',N'75011020',N'carmen.ruiz98@hotmail.com',N'Ninguna',N'Activo',N'Activo','1966-11-11','2026-07-15 05:17:45.1400000',N'EsSalud',N'Carmen',N'EsSalud',N'F',N'950000098',N'960000098',N'Regular',N'A+',1,152);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Salazar Ruiz',N'Familiar',N'Av. Arequipa 1000',N'La Molina',N'75011021',N'antonio.salazar99@gmail.com',N'Ninguna',N'Activo',N'Activo','1979-03-03','2026-07-15 05:17:45.1433333',N'Particular',N'Antonio',N'Particular',N'M',N'950000099',N'960000099',N'Premium',N'A+',3,153),
	 (N'Ninguna',N'Ninguno',N'León Castillo',N'Familiar',N'Av. Arequipa 1000',N'Surco',N'75011022',N'carmen.leon100@outlook.com',N'Ninguna',N'Activo',N'Activo','1980-12-25','2026-07-15 05:17:45.1500000',N'EsSalud',N'Carmen',N'EsSalud',N'F',N'950000100',N'960000100',N'Regular',N'A+',1,154),
	 (N'Ninguna',N'Ninguno',N'Quispe Pérez',N'Familiar',N'Av. Arequipa 1000',N'Ate',N'75011023',N'david.quispe101@icloud.com',N'Ninguna',N'Activo',N'Activo','1993-09-12','2026-07-15 05:17:45.1533333',N'EsSalud',N'David',N'EsSalud',N'M',N'950000101',N'960000101',N'Regular',N'O-',4,155),
	 (N'Ninguna',N'Ninguno',N'Ramírez León',N'Familiar',N'Av. Arequipa 1000',N'Lince',N'75011024',N'carmen.ramirez102@hotmail.com',N'Ninguna',N'Activo',N'Activo','1970-07-22','2026-07-15 05:17:45.1600000',N'SIS',N'Carmen',N'SIS',N'F',N'950000102',N'960000102',N'Plan Integral',N'B+',4,156),
	 (N'Ninguna',N'Ninguno',N'Campos Romero',N'Familiar',N'Av. Arequipa 1000',N'San Borja',N'75011025',N'carlos.campos103@icloud.com',N'Ninguna',N'Activo',N'Activo','1989-05-27','2026-07-15 05:17:45.1666667',N'SIS',N'Carlos',N'SIS',N'M',N'950000103',N'960000103',N'Plan Integral',N'B+',2,157),
	 (N'Ninguna',N'Ninguno',N'Flores Díaz',N'Familiar',N'Av. Arequipa 1000',N'San Isidro',N'75011026',N'andrea.flores104@hotmail.com',N'Ninguna',N'Activo',N'Activo','2004-01-07','2026-07-15 05:17:45.1700000',N'EsSalud',N'Andrea',N'EsSalud',N'F',N'950000104',N'960000104',N'Regular',N'B+',4,158),
	 (N'Ninguna',N'Ninguno',N'Díaz Mendoza',N'Familiar',N'Av. Arequipa 1000',N'Ate',N'75011027',N'alberto.diaz105@icloud.com',N'Ninguna',N'Activo',N'Activo','1961-10-29','2026-07-15 05:17:45.1733333',N'SIS',N'Alberto',N'SIS',N'M',N'950000105',N'960000105',N'Plan Integral',N'AB+',3,159),
	 (N'Ninguna',N'Ninguno',N'García Campos',N'Familiar',N'Av. Arequipa 1000',N'San Miguel',N'75011028',N'ana.garcia106@gmail.com',N'Ninguna',N'Activo',N'Activo','1965-10-02','2026-07-15 05:17:45.1833333',N'EsSalud',N'Ana',N'EsSalud',N'F',N'950000106',N'960000106',N'Regular',N'O+',1,160),
	 (N'Ninguna',N'Ninguno',N'Campos Pérez',N'Familiar',N'Av. Arequipa 1000',N'San Isidro',N'75011029',N'miguel.campos107@outlook.com',N'Ninguna',N'Activo',N'Activo','2002-06-17','2026-07-15 05:17:45.1900000',N'Particular',N'Miguel',N'Particular',N'M',N'950000107',N'960000107',N'Premium',N'AB+',4,161),
	 (N'Ninguna',N'Ninguno',N'Vargas León',N'Familiar',N'Av. Arequipa 1000',N'La Molina',N'75011030',N'carolina.vargas108@gmail.com',N'Ninguna',N'Activo',N'Activo','1997-05-07','2026-07-15 05:17:45.1933333',N'Particular',N'Carolina',N'Particular',N'F',N'950000108',N'960000108',N'Premium',N'AB+',4,162);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Rojas Ramírez',N'Familiar',N'Av. Arequipa 1000',N'Lince',N'75011031',N'fernando.rojas109@icloud.com',N'Ninguna',N'Activo',N'Activo','1986-07-23','2026-07-15 05:17:45.1966667',N'EsSalud',N'Fernando',N'EsSalud',N'M',N'950000109',N'960000109',N'Regular',N'A+',2,163),
	 (N'Ninguna',N'Ninguno',N'Flores Díaz',N'Familiar',N'Av. Arequipa 1000',N'San Isidro',N'75011032',N'natalia.flores110@hotmail.com',N'Ninguna',N'Activo',N'Activo','2000-03-24','2026-07-15 05:17:45.2000000',N'Particular',N'Natalia',N'Particular',N'F',N'950000110',N'960000110',N'Premium',N'O-',1,164),
	 (N'Ninguna',N'Ninguno',N'Rojas Quispe',N'Familiar',N'Av. Arequipa 1000',N'Lince',N'75011033',N'sergio.rojas111@gmail.com',N'Ninguna',N'Activo',N'Activo','1996-01-18','2026-07-15 05:17:45.2100000',N'Particular',N'Sergio',N'Particular',N'M',N'950000111',N'960000111',N'Premium',N'B+',4,165),
	 (N'Ninguna',N'Ninguno',N'Castillo Castillo',N'Familiar',N'Av. Arequipa 1000',N'San Borja',N'75011034',N'maria.castillo112@outlook.com',N'Ninguna',N'Activo',N'Activo','1981-08-14','2026-07-15 05:17:45.2133333',N'EsSalud',N'María',N'EsSalud',N'F',N'950000112',N'960000112',N'Regular',N'AB+',4,166),
	 (N'Ninguna',N'Ninguno',N'Salazar León',N'Familiar',N'Av. Arequipa 1000',N'Surco',N'75011035',N'jorge.salazar113@gmail.com',N'Ninguna',N'Activo',N'Activo','2003-05-15','2026-07-15 05:17:45.2200000',N'SIS',N'Jorge',N'SIS',N'M',N'950000113',N'960000113',N'Plan Integral',N'O+',4,167),
	 (N'Ninguna',N'Ninguno',N'Castillo Quispe',N'Familiar',N'Av. Arequipa 1000',N'Miraflores',N'75011036',N'lucia.castillo114@icloud.com',N'Ninguna',N'Activo',N'Activo','1966-05-17','2026-07-15 05:17:45.2300000',N'Particular',N'Lucía',N'Particular',N'F',N'950000114',N'960000114',N'Premium',N'AB+',3,168),
	 (N'Ninguna',N'Ninguno',N'Salazar Ramírez',N'Familiar',N'Av. Arequipa 1000',N'Ate',N'75011037',N'alberto.salazar115@yahoo.com',N'Ninguna',N'Activo',N'Activo','1962-10-16','2026-07-15 05:17:45.2333333',N'EsSalud',N'Alberto',N'EsSalud',N'M',N'950000115',N'960000115',N'Regular',N'AB+',4,169),
	 (N'Ninguna',N'Ninguno',N'Flores Campos',N'Familiar',N'Av. Arequipa 1000',N'Ate',N'75011038',N'natalia.flores116@yahoo.com',N'Ninguna',N'Activo',N'Activo','2004-09-12','2026-07-15 05:17:45.2400000',N'Particular',N'Natalia',N'Particular',N'F',N'950000116',N'960000116',N'Premium',N'AB+',1,170),
	 (N'Ninguna',N'Ninguno',N'Ramírez Díaz',N'Familiar',N'Av. Arequipa 1000',N'Ate',N'75011039',N'alberto.ramirez117@yahoo.com',N'Ninguna',N'Activo',N'Activo','1997-06-04','2026-07-15 05:17:45.2500000',N'SIS',N'Alberto',N'SIS',N'M',N'950000117',N'960000117',N'Plan Integral',N'AB+',2,171),
	 (N'Ninguna',N'Ninguno',N'Flores Rojas',N'Familiar',N'Av. Arequipa 1000',N'Lince',N'75011040',N'ana.flores118@gmail.com',N'Ninguna',N'Activo',N'Activo','1997-11-08','2026-07-15 05:17:45.2566667',N'Particular',N'Ana',N'Particular',N'F',N'950000118',N'960000118',N'Premium',N'O+',3,172);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Torres Castillo',N'Familiar',N'Av. Arequipa 1000',N'Ate',N'75011041',N'arturo.torres119@gmail.com',N'Ninguna',N'Activo',N'Activo','1987-02-06','2026-07-15 05:17:45.2666667',N'EsSalud',N'Arturo',N'EsSalud',N'M',N'950000119',N'960000119',N'Regular',N'A+',2,173),
	 (N'Ninguna',N'Ninguno',N'Quispe Romero',N'Familiar',N'Av. Canadá 1500',N'Lince',N'75011042',N'carmen.quispe120@outlook.com',N'Ninguna',N'Activo',N'Activo','1980-11-19','2026-07-15 05:20:10.0966667',N'SIS',N'Carmen',N'SIS',N'F',N'950000120',N'960000120',N'Plan Integral',N'O+',4,174),
	 (N'Ninguna',N'Ninguno',N'Vargas Mendoza',N'Familiar',N'Av. Canadá 1500',N'Ate',N'75011043',N'diego.vargas121@outlook.com',N'Ninguna',N'Activo',N'Activo','1981-10-18','2026-07-15 05:20:10.1033333',N'EsSalud',N'Diego',N'EsSalud',N'M',N'950000121',N'960000121',N'Regular',N'O-',1,175),
	 (N'Ninguna',N'Ninguno',N'Salazar Torres',N'Familiar',N'Av. Canadá 1500',N'Ate',N'75011044',N'lucia.salazar122@outlook.com',N'Ninguna',N'Activo',N'Activo','1964-03-13','2026-07-15 05:20:10.1100000',N'SIS',N'Lucía',N'SIS',N'F',N'950000122',N'960000122',N'Plan Integral',N'A+',3,176),
	 (N'Ninguna',N'Ninguno',N'Pérez Rojas',N'Familiar',N'Av. Canadá 1500',N'San Borja',N'75011045',N'luis.perez123@icloud.com',N'Ninguna',N'Activo',N'Activo','1977-10-19','2026-07-15 05:20:10.1166667',N'Particular',N'Luis',N'Particular',N'M',N'950000123',N'960000123',N'Premium',N'AB+',1,177),
	 (N'Ninguna',N'Ninguno',N'Torres Castillo',N'Familiar',N'Av. Canadá 1500',N'Lince',N'75011046',N'maria.torres124@outlook.com',N'Ninguna',N'Activo',N'Activo','1984-04-02','2026-07-15 05:20:10.1233333',N'EsSalud',N'María',N'EsSalud',N'F',N'950000124',N'960000124',N'Regular',N'A+',3,178),
	 (N'Ninguna',N'Ninguno',N'Quispe Díaz',N'Familiar',N'Av. Canadá 1500',N'La Molina',N'75011047',N'sergio.quispe125@hotmail.com',N'Ninguna',N'Activo',N'Activo','1974-10-01','2026-07-15 05:20:10.1300000',N'EsSalud',N'Sergio',N'EsSalud',N'M',N'950000125',N'960000125',N'Regular',N'AB+',1,179),
	 (N'Ninguna',N'Ninguno',N'Torres García',N'Familiar',N'Av. Canadá 1500',N'San Borja',N'75011048',N'natalia.torres126@gmail.com',N'Ninguna',N'Activo',N'Activo','1961-11-14','2026-07-15 05:20:10.1400000',N'SIS',N'Natalia',N'SIS',N'F',N'950000126',N'960000126',N'Plan Integral',N'O-',2,180),
	 (N'Ninguna',N'Ninguno',N'Rojas Flores',N'Familiar',N'Av. Canadá 1500',N'Surco',N'75011049',N'miguel.rojas127@gmail.com',N'Ninguna',N'Activo',N'Activo','1998-10-09','2026-07-15 05:20:10.1466667',N'Particular',N'Miguel',N'Particular',N'M',N'950000127',N'960000127',N'Premium',N'O-',4,181),
	 (N'Ninguna',N'Ninguno',N'Vargas León',N'Familiar',N'Av. Canadá 1500',N'San Borja',N'75011050',N'carolina.vargas128@outlook.com',N'Ninguna',N'Activo',N'Activo','1982-01-07','2026-07-15 05:20:10.1600000',N'Particular',N'Carolina',N'Particular',N'F',N'950000128',N'960000128',N'Premium',N'O-',4,182);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Quispe Romero',N'Familiar',N'Av. Canadá 1500',N'San Isidro',N'75011051',N'luis.quispe129@outlook.com',N'Ninguna',N'Activo',N'Activo','2010-12-19','2026-07-15 05:20:10.1666667',N'Particular',N'Luis',N'Particular',N'M',N'950000129',N'960000129',N'Premium',N'A+',1,183),
	 (N'Ninguna',N'Ninguno',N'León Flores',N'Familiar',N'Av. Canadá 1500',N'Lince',N'75011052',N'paola.leon130@outlook.com',N'Ninguna',N'Activo',N'Activo','1965-02-09','2026-07-15 05:20:10.1700000',N'Particular',N'Paola',N'Particular',N'F',N'950000130',N'960000130',N'Premium',N'A+',4,184),
	 (N'Ninguna',N'Ninguno',N'Castillo Castillo',N'Familiar',N'Av. Canadá 1500',N'Surco',N'75011053',N'fernando.castillo131@outlook.com',N'Ninguna',N'Activo',N'Activo','1990-03-08','2026-07-15 05:20:10.1766667',N'SIS',N'Fernando',N'SIS',N'M',N'950000131',N'960000131',N'Plan Integral',N'B+',4,185),
	 (N'Ninguna',N'Ninguno',N'Flores Torres',N'Familiar',N'Av. Canadá 1500',N'San Borja',N'75011054',N'carolina.flores132@gmail.com',N'Ninguna',N'Activo',N'Activo','1982-04-07','2026-07-15 05:20:10.1800000',N'EsSalud',N'Carolina',N'EsSalud',N'F',N'950000132',N'960000132',N'Regular',N'A+',4,186),
	 (N'Ninguna',N'Ninguno',N'Campos Ramírez',N'Familiar',N'Av. Canadá 1500',N'San Isidro',N'75011055',N'luis.campos133@gmail.com',N'Ninguna',N'Activo',N'Activo','1984-01-24','2026-07-15 05:20:10.1833333',N'SIS',N'Luis',N'SIS',N'M',N'950000133',N'960000133',N'Plan Integral',N'O+',1,187),
	 (N'Ninguna',N'Ninguno',N'Castillo León',N'Familiar',N'Av. Canadá 1500',N'La Molina',N'75011056',N'maria.castillo134@gmail.com',N'Ninguna',N'Activo',N'Activo','1964-01-18','2026-07-15 05:20:10.1866667',N'EsSalud',N'María',N'EsSalud',N'F',N'950000134',N'960000134',N'Regular',N'A+',2,188),
	 (N'Ninguna',N'Ninguno',N'Campos León',N'Familiar',N'Av. Canadá 1500',N'Lince',N'75011057',N'eduardo.campos135@yahoo.com',N'Ninguna',N'Activo',N'Activo','1962-05-03','2026-07-15 05:20:10.1900000',N'Particular',N'Eduardo',N'Particular',N'M',N'950000135',N'960000135',N'Premium',N'AB+',2,189),
	 (N'Ninguna',N'Ninguno',N'Campos Castillo',N'Familiar',N'Av. Canadá 1500',N'San Miguel',N'75011058',N'lucia.campos136@icloud.com',N'Ninguna',N'Activo',N'Activo','1976-11-10','2026-07-15 05:20:10.1966667',N'Particular',N'Lucía',N'Particular',N'F',N'950000136',N'960000136',N'Premium',N'AB+',2,190),
	 (N'Ninguna',N'Ninguno',N'Salazar Salazar',N'Familiar',N'Av. Canadá 1500',N'Miraflores',N'75011059',N'sergio.salazar137@icloud.com',N'Ninguna',N'Activo',N'Activo','1961-01-13','2026-07-15 05:20:10.2000000',N'Particular',N'Sergio',N'Particular',N'M',N'950000137',N'960000137',N'Premium',N'AB+',3,191),
	 (N'Ninguna',N'Ninguno',N'García Romero',N'Familiar',N'Av. Canadá 1500',N'Miraflores',N'75011060',N'elena.garcia138@outlook.com',N'Ninguna',N'Activo',N'Activo','2003-02-19','2026-07-15 05:20:10.2066667',N'EsSalud',N'Elena',N'EsSalud',N'F',N'950000138',N'960000138',N'Regular',N'AB+',1,192);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Castillo Rojas',N'Familiar',N'Av. Canadá 1500',N'Miraflores',N'75011061',N'roberto.castillo139@yahoo.com',N'Ninguna',N'Activo',N'Activo','2005-11-24','2026-07-15 05:20:10.2100000',N'SIS',N'Roberto',N'SIS',N'M',N'950000139',N'960000139',N'Plan Integral',N'O-',4,193),
	 (N'Ninguna',N'Ninguno',N'Campos Pérez',N'Familiar',N'Av. Canadá 1500',N'Lince',N'75011062',N'carmen.campos140@hotmail.com',N'Ninguna',N'Activo',N'Activo','1993-12-11','2026-07-15 05:20:10.2133333',N'SIS',N'Carmen',N'SIS',N'F',N'950000140',N'960000140',N'Plan Integral',N'O-',1,194),
	 (N'Ninguna',N'Ninguno',N'García Campos',N'Familiar',N'Av. Canadá 1500',N'Ate',N'75011063',N'arturo.garcia141@outlook.com',N'Ninguna',N'Activo',N'Activo','2003-10-31','2026-07-15 05:20:10.2166667',N'Particular',N'Arturo',N'Particular',N'M',N'950000141',N'960000141',N'Premium',N'B+',2,195),
	 (N'Ninguna',N'Ninguno',N'Castillo Rojas',N'Familiar',N'Av. Canadá 1500',N'La Molina',N'75011064',N'claudia.castillo142@icloud.com',N'Ninguna',N'Activo',N'Activo','1961-06-11','2026-07-15 05:20:10.2233333',N'Particular',N'Claudia',N'Particular',N'F',N'950000142',N'960000142',N'Premium',N'O-',3,196),
	 (N'Ninguna',N'Ninguno',N'Flores Pérez',N'Familiar',N'Av. Canadá 1500',N'Ate',N'75011065',N'miguel.flores143@outlook.com',N'Ninguna',N'Activo',N'Activo','1983-12-25','2026-07-15 05:20:10.2300000',N'SIS',N'Miguel',N'SIS',N'M',N'950000143',N'960000143',N'Plan Integral',N'A+',4,197),
	 (N'Ninguna',N'Ninguno',N'Díaz Díaz',N'Familiar',N'Av. Canadá 1500',N'San Borja',N'75011066',N'carmen.diaz144@gmail.com',N'Ninguna',N'Activo',N'Activo','2001-04-24','2026-07-15 05:20:10.2400000',N'EsSalud',N'Carmen',N'EsSalud',N'F',N'950000144',N'960000144',N'Regular',N'A+',3,198),
	 (N'Ninguna',N'Ninguno',N'Quispe Ramírez',N'Familiar',N'Av. Canadá 1500',N'La Molina',N'75011067',N'carlos.quispe145@icloud.com',N'Ninguna',N'Activo',N'Activo','1974-05-06','2026-07-15 05:20:10.2466667',N'SIS',N'Carlos',N'SIS',N'M',N'950000145',N'960000145',N'Plan Integral',N'A+',1,199),
	 (N'Ninguna',N'Ninguno',N'Salazar Vargas',N'Familiar',N'Av. Canadá 1500',N'Ate',N'75011068',N'paola.salazar146@yahoo.com',N'Ninguna',N'Activo',N'Activo','2012-08-24','2026-07-15 05:20:10.2533333',N'EsSalud',N'Paola',N'EsSalud',N'F',N'950000146',N'960000146',N'Regular',N'O+',1,200),
	 (N'Ninguna',N'Ninguno',N'Quispe Vargas',N'Familiar',N'Av. Canadá 1500',N'Ate',N'75011069',N'roberto.quispe147@hotmail.com',N'Ninguna',N'Activo',N'Activo','1969-11-02','2026-07-15 05:20:10.2566667',N'Particular',N'Roberto',N'Particular',N'M',N'950000147',N'960000147',N'Premium',N'AB+',2,201),
	 (N'Ninguna',N'Ninguno',N'Mendoza Salazar',N'Familiar',N'Av. Canadá 1500',N'Ate',N'75011070',N'julia.mendoza148@outlook.com',N'Ninguna',N'Activo',N'Activo','1963-10-18','2026-07-15 05:20:10.2633333',N'EsSalud',N'Julia',N'EsSalud',N'F',N'950000148',N'960000148',N'Regular',N'A+',4,202);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Vargas Romero',N'Familiar',N'Av. Canadá 1500',N'San Isidro',N'75011071',N'fernando.vargas149@gmail.com',N'Ninguna',N'Activo',N'Activo','1991-07-04','2026-07-15 05:20:10.2666667',N'Particular',N'Fernando',N'Particular',N'M',N'950000149',N'960000149',N'Premium',N'B+',2,203),
	 (N'Ninguna',N'Ninguno',N'Rojas Campos',N'Familiar',N'Av. Universitaria 2200',N'Comas',N'75011072',N'natalia.rojas150@yahoo.com',N'Ninguna',N'Activo',N'Activo','1995-06-25','2026-07-15 05:21:21.4700000',N'SIS',N'Natalia',N'SIS',N'F',N'950000150',N'960000150',N'Plan Integral',N'O+',3,204),
	 (N'Ninguna',N'Ninguno',N'García León',N'Familiar',N'Av. Universitaria 2200',N'Los Olivos',N'75011073',N'arturo.garcia151@yahoo.com',N'Ninguna',N'Activo',N'Activo','1965-11-23','2026-07-15 05:21:21.4800000',N'EsSalud',N'Arturo',N'EsSalud',N'M',N'950000151',N'960000151',N'Regular',N'AB+',4,205),
	 (N'Ninguna',N'Ninguno',N'Torres León',N'Familiar',N'Av. Universitaria 2200',N'San Miguel',N'75011074',N'andrea.torres152@outlook.com',N'Ninguna',N'Activo',N'Activo','1966-07-22','2026-07-15 05:21:21.4866667',N'SIS',N'Andrea',N'SIS',N'F',N'950000152',N'960000152',N'Plan Integral',N'O+',3,206),
	 (N'Ninguna',N'Ninguno',N'Rojas Flores',N'Familiar',N'Av. Universitaria 2200',N'Miraflores',N'75011075',N'luis.rojas153@gmail.com',N'Ninguna',N'Activo',N'Activo','2000-06-13','2026-07-15 05:21:21.4966667',N'Particular',N'Luis',N'Particular',N'M',N'950000153',N'960000153',N'Premium',N'AB+',4,207),
	 (N'Ninguna',N'Ninguno',N'Campos Pérez',N'Familiar',N'Av. Universitaria 2200',N'Comas',N'75011076',N'ana.campos154@outlook.com',N'Ninguna',N'Activo',N'Activo','1998-11-17','2026-07-15 05:21:21.5000000',N'Particular',N'Ana',N'Particular',N'F',N'950000154',N'960000154',N'Premium',N'O+',3,208),
	 (N'Ninguna',N'Ninguno',N'Flores Flores',N'Familiar',N'Av. Universitaria 2200',N'Miraflores',N'75011077',N'diego.flores155@hotmail.com',N'Ninguna',N'Activo',N'Activo','1985-07-15','2026-07-15 05:21:21.5066667',N'EsSalud',N'Diego',N'EsSalud',N'M',N'950000155',N'960000155',N'Regular',N'AB+',4,209),
	 (N'Ninguna',N'Ninguno',N'Flores Romero',N'Familiar',N'Av. Universitaria 2200',N'Lince',N'75011078',N'maria.flores156@hotmail.com',N'Ninguna',N'Activo',N'Activo','1972-09-24','2026-07-15 05:21:21.5133333',N'SIS',N'María',N'SIS',N'F',N'950000156',N'960000156',N'Plan Integral',N'O-',2,210),
	 (N'Ninguna',N'Ninguno',N'Torres Romero',N'Familiar',N'Av. Universitaria 2200',N'San Miguel',N'75011079',N'carlos.torres157@icloud.com',N'Ninguna',N'Activo',N'Activo','1958-03-15','2026-07-15 05:21:21.5200000',N'Particular',N'Carlos',N'Particular',N'M',N'950000157',N'960000157',N'Premium',N'A+',4,211),
	 (N'Ninguna',N'Ninguno',N'Mendoza Pérez',N'Familiar',N'Av. Universitaria 2200',N'San Miguel',N'75011080',N'isabel.mendoza158@hotmail.com',N'Ninguna',N'Activo',N'Activo','1992-12-30','2026-07-15 05:21:21.5266667',N'SIS',N'Isabel',N'SIS',N'F',N'950000158',N'960000158',N'Plan Integral',N'B+',1,212);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'León Salazar',N'Familiar',N'Av. Universitaria 2200',N'Miraflores',N'75011081',N'carlos.leon159@yahoo.com',N'Ninguna',N'Activo',N'Activo','2004-06-19','2026-07-15 05:21:21.5333333',N'SIS',N'Carlos',N'SIS',N'M',N'950000159',N'960000159',N'Plan Integral',N'A+',2,213),
	 (N'Ninguna',N'Ninguno',N'Romero Díaz',N'Familiar',N'Av. Universitaria 2200',N'La Molina',N'75011082',N'isabel.romero160@hotmail.com',N'Ninguna',N'Activo',N'Activo','2008-11-06','2026-07-15 05:21:21.5400000',N'EsSalud',N'Isabel',N'EsSalud',N'F',N'950000160',N'960000160',N'Regular',N'O+',3,214),
	 (N'Ninguna',N'Ninguno',N'Flores Flores',N'Familiar',N'Av. Universitaria 2200',N'La Molina',N'75011083',N'jorge.flores161@yahoo.com',N'Ninguna',N'Activo',N'Activo','2003-02-09','2026-07-15 05:21:21.5466667',N'SIS',N'Jorge',N'SIS',N'M',N'950000161',N'960000161',N'Plan Integral',N'AB+',3,215),
	 (N'Ninguna',N'Ninguno',N'Castillo Quispe',N'Familiar',N'Av. Universitaria 2200',N'Los Olivos',N'75011084',N'lucia.castillo162@yahoo.com',N'Ninguna',N'Activo',N'Activo','1993-06-22','2026-07-15 05:21:21.5500000',N'Particular',N'Lucía',N'Particular',N'F',N'950000162',N'960000162',N'Premium',N'A+',4,216),
	 (N'Ninguna',N'Ninguno',N'Quispe Pérez',N'Familiar',N'Av. Universitaria 2200',N'La Molina',N'75011085',N'antonio.quispe163@hotmail.com',N'Ninguna',N'Activo',N'Activo','1976-05-14','2026-07-15 05:21:21.5566667',N'EsSalud',N'Antonio',N'EsSalud',N'M',N'950000163',N'960000163',N'Regular',N'A+',2,217),
	 (N'Ninguna',N'Ninguno',N'Díaz Romero',N'Familiar',N'Av. Universitaria 2200',N'Ate',N'75011086',N'paola.diaz164@gmail.com',N'Ninguna',N'Activo',N'Activo','1972-10-19','2026-07-15 05:21:21.5633333',N'Particular',N'Paola',N'Particular',N'F',N'950000164',N'960000164',N'Premium',N'A+',2,218),
	 (N'Ninguna',N'Ninguno',N'Mendoza Ramírez',N'Familiar',N'Av. Universitaria 2200',N'Surco',N'75011087',N'miguel.mendoza165@icloud.com',N'Ninguna',N'Activo',N'Activo','1963-08-08','2026-07-15 05:21:21.5733333',N'SIS',N'Miguel',N'SIS',N'M',N'950000165',N'960000165',N'Plan Integral',N'B+',3,219),
	 (N'Ninguna',N'Ninguno',N'Torres Ramírez',N'Familiar',N'Av. Universitaria 2200',N'San Isidro',N'75011088',N'carolina.torres166@outlook.com',N'Ninguna',N'Activo',N'Activo','1963-07-16','2026-07-15 05:21:21.5800000',N'SIS',N'Carolina',N'SIS',N'F',N'950000166',N'960000166',N'Plan Integral',N'O-',1,220),
	 (N'Ninguna',N'Ninguno',N'Quispe Castillo',N'Familiar',N'Av. Universitaria 2200',N'Miraflores',N'75011089',N'antonio.quispe167@gmail.com',N'Ninguna',N'Activo',N'Activo','1977-04-15','2026-07-15 05:21:21.5866667',N'EsSalud',N'Antonio',N'EsSalud',N'M',N'950000167',N'960000167',N'Regular',N'O+',3,221),
	 (N'Ninguna',N'Ninguno',N'Quispe Vargas',N'Familiar',N'Av. Universitaria 2200',N'Miraflores',N'75011090',N'lucia.quispe168@gmail.com',N'Ninguna',N'Activo',N'Activo','1975-07-29','2026-07-15 05:21:21.5900000',N'SIS',N'Lucía',N'SIS',N'F',N'950000168',N'960000168',N'Plan Integral',N'B+',4,222);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Ramírez Ramírez',N'Familiar',N'Av. Universitaria 2200',N'San Borja',N'75011091',N'roberto.ramirez169@gmail.com',N'Ninguna',N'Activo',N'Activo','1993-09-28','2026-07-15 05:21:21.5966667',N'Particular',N'Roberto',N'Particular',N'M',N'950000169',N'960000169',N'Premium',N'AB+',3,223),
	 (N'Ninguna',N'Ninguno',N'León Ramírez',N'Familiar',N'Av. Universitaria 2200',N'La Molina',N'75011092',N'maria.leon170@hotmail.com',N'Ninguna',N'Activo',N'Activo','2009-01-01','2026-07-15 05:21:21.6033333',N'SIS',N'María',N'SIS',N'F',N'950000170',N'960000170',N'Plan Integral',N'O+',1,224),
	 (N'Ninguna',N'Ninguno',N'Pérez Díaz',N'Familiar',N'Av. Universitaria 2200',N'San Isidro',N'75011093',N'david.perez171@icloud.com',N'Ninguna',N'Activo',N'Activo','2011-05-27','2026-07-15 05:21:21.6066667',N'Particular',N'David',N'Particular',N'M',N'950000171',N'960000171',N'Premium',N'A+',1,225),
	 (N'Ninguna',N'Ninguno',N'García García',N'Familiar',N'Av. Universitaria 2200',N'Miraflores',N'75011094',N'patricia.garcia172@outlook.com',N'Ninguna',N'Activo',N'Activo','1990-04-06','2026-07-15 05:21:21.6133333',N'Particular',N'Patricia',N'Particular',N'F',N'950000172',N'960000172',N'Premium',N'B+',1,226),
	 (N'Ninguna',N'Ninguno',N'Campos Salazar',N'Familiar',N'Av. Universitaria 2200',N'Los Olivos',N'75011095',N'miguel.campos173@icloud.com',N'Ninguna',N'Activo',N'Activo','1987-02-12','2026-07-15 05:21:21.6200000',N'SIS',N'Miguel',N'SIS',N'M',N'950000173',N'960000173',N'Plan Integral',N'A+',3,227),
	 (N'Ninguna',N'Ninguno',N'García Torres',N'Familiar',N'Av. Universitaria 2200',N'Lince',N'75011096',N'sandra.garcia174@icloud.com',N'Ninguna',N'Activo',N'Activo','1990-01-06','2026-07-15 05:21:21.6266667',N'Particular',N'Sandra',N'Particular',N'F',N'950000174',N'960000174',N'Premium',N'B+',1,228),
	 (N'Ninguna',N'Ninguno',N'León Pérez',N'Familiar',N'Av. Universitaria 2200',N'San Miguel',N'75011097',N'javier.leon175@yahoo.com',N'Ninguna',N'Activo',N'Activo','1963-04-12','2026-07-15 05:21:21.6333333',N'Particular',N'Javier',N'Particular',N'M',N'950000175',N'960000175',N'Premium',N'O+',3,229),
	 (N'Ninguna',N'Ninguno',N'Ruiz García',N'Familiar',N'Av. Universitaria 2200',N'Lince',N'75011098',N'julia.ruiz176@gmail.com',N'Ninguna',N'Activo',N'Activo','1980-01-20','2026-07-15 05:21:21.6366667',N'Particular',N'Julia',N'Particular',N'F',N'950000176',N'960000176',N'Premium',N'O+',4,230),
	 (N'Ninguna',N'Ninguno',N'García León',N'Familiar',N'Av. Universitaria 2200',N'Ate',N'75011099',N'carlos.garcia177@yahoo.com',N'Ninguna',N'Activo',N'Activo','1996-06-19','2026-07-15 05:21:21.6433333',N'Particular',N'Carlos',N'Particular',N'M',N'950000177',N'960000177',N'Premium',N'O+',4,231),
	 (N'Ninguna',N'Ninguno',N'Díaz Flores',N'Familiar',N'Av. Universitaria 2200',N'Ate',N'75011100',N'patricia.diaz178@gmail.com',N'Ninguna',N'Activo',N'Activo','1960-12-09','2026-07-15 05:21:21.6500000',N'SIS',N'Patricia',N'SIS',N'F',N'950000178',N'960000178',N'Plan Integral',N'AB+',4,232);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Vargas Vargas',N'Familiar',N'Av. Universitaria 2200',N'Los Olivos',N'75011101',N'sergio.vargas179@outlook.com',N'Ninguna',N'Activo',N'Activo','1975-11-20','2026-07-15 05:21:21.6533333',N'Particular',N'Sergio',N'Particular',N'M',N'950000179',N'960000179',N'Premium',N'A+',3,233),
	 (N'Ninguna',N'Ninguno',N'León Torres',N'Familiar',N'Av. Brasil 3200',N'Comas',N'75011102',N'patricia.leon180@hotmail.com',N'Ninguna',N'Activo',N'Activo','1967-10-15','2026-07-15 05:22:23.2000000',N'Particular',N'Patricia',N'Particular',N'F',N'950000180',N'960000180',N'Premium',N'O-',2,234),
	 (N'Ninguna',N'Ninguno',N'Salazar Díaz',N'Familiar',N'Av. Brasil 3200',N'San Miguel',N'75011103',N'eduardo.salazar181@yahoo.com',N'Ninguna',N'Activo',N'Activo','1961-08-16','2026-07-15 05:22:23.2100000',N'SIS',N'Eduardo',N'SIS',N'M',N'950000181',N'960000181',N'Plan Integral',N'O+',3,235),
	 (N'Ninguna',N'Ninguno',N'León Flores',N'Familiar',N'Av. Brasil 3200',N'San Miguel',N'75011104',N'patricia.leon182@icloud.com',N'Ninguna',N'Activo',N'Activo','2001-05-03','2026-07-15 05:22:23.2200000',N'Particular',N'Patricia',N'Particular',N'F',N'950000182',N'960000182',N'Premium',N'AB+',4,236),
	 (N'Ninguna',N'Ninguno',N'Mendoza Ramírez',N'Familiar',N'Av. Brasil 3200',N'Lince',N'75011105',N'arturo.mendoza183@gmail.com',N'Ninguna',N'Activo',N'Activo','2011-03-10','2026-07-15 05:22:23.2266667',N'Particular',N'Arturo',N'Particular',N'M',N'950000183',N'960000183',N'Premium',N'O-',1,237),
	 (N'Ninguna',N'Ninguno',N'Vargas Campos',N'Familiar',N'Av. Brasil 3200',N'Surco',N'75011106',N'lucia.vargas184@icloud.com',N'Ninguna',N'Activo',N'Activo','1981-08-09','2026-07-15 05:22:23.2333333',N'SIS',N'Lucía',N'SIS',N'F',N'950000184',N'960000184',N'Plan Integral',N'B+',4,238),
	 (N'Ninguna',N'Ninguno',N'Quispe Salazar',N'Familiar',N'Av. Brasil 3200',N'Los Olivos',N'75011107',N'miguel.quispe185@outlook.com',N'Ninguna',N'Activo',N'Activo','1959-06-03','2026-07-15 05:22:23.2400000',N'SIS',N'Miguel',N'SIS',N'M',N'950000185',N'960000185',N'Plan Integral',N'AB+',4,239),
	 (N'Ninguna',N'Ninguno',N'Rojas García',N'Familiar',N'Av. Brasil 3200',N'Los Olivos',N'75011108',N'claudia.rojas186@hotmail.com',N'Ninguna',N'Activo',N'Activo','2014-12-03','2026-07-15 05:22:23.2466667',N'SIS',N'Claudia',N'SIS',N'F',N'950000186',N'960000186',N'Plan Integral',N'A+',4,240),
	 (N'Ninguna',N'Ninguno',N'Pérez Flores',N'Familiar',N'Av. Brasil 3200',N'San Miguel',N'75011109',N'arturo.perez187@icloud.com',N'Ninguna',N'Activo',N'Activo','1989-09-29','2026-07-15 05:22:23.2533333',N'Particular',N'Arturo',N'Particular',N'M',N'950000187',N'960000187',N'Premium',N'A+',1,241),
	 (N'Ninguna',N'Ninguno',N'León Rojas',N'Familiar',N'Av. Brasil 3200',N'San Isidro',N'75011110',N'paola.leon188@hotmail.com',N'Ninguna',N'Activo',N'Activo','2001-04-25','2026-07-15 05:22:23.2600000',N'EsSalud',N'Paola',N'EsSalud',N'F',N'950000188',N'960000188',N'Regular',N'AB+',4,242);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Torres García',N'Familiar',N'Av. Brasil 3200',N'San Borja',N'75011111',N'fernando.torres189@outlook.com',N'Ninguna',N'Activo',N'Activo','1974-04-28','2026-07-15 05:22:23.2700000',N'Particular',N'Fernando',N'Particular',N'M',N'950000189',N'960000189',N'Premium',N'O+',1,243),
	 (N'Ninguna',N'Ninguno',N'Flores Salazar',N'Familiar',N'Av. Brasil 3200',N'Lince',N'75011112',N'andrea.flores190@hotmail.com',N'Ninguna',N'Activo',N'Activo','2014-04-10','2026-07-15 05:22:23.2766667',N'SIS',N'Andrea',N'SIS',N'F',N'950000190',N'960000190',N'Plan Integral',N'O+',2,244),
	 (N'Ninguna',N'Ninguno',N'Salazar Pérez',N'Familiar',N'Av. Brasil 3200',N'San Isidro',N'75011113',N'miguel.salazar191@gmail.com',N'Ninguna',N'Activo',N'Activo','1982-10-06','2026-07-15 05:22:23.2833333',N'EsSalud',N'Miguel',N'EsSalud',N'M',N'950000191',N'960000191',N'Regular',N'A+',4,245),
	 (N'Ninguna',N'Ninguno',N'Castillo Díaz',N'Familiar',N'Av. Brasil 3200',N'Comas',N'75011114',N'patricia.castillo192@hotmail.com',N'Ninguna',N'Activo',N'Activo','1964-01-26','2026-07-15 05:22:23.2900000',N'SIS',N'Patricia',N'SIS',N'F',N'950000192',N'960000192',N'Plan Integral',N'O-',4,246),
	 (N'Ninguna',N'Ninguno',N'Salazar Salazar',N'Familiar',N'Av. Brasil 3200',N'La Molina',N'75011115',N'miguel.salazar193@hotmail.com',N'Ninguna',N'Activo',N'Activo','1975-09-10','2026-07-15 05:22:23.3000000',N'Particular',N'Miguel',N'Particular',N'M',N'950000193',N'960000193',N'Premium',N'AB+',3,247),
	 (N'Ninguna',N'Ninguno',N'García Quispe',N'Familiar',N'Av. Brasil 3200',N'Comas',N'75011116',N'teresa.garcia194@outlook.com',N'Ninguna',N'Activo',N'Activo','1960-11-24','2026-07-15 05:22:23.3066667',N'Particular',N'Teresa',N'Particular',N'F',N'950000194',N'960000194',N'Premium',N'B+',4,248),
	 (N'Ninguna',N'Ninguno',N'Romero Ruiz',N'Familiar',N'Av. Brasil 3200',N'Lince',N'75011117',N'roberto.romero195@outlook.com',N'Ninguna',N'Activo',N'Activo','1968-06-09','2026-07-15 05:22:23.3100000',N'SIS',N'Roberto',N'SIS',N'M',N'950000195',N'960000195',N'Plan Integral',N'A+',1,249),
	 (N'Ninguna',N'Ninguno',N'Torres Salazar',N'Familiar',N'Av. Brasil 3200',N'Lince',N'75011118',N'paola.torres196@outlook.com',N'Ninguna',N'Activo',N'Activo','2006-04-29','2026-07-15 05:22:23.3200000',N'EsSalud',N'Paola',N'EsSalud',N'F',N'950000196',N'960000196',N'Regular',N'A+',3,250),
	 (N'Ninguna',N'Ninguno',N'Quispe Castillo',N'Familiar',N'Av. Brasil 3200',N'Ate',N'75011119',N'arturo.quispe197@outlook.com',N'Ninguna',N'Activo',N'Activo','2007-12-29','2026-07-15 05:22:23.3266667',N'Particular',N'Arturo',N'Particular',N'M',N'950000197',N'960000197',N'Premium',N'AB+',2,251),
	 (N'Ninguna',N'Ninguno',N'García Ramírez',N'Familiar',N'Av. Brasil 3200',N'La Molina',N'75011120',N'claudia.garcia198@yahoo.com',N'Ninguna',N'Activo',N'Activo','1999-03-02','2026-07-15 05:22:23.3366667',N'SIS',N'Claudia',N'SIS',N'F',N'950000198',N'960000198',N'Plan Integral',N'AB+',4,252);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Quispe García',N'Familiar',N'Av. Brasil 3200',N'Miraflores',N'75011121',N'antonio.quispe199@icloud.com',N'Ninguna',N'Activo',N'Activo','1990-12-11','2026-07-15 05:22:23.3433333',N'Particular',N'Antonio',N'Particular',N'M',N'950000199',N'960000199',N'Premium',N'AB+',2,253),
	 (N'Ninguna',N'Ninguno',N'Ramírez Flores',N'Familiar',N'Av. Brasil 3200',N'Lince',N'75011122',N'isabel.ramirez200@hotmail.com',N'Ninguna',N'Activo',N'Activo','1966-07-28','2026-07-15 05:22:23.3533333',N'EsSalud',N'Isabel',N'EsSalud',N'F',N'950000200',N'960000200',N'Regular',N'AB+',4,254),
	 (N'Ninguna',N'Ninguno',N'Salazar Quispe',N'Familiar',N'Av. Brasil 3200',N'Comas',N'75011123',N'luis.salazar201@yahoo.com',N'Ninguna',N'Activo',N'Activo','2005-08-17','2026-07-15 05:22:23.3600000',N'EsSalud',N'Luis',N'EsSalud',N'M',N'950000201',N'960000201',N'Regular',N'O-',3,255),
	 (N'Ninguna',N'Ninguno',N'León Salazar',N'Familiar',N'Av. Brasil 3200',N'Surco',N'75011124',N'carolina.leon202@hotmail.com',N'Ninguna',N'Activo',N'Activo','1979-04-26','2026-07-15 05:22:23.3666667',N'SIS',N'Carolina',N'SIS',N'F',N'950000202',N'960000202',N'Plan Integral',N'AB+',2,256),
	 (N'Ninguna',N'Ninguno',N'Salazar Salazar',N'Familiar',N'Av. Brasil 3200',N'Los Olivos',N'75011125',N'fernando.salazar203@gmail.com',N'Ninguna',N'Activo',N'Activo','1968-05-24','2026-07-15 05:22:23.3733333',N'EsSalud',N'Fernando',N'EsSalud',N'M',N'950000203',N'960000203',N'Regular',N'A+',4,257),
	 (N'Ninguna',N'Ninguno',N'Flores Torres',N'Familiar',N'Av. Brasil 3200',N'Surco',N'75011126',N'andrea.flores204@outlook.com',N'Ninguna',N'Activo',N'Activo','2006-03-01','2026-07-15 05:22:23.3833333',N'Particular',N'Andrea',N'Particular',N'F',N'950000204',N'960000204',N'Premium',N'B+',4,258),
	 (N'Ninguna',N'Ninguno',N'Vargas Díaz',N'Familiar',N'Av. Brasil 3200',N'Surco',N'75011127',N'jorge.vargas205@outlook.com',N'Ninguna',N'Activo',N'Activo','1982-07-24','2026-07-15 05:22:23.3900000',N'EsSalud',N'Jorge',N'EsSalud',N'M',N'950000205',N'960000205',N'Regular',N'O+',4,259),
	 (N'Ninguna',N'Ninguno',N'Ruiz Flores',N'Familiar',N'Av. Brasil 3200',N'Los Olivos',N'75011128',N'maria.ruiz206@gmail.com',N'Ninguna',N'Activo',N'Activo','2008-02-24','2026-07-15 05:22:23.4000000',N'SIS',N'María',N'SIS',N'F',N'950000206',N'960000206',N'Plan Integral',N'AB+',3,260),
	 (N'Ninguna',N'Ninguno',N'Ramírez Salazar',N'Familiar',N'Av. Brasil 3200',N'Surco',N'75011129',N'roberto.ramirez207@outlook.com',N'Ninguna',N'Activo',N'Activo','2007-03-09','2026-07-15 05:22:23.4066667',N'SIS',N'Roberto',N'SIS',N'M',N'950000207',N'960000207',N'Plan Integral',N'B+',4,261),
	 (N'Ninguna',N'Ninguno',N'Mendoza Torres',N'Familiar',N'Av. Brasil 3200',N'Lince',N'75011130',N'patricia.mendoza208@gmail.com',N'Ninguna',N'Activo',N'Activo','1987-10-14','2026-07-15 05:22:23.4100000',N'Particular',N'Patricia',N'Particular',N'F',N'950000208',N'960000208',N'Premium',N'A+',4,262);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Rojas Torres',N'Familiar',N'Av. Brasil 3200',N'San Borja',N'75011131',N'david.rojas209@outlook.com',N'Ninguna',N'Activo',N'Activo','2002-07-18','2026-07-15 05:22:23.4200000',N'SIS',N'David',N'SIS',N'M',N'950000209',N'960000209',N'Plan Integral',N'B+',2,263),
	 (N'Ninguna',N'Ninguno',N'Ramírez Flores',N'Familiar',N'Av. Colonial 4500',N'Ate',N'75011132',N'patricia.ramirez210@hotmail.com',N'Ninguna',N'Activo',N'Activo','1977-11-19','2026-07-15 05:23:06.6266667',N'Particular',N'Patricia',N'Particular',N'F',N'950000210',N'960000210',N'Premium',N'O+',2,264),
	 (N'Ninguna',N'Ninguno',N'Salazar Pérez',N'Familiar',N'Av. Colonial 4500',N'La Molina',N'75011133',N'fernando.salazar211@gmail.com',N'Ninguna',N'Activo',N'Activo','2010-08-01','2026-07-15 05:23:06.6366667',N'SIS',N'Fernando',N'SIS',N'M',N'950000211',N'960000211',N'Plan Integral',N'B+',1,265),
	 (N'Ninguna',N'Ninguno',N'Salazar Rojas',N'Familiar',N'Av. Colonial 4500',N'Comas',N'75011134',N'julia.salazar212@icloud.com',N'Ninguna',N'Activo',N'Activo','1980-04-04','2026-07-15 05:23:06.6466667',N'SIS',N'Julia',N'SIS',N'F',N'950000212',N'960000212',N'Plan Integral',N'O-',4,266),
	 (N'Ninguna',N'Ninguno',N'Campos León',N'Familiar',N'Av. Colonial 4500',N'San Borja',N'75011135',N'fernando.campos213@outlook.com',N'Ninguna',N'Activo',N'Activo','1984-06-03','2026-07-15 05:23:06.6566667',N'Particular',N'Fernando',N'Particular',N'M',N'950000213',N'960000213',N'Premium',N'A+',3,267),
	 (N'Ninguna',N'Ninguno',N'Torres Vargas',N'Familiar',N'Av. Colonial 4500',N'Miraflores',N'75011136',N'lucia.torres214@outlook.com',N'Ninguna',N'Activo',N'Activo','1993-08-31','2026-07-15 05:23:06.6633333',N'EsSalud',N'Lucía',N'EsSalud',N'F',N'950000214',N'960000214',N'Regular',N'O-',3,268),
	 (N'Ninguna',N'Ninguno',N'García Campos',N'Familiar',N'Av. Colonial 4500',N'San Isidro',N'75011137',N'luis.garcia215@gmail.com',N'Ninguna',N'Activo',N'Activo','2005-11-09','2026-07-15 05:23:06.6700000',N'SIS',N'Luis',N'SIS',N'M',N'950000215',N'960000215',N'Plan Integral',N'AB+',2,269),
	 (N'Ninguna',N'Ninguno',N'Mendoza Torres',N'Familiar',N'Av. Colonial 4500',N'San Miguel',N'75011138',N'lucia.mendoza216@hotmail.com',N'Ninguna',N'Activo',N'Activo','1983-11-14','2026-07-15 05:23:06.6766667',N'Particular',N'Lucía',N'Particular',N'F',N'950000216',N'960000216',N'Premium',N'O-',1,270),
	 (N'Ninguna',N'Ninguno',N'Vargas Ramírez',N'Familiar',N'Av. Colonial 4500',N'San Isidro',N'75011139',N'diego.vargas217@gmail.com',N'Ninguna',N'Activo',N'Activo','2007-04-26','2026-07-15 05:23:06.6800000',N'SIS',N'Diego',N'SIS',N'M',N'950000217',N'960000217',N'Plan Integral',N'AB+',2,271),
	 (N'Ninguna',N'Ninguno',N'Flores León',N'Familiar',N'Av. Colonial 4500',N'San Borja',N'75011140',N'claudia.flores218@icloud.com',N'Ninguna',N'Activo',N'Activo','1970-05-26','2026-07-15 05:23:06.6866667',N'EsSalud',N'Claudia',N'EsSalud',N'F',N'950000218',N'960000218',N'Regular',N'B+',3,272);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Mendoza Díaz',N'Familiar',N'Av. Colonial 4500',N'Lince',N'75011141',N'luis.mendoza219@icloud.com',N'Ninguna',N'Activo',N'Activo','1965-06-25','2026-07-15 05:23:06.6933333',N'SIS',N'Luis',N'SIS',N'M',N'950000219',N'960000219',N'Plan Integral',N'A+',3,273),
	 (N'Ninguna',N'Ninguno',N'Quispe Campos',N'Familiar',N'Av. Colonial 4500',N'La Molina',N'75011142',N'teresa.quispe220@icloud.com',N'Ninguna',N'Activo',N'Activo','2003-07-17','2026-07-15 05:23:06.6966667',N'SIS',N'Teresa',N'SIS',N'F',N'950000220',N'960000220',N'Plan Integral',N'O+',4,274),
	 (N'Ninguna',N'Ninguno',N'Flores Castillo',N'Familiar',N'Av. Colonial 4500',N'San Isidro',N'75011143',N'diego.flores221@icloud.com',N'Ninguna',N'Activo',N'Activo','1972-01-31','2026-07-15 05:23:06.7066667',N'Particular',N'Diego',N'Particular',N'M',N'950000221',N'960000221',N'Premium',N'O+',1,275),
	 (N'Ninguna',N'Ninguno',N'Romero Ruiz',N'Familiar',N'Av. Colonial 4500',N'San Miguel',N'75011144',N'lucia.romero222@gmail.com',N'Ninguna',N'Activo',N'Activo','1969-07-24','2026-07-15 05:23:06.7100000',N'Particular',N'Lucía',N'Particular',N'F',N'950000222',N'960000222',N'Premium',N'AB+',1,276),
	 (N'Ninguna',N'Ninguno',N'Torres Flores',N'Familiar',N'Av. Colonial 4500',N'Lince',N'75011145',N'jorge.torres223@outlook.com',N'Ninguna',N'Activo',N'Activo','2010-11-26','2026-07-15 05:23:06.7166667',N'EsSalud',N'Jorge',N'EsSalud',N'M',N'950000223',N'960000223',N'Regular',N'A+',4,277),
	 (N'Ninguna',N'Ninguno',N'Torres Torres',N'Familiar',N'Av. Colonial 4500',N'San Miguel',N'75011146',N'andrea.torres224@gmail.com',N'Ninguna',N'Activo',N'Activo','1970-10-06','2026-07-15 05:23:06.7233333',N'EsSalud',N'Andrea',N'EsSalud',N'F',N'950000224',N'960000224',N'Regular',N'A+',1,278),
	 (N'Ninguna',N'Ninguno',N'Salazar Romero',N'Familiar',N'Av. Colonial 4500',N'San Miguel',N'75011147',N'luis.salazar225@outlook.com',N'Ninguna',N'Activo',N'Activo','1973-07-13','2026-07-15 05:23:06.7266667',N'EsSalud',N'Luis',N'EsSalud',N'M',N'950000225',N'960000225',N'Regular',N'A+',2,279),
	 (N'Ninguna',N'Ninguno',N'Torres Vargas',N'Familiar',N'Av. Colonial 4500',N'San Miguel',N'75011148',N'patricia.torres226@icloud.com',N'Ninguna',N'Activo',N'Activo','1974-10-31','2026-07-15 05:23:06.7333333',N'Particular',N'Patricia',N'Particular',N'F',N'950000226',N'960000226',N'Premium',N'B+',4,280),
	 (N'Ninguna',N'Ninguno',N'Castillo Flores',N'Familiar',N'Av. Colonial 4500',N'Ate',N'75011149',N'arturo.castillo227@gmail.com',N'Ninguna',N'Activo',N'Activo','1985-11-19','2026-07-15 05:23:06.7433333',N'SIS',N'Arturo',N'SIS',N'M',N'950000227',N'960000227',N'Plan Integral',N'AB+',2,281),
	 (N'Ninguna',N'Ninguno',N'Ramírez Quispe',N'Familiar',N'Av. Colonial 4500',N'Ate',N'75011150',N'andrea.ramirez228@gmail.com',N'Ninguna',N'Activo',N'Activo','2002-04-03','2026-07-15 05:23:06.7600000',N'Particular',N'Andrea',N'Particular',N'F',N'950000228',N'960000228',N'Premium',N'A+',3,282);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Castillo Ramírez',N'Familiar',N'Av. Colonial 4500',N'Miraflores',N'75011151',N'diego.castillo229@icloud.com',N'Ninguna',N'Activo',N'Activo','1974-04-26','2026-07-15 05:23:06.7700000',N'EsSalud',N'Diego',N'EsSalud',N'M',N'950000229',N'960000229',N'Regular',N'B+',3,283),
	 (N'Ninguna',N'Ninguno',N'Rojas Ramírez',N'Familiar',N'Av. Colonial 4500',N'Ate',N'75011152',N'claudia.rojas230@gmail.com',N'Ninguna',N'Activo',N'Activo','1977-11-29','2026-07-15 05:23:06.7766667',N'EsSalud',N'Claudia',N'EsSalud',N'F',N'950000230',N'960000230',N'Regular',N'A+',4,284),
	 (N'Ninguna',N'Ninguno',N'Vargas García',N'Familiar',N'Av. Colonial 4500',N'San Isidro',N'75011153',N'roberto.vargas231@hotmail.com',N'Ninguna',N'Activo',N'Activo','1970-06-24','2026-07-15 05:23:06.7866667',N'Particular',N'Roberto',N'Particular',N'M',N'950000231',N'960000231',N'Premium',N'B+',1,285),
	 (N'Ninguna',N'Ninguno',N'Torres Romero',N'Familiar',N'Av. Colonial 4500',N'Surco',N'75011154',N'patricia.torres232@outlook.com',N'Ninguna',N'Activo',N'Activo','1995-01-18','2026-07-15 05:23:06.7933333',N'SIS',N'Patricia',N'SIS',N'F',N'950000232',N'960000232',N'Plan Integral',N'AB+',1,286),
	 (N'Ninguna',N'Ninguno',N'Salazar García',N'Familiar',N'Av. Colonial 4500',N'San Miguel',N'75011155',N'roberto.salazar233@yahoo.com',N'Ninguna',N'Activo',N'Activo','2006-04-26','2026-07-15 05:23:06.8000000',N'Particular',N'Roberto',N'Particular',N'M',N'950000233',N'960000233',N'Premium',N'B+',4,287),
	 (N'Ninguna',N'Ninguno',N'Salazar Quispe',N'Familiar',N'Av. Colonial 4500',N'San Borja',N'75011156',N'sandra.salazar234@yahoo.com',N'Ninguna',N'Activo',N'Activo','1961-03-24','2026-07-15 05:23:06.8100000',N'EsSalud',N'Sandra',N'EsSalud',N'F',N'950000234',N'960000234',N'Regular',N'A+',2,288),
	 (N'Ninguna',N'Ninguno',N'Campos Mendoza',N'Familiar',N'Av. Colonial 4500',N'Comas',N'75011157',N'sergio.campos235@yahoo.com',N'Ninguna',N'Activo',N'Activo','2002-01-22','2026-07-15 05:23:06.8200000',N'SIS',N'Sergio',N'SIS',N'M',N'950000235',N'960000235',N'Plan Integral',N'A+',3,289),
	 (N'Ninguna',N'Ninguno',N'Pérez Torres',N'Familiar',N'Av. Colonial 4500',N'San Borja',N'75011158',N'carolina.perez236@hotmail.com',N'Ninguna',N'Activo',N'Activo','1996-10-10','2026-07-15 05:23:06.8266667',N'Particular',N'Carolina',N'Particular',N'F',N'950000236',N'960000236',N'Premium',N'O+',4,290),
	 (N'Ninguna',N'Ninguno',N'Torres Flores',N'Familiar',N'Av. Colonial 4500',N'Los Olivos',N'75011159',N'diego.torres237@outlook.com',N'Ninguna',N'Activo',N'Activo','1986-05-09','2026-07-15 05:23:06.8366667',N'Particular',N'Diego',N'Particular',N'M',N'950000237',N'960000237',N'Premium',N'O+',2,291),
	 (N'Ninguna',N'Ninguno',N'Torres Salazar',N'Familiar',N'Av. Colonial 4500',N'Los Olivos',N'75011160',N'paola.torres238@hotmail.com',N'Ninguna',N'Activo',N'Activo','1985-01-28','2026-07-15 05:23:06.8433333',N'EsSalud',N'Paola',N'EsSalud',N'F',N'950000238',N'960000238',N'Regular',N'O-',1,292);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Ruiz Ruiz',N'Familiar',N'Av. Colonial 4500',N'Comas',N'75011161',N'pedro.ruiz239@hotmail.com',N'Ninguna',N'Activo',N'Activo','1967-04-24','2026-07-15 05:23:06.8533333',N'SIS',N'Pedro',N'SIS',N'M',N'950000239',N'960000239',N'Plan Integral',N'B+',2,293),
	 (N'Ninguna',N'Ninguno',N'Castillo Mendoza',N'Familiar',N'Av. Faucett 5100',N'San Isidro',N'75011162',N'isabel.castillo240@gmail.com',N'Ninguna',N'Activo',N'Activo','2010-08-23','2026-07-15 05:24:25.7300000',N'Particular',N'Isabel',N'Particular',N'F',N'950000240',N'960000240',N'Premium',N'B+',4,294),
	 (N'Ninguna',N'Ninguno',N'Ramírez Quispe',N'Familiar',N'Av. Faucett 5100',N'San Borja',N'75011163',N'luis.ramirez241@gmail.com',N'Ninguna',N'Activo',N'Activo','2006-06-05','2026-07-15 05:24:25.7400000',N'Particular',N'Luis',N'Particular',N'M',N'950000241',N'960000241',N'Premium',N'O-',4,295),
	 (N'Ninguna',N'Ninguno',N'García Romero',N'Familiar',N'Av. Faucett 5100',N'Los Olivos',N'75011164',N'lucia.garcia242@yahoo.com',N'Ninguna',N'Activo',N'Activo','1992-10-04','2026-07-15 05:24:25.7500000',N'EsSalud',N'Lucía',N'EsSalud',N'F',N'950000242',N'960000242',N'Regular',N'A+',2,296),
	 (N'Ninguna',N'Ninguno',N'Torres Mendoza',N'Familiar',N'Av. Faucett 5100',N'San Borja',N'75011165',N'antonio.torres243@hotmail.com',N'Ninguna',N'Activo',N'Activo','1984-02-07','2026-07-15 05:24:25.7566667',N'SIS',N'Antonio',N'SIS',N'M',N'950000243',N'960000243',N'Plan Integral',N'B+',3,297),
	 (N'Ninguna',N'Ninguno',N'Flores Ruiz',N'Familiar',N'Av. Faucett 5100',N'San Borja',N'75011166',N'maria.flores244@gmail.com',N'Ninguna',N'Activo',N'Activo','2005-04-16','2026-07-15 05:24:25.7666667',N'Particular',N'María',N'Particular',N'F',N'950000244',N'960000244',N'Premium',N'AB+',2,298),
	 (N'Ninguna',N'Ninguno',N'Vargas Campos',N'Familiar',N'Av. Faucett 5100',N'San Borja',N'75011167',N'luis.vargas245@icloud.com',N'Ninguna',N'Activo',N'Activo','1965-03-21','2026-07-15 05:24:25.7733333',N'Particular',N'Luis',N'Particular',N'M',N'950000245',N'960000245',N'Premium',N'O+',4,299),
	 (N'Ninguna',N'Ninguno',N'Flores Romero',N'Familiar',N'Av. Faucett 5100',N'Lince',N'75011168',N'sandra.flores246@gmail.com',N'Ninguna',N'Activo',N'Activo','1999-01-04','2026-07-15 05:24:25.7800000',N'Particular',N'Sandra',N'Particular',N'F',N'950000246',N'960000246',N'Premium',N'O-',1,300),
	 (N'Ninguna',N'Ninguno',N'Ruiz García',N'Familiar',N'Av. Faucett 5100',N'La Molina',N'75011169',N'roberto.ruiz247@gmail.com',N'Ninguna',N'Activo',N'Activo','2008-03-29','2026-07-15 05:24:25.7866667',N'EsSalud',N'Roberto',N'EsSalud',N'M',N'950000247',N'960000247',N'Regular',N'A+',1,301),
	 (N'Ninguna',N'Ninguno',N'Mendoza Quispe',N'Familiar',N'Av. Faucett 5100',N'San Isidro',N'75011170',N'patricia.mendoza248@hotmail.com',N'Ninguna',N'Activo',N'Activo','1983-10-19','2026-07-15 05:24:25.7933333',N'Particular',N'Patricia',N'Particular',N'F',N'950000248',N'960000248',N'Premium',N'O+',2,302);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Torres Ramírez',N'Familiar',N'Av. Faucett 5100',N'Miraflores',N'75011171',N'pedro.torres249@yahoo.com',N'Ninguna',N'Activo',N'Activo','2001-12-01','2026-07-15 05:24:25.8000000',N'EsSalud',N'Pedro',N'EsSalud',N'M',N'950000249',N'960000249',N'Regular',N'O+',4,303),
	 (N'Ninguna',N'Ninguno',N'Rojas Díaz',N'Familiar',N'Av. Faucett 5100',N'San Miguel',N'75011172',N'claudia.rojas250@yahoo.com',N'Ninguna',N'Activo',N'Activo','1975-05-11','2026-07-15 05:24:25.8066667',N'Particular',N'Claudia',N'Particular',N'F',N'950000250',N'960000250',N'Premium',N'O-',4,304),
	 (N'Ninguna',N'Ninguno',N'Díaz Quispe',N'Familiar',N'Av. Faucett 5100',N'San Miguel',N'75011173',N'eduardo.diaz251@icloud.com',N'Ninguna',N'Activo',N'Activo','1981-06-30','2026-07-15 05:24:25.8100000',N'SIS',N'Eduardo',N'SIS',N'M',N'950000251',N'960000251',N'Plan Integral',N'O+',1,305),
	 (N'Ninguna',N'Ninguno',N'Pérez Campos',N'Familiar',N'Av. Faucett 5100',N'San Borja',N'75011174',N'carolina.perez252@hotmail.com',N'Ninguna',N'Activo',N'Activo','1978-07-19','2026-07-15 05:24:25.8166667',N'SIS',N'Carolina',N'SIS',N'F',N'950000252',N'960000252',N'Plan Integral',N'O-',1,306),
	 (N'Ninguna',N'Ninguno',N'Díaz Romero',N'Familiar',N'Av. Faucett 5100',N'Surco',N'75011175',N'jorge.diaz253@yahoo.com',N'Ninguna',N'Activo',N'Activo','2004-10-12','2026-07-15 05:24:25.8200000',N'Particular',N'Jorge',N'Particular',N'M',N'950000253',N'960000253',N'Premium',N'O+',1,307),
	 (N'Ninguna',N'Ninguno',N'Pérez Díaz',N'Familiar',N'Av. Faucett 5100',N'San Isidro',N'75011176',N'paola.perez254@hotmail.com',N'Ninguna',N'Activo',N'Activo','2008-12-09','2026-07-15 05:24:25.8266667',N'Particular',N'Paola',N'Particular',N'F',N'950000254',N'960000254',N'Premium',N'B+',1,308),
	 (N'Ninguna',N'Ninguno',N'Díaz Mendoza',N'Familiar',N'Av. Faucett 5100',N'San Isidro',N'75011177',N'carlos.diaz255@gmail.com',N'Ninguna',N'Activo',N'Activo','1988-07-20','2026-07-15 05:24:25.8333333',N'SIS',N'Carlos',N'SIS',N'M',N'950000255',N'960000255',N'Plan Integral',N'B+',3,309),
	 (N'Ninguna',N'Ninguno',N'Castillo Salazar',N'Familiar',N'Av. Faucett 5100',N'La Molina',N'75011178',N'isabel.castillo256@gmail.com',N'Ninguna',N'Activo',N'Activo','1970-08-06','2026-07-15 05:24:25.8400000',N'SIS',N'Isabel',N'SIS',N'F',N'950000256',N'960000256',N'Plan Integral',N'A+',4,310),
	 (N'Ninguna',N'Ninguno',N'Castillo Romero',N'Familiar',N'Av. Faucett 5100',N'Ate',N'75011179',N'javier.castillo257@gmail.com',N'Ninguna',N'Activo',N'Activo','1966-04-28','2026-07-15 05:24:25.8433333',N'SIS',N'Javier',N'SIS',N'M',N'950000257',N'960000257',N'Plan Integral',N'O-',2,311),
	 (N'Ninguna',N'Ninguno',N'Ruiz Ramírez',N'Familiar',N'Av. Faucett 5100',N'Lince',N'75011180',N'maria.ruiz258@yahoo.com',N'Ninguna',N'Activo',N'Activo','1988-01-11','2026-07-15 05:24:25.8500000',N'Particular',N'María',N'Particular',N'F',N'950000258',N'960000258',N'Premium',N'O+',2,312);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Rojas Mendoza',N'Familiar',N'Av. Faucett 5100',N'San Isidro',N'75011181',N'jorge.rojas259@outlook.com',N'Ninguna',N'Activo',N'Activo','1964-12-08','2026-07-15 05:24:25.8533333',N'SIS',N'Jorge',N'SIS',N'M',N'950000259',N'960000259',N'Plan Integral',N'B+',2,313),
	 (N'Ninguna',N'Ninguno',N'Pérez Quispe',N'Familiar',N'Av. Faucett 5100',N'Surco',N'75011182',N'maria.perez260@yahoo.com',N'Ninguna',N'Activo',N'Activo','2009-10-14','2026-07-15 05:24:25.8600000',N'SIS',N'María',N'SIS',N'F',N'950000260',N'960000260',N'Plan Integral',N'B+',2,314),
	 (N'Ninguna',N'Ninguno',N'García García',N'Familiar',N'Av. Faucett 5100',N'Ate',N'75011183',N'luis.garcia261@gmail.com',N'Ninguna',N'Activo',N'Activo','1984-07-30','2026-07-15 05:24:25.8666667',N'SIS',N'Luis',N'SIS',N'M',N'950000261',N'960000261',N'Plan Integral',N'AB+',4,315),
	 (N'Ninguna',N'Ninguno',N'Díaz Díaz',N'Familiar',N'Av. Faucett 5100',N'Lince',N'75011184',N'sandra.diaz262@gmail.com',N'Ninguna',N'Activo',N'Activo','2006-08-06','2026-07-15 05:24:25.8733333',N'SIS',N'Sandra',N'SIS',N'F',N'950000262',N'960000262',N'Plan Integral',N'A+',3,316),
	 (N'Ninguna',N'Ninguno',N'Vargas Ramírez',N'Familiar',N'Av. Faucett 5100',N'Lince',N'75011185',N'arturo.vargas263@icloud.com',N'Ninguna',N'Activo',N'Activo','1961-04-23','2026-07-15 05:24:25.8800000',N'Particular',N'Arturo',N'Particular',N'M',N'950000263',N'960000263',N'Premium',N'A+',3,317),
	 (N'Ninguna',N'Ninguno',N'Romero Ramírez',N'Familiar',N'Av. Faucett 5100',N'Los Olivos',N'75011186',N'julia.romero264@icloud.com',N'Ninguna',N'Activo',N'Activo','1964-01-17','2026-07-15 05:24:25.8866667',N'Particular',N'Julia',N'Particular',N'F',N'950000264',N'960000264',N'Premium',N'O-',2,318),
	 (N'Ninguna',N'Ninguno',N'Vargas Romero',N'Familiar',N'Av. Faucett 5100',N'San Miguel',N'75011187',N'javier.vargas265@icloud.com',N'Ninguna',N'Activo',N'Activo','2001-02-22','2026-07-15 05:24:25.8900000',N'Particular',N'Javier',N'Particular',N'M',N'950000265',N'960000265',N'Premium',N'O-',4,319),
	 (N'Ninguna',N'Ninguno',N'García Ruiz',N'Familiar',N'Av. Faucett 5100',N'Surco',N'75011188',N'claudia.garcia266@outlook.com',N'Ninguna',N'Activo',N'Activo','1979-08-21','2026-07-15 05:24:25.8966667',N'Particular',N'Claudia',N'Particular',N'F',N'950000266',N'960000266',N'Premium',N'A+',1,320),
	 (N'Ninguna',N'Ninguno',N'Castillo Ramírez',N'Familiar',N'Av. Faucett 5100',N'Ate',N'75011189',N'javier.castillo267@yahoo.com',N'Ninguna',N'Activo',N'Activo','1971-08-06','2026-07-15 05:24:25.9000000',N'Particular',N'Javier',N'Particular',N'M',N'950000267',N'960000267',N'Premium',N'O+',4,321),
	 (N'Ninguna',N'Ninguno',N'Torres García',N'Familiar',N'Av. Faucett 5100',N'Ate',N'75011190',N'teresa.torres268@yahoo.com',N'Ninguna',N'Activo',N'Activo','1964-05-25','2026-07-15 05:24:25.9066667',N'EsSalud',N'Teresa',N'EsSalud',N'F',N'950000268',N'960000268',N'Regular',N'AB+',1,322);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Salazar Campos',N'Familiar',N'Av. Faucett 5100',N'San Isidro',N'75011191',N'miguel.salazar269@yahoo.com',N'Ninguna',N'Activo',N'Activo','2014-09-16','2026-07-15 05:24:25.9100000',N'SIS',N'Miguel',N'SIS',N'M',N'950000269',N'960000269',N'Plan Integral',N'B+',2,323),
	 (N'Ninguna',N'Ninguno',N'Mendoza Vargas',N'Familiar',N'Av. Benavides 6200',N'Comas',N'75011192',N'julia.mendoza270@hotmail.com',N'Ninguna',N'Activo',N'Activo','1995-12-27','2026-07-15 05:25:31.0700000',N'SIS',N'Julia',N'SIS',N'F',N'950000270',N'960000270',N'Plan Integral',N'O-',3,324),
	 (N'Ninguna',N'Ninguno',N'Torres Rojas',N'Familiar',N'Av. Benavides 6200',N'San Isidro',N'75011193',N'arturo.torres271@hotmail.com',N'Ninguna',N'Activo',N'Activo','2002-01-08','2026-07-15 05:25:31.0800000',N'EsSalud',N'Arturo',N'EsSalud',N'M',N'950000271',N'960000271',N'Regular',N'A+',3,325),
	 (N'Ninguna',N'Ninguno',N'Ruiz Castillo',N'Familiar',N'Av. Benavides 6200',N'San Miguel',N'75011194',N'patricia.ruiz272@yahoo.com',N'Ninguna',N'Activo',N'Activo','1982-07-07','2026-07-15 05:25:31.0866667',N'EsSalud',N'Patricia',N'EsSalud',N'F',N'950000272',N'960000272',N'Regular',N'AB+',2,326),
	 (N'Ninguna',N'Ninguno',N'Romero Ruiz',N'Familiar',N'Av. Benavides 6200',N'Ate',N'75011195',N'fernando.romero273@icloud.com',N'Ninguna',N'Activo',N'Activo','2003-10-04','2026-07-15 05:25:31.1000000',N'EsSalud',N'Fernando',N'EsSalud',N'M',N'950000273',N'960000273',N'Regular',N'AB+',2,327),
	 (N'Ninguna',N'Ninguno',N'Castillo Díaz',N'Familiar',N'Av. Benavides 6200',N'Los Olivos',N'75011196',N'lucia.castillo274@gmail.com',N'Ninguna',N'Activo',N'Activo','2002-07-01','2026-07-15 05:25:31.1100000',N'Particular',N'Lucía',N'Particular',N'F',N'950000274',N'960000274',N'Premium',N'A+',2,328),
	 (N'Ninguna',N'Ninguno',N'Ruiz Vargas',N'Familiar',N'Av. Benavides 6200',N'San Isidro',N'75011197',N'roberto.ruiz275@outlook.com',N'Ninguna',N'Activo',N'Activo','1983-10-01','2026-07-15 05:25:31.1166667',N'Particular',N'Roberto',N'Particular',N'M',N'950000275',N'960000275',N'Premium',N'O+',1,329),
	 (N'Ninguna',N'Ninguno',N'Ruiz Castillo',N'Familiar',N'Av. Benavides 6200',N'San Borja',N'75011198',N'elena.ruiz276@yahoo.com',N'Ninguna',N'Activo',N'Activo','2005-02-13','2026-07-15 05:25:31.1266667',N'EsSalud',N'Elena',N'EsSalud',N'F',N'950000276',N'960000276',N'Regular',N'O-',2,330),
	 (N'Ninguna',N'Ninguno',N'Torres Ruiz',N'Familiar',N'Av. Benavides 6200',N'San Isidro',N'75011199',N'carlos.torres277@gmail.com',N'Ninguna',N'Activo',N'Activo','1974-05-02','2026-07-15 05:25:31.1300000',N'Particular',N'Carlos',N'Particular',N'M',N'950000277',N'960000277',N'Premium',N'B+',3,331),
	 (N'Ninguna',N'Ninguno',N'Díaz Romero',N'Familiar',N'Av. Benavides 6200',N'La Molina',N'75011200',N'natalia.diaz278@hotmail.com',N'Ninguna',N'Activo',N'Activo','1973-03-25','2026-07-15 05:25:31.1366667',N'Particular',N'Natalia',N'Particular',N'F',N'950000278',N'960000278',N'Premium',N'B+',3,332);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Mendoza Romero',N'Familiar',N'Av. Benavides 6200',N'San Miguel',N'75011201',N'jorge.mendoza279@outlook.com',N'Ninguna',N'Activo',N'Activo','1966-06-26','2026-07-15 05:25:31.1466667',N'EsSalud',N'Jorge',N'EsSalud',N'M',N'950000279',N'960000279',N'Regular',N'O-',4,333),
	 (N'Ninguna',N'Ninguno',N'Díaz Flores',N'Familiar',N'Av. Benavides 6200',N'Ate',N'75011202',N'patricia.diaz280@gmail.com',N'Ninguna',N'Activo',N'Activo','2015-02-09','2026-07-15 05:25:31.1500000',N'Particular',N'Patricia',N'Particular',N'F',N'950000280',N'960000280',N'Premium',N'B+',3,334),
	 (N'Ninguna',N'Ninguno',N'García Quispe',N'Familiar',N'Av. Benavides 6200',N'Miraflores',N'75011203',N'javier.garcia281@outlook.com',N'Ninguna',N'Activo',N'Activo','1968-08-05','2026-07-15 05:25:31.1566667',N'SIS',N'Javier',N'SIS',N'M',N'950000281',N'960000281',N'Plan Integral',N'O+',4,335),
	 (N'Ninguna',N'Ninguno',N'Castillo Díaz',N'Familiar',N'Av. Benavides 6200',N'Comas',N'75011204',N'sandra.castillo282@yahoo.com',N'Ninguna',N'Activo',N'Activo','1995-05-18','2026-07-15 05:25:31.1633333',N'EsSalud',N'Sandra',N'EsSalud',N'F',N'950000282',N'960000282',N'Regular',N'AB+',2,336),
	 (N'Ninguna',N'Ninguno',N'Castillo Campos',N'Familiar',N'Av. Benavides 6200',N'La Molina',N'75011205',N'arturo.castillo283@icloud.com',N'Ninguna',N'Activo',N'Activo','1986-11-23','2026-07-15 05:25:31.1700000',N'EsSalud',N'Arturo',N'EsSalud',N'M',N'950000283',N'960000283',N'Regular',N'O-',1,337),
	 (N'Ninguna',N'Ninguno',N'Castillo Rojas',N'Familiar',N'Av. Benavides 6200',N'Ate',N'75011206',N'isabel.castillo284@gmail.com',N'Ninguna',N'Activo',N'Activo','2011-06-21','2026-07-15 05:25:31.1733333',N'EsSalud',N'Isabel',N'EsSalud',N'F',N'950000284',N'960000284',N'Regular',N'B+',2,338),
	 (N'Ninguna',N'Ninguno',N'Vargas Romero',N'Familiar',N'Av. Benavides 6200',N'Lince',N'75011207',N'arturo.vargas285@yahoo.com',N'Ninguna',N'Activo',N'Activo','1969-10-02','2026-07-15 05:25:31.1766667',N'EsSalud',N'Arturo',N'EsSalud',N'M',N'950000285',N'960000285',N'Regular',N'A+',1,339),
	 (N'Ninguna',N'Ninguno',N'León Mendoza',N'Familiar',N'Av. Benavides 6200',N'Surco',N'75011208',N'patricia.leon286@icloud.com',N'Ninguna',N'Activo',N'Activo','1958-08-24','2026-07-15 05:25:31.1833333',N'EsSalud',N'Patricia',N'EsSalud',N'F',N'950000286',N'960000286',N'Regular',N'AB+',4,340),
	 (N'Ninguna',N'Ninguno',N'Flores Vargas',N'Familiar',N'Av. Benavides 6200',N'San Borja',N'75011209',N'carlos.flores287@gmail.com',N'Ninguna',N'Activo',N'Activo','1971-11-01','2026-07-15 05:25:31.1900000',N'SIS',N'Carlos',N'SIS',N'M',N'950000287',N'960000287',N'Plan Integral',N'O+',2,341),
	 (N'Ninguna',N'Ninguno',N'Díaz Vargas',N'Familiar',N'Av. Benavides 6200',N'Comas',N'75011210',N'patricia.diaz288@yahoo.com',N'Ninguna',N'Activo',N'Activo','2001-05-12','2026-07-15 05:25:31.1966667',N'SIS',N'Patricia',N'SIS',N'F',N'950000288',N'960000288',N'Plan Integral',N'A+',2,342);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Romero Ramírez',N'Familiar',N'Av. Benavides 6200',N'Los Olivos',N'75011211',N'pedro.romero289@icloud.com',N'Ninguna',N'Activo',N'Activo','1970-09-06','2026-07-15 05:25:31.2066667',N'SIS',N'Pedro',N'SIS',N'M',N'950000289',N'960000289',N'Plan Integral',N'O-',4,343),
	 (N'Ninguna',N'Ninguno',N'Quispe Campos',N'Familiar',N'Av. Benavides 6200',N'Comas',N'75011212',N'isabel.quispe290@yahoo.com',N'Ninguna',N'Activo',N'Activo','1980-03-12','2026-07-15 05:25:31.2133333',N'SIS',N'Isabel',N'SIS',N'F',N'950000290',N'960000290',N'Plan Integral',N'B+',4,344),
	 (N'Ninguna',N'Ninguno',N'Flores León',N'Familiar',N'Av. Benavides 6200',N'San Miguel',N'75011213',N'david.flores291@icloud.com',N'Ninguna',N'Activo',N'Activo','1962-12-28','2026-07-15 05:25:31.2166667',N'EsSalud',N'David',N'EsSalud',N'M',N'950000291',N'960000291',N'Regular',N'O-',2,345),
	 (N'Ninguna',N'Ninguno',N'Campos Flores',N'Familiar',N'Av. Benavides 6200',N'Comas',N'75011214',N'carmen.campos292@gmail.com',N'Ninguna',N'Activo',N'Activo','1998-02-11','2026-07-15 05:25:31.2233333',N'EsSalud',N'Carmen',N'EsSalud',N'F',N'950000292',N'960000292',N'Regular',N'AB+',4,346),
	 (N'Ninguna',N'Ninguno',N'Díaz Díaz',N'Familiar',N'Av. Benavides 6200',N'San Miguel',N'75011215',N'arturo.diaz293@hotmail.com',N'Ninguna',N'Activo',N'Activo','2010-06-11','2026-07-15 05:25:31.2300000',N'SIS',N'Arturo',N'SIS',N'M',N'950000293',N'960000293',N'Plan Integral',N'AB+',4,347),
	 (N'Ninguna',N'Ninguno',N'Pérez Rojas',N'Familiar',N'Av. Benavides 6200',N'Ate',N'75011216',N'elena.perez294@icloud.com',N'Ninguna',N'Activo',N'Activo','1973-09-22','2026-07-15 05:25:31.2366667',N'Particular',N'Elena',N'Particular',N'F',N'950000294',N'960000294',N'Premium',N'A+',3,348),
	 (N'Ninguna',N'Ninguno',N'Mendoza Salazar',N'Familiar',N'Av. Benavides 6200',N'Comas',N'75011217',N'arturo.mendoza295@hotmail.com',N'Ninguna',N'Activo',N'Activo','2006-02-04','2026-07-15 05:25:31.2433333',N'EsSalud',N'Arturo',N'EsSalud',N'M',N'950000295',N'960000295',N'Regular',N'O+',3,349),
	 (N'Ninguna',N'Ninguno',N'Díaz Quispe',N'Familiar',N'Av. Benavides 6200',N'San Isidro',N'75011218',N'ana.diaz296@hotmail.com',N'Ninguna',N'Activo',N'Activo','1968-04-10','2026-07-15 05:25:31.2500000',N'SIS',N'Ana',N'SIS',N'F',N'950000296',N'960000296',N'Plan Integral',N'O-',3,350),
	 (N'Ninguna',N'Ninguno',N'García Torres',N'Familiar',N'Av. Benavides 6200',N'Los Olivos',N'75011219',N'eduardo.garcia297@outlook.com',N'Ninguna',N'Activo',N'Activo','1971-02-10','2026-07-15 05:25:31.2566667',N'EsSalud',N'Eduardo',N'EsSalud',N'M',N'950000297',N'960000297',N'Regular',N'A+',1,351),
	 (N'Ninguna',N'Ninguno',N'Quispe Quispe',N'Familiar',N'Av. Benavides 6200',N'San Isidro',N'75011220',N'sandra.quispe298@gmail.com',N'Ninguna',N'Activo',N'Activo','1989-11-25','2026-07-15 05:25:31.2633333',N'EsSalud',N'Sandra',N'EsSalud',N'F',N'950000298',N'960000298',N'Regular',N'B+',3,352);
INSERT INTO bd_clinica.dbo.pacientes (alergias,antecedente,apellidos,contacto_emergencia,direccion,distrito,dni,email,enfermedades_cronicas,estado,estado_seguro,fecha_nacimiento,fecha_sincronizacion_seguro,nombre_iafas,nombres,seguro,sexo,telefono,telefono_emergencia,tipo_plan,tipo_sangre,id_sede,id_usuario) VALUES
	 (N'Ninguna',N'Ninguno',N'Mendoza Ramírez',N'Familiar',N'Av. Benavides 6200',N'La Molina',N'75011221',N'sergio.mendoza299@yahoo.com',N'Ninguna',N'Activo',N'Activo','1986-06-20','2026-07-15 05:25:31.2700000',N'SIS',N'Sergio',N'SIS',N'M',N'950000299',N'960000299',N'Plan Integral',N'A+',1,353),
	 (NULL,NULL,N'YARA LARA',NULL,N'',N'',N'40713054',NULL,NULL,N'Activo',N'ACTIVO',NULL,'2026-07-16 14:57:41.6887365',N'ESSALUD / SIS (Acreditado)',N'LUIS ENRIQUE',NULL,NULL,N'999999999',NULL,N'PEAS - Plan Esencial de Aseguramiento',NULL,NULL,354),
	 (NULL,NULL,N'LIZANA YAURI',NULL,N'',N'',N'40723654',NULL,NULL,N'Activo',N'ACTIVO',NULL,'2026-07-17 00:48:26.4405044',N'ESSALUD / SIS (Acreditado)',N'ALFREDO',NULL,NULL,N'999999999',NULL,N'PEAS - Plan Esencial de Aseguramiento',NULL,NULL,355);
INSERT INTO bd_clinica.dbo.productos (categoria,descripcion,estado,imagen_url,nombre,precio,precio_descuento,stock) VALUES
	 (N'Medicamentos Generales',N'Caja x 100 tabletas. Analgésico y antipirético.',N'Activo',N'https://placehold.co/400x400/DCFCE7/166534?text=Medicina',N'Paracetamol 500mg',15.50,12.50,100),
	 (N'Analgésicos',N'Caja x 50 cápsulas blandas.',N'Activo',N'https://placehold.co/400x400/DBEAFE/1E40AF?text=Analgésico',N'Ibuprofeno 400mg',22.00,NULL,50),
	 (N'Antibióticos',N'Caja x 50 cápsulas. Requiere receta médica.',N'Activo',N'https://placehold.co/400x400/FEE2E2/991B1B?text=Antibiótico',N'Amoxicilina 500mg',35.00,30.00,80),
	 (N'Vitaminas y Suplementos',N'Frasco x 100 tabletas efervescentes.',N'Activo',N'https://placehold.co/400x400/FEF9C3/854D0E?text=Vitamina',N'Vitamina C 1000mg + Zinc',45.00,35.00,120),
	 (N'Respiratorio',N'Frasco 120ml. Expectorante adulto.',N'Activo',N'https://placehold.co/400x400/FCE7F3/9D174D?text=Jarabe',N'Jarabe para la tos con miel',28.00,NULL,40),
	 (N'Equipos Médicos',N'Termómetro de uso clínico preciso con alarma auditiva.',N'Activo',N'https://placehold.co/400x400/F3E8FF/6B21A8?text=Salud',N'Termómetro Digital',18.00,14.00,15);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000001',N'Finalizada','2026-01-01',12,89),
	 (N'R-2026-000002',N'Finalizada','2026-01-01',5,254),
	 (N'R-2026-000003',N'Finalizada','2026-01-01',1,160),
	 (N'R-2026-000004',N'Activa','2026-01-01',13,29),
	 (N'R-2026-000005',N'Finalizada','2026-01-01',12,28),
	 (N'R-2026-000006',N'Finalizada','2026-01-02',13,53),
	 (N'R-2026-000007',N'Finalizada','2026-01-02',36,197),
	 (N'R-2026-000008',N'Finalizada','2026-01-02',8,91),
	 (N'R-2026-000009',N'Finalizada','2026-01-03',20,254),
	 (N'R-2026-000010',N'Finalizada','2026-01-03',38,11);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000011',N'Finalizada','2026-01-04',17,266),
	 (N'R-2026-000012',N'Finalizada','2026-01-04',7,33),
	 (N'R-2026-000013',N'Finalizada','2026-01-05',11,2),
	 (N'R-2026-000014',N'Finalizada','2026-01-05',12,216),
	 (N'R-2026-000015',N'Finalizada','2026-01-06',3,273),
	 (N'R-2026-000016',N'Finalizada','2026-01-06',34,198),
	 (N'R-2026-000017',N'Finalizada','2026-01-06',15,154),
	 (N'R-2026-000018',N'Finalizada','2026-01-07',1,34),
	 (N'R-2026-000019',N'Finalizada','2026-01-07',3,135),
	 (N'R-2026-000020',N'Finalizada','2026-01-07',36,293);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000021',N'Finalizada','2026-01-08',19,279),
	 (N'R-2026-000022',N'Finalizada','2026-01-08',8,150),
	 (N'R-2026-000023',N'Finalizada','2026-01-08',13,129),
	 (N'R-2026-000024',N'Finalizada','2026-01-09',34,162),
	 (N'R-2026-000025',N'Activa','2026-01-09',38,26),
	 (N'R-2026-000026',N'Finalizada','2026-01-09',4,146),
	 (N'R-2026-000027',N'Finalizada','2026-01-10',4,147),
	 (N'R-2026-000028',N'Finalizada','2026-01-10',35,147),
	 (N'R-2026-000029',N'Activa','2026-01-11',12,181),
	 (N'R-2026-000030',N'Finalizada','2026-01-11',12,47);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000031',N'Finalizada','2026-01-11',23,146),
	 (N'R-2026-000032',N'Activa','2026-01-11',11,45),
	 (N'R-2026-000033',N'Finalizada','2026-01-11',34,234),
	 (N'R-2026-000034',N'Finalizada','2026-01-11',4,67),
	 (N'R-2026-000035',N'Finalizada','2026-01-11',4,63),
	 (N'R-2026-000036',N'Finalizada','2026-01-12',3,157),
	 (N'R-2026-000037',N'Finalizada','2026-01-12',39,294),
	 (N'R-2026-000038',N'Activa','2026-01-12',19,262),
	 (N'R-2026-000039',N'Activa','2026-01-13',3,167),
	 (N'R-2026-000040',N'Finalizada','2026-01-13',10,86);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000041',N'Finalizada','2026-01-13',17,286),
	 (N'R-2026-000042',N'Finalizada','2026-01-14',1,139),
	 (N'R-2026-000043',N'Finalizada','2026-01-14',9,130),
	 (N'R-2026-000044',N'Finalizada','2026-01-14',5,231),
	 (N'R-2026-000045',N'Finalizada','2026-01-15',36,198),
	 (N'R-2026-000046',N'Activa','2026-01-15',34,20),
	 (N'R-2026-000047',N'Finalizada','2026-01-15',40,107),
	 (N'R-2026-000048',N'Finalizada','2026-01-15',3,81),
	 (N'R-2026-000049',N'Finalizada','2026-01-16',5,44),
	 (N'R-2026-000050',N'Finalizada','2026-01-16',13,218);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000051',N'Finalizada','2026-01-16',17,291),
	 (N'R-2026-000052',N'Finalizada','2026-01-17',1,22),
	 (N'R-2026-000053',N'Finalizada','2026-01-17',33,300),
	 (N'R-2026-000054',N'Finalizada','2026-01-17',36,274),
	 (N'R-2026-000055',N'Finalizada','2026-01-17',13,289),
	 (N'R-2026-000056',N'Finalizada','2026-01-17',1,228),
	 (N'R-2026-000057',N'Finalizada','2026-01-17',7,84),
	 (N'R-2026-000058',N'Finalizada','2026-01-18',40,258),
	 (N'R-2026-000059',N'Finalizada','2026-01-18',34,274),
	 (N'R-2026-000060',N'Finalizada','2026-01-18',6,123);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000061',N'Finalizada','2026-01-19',21,144),
	 (N'R-2026-000062',N'Finalizada','2026-01-19',19,200),
	 (N'R-2026-000063',N'Finalizada','2026-01-19',14,85),
	 (N'R-2026-000064',N'Finalizada','2026-01-19',28,139),
	 (N'R-2026-000065',N'Activa','2026-01-19',33,233),
	 (N'R-2026-000066',N'Finalizada','2026-01-19',1,42),
	 (N'R-2026-000067',N'Activa','2026-01-20',2,79),
	 (N'R-2026-000068',N'Finalizada','2026-01-20',3,280),
	 (N'R-2026-000069',N'Finalizada','2026-01-20',13,37),
	 (N'R-2026-000070',N'Finalizada','2026-01-20',14,301);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000071',N'Finalizada','2026-01-20',14,299),
	 (N'R-2026-000072',N'Finalizada','2026-01-21',17,281),
	 (N'R-2026-000073',N'Finalizada','2026-01-21',5,293),
	 (N'R-2026-000074',N'Activa','2026-01-21',19,38),
	 (N'R-2026-000075',N'Finalizada','2026-01-21',33,192),
	 (N'R-2026-000076',N'Finalizada','2026-01-22',39,84),
	 (N'R-2026-000077',N'Finalizada','2026-01-22',5,243),
	 (N'R-2026-000078',N'Finalizada','2026-01-22',1,3),
	 (N'R-2026-000079',N'Finalizada','2026-01-22',12,161),
	 (N'R-2026-000080',N'Activa','2026-01-22',35,15);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000081',N'Finalizada','2026-01-22',1,118),
	 (N'R-2026-000082',N'Finalizada','2026-01-23',31,82),
	 (N'R-2026-000083',N'Activa','2026-01-23',33,172),
	 (N'R-2026-000084',N'Finalizada','2026-01-23',19,112),
	 (N'R-2026-000085',N'Finalizada','2026-01-24',32,17),
	 (N'R-2026-000086',N'Finalizada','2026-01-24',35,266),
	 (N'R-2026-000087',N'Finalizada','2026-01-24',1,5),
	 (N'R-2026-000088',N'Finalizada','2026-01-25',7,207),
	 (N'R-2026-000089',N'Finalizada','2026-01-25',35,169),
	 (N'R-2026-000090',N'Finalizada','2026-01-25',8,242);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000091',N'Activa','2026-01-25',23,208),
	 (N'R-2026-000092',N'Activa','2026-01-26',32,166),
	 (N'R-2026-000093',N'Finalizada','2026-01-26',15,194),
	 (N'R-2026-000094',N'Activa','2026-01-27',2,263),
	 (N'R-2026-000095',N'Finalizada','2026-01-27',7,137),
	 (N'R-2026-000096',N'Activa','2026-01-27',21,252),
	 (N'R-2026-000097',N'Finalizada','2026-01-28',15,130),
	 (N'R-2026-000098',N'Finalizada','2026-01-28',7,169),
	 (N'R-2026-000099',N'Activa','2026-01-29',14,282),
	 (N'R-2026-000100',N'Finalizada','2026-01-29',13,234);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000101',N'Finalizada','2026-01-29',4,112),
	 (N'R-2026-000102',N'Activa','2026-01-29',4,112),
	 (N'R-2026-000103',N'Finalizada','2026-01-30',16,42),
	 (N'R-2026-000104',N'Finalizada','2026-01-30',7,176),
	 (N'R-2026-000105',N'Finalizada','2026-01-30',34,51),
	 (N'R-2026-000106',N'Activa','2026-01-30',1,281),
	 (N'R-2026-000107',N'Finalizada','2026-01-30',34,8),
	 (N'R-2026-000108',N'Activa','2026-01-31',1,10),
	 (N'R-2026-000109',N'Finalizada','2026-01-31',13,206),
	 (N'R-2026-000110',N'Finalizada','2026-01-31',13,117);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000111',N'Finalizada','2026-02-01',12,195),
	 (N'R-2026-000112',N'Finalizada','2026-02-01',10,291),
	 (N'R-2026-000113',N'Finalizada','2026-02-01',33,95),
	 (N'R-2026-000114',N'Finalizada','2026-02-02',35,113),
	 (N'R-2026-000115',N'Finalizada','2026-02-02',20,200),
	 (N'R-2026-000116',N'Finalizada','2026-02-02',4,123),
	 (N'R-2026-000117',N'Finalizada','2026-02-02',38,209),
	 (N'R-2026-000118',N'Activa','2026-02-03',7,163),
	 (N'R-2026-000119',N'Activa','2026-02-03',12,170),
	 (N'R-2026-000120',N'Finalizada','2026-02-03',36,102);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000121',N'Finalizada','2026-02-03',16,23),
	 (N'R-2026-000122',N'Finalizada','2026-02-04',1,107),
	 (N'R-2026-000123',N'Finalizada','2026-02-04',4,200),
	 (N'R-2026-000124',N'Finalizada','2026-02-05',13,265),
	 (N'R-2026-000125',N'Finalizada','2026-02-05',17,272),
	 (N'R-2026-000126',N'Finalizada','2026-02-06',35,44),
	 (N'R-2026-000127',N'Finalizada','2026-02-06',32,88),
	 (N'R-2026-000128',N'Activa','2026-02-06',14,59),
	 (N'R-2026-000129',N'Finalizada','2026-02-07',8,51),
	 (N'R-2026-000130',N'Finalizada','2026-02-07',39,113);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000131',N'Finalizada','2026-02-07',33,240),
	 (N'R-2026-000132',N'Finalizada','2026-02-07',31,293),
	 (N'R-2026-000133',N'Finalizada','2026-02-07',14,253),
	 (N'R-2026-000134',N'Activa','2026-02-07',12,286),
	 (N'R-2026-000135',N'Finalizada','2026-02-07',14,111),
	 (N'R-2026-000136',N'Finalizada','2026-02-07',17,294),
	 (N'R-2026-000137',N'Activa','2026-02-08',1,245),
	 (N'R-2026-000138',N'Finalizada','2026-02-08',14,183),
	 (N'R-2026-000139',N'Finalizada','2026-02-09',2,259),
	 (N'R-2026-000140',N'Finalizada','2026-02-09',11,123);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000141',N'Finalizada','2026-02-09',3,197),
	 (N'R-2026-000142',N'Finalizada','2026-02-09',30,85),
	 (N'R-2026-000143',N'Activa','2026-02-09',4,212),
	 (N'R-2026-000144',N'Finalizada','2026-02-10',12,177),
	 (N'R-2026-000145',N'Finalizada','2026-02-10',13,7),
	 (N'R-2026-000146',N'Finalizada','2026-02-10',5,258),
	 (N'R-2026-000147',N'Finalizada','2026-02-10',12,203),
	 (N'R-2026-000148',N'Finalizada','2026-02-11',5,225),
	 (N'R-2026-000149',N'Activa','2026-02-11',22,221),
	 (N'R-2026-000150',N'Activa','2026-02-12',6,250);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000151',N'Finalizada','2026-02-12',3,271),
	 (N'R-2026-000152',N'Activa','2026-02-12',9,22),
	 (N'R-2026-000153',N'Activa','2026-02-12',32,139),
	 (N'R-2026-000154',N'Finalizada','2026-02-14',10,204),
	 (N'R-2026-000155',N'Finalizada','2026-02-14',32,179),
	 (N'R-2026-000156',N'Finalizada','2026-02-14',8,150),
	 (N'R-2026-000157',N'Finalizada','2026-02-15',3,123),
	 (N'R-2026-000158',N'Finalizada','2026-02-15',31,177),
	 (N'R-2026-000159',N'Activa','2026-02-15',3,157),
	 (N'R-2026-000160',N'Activa','2026-02-15',5,47);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000161',N'Activa','2026-02-16',15,14),
	 (N'R-2026-000162',N'Finalizada','2026-02-16',13,242),
	 (N'R-2026-000163',N'Finalizada','2026-02-16',20,149),
	 (N'R-2026-000164',N'Activa','2026-02-16',24,298),
	 (N'R-2026-000165',N'Finalizada','2026-02-17',5,264),
	 (N'R-2026-000166',N'Finalizada','2026-02-17',3,196),
	 (N'R-2026-000167',N'Activa','2026-02-17',11,102),
	 (N'R-2026-000168',N'Finalizada','2026-02-17',1,51),
	 (N'R-2026-000169',N'Finalizada','2026-02-17',32,225),
	 (N'R-2026-000170',N'Finalizada','2026-02-17',21,6);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000171',N'Finalizada','2026-02-17',33,285),
	 (N'R-2026-000172',N'Finalizada','2026-02-18',1,222),
	 (N'R-2026-000173',N'Finalizada','2026-02-18',39,104),
	 (N'R-2026-000174',N'Finalizada','2026-02-18',3,69),
	 (N'R-2026-000175',N'Activa','2026-02-20',7,73),
	 (N'R-2026-000176',N'Finalizada','2026-02-20',9,183),
	 (N'R-2026-000177',N'Activa','2026-02-20',28,299),
	 (N'R-2026-000178',N'Finalizada','2026-02-20',16,39),
	 (N'R-2026-000179',N'Activa','2026-02-21',34,272),
	 (N'R-2026-000180',N'Finalizada','2026-02-21',1,226);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000181',N'Finalizada','2026-02-21',9,194),
	 (N'R-2026-000182',N'Finalizada','2026-02-21',2,132),
	 (N'R-2026-000183',N'Finalizada','2026-02-21',4,248),
	 (N'R-2026-000184',N'Finalizada','2026-02-22',3,11),
	 (N'R-2026-000185',N'Finalizada','2026-02-22',4,30),
	 (N'R-2026-000186',N'Activa','2026-02-22',13,280),
	 (N'R-2026-000187',N'Finalizada','2026-02-22',18,18),
	 (N'R-2026-000188',N'Finalizada','2026-02-22',10,232),
	 (N'R-2026-000189',N'Activa','2026-02-22',17,42),
	 (N'R-2026-000190',N'Finalizada','2026-02-23',3,11);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000191',N'Finalizada','2026-02-23',7,11),
	 (N'R-2026-000192',N'Activa','2026-02-24',36,189),
	 (N'R-2026-000193',N'Finalizada','2026-02-24',19,169),
	 (N'R-2026-000194',N'Activa','2026-02-24',34,137),
	 (N'R-2026-000195',N'Finalizada','2026-02-24',9,80),
	 (N'R-2026-000196',N'Activa','2026-02-24',3,266),
	 (N'R-2026-000197',N'Finalizada','2026-02-25',6,115),
	 (N'R-2026-000198',N'Finalizada','2026-02-25',13,241),
	 (N'R-2026-000199',N'Activa','2026-02-25',35,242),
	 (N'R-2026-000200',N'Finalizada','2026-02-25',35,93);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000201',N'Finalizada','2026-02-25',17,254),
	 (N'R-2026-000202',N'Activa','2026-02-26',5,83),
	 (N'R-2026-000203',N'Finalizada','2026-02-26',16,122),
	 (N'R-2026-000204',N'Finalizada','2026-02-26',12,135),
	 (N'R-2026-000205',N'Finalizada','2026-02-26',12,60),
	 (N'R-2026-000206',N'Finalizada','2026-02-27',17,243),
	 (N'R-2026-000207',N'Finalizada','2026-02-27',2,155),
	 (N'R-2026-000208',N'Finalizada','2026-02-27',1,122),
	 (N'R-2026-000209',N'Activa','2026-02-27',4,283),
	 (N'R-2026-000210',N'Finalizada','2026-02-28',6,278);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000211',N'Finalizada','2026-02-28',39,57),
	 (N'R-2026-000212',N'Activa','2026-02-28',10,259),
	 (N'R-2026-000213',N'Finalizada','2026-02-28',35,52),
	 (N'R-2026-000214',N'Finalizada','2026-02-28',4,75),
	 (N'R-2026-000215',N'Finalizada','2026-02-28',2,70),
	 (N'R-2026-000216',N'Finalizada','2026-03-01',15,114),
	 (N'R-2026-000217',N'Finalizada','2026-03-01',14,257),
	 (N'R-2026-000218',N'Finalizada','2026-03-01',2,289),
	 (N'R-2026-000219',N'Finalizada','2026-03-02',13,274),
	 (N'R-2026-000220',N'Finalizada','2026-03-02',13,293);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000221',N'Finalizada','2026-03-03',9,222),
	 (N'R-2026-000222',N'Finalizada','2026-03-03',4,234),
	 (N'R-2026-000223',N'Finalizada','2026-03-03',6,248),
	 (N'R-2026-000224',N'Finalizada','2026-03-03',15,133),
	 (N'R-2026-000225',N'Finalizada','2026-03-04',12,182),
	 (N'R-2026-000226',N'Activa','2026-03-04',5,230),
	 (N'R-2026-000227',N'Finalizada','2026-03-04',14,142),
	 (N'R-2026-000228',N'Finalizada','2026-03-05',33,134),
	 (N'R-2026-000229',N'Finalizada','2026-03-05',15,287),
	 (N'R-2026-000230',N'Finalizada','2026-03-05',1,88);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000231',N'Activa','2026-03-05',1,144),
	 (N'R-2026-000232',N'Activa','2026-03-06',2,300),
	 (N'R-2026-000233',N'Finalizada','2026-03-06',2,131),
	 (N'R-2026-000234',N'Finalizada','2026-03-07',6,183),
	 (N'R-2026-000235',N'Finalizada','2026-03-08',31,160),
	 (N'R-2026-000236',N'Activa','2026-03-08',33,95),
	 (N'R-2026-000237',N'Finalizada','2026-03-08',1,287),
	 (N'R-2026-000238',N'Finalizada','2026-03-09',24,30),
	 (N'R-2026-000239',N'Finalizada','2026-03-09',16,113),
	 (N'R-2026-000240',N'Finalizada','2026-03-09',17,11);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000241',N'Activa','2026-03-09',32,207),
	 (N'R-2026-000242',N'Activa','2026-03-10',12,220),
	 (N'R-2026-000243',N'Activa','2026-03-10',2,205),
	 (N'R-2026-000244',N'Activa','2026-03-10',31,179),
	 (N'R-2026-000245',N'Activa','2026-03-10',13,159),
	 (N'R-2026-000246',N'Finalizada','2026-03-12',30,224),
	 (N'R-2026-000247',N'Finalizada','2026-03-12',1,265),
	 (N'R-2026-000248',N'Finalizada','2026-03-12',4,168),
	 (N'R-2026-000249',N'Finalizada','2026-03-12',8,224),
	 (N'R-2026-000250',N'Finalizada','2026-03-14',12,11);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000251',N'Finalizada','2026-03-14',15,78),
	 (N'R-2026-000252',N'Activa','2026-03-14',8,52),
	 (N'R-2026-000253',N'Finalizada','2026-03-14',45,184),
	 (N'R-2026-000254',N'Finalizada','2026-03-15',12,108),
	 (N'R-2026-000255',N'Activa','2026-03-15',13,150),
	 (N'R-2026-000256',N'Finalizada','2026-03-16',19,3),
	 (N'R-2026-000257',N'Activa','2026-03-16',42,146),
	 (N'R-2026-000258',N'Finalizada','2026-03-16',1,2),
	 (N'R-2026-000259',N'Finalizada','2026-03-17',16,24),
	 (N'R-2026-000260',N'Activa','2026-03-17',37,11);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000261',N'Activa','2026-03-17',1,135),
	 (N'R-2026-000262',N'Finalizada','2026-03-17',5,184),
	 (N'R-2026-000263',N'Activa','2026-03-18',13,75),
	 (N'R-2026-000264',N'Finalizada','2026-03-19',20,50),
	 (N'R-2026-000265',N'Activa','2026-03-21',8,265),
	 (N'R-2026-000266',N'Finalizada','2026-03-22',40,72),
	 (N'R-2026-000267',N'Finalizada','2026-03-23',1,84),
	 (N'R-2026-000268',N'Activa','2026-03-23',17,56),
	 (N'R-2026-000269',N'Finalizada','2026-03-23',4,80),
	 (N'R-2026-000270',N'Activa','2026-03-23',18,253);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000271',N'Finalizada','2026-03-24',36,51),
	 (N'R-2026-000272',N'Finalizada','2026-03-24',39,217),
	 (N'R-2026-000273',N'Finalizada','2026-03-24',3,17),
	 (N'R-2026-000274',N'Finalizada','2026-03-24',12,74),
	 (N'R-2026-000275',N'Finalizada','2026-03-24',13,118),
	 (N'R-2026-000276',N'Finalizada','2026-03-25',37,4),
	 (N'R-2026-000277',N'Activa','2026-03-26',32,12),
	 (N'R-2026-000278',N'Activa','2026-03-26',36,215),
	 (N'R-2026-000279',N'Finalizada','2026-03-28',36,40),
	 (N'R-2026-000280',N'Finalizada','2026-03-28',16,99);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000281',N'Activa','2026-03-28',15,206),
	 (N'R-2026-000282',N'Finalizada','2026-03-29',5,127),
	 (N'R-2026-000283',N'Activa','2026-03-31',6,224),
	 (N'R-2026-000284',N'Finalizada','2026-03-31',2,72),
	 (N'R-2026-000285',N'Finalizada','2026-03-31',4,49),
	 (N'R-2026-000286',N'Finalizada','2026-04-01',2,108),
	 (N'R-2026-000287',N'Finalizada','2026-04-01',3,236),
	 (N'R-2026-000288',N'Finalizada','2026-04-02',3,285),
	 (N'R-2026-000289',N'Finalizada','2026-04-02',6,7),
	 (N'R-2026-000290',N'Finalizada','2026-04-02',25,168);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000291',N'Activa','2026-04-03',2,186),
	 (N'R-2026-000292',N'Activa','2026-04-03',1,247),
	 (N'R-2026-000293',N'Finalizada','2026-04-04',1,118),
	 (N'R-2026-000294',N'Finalizada','2026-04-04',15,63),
	 (N'R-2026-000295',N'Finalizada','2026-04-04',3,114),
	 (N'R-2026-000296',N'Finalizada','2026-04-04',12,89),
	 (N'R-2026-000297',N'Finalizada','2026-04-04',23,48),
	 (N'R-2026-000298',N'Finalizada','2026-04-04',2,188),
	 (N'R-2026-000299',N'Finalizada','2026-04-04',17,62),
	 (N'R-2026-000300',N'Finalizada','2026-04-04',3,273);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000301',N'Finalizada','2026-04-05',16,156),
	 (N'R-2026-000302',N'Activa','2026-04-05',3,254),
	 (N'R-2026-000303',N'Finalizada','2026-04-06',2,218),
	 (N'R-2026-000304',N'Activa','2026-04-07',12,284),
	 (N'R-2026-000305',N'Finalizada','2026-04-07',7,235),
	 (N'R-2026-000306',N'Finalizada','2026-04-07',30,17),
	 (N'R-2026-000307',N'Finalizada','2026-04-07',1,209),
	 (N'R-2026-000308',N'Activa','2026-04-08',23,129),
	 (N'R-2026-000309',N'Finalizada','2026-04-09',10,294),
	 (N'R-2026-000310',N'Finalizada','2026-04-09',36,293);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000311',N'Activa','2026-04-11',35,124),
	 (N'R-2026-000312',N'Finalizada','2026-04-11',18,40),
	 (N'R-2026-000313',N'Activa','2026-04-11',26,240),
	 (N'R-2026-000314',N'Activa','2026-04-12',4,279),
	 (N'R-2026-000315',N'Activa','2026-04-12',6,60),
	 (N'R-2026-000316',N'Finalizada','2026-04-12',9,134),
	 (N'R-2026-000317',N'Activa','2026-04-12',37,232),
	 (N'R-2026-000318',N'Finalizada','2026-04-13',15,30),
	 (N'R-2026-000319',N'Finalizada','2026-04-14',2,122),
	 (N'R-2026-000320',N'Finalizada','2026-04-14',4,235);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000321',N'Activa','2026-04-14',3,203),
	 (N'R-2026-000322',N'Activa','2026-04-15',37,116),
	 (N'R-2026-000323',N'Finalizada','2026-04-15',7,241),
	 (N'R-2026-000324',N'Finalizada','2026-04-15',13,78),
	 (N'R-2026-000325',N'Finalizada','2026-04-15',6,236),
	 (N'R-2026-000326',N'Activa','2026-04-15',13,187),
	 (N'R-2026-000327',N'Activa','2026-04-15',2,229),
	 (N'R-2026-000328',N'Activa','2026-04-15',32,4),
	 (N'R-2026-000329',N'Finalizada','2026-04-17',34,82),
	 (N'R-2026-000330',N'Activa','2026-04-17',24,13);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000331',N'Finalizada','2026-04-18',7,288),
	 (N'R-2026-000332',N'Finalizada','2026-04-18',34,93),
	 (N'R-2026-000333',N'Activa','2026-04-18',5,62),
	 (N'R-2026-000334',N'Finalizada','2026-04-19',5,238),
	 (N'R-2026-000335',N'Finalizada','2026-04-19',35,260),
	 (N'R-2026-000336',N'Finalizada','2026-04-19',15,101),
	 (N'R-2026-000337',N'Finalizada','2026-04-19',5,51),
	 (N'R-2026-000338',N'Activa','2026-04-20',18,86),
	 (N'R-2026-000339',N'Finalizada','2026-04-20',18,287),
	 (N'R-2026-000340',N'Finalizada','2026-04-20',15,99);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000341',N'Finalizada','2026-04-20',15,64),
	 (N'R-2026-000342',N'Activa','2026-04-22',18,241),
	 (N'R-2026-000343',N'Finalizada','2026-04-22',18,154),
	 (N'R-2026-000344',N'Finalizada','2026-04-23',12,77),
	 (N'R-2026-000345',N'Activa','2026-04-23',11,91),
	 (N'R-2026-000346',N'Activa','2026-04-23',37,131),
	 (N'R-2026-000347',N'Finalizada','2026-04-23',12,48),
	 (N'R-2026-000348',N'Activa','2026-04-23',22,161),
	 (N'R-2026-000349',N'Finalizada','2026-04-24',25,260),
	 (N'R-2026-000350',N'Activa','2026-04-24',2,17);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000351',N'Activa','2026-04-24',3,40),
	 (N'R-2026-000352',N'Finalizada','2026-04-24',13,120),
	 (N'R-2026-000353',N'Finalizada','2026-04-25',34,30),
	 (N'R-2026-000354',N'Finalizada','2026-04-25',32,72),
	 (N'R-2026-000355',N'Finalizada','2026-04-26',2,107),
	 (N'R-2026-000356',N'Finalizada','2026-04-26',12,223),
	 (N'R-2026-000357',N'Finalizada','2026-04-26',12,260),
	 (N'R-2026-000358',N'Activa','2026-04-27',18,134),
	 (N'R-2026-000359',N'Finalizada','2026-04-28',9,156),
	 (N'R-2026-000360',N'Activa','2026-04-28',2,216);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000361',N'Activa','2026-04-28',9,101),
	 (N'R-2026-000362',N'Finalizada','2026-04-28',8,30),
	 (N'R-2026-000363',N'Finalizada','2026-04-29',14,258),
	 (N'R-2026-000364',N'Finalizada','2026-04-30',34,199),
	 (N'R-2026-000365',N'Activa','2026-04-30',39,201),
	 (N'R-2026-000366',N'Activa','2026-04-30',33,118),
	 (N'R-2026-000367',N'Finalizada','2026-04-30',17,34),
	 (N'R-2026-000368',N'Finalizada','2026-05-01',6,63),
	 (N'R-2026-000369',N'Activa','2026-05-01',2,104),
	 (N'R-2026-000370',N'Finalizada','2026-05-01',18,227);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000371',N'Finalizada','2026-05-01',1,117),
	 (N'R-2026-000372',N'Activa','2026-05-01',2,1),
	 (N'R-2026-000373',N'Activa','2026-05-01',32,54),
	 (N'R-2026-000374',N'Activa','2026-05-01',27,16),
	 (N'R-2026-000375',N'Activa','2026-05-01',36,113),
	 (N'R-2026-000376',N'Finalizada','2026-05-02',24,89),
	 (N'R-2026-000377',N'Activa','2026-05-02',15,209),
	 (N'R-2026-000378',N'Activa','2026-05-02',5,273),
	 (N'R-2026-000379',N'Finalizada','2026-05-03',18,111),
	 (N'R-2026-000380',N'Finalizada','2026-05-03',15,292);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000381',N'Activa','2026-05-03',32,234),
	 (N'R-2026-000382',N'Activa','2026-05-03',2,123),
	 (N'R-2026-000383',N'Finalizada','2026-05-04',21,260),
	 (N'R-2026-000384',N'Activa','2026-05-04',38,264),
	 (N'R-2026-000385',N'Activa','2026-05-04',32,178),
	 (N'R-2026-000386',N'Activa','2026-05-05',12,107),
	 (N'R-2026-000387',N'Finalizada','2026-05-05',12,218),
	 (N'R-2026-000388',N'Finalizada','2026-05-05',34,168),
	 (N'R-2026-000389',N'Activa','2026-05-05',14,64),
	 (N'R-2026-000390',N'Finalizada','2026-05-06',5,70);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000391',N'Activa','2026-05-06',7,50),
	 (N'R-2026-000392',N'Activa','2026-05-07',21,80),
	 (N'R-2026-000393',N'Finalizada','2026-05-07',1,184),
	 (N'R-2026-000394',N'Finalizada','2026-05-07',3,188),
	 (N'R-2026-000395',N'Activa','2026-05-07',12,293),
	 (N'R-2026-000396',N'Activa','2026-05-08',29,165),
	 (N'R-2026-000397',N'Finalizada','2026-05-09',8,69),
	 (N'R-2026-000398',N'Activa','2026-05-09',30,274),
	 (N'R-2026-000399',N'Activa','2026-05-10',18,162),
	 (N'R-2026-000400',N'Activa','2026-05-10',33,121);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000401',N'Finalizada','2026-05-10',6,90),
	 (N'R-2026-000402',N'Activa','2026-05-10',13,7),
	 (N'R-2026-000403',N'Finalizada','2026-05-10',19,35),
	 (N'R-2026-000404',N'Finalizada','2026-05-11',38,277),
	 (N'R-2026-000405',N'Activa','2026-05-11',41,100),
	 (N'R-2026-000406',N'Finalizada','2026-05-11',35,67),
	 (N'R-2026-000407',N'Activa','2026-05-12',1,37),
	 (N'R-2026-000408',N'Finalizada','2026-05-12',45,48),
	 (N'R-2026-000409',N'Activa','2026-05-12',12,210),
	 (N'R-2026-000410',N'Finalizada','2026-05-12',1,235);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000411',N'Activa','2026-05-12',17,301),
	 (N'R-2026-000412',N'Activa','2026-05-12',2,87),
	 (N'R-2026-000413',N'Finalizada','2026-05-13',33,182),
	 (N'R-2026-000414',N'Finalizada','2026-05-13',23,151),
	 (N'R-2026-000415',N'Activa','2026-05-13',16,74),
	 (N'R-2026-000416',N'Activa','2026-05-14',19,176),
	 (N'R-2026-000417',N'Finalizada','2026-05-14',38,122),
	 (N'R-2026-000418',N'Activa','2026-05-14',1,122),
	 (N'R-2026-000419',N'Activa','2026-05-14',13,133),
	 (N'R-2026-000420',N'Finalizada','2026-05-14',14,103);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000421',N'Finalizada','2026-05-14',1,143),
	 (N'R-2026-000422',N'Activa','2026-05-14',38,270),
	 (N'R-2026-000423',N'Activa','2026-05-15',20,199),
	 (N'R-2026-000424',N'Finalizada','2026-05-15',33,24),
	 (N'R-2026-000425',N'Activa','2026-05-16',12,35),
	 (N'R-2026-000426',N'Activa','2026-05-16',3,288),
	 (N'R-2026-000427',N'Finalizada','2026-05-17',32,291),
	 (N'R-2026-000428',N'Activa','2026-05-17',13,99),
	 (N'R-2026-000429',N'Finalizada','2026-05-17',17,28),
	 (N'R-2026-000430',N'Finalizada','2026-05-18',6,251);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000431',N'Finalizada','2026-05-18',14,84),
	 (N'R-2026-000432',N'Activa','2026-05-18',12,127),
	 (N'R-2026-000433',N'Finalizada','2026-05-19',45,236),
	 (N'R-2026-000434',N'Finalizada','2026-05-19',3,63),
	 (N'R-2026-000435',N'Finalizada','2026-05-19',27,110),
	 (N'R-2026-000436',N'Activa','2026-05-19',32,275),
	 (N'R-2026-000437',N'Finalizada','2026-05-19',17,89),
	 (N'R-2026-000438',N'Activa','2026-05-20',32,239),
	 (N'R-2026-000439',N'Finalizada','2026-05-21',13,192),
	 (N'R-2026-000440',N'Finalizada','2026-05-21',1,117);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000441',N'Activa','2026-05-22',33,93),
	 (N'R-2026-000442',N'Activa','2026-05-22',5,103),
	 (N'R-2026-000443',N'Finalizada','2026-05-22',4,289),
	 (N'R-2026-000444',N'Finalizada','2026-05-22',34,98),
	 (N'R-2026-000445',N'Activa','2026-05-23',3,258),
	 (N'R-2026-000446',N'Finalizada','2026-05-24',38,147),
	 (N'R-2026-000447',N'Activa','2026-05-24',4,117),
	 (N'R-2026-000448',N'Activa','2026-05-24',34,84),
	 (N'R-2026-000449',N'Finalizada','2026-05-24',17,174),
	 (N'R-2026-000450',N'Activa','2026-05-25',2,222);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000451',N'Finalizada','2026-05-25',13,8),
	 (N'R-2026-000452',N'Activa','2026-05-26',33,225),
	 (N'R-2026-000453',N'Activa','2026-05-26',2,44),
	 (N'R-2026-000454',N'Activa','2026-05-26',36,238),
	 (N'R-2026-000455',N'Activa','2026-05-26',32,98),
	 (N'R-2026-000456',N'Activa','2026-05-27',19,48),
	 (N'R-2026-000457',N'Finalizada','2026-05-27',3,155),
	 (N'R-2026-000458',N'Activa','2026-05-27',32,177),
	 (N'R-2026-000459',N'Finalizada','2026-05-27',17,138),
	 (N'R-2026-000460',N'Activa','2026-05-27',13,287);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000461',N'Activa','2026-05-28',12,33),
	 (N'R-2026-000462',N'Finalizada','2026-05-28',35,188),
	 (N'R-2026-000463',N'Activa','2026-05-29',1,126),
	 (N'R-2026-000464',N'Activa','2026-05-29',40,218),
	 (N'R-2026-000465',N'Activa','2026-05-29',7,183),
	 (N'R-2026-000466',N'Activa','2026-05-30',3,289),
	 (N'R-2026-000467',N'Finalizada','2026-05-30',1,61),
	 (N'R-2026-000468',N'Activa','2026-05-30',16,278),
	 (N'R-2026-000469',N'Activa','2026-05-30',18,70),
	 (N'R-2026-000470',N'Activa','2026-05-30',22,81);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000471',N'Finalizada','2026-05-31',32,143),
	 (N'R-2026-000472',N'Activa','2026-05-31',5,271),
	 (N'R-2026-000473',N'Activa','2026-05-31',35,192),
	 (N'R-2026-000474',N'Activa','2026-05-31',6,291),
	 (N'R-2026-000475',N'Finalizada','2026-05-31',4,174),
	 (N'R-2026-000476',N'Finalizada','2026-05-31',14,188),
	 (N'R-2026-000477',N'Activa','2026-05-31',3,141),
	 (N'R-2026-000478',N'Finalizada','2026-06-01',4,236),
	 (N'R-2026-000479',N'Activa','2026-06-01',20,294),
	 (N'R-2026-000480',N'Finalizada','2026-06-01',17,152);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000481',N'Activa','2026-06-01',16,235),
	 (N'R-2026-000482',N'Activa','2026-06-01',25,143),
	 (N'R-2026-000483',N'Activa','2026-06-02',1,151),
	 (N'R-2026-000484',N'Activa','2026-06-03',45,260),
	 (N'R-2026-000485',N'Activa','2026-06-03',34,160),
	 (N'R-2026-000486',N'Finalizada','2026-06-03',34,196),
	 (N'R-2026-000487',N'Activa','2026-06-03',32,114),
	 (N'R-2026-000488',N'Activa','2026-06-03',35,204),
	 (N'R-2026-000489',N'Activa','2026-06-03',33,69),
	 (N'R-2026-000490',N'Activa','2026-06-04',9,188);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000491',N'Finalizada','2026-06-04',2,211),
	 (N'R-2026-000492',N'Activa','2026-06-04',3,237),
	 (N'R-2026-000493',N'Activa','2026-06-04',8,152),
	 (N'R-2026-000494',N'Activa','2026-06-05',2,198),
	 (N'R-2026-000495',N'Activa','2026-06-05',36,77),
	 (N'R-2026-000496',N'Activa','2026-06-06',4,292),
	 (N'R-2026-000497',N'Activa','2026-06-06',16,128),
	 (N'R-2026-000498',N'Activa','2026-06-06',7,55),
	 (N'R-2026-000499',N'Activa','2026-06-06',1,136),
	 (N'R-2026-000500',N'Activa','2026-06-06',37,184);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000501',N'Activa','2026-06-06',13,89),
	 (N'R-2026-000502',N'Activa','2026-06-07',13,130),
	 (N'R-2026-000503',N'Activa','2026-06-07',25,67),
	 (N'R-2026-000504',N'Activa','2026-06-08',16,195),
	 (N'R-2026-000505',N'Activa','2026-06-08',4,290),
	 (N'R-2026-000506',N'Finalizada','2026-06-09',32,90),
	 (N'R-2026-000507',N'Activa','2026-06-09',37,261),
	 (N'R-2026-000508',N'Finalizada','2026-06-09',15,164),
	 (N'R-2026-000509',N'Finalizada','2026-06-10',12,236),
	 (N'R-2026-000510',N'Activa','2026-06-11',3,120);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000511',N'Activa','2026-06-11',1,90),
	 (N'R-2026-000512',N'Activa','2026-06-12',2,211),
	 (N'R-2026-000513',N'Finalizada','2026-06-12',37,231),
	 (N'R-2026-000514',N'Activa','2026-06-12',2,24),
	 (N'R-2026-000515',N'Activa','2026-06-13',4,248),
	 (N'R-2026-000516',N'Activa','2026-06-14',13,243),
	 (N'R-2026-000517',N'Finalizada','2026-06-14',13,132),
	 (N'R-2026-000518',N'Activa','2026-06-14',4,132),
	 (N'R-2026-000519',N'Activa','2026-06-15',12,164),
	 (N'R-2026-000520',N'Activa','2026-06-15',13,111);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000521',N'Activa','2026-06-16',15,147),
	 (N'R-2026-000522',N'Activa','2026-06-16',2,53),
	 (N'R-2026-000523',N'Activa','2026-06-16',4,6),
	 (N'R-2026-000524',N'Finalizada','2026-06-16',20,168),
	 (N'R-2026-000525',N'Activa','2026-06-16',29,268),
	 (N'R-2026-000526',N'Activa','2026-06-17',25,66),
	 (N'R-2026-000527',N'Activa','2026-06-17',9,200),
	 (N'R-2026-000528',N'Finalizada','2026-06-17',1,154),
	 (N'R-2026-000529',N'Activa','2026-06-17',8,236),
	 (N'R-2026-000530',N'Activa','2026-06-18',1,223);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000531',N'Finalizada','2026-06-18',17,61),
	 (N'R-2026-000532',N'Activa','2026-06-19',2,217),
	 (N'R-2026-000533',N'Activa','2026-06-19',26,226),
	 (N'R-2026-000534',N'Activa','2026-06-19',32,142),
	 (N'R-2026-000535',N'Activa','2026-06-19',1,251),
	 (N'R-2026-000536',N'Activa','2026-06-19',36,169),
	 (N'R-2026-000537',N'Activa','2026-06-19',35,82),
	 (N'R-2026-000538',N'Activa','2026-06-20',14,182),
	 (N'R-2026-000539',N'Activa','2026-06-20',32,197),
	 (N'R-2026-000540',N'Activa','2026-06-20',15,57);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000541',N'Activa','2026-06-20',2,2),
	 (N'R-2026-000542',N'Activa','2026-06-21',3,18),
	 (N'R-2026-000543',N'Activa','2026-06-21',18,23),
	 (N'R-2026-000544',N'Activa','2026-06-21',17,8),
	 (N'R-2026-000545',N'Activa','2026-06-22',3,227),
	 (N'R-2026-000546',N'Activa','2026-06-22',15,196),
	 (N'R-2026-000547',N'Finalizada','2026-06-23',5,31),
	 (N'R-2026-000548',N'Finalizada','2026-06-23',14,63),
	 (N'R-2026-000549',N'Activa','2026-06-23',10,174),
	 (N'R-2026-000550',N'Activa','2026-06-23',4,173);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000551',N'Activa','2026-06-23',1,108),
	 (N'R-2026-000552',N'Activa','2026-06-24',5,257),
	 (N'R-2026-000553',N'Activa','2026-06-24',4,231),
	 (N'R-2026-000554',N'Activa','2026-06-24',3,168),
	 (N'R-2026-000555',N'Activa','2026-06-24',16,115),
	 (N'R-2026-000556',N'Activa','2026-06-24',1,138),
	 (N'R-2026-000557',N'Finalizada','2026-06-25',20,61),
	 (N'R-2026-000558',N'Activa','2026-06-25',5,155),
	 (N'R-2026-000559',N'Activa','2026-06-25',12,214),
	 (N'R-2026-000560',N'Activa','2026-06-25',4,156);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000561',N'Activa','2026-06-26',12,68),
	 (N'R-2026-000562',N'Activa','2026-06-26',13,85),
	 (N'R-2026-000563',N'Activa','2026-06-26',23,149),
	 (N'R-2026-000564',N'Activa','2026-06-26',32,228),
	 (N'R-2026-000565',N'Activa','2026-06-26',32,191),
	 (N'R-2026-000566',N'Activa','2026-06-27',34,269),
	 (N'R-2026-000567',N'Activa','2026-06-27',17,5),
	 (N'R-2026-000568',N'Activa','2026-06-27',7,194),
	 (N'R-2026-000569',N'Activa','2026-06-27',1,277),
	 (N'R-2026-000570',N'Activa','2026-06-28',37,31);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000571',N'Activa','2026-06-28',37,78),
	 (N'R-2026-000572',N'Activa','2026-06-28',32,285),
	 (N'R-2026-000573',N'Activa','2026-06-28',4,110),
	 (N'R-2026-000574',N'Activa','2026-06-28',1,63),
	 (N'R-2026-000575',N'Activa','2026-06-29',2,49),
	 (N'R-2026-000576',N'Activa','2026-06-29',37,3),
	 (N'R-2026-000577',N'Activa','2026-06-29',14,28),
	 (N'R-2026-000578',N'Activa','2026-06-29',21,72),
	 (N'R-2026-000579',N'Activa','2026-06-29',24,51),
	 (N'R-2026-000580',N'Activa','2026-06-29',3,88);
INSERT INTO bd_clinica.dbo.recetas (codigo,estado,fecha_emision,id_medico,id_paciente) VALUES
	 (N'R-2026-000581',N'Activa','2026-06-29',15,61),
	 (N'R-2026-000582',N'Activa','2026-06-30',1,34),
	 (N'R-2026-000583',N'Activa','2026-06-30',6,30),
	 (N'R-2026-000584',N'Activa','2026-06-30',1,39),
	 (N'R-2026-000585',N'Activa','2026-06-30',13,154),
	 (N'R-2026-H001',N'Finalizada','2026-04-15',34,1),
	 (N'R-2026-H002',N'Finalizada','2026-07-20',34,1);
INSERT INTO bd_clinica.dbo.sedes (ciudad,direccion,distrito,email,estado,horario_domingo,horario_lv,horario_sabado,nombre,num_consultorios,telefono) VALUES
	 (N'Lima',N'Av. Arenales 1256, Centro de Lima',N'Lima Centro',N'centrolima@clinicx.pe',N'Activo',N'Cerrado',N'07:00 - 20:00',N'08:00 - 14:00',N'Clínica Centro Lima',12,N'(01) 424-1234'),
	 (N'Lima',N'Av. Larco 890, Miraflores',N'Miraflores',N'miraflores@clinicx.pe',N'Activo',N'09:00 - 13:00',N'07:00 - 21:00',N'08:00 - 16:00',N'Clínica Miraflores',8,N'(01) 445-5678'),
	 (N'Lima',N'Av. Javier Prado Este 2150, San Isidro',N'San Isidro',N'sanisidro@clinicx.pe',N'Activo',NULL,NULL,NULL,N'Clínica San Isidro',10,N'(01) 512-8901'),
	 (N'Lima',N'Av. El Derby 250, Surco',N'Santiago de Surco',N'surco@clinicx.pe',N'Activo',NULL,NULL,N'08:00 - 15:00',N'Clínica Surco',6,N'(01) 634-2100');
INSERT INTO bd_clinica.dbo.servicios (descripcion,estado,nombre,precio,id_especialidad) VALUES
	 (N'Consulta médica en Medicina General',N'Activo',N'Consulta de Medicina General',50.00,1),
	 (N'Consulta médica en Pediatría',N'Activo',N'Consulta de Pediatría',50.00,2),
	 (N'Consulta médica en Ginecología',N'Activo',N'Consulta de Ginecología',50.00,3),
	 (N'Consulta médica en Cardiología',N'Activo',N'Consulta de Cardiología',50.00,4),
	 (N'Consulta médica en Neurología',N'Activo',N'Consulta de Neurología',50.00,5),
	 (N'Consulta médica en Traumatología',N'Activo',N'Consulta de Traumatología',50.00,6),
	 (N'Consulta médica en Dermatología',N'Activo',N'Consulta de Dermatología',50.00,7),
	 (N'Consulta médica en Oftalmología',N'Activo',N'Consulta de Oftalmología',50.00,8),
	 (N'Consulta médica en Endocrinología',N'Activo',N'Consulta de Endocrinología',50.00,9),
	 (N'Consulta médica en Otorrinolaringología',N'Activo',N'Consulta de Otorrinolaringología',50.00,10);
INSERT INTO bd_clinica.dbo.servicios (descripcion,estado,nombre,precio,id_especialidad) VALUES
	 (N'Consulta médica en Urología',N'Activo',N'Consulta de Urología',50.00,11),
	 (N'Consulta médica en Neumología',N'Activo',N'Consulta de Neumología',50.00,12),
	 (N'Consulta médica en Reumatología',N'Activo',N'Consulta de Reumatología',50.00,13),
	 (N'Consulta médica en Gastroenterología',N'Activo',N'Consulta de Gastroenterología',50.00,14),
	 (N'Consulta médica en Oncología',N'Activo',N'Consulta de Oncología',50.00,15);
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'rhommelerwin@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-13 04:06:39.9666667',1,N'$2b$12$YbKZ1prf.ngZMd2a1vMXseN9PYZ1vYr4.slER7KRIL07hUHyVsB.m',NULL,N'75010843'),
	 (N'rhomelerwin@gmail.com',1,N'PENDIENTE','2026-07-13 00:27:24.6027107','2026-07-13 00:27:24.6027107',3,N'$2a$10$1tJKk.lWaoetgg/N0lYVruBgeH0TmSVRhPcRf/rUxD9IMFZCKD2fC',NULL,N'75010866'),
	 (N'rhomelbautista@gmail.com',1,N'PENDIENTE','2026-07-13 14:38:07.0307275','2026-07-13 14:38:07.0307275',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010877'),
	 (N'jramirez@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-13 19:45:27.3000000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010878'),
	 (N'aparedes@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-13 19:45:27.3000000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010879'),
	 (N'mtorres@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-13 19:45:27.3000000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010880'),
	 (N'lherrera@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-13 19:45:27.3000000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010881'),
	 (N'cespinoza@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-13 19:45:27.3000000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010882'),
	 (N'mflores@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-13 19:47:29.7900000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010883'),
	 (N'rvargas@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-13 19:47:29.7900000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010884');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'csalas@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-13 19:47:29.7900000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010885'),
	 (N'pgutierrez@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-13 19:47:29.7900000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010886'),
	 (N'dmedina@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-13 19:47:29.7900000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010887'),
	 (N'jrojas@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-13 19:47:29.7900000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010888'),
	 (N'ncastillo@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-13 19:47:29.7900000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010889'),
	 (N'lquispe@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-13 19:47:29.7900000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010890'),
	 (N'asanchez@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-13 19:47:29.7900000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010891'),
	 (N'fcabrera@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-13 19:47:29.7900000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010892'),
	 (N'avaldivia@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:06:01.5800000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010893'),
	 (N'pmendoza@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:06:01.5800000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010894');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'jguzman@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:06:01.5800000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010895'),
	 (N'rcampos@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:06:01.5800000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010896'),
	 (N'mbenites@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:06:01.5800000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010897'),
	 (N'caguilar@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:06:01.5800000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010898'),
	 (N'fvillanueva@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:06:01.5800000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010899'),
	 (N'slopez@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:06:01.5800000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010900'),
	 (N'drodriguez@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:06:01.5800000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010901'),
	 (N'lgarcia@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:06:01.5800000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010902'),
	 (N'eparedes@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:06:01.5800000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010903'),
	 (N'hvargas@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:06:01.5800000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010904');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'jespinoza@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:06:01.5800000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010905'),
	 (N'amarquez@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:06:01.5800000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010906'),
	 (N'tcastro@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:06:01.5800000',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010907'),
	 (N'rrios@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:20:20.5433333',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010908'),
	 (N'imorales@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:20:20.5433333',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010909'),
	 (N'agomez@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:20:20.5433333',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010910'),
	 (N'mruiz@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:20:20.5433333',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010911'),
	 (N'dflores@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:20:20.5433333',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010912'),
	 (N'pcampos@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:20:20.5433333',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010913'),
	 (N'svega@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:20:20.5433333',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010914');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'cgutierrez@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:20:20.5433333',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010915'),
	 (N'vsalazar@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:20:20.5433333',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010916'),
	 (N'egarcia@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:20:20.5433333',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010917'),
	 (N'lramirez@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:20:20.5433333',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010918'),
	 (N'mcastillo@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:20:20.5433333',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010919'),
	 (N'jnavarro@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:20:20.5433333',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010920'),
	 (N'fortiz@clinicx.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 03:20:20.5433333',2,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010921'),
	 (N'ana.diaz0@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.3466667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010922'),
	 (N'fernando.ramirez1@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.3933333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010923'),
	 (N'natalia.salazar2@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.4000000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010924');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'diego.quispe3@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.4066667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010925'),
	 (N'andrea.perez4@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.4200000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010926'),
	 (N'arturo.garcia5@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.4266667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010927'),
	 (N'patricia.castillo6@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.4333333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010928'),
	 (N'sergio.leon7@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.4400000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010929'),
	 (N'isabel.flores8@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.4466667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010930'),
	 (N'antonio.torres9@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.4533333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010931'),
	 (N'maria.torres10@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.4600000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010932'),
	 (N'david.perez11@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.4666667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010933'),
	 (N'paola.mendoza12@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.4733333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010934');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'diego.perez13@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.4800000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010935'),
	 (N'ana.castillo14@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.4900000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010936'),
	 (N'luis.rojas15@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.4966667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010937'),
	 (N'sandra.leon16@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.5066667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010938'),
	 (N'alberto.perez17@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.5200000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010939'),
	 (N'andrea.torres18@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.5300000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010940'),
	 (N'david.salazar19@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.5333333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010941'),
	 (N'patricia.mendoza20@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.5466667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010942'),
	 (N'antonio.leon21@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.5533333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010943'),
	 (N'andrea.salazar22@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.5633333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010944');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'eduardo.quispe23@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.5733333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010945'),
	 (N'claudia.perez24@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.5866667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010946'),
	 (N'jorge.garcia25@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.5966667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010947'),
	 (N'ana.vargas26@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.6033333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010948'),
	 (N'pedro.diaz27@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.6133333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010949'),
	 (N'julia.quispe28@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.6233333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010950'),
	 (N'javier.perez29@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:12:48.6333333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010951'),
	 (N'maria.perez30@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.2833333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010952'),
	 (N'diego.flores31@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.3033333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010953'),
	 (N'elena.mendoza32@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.3133333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010954');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'miguel.torres33@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.3200000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010955'),
	 (N'carmen.perez34@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.3300000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010956'),
	 (N'david.rojas35@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.3400000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010957'),
	 (N'elena.ruiz36@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.3600000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010958'),
	 (N'jorge.ramirez37@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.3833333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010959'),
	 (N'elena.ruiz38@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.4033333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010960'),
	 (N'sergio.vargas39@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.4166667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010961'),
	 (N'patricia.perez40@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.4266667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010962'),
	 (N'sergio.vargas41@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.4333333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010963'),
	 (N'paola.leon42@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.4400000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010964');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'luis.rojas43@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.4466667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010965'),
	 (N'sandra.torres44@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.4566667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010966'),
	 (N'luis.flores45@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.4633333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010967'),
	 (N'maria.quispe46@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.4700000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010968'),
	 (N'jorge.vargas47@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.4766667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010969'),
	 (N'isabel.leon48@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.4833333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010970'),
	 (N'antonio.ruiz49@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.4900000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010971'),
	 (N'ana.mendoza50@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.4933333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010972'),
	 (N'roberto.torres51@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.5000000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010973'),
	 (N'ana.perez52@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.5133333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010974');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'javier.castillo53@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.5200000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010975'),
	 (N'carolina.castillo54@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.5300000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010976'),
	 (N'carlos.torres55@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.5466667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010977'),
	 (N'elena.salazar56@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.5633333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010978'),
	 (N'arturo.diaz57@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.5733333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010979'),
	 (N'teresa.salazar58@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.5866667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010980'),
	 (N'antonio.rojas59@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:14:24.5966667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010981'),
	 (N'paola.leon60@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.3366667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010982'),
	 (N'sergio.ramirez61@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.3466667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010983'),
	 (N'claudia.romero62@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.3566667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010984');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'antonio.ruiz63@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.3633333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010985'),
	 (N'carmen.ramirez64@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.3700000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010986'),
	 (N'arturo.romero65@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.3800000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010987'),
	 (N'paola.perez66@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.3866667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010988'),
	 (N'fernando.leon67@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.3933333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010989'),
	 (N'patricia.torres68@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.4000000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010990'),
	 (N'luis.diaz69@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.4066667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010991'),
	 (N'isabel.leon70@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.4100000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010992'),
	 (N'miguel.rojas71@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.4133333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010993'),
	 (N'maria.mendoza72@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.4200000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010994');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'pedro.leon73@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.4266667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010995'),
	 (N'lucia.vargas74@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.4300000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010996'),
	 (N'alberto.ramirez75@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.4366667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010997'),
	 (N'isabel.campos76@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.4466667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010998'),
	 (N'roberto.garcia77@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.4566667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75010999'),
	 (N'maria.rojas78@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.4633333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011000'),
	 (N'diego.campos79@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.4733333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011001'),
	 (N'andrea.ramirez80@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.4866667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011002'),
	 (N'pedro.garcia81@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.5033333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011003'),
	 (N'claudia.mendoza82@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.5133333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011004');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'arturo.salazar83@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.5233333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011005'),
	 (N'maria.ramirez84@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.5333333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011006'),
	 (N'pedro.garcia85@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.5400000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011007'),
	 (N'natalia.vargas86@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.5466667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011008'),
	 (N'javier.romero87@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.5566667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011009'),
	 (N'carolina.rojas88@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.5666667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011010'),
	 (N'arturo.ramirez89@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:15:30.5733333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011011'),
	 (N'andrea.campos90@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.0700000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011012'),
	 (N'alberto.vargas91@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.0833333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011013'),
	 (N'paola.rojas92@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.0933333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011014');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'luis.vargas93@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.1033333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011015'),
	 (N'natalia.diaz94@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.1100000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011016'),
	 (N'fernando.ramirez95@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.1166667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011017'),
	 (N'patricia.perez96@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.1233333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011018'),
	 (N'antonio.rojas97@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.1300000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011019'),
	 (N'carmen.ruiz98@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.1366667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011020'),
	 (N'antonio.salazar99@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.1433333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011021'),
	 (N'carmen.leon100@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.1466667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011022'),
	 (N'david.quispe101@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.1533333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011023'),
	 (N'carmen.ramirez102@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.1566667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011024');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'carlos.campos103@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.1600000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011025'),
	 (N'andrea.flores104@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.1700000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011026'),
	 (N'alberto.diaz105@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.1733333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011027'),
	 (N'ana.garcia106@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.1800000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011028'),
	 (N'miguel.campos107@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.1866667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011029'),
	 (N'carolina.vargas108@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.1900000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011030'),
	 (N'fernando.rojas109@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.1933333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011031'),
	 (N'natalia.flores110@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.2000000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011032'),
	 (N'sergio.rojas111@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.2066667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011033'),
	 (N'maria.castillo112@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.2133333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011034');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'jorge.salazar113@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.2200000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011035'),
	 (N'lucia.castillo114@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.2266667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011036'),
	 (N'alberto.salazar115@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.2300000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011037'),
	 (N'natalia.flores116@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.2400000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011038'),
	 (N'alberto.ramirez117@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.2466667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011039'),
	 (N'ana.flores118@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.2533333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011040'),
	 (N'arturo.torres119@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:17:45.2600000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011041'),
	 (N'carmen.quispe120@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.0900000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011042'),
	 (N'diego.vargas121@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.1000000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011043'),
	 (N'lucia.salazar122@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.1066667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011044');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'luis.perez123@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.1133333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011045'),
	 (N'maria.torres124@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.1200000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011046'),
	 (N'sergio.quispe125@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.1266667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011047'),
	 (N'natalia.torres126@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.1366667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011048'),
	 (N'miguel.rojas127@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.1433333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011049'),
	 (N'carolina.vargas128@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.1533333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011050'),
	 (N'luis.quispe129@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.1633333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011051'),
	 (N'paola.leon130@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.1700000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011052'),
	 (N'fernando.castillo131@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.1733333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011053'),
	 (N'carolina.flores132@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.1766667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011054');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'luis.campos133@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.1800000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011055'),
	 (N'maria.castillo134@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.1866667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011056'),
	 (N'eduardo.campos135@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.1900000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011057'),
	 (N'lucia.campos136@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.1933333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011058'),
	 (N'sergio.salazar137@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.2000000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011059'),
	 (N'elena.garcia138@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.2033333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011060'),
	 (N'roberto.castillo139@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.2066667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011061'),
	 (N'carmen.campos140@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.2100000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011062'),
	 (N'arturo.garcia141@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.2166667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011063'),
	 (N'claudia.castillo142@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.2200000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011064');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'miguel.flores143@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.2266667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011065'),
	 (N'carmen.diaz144@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.2333333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011066'),
	 (N'carlos.quispe145@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.2433333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011067'),
	 (N'paola.salazar146@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.2500000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011068'),
	 (N'roberto.quispe147@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.2566667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011069'),
	 (N'julia.mendoza148@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.2600000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011070'),
	 (N'fernando.vargas149@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:20:10.2633333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011071'),
	 (N'natalia.rojas150@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.4633333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011072'),
	 (N'arturo.garcia151@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.4733333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011073'),
	 (N'andrea.torres152@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.4833333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011074');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'luis.rojas153@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.4900000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011075'),
	 (N'ana.campos154@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.4966667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011076'),
	 (N'diego.flores155@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.5033333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011077'),
	 (N'maria.flores156@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.5100000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011078'),
	 (N'carlos.torres157@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.5166667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011079'),
	 (N'isabel.mendoza158@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.5233333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011080'),
	 (N'carlos.leon159@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.5300000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011081'),
	 (N'isabel.romero160@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.5400000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011082'),
	 (N'jorge.flores161@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.5433333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011083'),
	 (N'lucia.castillo162@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.5466667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011084');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'antonio.quispe163@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.5533333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011085'),
	 (N'paola.diaz164@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.5600000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011086'),
	 (N'miguel.mendoza165@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.5700000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011087'),
	 (N'carolina.torres166@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.5733333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011088'),
	 (N'antonio.quispe167@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.5833333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011089'),
	 (N'lucia.quispe168@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.5900000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011090'),
	 (N'roberto.ramirez169@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.5933333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011091'),
	 (N'maria.leon170@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.6000000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011092'),
	 (N'david.perez171@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.6066667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011093'),
	 (N'patricia.garcia172@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.6100000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011094');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'miguel.campos173@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.6166667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011095'),
	 (N'sandra.garcia174@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.6233333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011096'),
	 (N'javier.leon175@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.6300000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011097'),
	 (N'julia.ruiz176@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.6333333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011098'),
	 (N'carlos.garcia177@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.6400000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011099'),
	 (N'patricia.diaz178@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.6466667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011100'),
	 (N'sergio.vargas179@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:21:21.6533333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011101'),
	 (N'patricia.leon180@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.1966667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011102'),
	 (N'eduardo.salazar181@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.2066667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011103'),
	 (N'patricia.leon182@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.2166667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011104');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'arturo.mendoza183@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.2233333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011105'),
	 (N'lucia.vargas184@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.2300000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011106'),
	 (N'miguel.quispe185@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.2400000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011107'),
	 (N'claudia.rojas186@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.2466667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011108'),
	 (N'arturo.perez187@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.2500000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011109'),
	 (N'paola.leon188@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.2566667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011110'),
	 (N'fernando.torres189@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.2633333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011111'),
	 (N'andrea.flores190@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.2733333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011112'),
	 (N'miguel.salazar191@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.2800000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011113'),
	 (N'patricia.castillo192@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.2866667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011114');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'miguel.salazar193@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.2933333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011115'),
	 (N'teresa.garcia194@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.3000000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011116'),
	 (N'roberto.romero195@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.3066667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011117'),
	 (N'paola.torres196@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.3166667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011118'),
	 (N'arturo.quispe197@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.3233333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011119'),
	 (N'claudia.garcia198@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.3333333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011120'),
	 (N'antonio.quispe199@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.3400000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011121'),
	 (N'isabel.ramirez200@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.3500000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011122'),
	 (N'luis.salazar201@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.3566667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011123'),
	 (N'carolina.leon202@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.3633333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011124');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'fernando.salazar203@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.3700000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011125'),
	 (N'andrea.flores204@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.3766667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011126'),
	 (N'jorge.vargas205@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.3866667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011127'),
	 (N'maria.ruiz206@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.3933333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011128'),
	 (N'roberto.ramirez207@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.4033333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011129'),
	 (N'patricia.mendoza208@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.4100000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011130'),
	 (N'david.rojas209@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:22:23.4133333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011131'),
	 (N'patricia.ramirez210@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.6200000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011132'),
	 (N'fernando.salazar211@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.6300000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011133'),
	 (N'julia.salazar212@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.6400000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011134');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'fernando.campos213@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.6533333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011135'),
	 (N'lucia.torres214@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.6600000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011136'),
	 (N'luis.garcia215@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.6700000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011137'),
	 (N'lucia.mendoza216@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.6733333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011138'),
	 (N'diego.vargas217@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.6800000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011139'),
	 (N'claudia.flores218@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.6833333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011140'),
	 (N'luis.mendoza219@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.6900000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011141'),
	 (N'teresa.quispe220@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.6933333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011142'),
	 (N'diego.flores221@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.7033333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011143'),
	 (N'lucia.romero222@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.7100000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011144');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'jorge.torres223@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.7133333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011145'),
	 (N'andrea.torres224@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.7200000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011146'),
	 (N'luis.salazar225@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.7233333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011147'),
	 (N'patricia.torres226@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.7300000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011148'),
	 (N'arturo.castillo227@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.7366667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011149'),
	 (N'andrea.ramirez228@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.7533333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011150'),
	 (N'diego.castillo229@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.7633333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011151'),
	 (N'claudia.rojas230@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.7733333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011152'),
	 (N'roberto.vargas231@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.7800000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011153'),
	 (N'patricia.torres232@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.7900000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011154');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'roberto.salazar233@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.7966667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011155'),
	 (N'sandra.salazar234@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.8033333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011156'),
	 (N'sergio.campos235@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.8166667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011157'),
	 (N'carolina.perez236@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.8233333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011158'),
	 (N'diego.torres237@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.8333333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011159'),
	 (N'paola.torres238@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.8400000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011160'),
	 (N'pedro.ruiz239@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:23:06.8466667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011161'),
	 (N'isabel.castillo240@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.7233333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011162'),
	 (N'luis.ramirez241@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.7366667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011163'),
	 (N'lucia.garcia242@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.7433333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011164');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'antonio.torres243@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.7533333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011165'),
	 (N'maria.flores244@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.7600000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011166'),
	 (N'luis.vargas245@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.7700000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011167'),
	 (N'sandra.flores246@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.7733333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011168'),
	 (N'roberto.ruiz247@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.7800000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011169'),
	 (N'patricia.mendoza248@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.7866667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011170'),
	 (N'pedro.torres249@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.7966667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011171'),
	 (N'claudia.rojas250@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.8033333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011172'),
	 (N'eduardo.diaz251@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.8100000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011173'),
	 (N'carolina.perez252@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.8133333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011174');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'jorge.diaz253@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.8200000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011175'),
	 (N'paola.perez254@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.8233333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011176'),
	 (N'carlos.diaz255@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.8300000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011177'),
	 (N'isabel.castillo256@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.8366667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011178'),
	 (N'javier.castillo257@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.8400000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011179'),
	 (N'maria.ruiz258@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.8466667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011180'),
	 (N'jorge.rojas259@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.8533333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011181'),
	 (N'maria.perez260@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.8600000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011182'),
	 (N'luis.garcia261@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.8633333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011183'),
	 (N'sandra.diaz262@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.8700000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011184');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'arturo.vargas263@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.8733333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011185'),
	 (N'julia.romero264@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.8833333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011186'),
	 (N'javier.vargas265@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.8866667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011187'),
	 (N'claudia.garcia266@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.8933333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011188'),
	 (N'javier.castillo267@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.9000000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011189'),
	 (N'teresa.torres268@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.9033333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011190'),
	 (N'miguel.salazar269@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:24:25.9100000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011191'),
	 (N'julia.mendoza270@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.0666667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011192'),
	 (N'arturo.torres271@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.0766667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011193'),
	 (N'patricia.ruiz272@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.0833333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011194');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'fernando.romero273@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.0933333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011195'),
	 (N'lucia.castillo274@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.1066667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011196'),
	 (N'roberto.ruiz275@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.1133333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011197'),
	 (N'elena.ruiz276@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.1200000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011198'),
	 (N'carlos.torres277@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.1300000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011199'),
	 (N'natalia.diaz278@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.1333333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011200'),
	 (N'jorge.mendoza279@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.1400000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011201'),
	 (N'patricia.diaz280@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.1500000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011202'),
	 (N'javier.garcia281@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.1533333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011203'),
	 (N'sandra.castillo282@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.1600000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011204');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'arturo.castillo283@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.1666667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011205'),
	 (N'isabel.castillo284@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.1700000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011206'),
	 (N'arturo.vargas285@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.1766667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011207'),
	 (N'patricia.leon286@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.1800000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011208'),
	 (N'carlos.flores287@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.1866667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011209'),
	 (N'patricia.diaz288@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.1933333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011210'),
	 (N'pedro.romero289@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.1966667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011211'),
	 (N'isabel.quispe290@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.2100000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011212'),
	 (N'david.flores291@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.2133333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011213'),
	 (N'carmen.campos292@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.2200000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011214');
INSERT INTO bd_clinica.dbo.usuarios (email,estado,estado_registro,fecha_actualizacion,fecha_creacion,id_rol,password,ultimo_acceso,username) VALUES
	 (N'arturo.diaz293@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.2300000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011215'),
	 (N'elena.perez294@icloud.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.2333333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011216'),
	 (N'arturo.mendoza295@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.2400000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011217'),
	 (N'ana.diaz296@hotmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.2466667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011218'),
	 (N'eduardo.garcia297@outlook.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.2533333',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011219'),
	 (N'sandra.quispe298@gmail.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.2600000',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011220'),
	 (N'sergio.mendoza299@yahoo.com',1,N'VALIDADO_CLINICA',NULL,'2026-07-15 05:25:31.2666667',3,N'$2a$10$Uu8VYe0SykjOCh9hPCraCeHUtfV5VCsbZ/n.717FWVmHnFc0f/CsS',NULL,N'75011221'),
	 (N'fuzobit7615@raxel.me',1,N'PENDIENTE','2026-07-16 14:57:40.6766354','2026-07-16 14:57:40.6766354',3,N'$2a$10$d66oQ878IWD3iQqwCYotweR79vDd1/7fe7rDdSRV2ZSZy4oSLybDm',NULL,N'40713054'),
	 (N'jiriweb7501@molix.tech',1,N'PENDIENTE','2026-07-17 00:48:26.2791988','2026-07-17 00:48:26.2774387',3,N'$2a$10$o4qd9fOjvF6vkBfHojB5g.UCtKquCTYSnVwZ0xYlG7fQGAphMkU8.',NULL,N'40723654');
