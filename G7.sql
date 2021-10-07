drop schema if exists G7;
create database G7;

-- Estructura de tabla para la tabla `usuario`
use G7;

CREATE TABLE usuario 
( id INT PRIMARY KEY auto_increment,
    nombre varchar(50),
    apellido varchar(50),
	usuario varchar(50) unique,
	contrasenia varchar (40),
    email varchar(100) not null,
 	estado boolean,
 	codigo smallint
);

INSERT into usuario(nombre, apellido, usuario, contrasenia , email, estado)
values('admin', 'admin','admin', '21232f297a57a5a743894a0e4a801fc3', 'admin@g7.com', true),
	('supervisor', 'supervisor','supervisor', '09348c20a019be0318387c08df7a783d', 'supervisor@g7.com', true),
	('mecanico', 'mecanico','mecanico', '9afb05161c835f1059a1e30b52fe40bf', 'mecanico@g7.com', true),
	('chofer', 'chofer','chofer', '85b164d9c8eb210ae8a1a4679275b26a', 'chofer@g7.com', true),
    ('facundo', 'marin','facundo', '242ac92bff7cc0bf1f52de2f254b27a8', 'facundo@g7.com', true);
    
CREATE TABLE rol(
id tinyint primary key,
rol varchar(50)
);
INSERT INTO rol(id,rol) 
VALUE(1,"Administrativo"),
	 (2,"Supervisor"),
	 (3,"Mecanico"),
     (4,"Chofer"),
     (5,"sinRol");

CREATE TABLE empleado
(legajo tinyint primary key auto_increment,
dni int(15),
fecha_nacimiento datetime,
usuario_id int,
id_rol tinyint,
foreign key(id_rol) references rol(id) ON UPDATE CASCADE ON DELETE CASCADE ,
foreign key(usuario_id) references usuario(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT into empleado(dni, fecha_nacimiento, usuario_id,id_rol)
values(25634786,'20160104', 1,1),
      (17601423,'20080512', 2,2),
      (30345123,'20171020', 3,3),
      (23053567,'20160307', 4,4),
      (38670221,'19940813', 5,4);


CREATE TABLE administrador
	(id tinyint primary key auto_increment,
	legajo tinyint,
    id_rol tinyint,
    foreign key(id_rol) references rol(id) ON UPDATE CASCADE ON DELETE CASCADE ,
	foreign key(legajo) references empleado(legajo) ON UPDATE CASCADE ON DELETE CASCADE 
	);

INSERT into administrador(legajo,id_rol)
values(001,1); 

CREATE TABLE supervisor
	(id tinyint primary key auto_increment,
	legajo tinyint,
    id_rol tinyint,
    foreign key(id_rol) references rol(id) ON UPDATE CASCADE ON DELETE CASCADE ,
	foreign key(legajo) references empleado(legajo) ON UPDATE CASCADE ON DELETE CASCADE 
	);

INSERT into supervisor(legajo,id_rol)
	values(002,2);

CREATE TABLE chofer
(id tinyint primary key auto_increment,
	tipo_licencia varchar(10),
	legajo tinyint,
    id_rol tinyint,
    foreign key(id_rol) references rol(id) ON UPDATE CASCADE ON DELETE CASCADE ,
	foreign key(legajo) references empleado(legajo) ON UPDATE CASCADE ON DELETE CASCADE , 
	patente varchar(10),
    estado enum('DISPONIBLE', 'EN_VIAJE')
	);

INSERT into chofer(tipo_licencia, legajo, patente,id_rol)
	values('A', 004, 'amh628',4),
          ('A', 005, 'FAC123',4);

CREATE TABLE mecanico
	(id tinyint primary key auto_increment,
	legajo tinyint,
    id_rol tinyint,
    foreign key(id_rol) references rol(id) ON UPDATE CASCADE ON DELETE CASCADE ,
	foreign key(legajo) references empleado(legajo) ON UPDATE CASCADE ON DELETE CASCADE 
	);

INSERT into mecanico(legajo,id_rol)
	values(003,3);

CREATE TABLE camiones
(
    id tinyint primary key auto_increment,
    patente varchar(7) not null unique,
    marca varchar(15),
    modelo varchar(15),
    nro_motor int(15) unique,
    nro_chasis varchar(15) unique,
    kilometraje int(15),
    ultimo_service datetime
);

INSERT into camiones(marca, modelo, patente, nro_motor, nro_chasis, kilometraje, ultimo_service)
values('IVECO', 'Cursor', 'AA123CD', 53879558, 'L53879558', 10000, '2021-01-01'),
      ('IVECO','Cursor','AA124DC', 69904367,'R69904367', 10000, '2021-01-01'),
      ('IVECO','Cursor','AD200XS',	57193968,'R57193968', 10000, '2021-01-01'),
      ('IVECO','Cursor','AA211ZX',	82836641,'N82836641', 10000, '2021-01-01'),
      ('IVECO','Cursor','AC452WE',	28204636,'R28204636', 10000, '2021-01-01'),
      ('IVECO','Cursor','AA233SS',	26139668,'K26139668', 10000, '2021-01-01'),
      ('IVECO','Cursor','AB900QW',	44301415,'F44301415', 10000, '2021-01-01'),
      ('IVECO','Cursor','AC342WW',	44260023,'D44260023', 10000, '2021-01-01'),

      ('SCANIA','G310','AA150QW',	82039512,'I82039512', 10000, '2021-01-01'),
      ('SCANIA','G410','AB198QZ',	18389741,'V18389741', 10000, '2021-01-01'),
      ('SCANIA','G460','AC246QD',	62500687,'O62500687', 10000, '2021-01-01'),
      ('SCANIA','G310','AD294QW',	27510702,'T27510702', 10000, '2021-01-01'),
      ('SCANIA','G410','AA342QZ',	72582865,'C72582865', 10000, '2021-01-01'),
      ('SCANIA','G460','AB390QD',	32041290,'Z32041290', 10000, '2021-01-01'),
      ('SCANIA','G310','AC438QW',	54712451,'W54712451', 10000, '2021-01-01'),
      ('SCANIA','G410','AD486QZ',   56284263,'L56284263', 10000, '2021-01-01'),
      ('SCANIA','G460','AA534QD',	21357689,'A21357689', 10000, '2021-01-01'),

      ('M.BENZ','Actros 1846','AB582QW',17800122,'V17800122', 10000, '2021-01-01'),
      ('M.BENZ','Actros 1846','AC630QZ',88648319,'G88648319', 10000, '2021-01-01'),
      ('M.BENZ','Actros 1846','AD678QD',23849041,'C23849041', 10000, '2021-01-01'),
      ('M.BENZ','Actros 1846','AA726QW',54650513,'C54650513', 10000, '2021-01-01'),
      ('M.BENZ','Actros 1846','AB774QZ',46753468,'J46753468', 10000, '2021-01-01'),
      ('M.BENZ','Actros 1846','AC822QD',60916748,'J60916748', 10000, '2021-01-01'),
      ('M.BENZ','Actros 1846','AD870QW',30207594,'M30207594', 10000, '2021-01-01'),
      ('M.BENZ','Actros 1846','AA918QZ',31256965,'C31256965', 10000, '2021-01-01'),
      ('M.BENZ','Actros 1846','AB966QD',32632699,'B32632699', 10000, '2021-01-01'),
      ('M.BENZ','Actros 1846','AC989QW',64092078,'F64092078', 10000, '2021-01-01');

CREATE TABLE arrastrador
(id tinyint primary key auto_increment,
 nro_chasis int(15) unique,
 tipo varchar(150),
 patente varchar(7) not null unique
);

INSERT into arrastrador( tipo, patente, nro_chasis)
values('Araña','AA100AS',585822),
      ('Araña','AC125AD',605737),
      ('Araña','AB135AG',705687),
      ('Araña','AD166AS',815082),
      ('Araña','AA189AD',775167),
      ('Araña','AC208AG',642287),
      ('Araña','AB230AS',678666),
      ('Araña','AD252AD',758967),
      ('Araña','AA274AG',498515),

      ('Jaula','AC296AS',882174),
      ('Jaula','AB318AD',595287),
      ('Jaula','AD340AG',549916),
      ('Jaula','AA362AS',831768),
      ('Jaula','AC383AD',535330),

      ('Tanque','AB405AG',583419),
      ('Tanque','AD427AS',703673),
      ('Tanque','AA449AD',884654),
      ('Tanque','AC471AG',510019),
      ('Tanque','AB493AS',595948),
      ('Tanque','AD515AD',704640),
      ('Tanque','AA537AG',752105),

      ('Granel','AB581AD',761560),
      ('Granel','AD602AG',555608),
      ('Granel','AA624AS',852157),
      ('Granel','AC646AD',710797),
      ('Granel','AB668AG',815072),
      ('Granel','AD690AS',495851),
      ('Granel','AA712AD',468708),
      ('Granel','AC734AG',661897),
      ('Granel','AB756AS',616372),
      ('Granel','AD778AD',873758),
      ('Granel','AA800AG',820810),

      ('CarCarrier','AD100AZ',730027),
      ('CarCarrier','AD100AQ',730502),
      ('CarCarrier','AD100ER',730978),
      ('CarCarrier','AD101EF',731453),
      ('CarCarrier','AD102HG',731929),
      ('CarCarrier','AD103LO',732404),
      ('CarCarrier','AD104WE',732880),
      ('CarCarrier','AD105ZP',733355);

CREATE TABLE viaje
	(id tinyint primary key auto_increment,
	origen varchar(100),
	destino varchar(100),
	fecha_carga datetime,
	estado enum('PENDIENTE', 'ACTIVO', 'FINALIZADO'),
	id_supervisor tinyint,
    fecha_llegada_previsto datetime,
    fecha_llegada_real datetime,
    fecha_salida_previsto datetime,
    fecha_salida_real datetime,
    combustible_previsto int(10),
    combustible_real int(10),
    kilometros_real int(10),
    kilometros_previsto int(10),
    importe_combustible_real int(10),
	importe_combustible_previsto int(10),
    peajes_previsto int(10),
    peajes_real int(10),
    pesajes_previsto int(10),
    pesajes_real int(10),
    viaticos_previsto int(10),
    viaticos_real int(10),
    extras_previsto int(10),
    extras_real int(10),
    fee_previsto int(10),
    fee_real int(10),
    hazard_precio int(10),
    reefer_precio int(10),
    gasto_total int(10),
	foreign key(id_supervisor) references supervisor(id) on delete cascade on update cascade,
	id_chofer tinyint,
	foreign key(id_chofer) references chofer(id) on delete cascade on update cascade,
	id_camion tinyint,
	foreign key(id_camion) references camiones(id) on delete cascade on update cascade,
	id_arrastrador tinyint,
	foreign key(id_arrastrador) references arrastrador(id) on delete cascade on update cascade
);

CREATE TABLE costeo(
    id tinyint primary key auto_increment,
    id_viaje tinyint,
    km int,
    litros int,
    importe int,
    viatico float,
    peaje float,
    extras float,
	latitud float,
    longitud float,
    foreign key(id_viaje) references viaje(id) on update cascade on delete cascade
);

insert into viaje(origen, destino, fecha_carga, estado, id_supervisor, id_chofer, id_camion, id_arrastrador, fecha_llegada_previsto, fecha_salida_previsto, combustible_previsto, kilometros_previsto, peajes_previsto, viaticos_previsto, extras_previsto, fee_previsto, pesajes_previsto,importe_combustible_previsto)
values('Buenos Aires', 'Cordoba', '2021-07-20 19:00:00', 'PENDIENTE', 1, 1, 1, 1, '2021-07-22 20:00:00', '2021-07-20 00:20:00', 200, 1200, 2000, 4000, 1000, 4500, 19000, 25000);
insert into viaje(origen, destino, fecha_carga, estado, id_supervisor, id_chofer, id_camion, id_arrastrador, fecha_llegada_previsto, fecha_salida_previsto, combustible_previsto, kilometros_previsto, peajes_previsto, viaticos_previsto, extras_previsto, fee_previsto, pesajes_previsto, importe_combustible_previsto)
values('Cordoba', 'Buenos Aires', '2021-05-24 14:00:00', 'ACTIVO', 1, 1, 1, 1,  '2021-06-26 00:00:00', '2021-06-25 00:03:00', 120, 800, 763, 400, 600, 4000, 39000, 30000);
insert into viaje(
	origen,
    destino, 
    fecha_carga, 
    estado, 
    id_supervisor, 
    id_chofer, 
    id_camion, 
    id_arrastrador, 
    fecha_llegada_previsto, 
    fecha_salida_previsto, 
    combustible_previsto, 
    kilometros_previsto, 
    peajes_previsto, 
    viaticos_previsto, 
    extras_previsto, 
    fee_previsto, 
    pesajes_previsto, 
    pesajes_real,
	fecha_salida_real, 
    fecha_llegada_real,
    combustible_real,
    kilometros_real,
    peajes_real,
    viaticos_real,
    extras_real,
    fee_real,
    importe_combustible_real,
    importe_combustible_previsto,
    gasto_total
    )
values('Cordoba', 
	'Buenos Aires', 
	'2021-05-22 14:00:00', 
    'FINALIZADO',
    1,
    1,
    1,
    1,
    '2021-05-24 00:00:00', 
    '2021-05-23 00:03:00', 
    130, 
    850,
    1000,
    5000,
    400,
    7000,
    28000,
    29000,
    '2021-05-24 02:03:00',
    '2021-06-26 00:00:00',
    140,
    1200,
    1000,
    4001,
    7500,
    28500,
    40000,
    37500,
    177501);

CREATE TABLE carga
(id tinyint primary key auto_increment,
 tipo_carga varchar(15),
 hazard boolean,
 imo_class varchar(100),
 reefer boolean,
 temperatura int(10),
 peso_neto varchar(15),
 id_viaje tinyint,
 foreign key(id_viaje) references viaje(id) on delete cascade on update cascade
);

INSERT INTO `g7`.`carga` (`tipo_carga`, `hazard`, `imo_class`, `reefer`, `peso_neto`, `id_viaje`) VALUES ('Tanque', '0', '', '0', '20000', '1');
INSERT INTO `g7`.`carga` (`tipo_carga`, `hazard`, `imo_class`, `reefer`, `peso_neto`, `id_viaje`) VALUES ('Jaula', '0', '', '0', '30000', '2');
INSERT INTO `g7`.`carga` (`tipo_carga`, `hazard`, `reefer`, `temperatura`, `peso_neto`, `id_viaje`) VALUES ('Granel', '0', '1', '-20', '25000', '3');


CREATE TABLE cliente
(id tinyint primary key auto_increment,
nombre varchar(15),
apellido varchar(15),
telefono int(15),
cuit bigint,
direccion varchar(15),
email varchar(150) not null,
id_viaje tinyint,
foreign key(id_viaje) references viaje(id) on delete cascade on update cascade
);

INSERT INTO `g7`.`cliente` (`nombre`, `apellido`, `telefono`, `cuit`, `direccion`, `email`, `id_viaje`) VALUES ('Juan', 'Roman', '1120252411', '20365545689', 'Bv Finca 6244', 'alguienMuyGroso@gmail.com', '1');
INSERT INTO `g7`.`cliente` (`nombre`, `apellido`, `telefono`, `cuit`, `direccion`, `email`, `id_viaje`) VALUES ('Raul', 'Tijuano', '1154865852', '20458589588', 'Los Cerros 2020', 'otroMuyGroso@suEmpresa.com', '2');
INSERT INTO `g7`.`cliente` (`nombre`, `apellido`, `telefono`, `cuit`, `direccion`, `email`, `id_viaje`) VALUES ('Homero', 'Simpson', '1142565289', '20254569879', 'Calle Siempre Viva 724', 'homero@simpson.com', '3');


CREATE TABLE mantenimiento
(id tinyint primary key auto_increment,
fecha datetime,
costo int(15),
tipo enum('INTERNO', 'EXTERNO'),
repuesto_cam varchar(150),
id_camion tinyint,
foreign key(id_camion) references camiones(id) on delete cascade on update cascade,
id_mecanico tinyint,
foreign key(id_mecanico) references mecanico(id) on delete cascade on update cascade
);

INSERT INTO `g7`.`mantenimiento` (`fecha`, `costo`, `tipo`, `repuesto_cam`, `id_camion`, `id_mecanico`) VALUES ('2021-07-14 11:00:00', '20000', 'INTERNO', 'Neumatico', 4, 1);
INSERT INTO `g7`.`mantenimiento` (`fecha`, `costo`, `tipo`, `repuesto_cam`, `id_camion`, `id_mecanico`) VALUES ('2021-07-15 12:00:00', '3000', 'EXTERNO', 'Luz Optica', 10, 1);
INSERT INTO `g7`.`mantenimiento` (`fecha`, `costo`, `tipo`, `repuesto_cam`, `id_camion`, `id_mecanico`) VALUES ('2021-07-16 13:00:00', '15000', 'EXTERNO', 'Paragolpe', 20, 1);
INSERT INTO `g7`.`mantenimiento` (`fecha`, `costo`, `tipo`, `repuesto_cam`, `id_camion`, `id_mecanico`) VALUES ('2021-07-17 15:00:00', '25000', 'INTERNO', 'Neumatico', 12, 1);