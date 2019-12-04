
CREATE TABLE USUARIO (
	id_usr SERIAL PRIMARY KEY,
	nombre_usr varchar(25),
	apellido varchar(25),
	id_met_pag SERIAL REFERENCES METODO_PAGO(id_met_pag) 
);

CREATE TABLE SUBASTA (
	id_sub SERIAL PRIMARY KEY,
	id_usr SERIAL REFERENCES
	id_prod SERIAL REFERENCES
	precio_actual
	precio_inicial
	precio_reserva
	nro_usr_act
	fecha_init
	fecha_end
	min_bid_monto
	id_bid SERIAL REFERENCES
	end_
	id_pag SERIAL REFERENCES
);

CREATE TABLE PRODUCTO (
	id_prod SERIAL PRIMARY KEY,
	nombre_prod
	descripcion
	especificaciones
);

CREATE TABLE METODO_PAGO (
	id_met_pag SERIAL PRIMARY KEY,
	id_usr SERIAL REFERENCES
	tipo_tarjeta
	nro_tarjeta
);

CREATE TABLE PAGO (
	id_pag  SERIAL PRIMARY KEY,
	id_met_pag SERIAL REFERENCES ,
	id_bid SERIAL REFERENCES ,
	id_sub SERIAL REFERENCES ,
	monto_pag ,
	nro_referencia ,
);

CREATE TABLE BID (
	id_bid SERIAL PRIMARY KEY,
	id_usr SERIAL REFERENCES USUARIO(id_usr),
	id_sub SERIAL REFERENCES SUBASTA(id_sub),
	monto_bid ,
	fecha_bid
);

CREATE TABLE PERTENECE (
	id_cat SERIAL REFERENCES CATEGORIA(id_cat),
	id_prod SERIAL REFERENCES PRODUCTO(id_prod),
	PRIMARY KEY (id_cat, id_prod)
);

CREATE TABLE CATEGORIA (
	id_cat SERIAL PRIMARY KEY, 
	nombre_cat  varchar(25),
	child SERIAL REFERENCES CATEGORIA(id_cat),
	next_brother SERIAL REFERENCES CATEGORIA(id_cat),
	parent SERIAL REFERENCES CATEGORIA(id_cat)
);