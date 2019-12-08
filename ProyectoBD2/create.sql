-- Autors: Neil Villamizar 15-11523
--		   Marco Benitez   13-10137
--
--	Se crean las tablas de la base de datos
--

\c subastas
--
-- Se crea la tabla USUARIO
--
CREATE TABLE USUARIO (
	id_usr SERIAL PRIMARY KEY,
	nombre_usr varchar(25) NOT NULL,
	apellido varchar(25) NOT NULL
);

--
-- Se crea la tabla PRODUCTO
--
CREATE TABLE PRODUCTO (
	id_prod SERIAL PRIMARY KEY,
	nombre_prod		varchar(100) NOT NULL,
	descripcion		varchar(500),
	especificaciones	varchar(500)
);

--
-- Se crea la tabla SUBASTA
--
CREATE TABLE SUBASTA (
	id_sub SERIAL PRIMARY KEY,
	id_usr int REFERENCES USUARIO NOT NULL,
	id_prod int REFERENCES PRODUCTO NOT NULL,
	precio_actual 	decimal NOT NULL,
	precio_inicial	decimal NOT NULL,
	precio_reserva	decimal NOT NULL,
	fecha_init	timestamp DEFAULT NOW()::timestamp NOT NULL,
	fecha_end	timestamp NOT NULL CHECK( fecha_init < fecha_end ),
	min_bid_monto	decimal NOT NULL,
	ext_minutos	int DEFAULT 30
);

-- Se crea tipo de variable "tipo_t" que toma los valores 'Debito' o 'Credito'
-- para usarse en la tabla METODO_PAGO
CREATE DOMAIN tipo_t varchar(15) check (value in('Debito','Credito'));
--
-- Se crea la tabla METODO_PAGO
--
CREATE TABLE METODO_PAGO (
	id_met_pag SERIAL PRIMARY KEY,
	id_usr int REFERENCES USUARIO NOT NULL,
	tipo_tarjeta tipo_t NOT NULL,
	nro_tarjeta int NOT NULL
);

--
-- Se crea la tabla BID
--
CREATE TABLE BID (
	id_bid SERIAL PRIMARY KEY,
	id_usr int REFERENCES USUARIO(id_usr) NOT NULL,
	id_sub int REFERENCES SUBASTA(id_sub) NOT NULL,
	monto_bid	decimal NOT NULL,
	fecha_bid	timestamp DEFAULT NOW()::timestamp
);

--
-- Se crea la tabla CATEGORIA
--
CREATE TABLE CATEGORIA (
	id_cat SERIAL PRIMARY KEY, 
	nombre_cat  varchar(25) NOT NULL,
	child int REFERENCES CATEGORIA(id_cat),
	next_brother int REFERENCES CATEGORIA(id_cat),
	parent int REFERENCES CATEGORIA(id_cat)
);

--
-- Se crea la tabla PERTENECE
--
CREATE TABLE PERTENECE (
	id_cat int REFERENCES CATEGORIA(id_cat) NOT NULL,
	id_prod int REFERENCES PRODUCTO(id_prod) NOT NULL,
	PRIMARY KEY (id_cat, id_prod)
);

