-- Autors: Neil Villamizar 15-11523
--		   Marco Benitez   13-10137
--
-- Procedimiento para hacer un BID
--
-- $1 : CLAVE DE USUARIO
-- $2 : CLAVE DE SUBASTA
-- $3 : MONTO OFRECIDO
\c subastas_15_11523_13_10137

CREATE OR REPLACE PROCEDURE BID(int, int, decimal) 
AS $BID$

DECLARE
precio_actual int;  	-- guarda el precio actual de la subasta
precio_min int;			-- guarda el precio minimo de una puja (con respecto al anterior)
userid int;				-- guarda el id de usuario que hace el bid (para chequear que esta registrado)
subastaid int;			-- guarda el id de la subasta (analogo a la variable anterior)
fecha_init timestamp;	-- guarda la fecha de inicio de la subasta
fecha_end timestamp;	-- guarda la fecha de finalizacion de la subasta
ext_minutos int;		-- guarda la cantidad de minutos que se extiende la subasta en caso de extension

BEGIN

	LOCK TABLE SUBASTA; -- Lock a la tabla subasta

	-- Se asignan las variables fecha_end, fecha_init y ext_minutos
	SELECT SUBASTA.fecha_end INTO fecha_end FROM SUBASTA WHERE id_sub = $2;
	SELECT SUBASTA.fecha_init INTO fecha_init FROM SUBASTA WHERE id_sub = $2;
	SELECT SUBASTA.ext_minutos INTO ext_minutos FROM SUBASTA WHERE id_sub = $2;

	-- revisa si ya se termino la subasta
	IF (NOW()::timestamp > fecha_end) THEN
		RAISE EXCEPTION 'No puedes hacer bids a una subasta terminada';
	END IF;

	-- revisa si ya comenzo la subasta
	IF (NOW()::timestamp < fecha_init) THEN
		RAISE EXCEPTION 'No puedes hacer bids a una subasta que no ha comenzado';
	END IF;

	-- revisa si es necesario extender la subasta y si lo es, entonces la extiende
	IF (fecha_end - (ext_minutos * (INTERVAL '1 minute') ) <= NOW()::timestamp) THEN
		UPDATE subasta
		SET fecha_end = fecha_end + ext_minutos * (INTERVAL '1 minute')
		WHERE id_sub = $2;
	END IF;

	-- Se asignan las variables precio_actual, precio_min y userid
	SELECT SUBASTA.precio_actual INTO precio_actual FROM SUBASTA WHERE id_sub = $2;
	SELECT min_bid_monto INTO precio_min FROM SUBASTA WHERE id_sub = $2;
	SELECT * INTO userid FROM USUARIO WHERE id_usr = $1;
	-- se verifica que el usuario este en la base de datos
	IF NOT FOUND THEN
		RAISE EXCEPTION 'Solo los usuarios registrados pueden participar en subastas';
	END IF;
	-- se verifica que la subasta existe en la base de datos
	SELECT * INTO subastaid FROM SUBASTA WHERE id_sub = $2;
	IF NOT FOUND THEN
		RAISE EXCEPTION 'La subasta % no existe', $2;
	END IF;		
	-- Se verifica la validez del bid
	IF $3-precio_min < precio_actual THEN
		RAISE EXCEPTION 'El monto ofrecido debe ser mayor o igual a %',precio_actual + precio_min;	
	ELSEIF $3-precio_min >= precio_actual THEN
		INSERT INTO BID(id_usr, id_sub, monto_bid, fecha_bid)
		values ($1, $2, $3, NOW()::timestamp);
		UPDATE subasta SET precio_actual = $3 WHERE id_sub = $2; 
	END IF;
	
	COMMIT;
END;
$BID$ LANGUAGE plpgsql