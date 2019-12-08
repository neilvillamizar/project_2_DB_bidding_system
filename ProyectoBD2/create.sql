CREATE TABLE USUARIO (
	id_usr SERIAL PRIMARY KEY,
	nombre_usr varchar(25) NOT NULL,
	apellido varchar(25) NOT NULL
);

CREATE TABLE PRODUCTO (
	id_prod SERIAL PRIMARY KEY,
	nombre_prod		varchar(100) NOT NULL,
	descripcion		varchar(500),
	especificaciones	varchar(500)
);

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

CREATE DOMAIN tipo_t varchar(15) check (value in('Debito','Credito'));
CREATE TABLE METODO_PAGO (
	id_met_pag SERIAL PRIMARY KEY,
	id_usr int REFERENCES USUARIO NOT NULL,
	tipo_tarjeta tipo_t NOT NULL,
	nro_tarjeta int NOT NULL
);

CREATE TABLE BID (
	id_bid SERIAL PRIMARY KEY,
	id_usr int REFERENCES USUARIO(id_usr) NOT NULL,
	id_sub int REFERENCES SUBASTA(id_sub) NOT NULL,
	monto_bid	decimal NOT NULL,
	fecha_bid	timestamp DEFAULT NOW()::timestamp
);

CREATE TABLE CATEGORIA (
	id_cat SERIAL PRIMARY KEY, 
	nombre_cat  varchar(25) NOT NULL,
	child int REFERENCES CATEGORIA(id_cat),
	next_brother int REFERENCES CATEGORIA(id_cat),
	parent int REFERENCES CATEGORIA(id_cat)
);

CREATE TABLE PERTENECE (
	id_cat int REFERENCES CATEGORIA(id_cat) NOT NULL,
	id_prod int REFERENCES PRODUCTO(id_prod) NOT NULL,
	PRIMARY KEY (id_cat, id_prod)
);

