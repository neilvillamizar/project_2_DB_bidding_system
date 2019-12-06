CREATE TABLE USUARIO (
	id_usr SERIAL PRIMARY KEY,
	nombre_usr varchar(25),
	apellido varchar(25)
);

CREATE TABLE PRODUCTO (
	id_prod SERIAL PRIMARY KEY,
	nombre_prod		varchar(100),
	descripcion		varchar(500),
	especificaciones	varchar(500)
);

CREATE TABLE SUBASTA (
	id_sub SERIAL PRIMARY KEY,
	id_usr int REFERENCES USUARIO,
	id_prod int REFERENCES PRODUCTO,
	precio_actual decimal,
	precio_inicial	decimal,
	precio_reserva	decimal,
	nro_usr_act		int,
	fecha_init	date,
	fecha_end	date,
	min_bid_monto	decimal
);

CREATE DOMAIN tipo_t varchar(15) check (value in('Debito','Credito'));
CREATE TABLE METODO_PAGO (
	id_met_pag SERIAL PRIMARY KEY,
	id_usr int REFERENCES USUARIO,
	tipo_tarjeta tipo_t,
	nro_tarjeta int
);

CREATE TABLE BID (
	id_bid SERIAL PRIMARY KEY,
	id_usr int REFERENCES USUARIO(id_usr),
	id_sub int REFERENCES SUBASTA(id_sub),
	monto_bid	decimal,
	fecha_bid	date	
);

CREATE TABLE CATEGORIA (
	id_cat SERIAL PRIMARY KEY, 
	nombre_cat  varchar(25),
	child int REFERENCES CATEGORIA(id_cat),
	next_brother int REFERENCES CATEGORIA(id_cat),
	parent int REFERENCES CATEGORIA(id_cat)
);

CREATE TABLE PERTENECE (
	id_cat int REFERENCES CATEGORIA(id_cat),
	id_prod int REFERENCES PRODUCTO(id_prod),
	PRIMARY KEY (id_cat, id_prod)
);

