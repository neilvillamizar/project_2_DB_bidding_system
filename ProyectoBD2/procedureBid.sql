CREATE OR REPLACE PROCEDURE BID(int, int,decimal) AS
$BID$
DECLARE
precio_actual int;
precio_min int;
userid int;
fecha_init timestamp;
fecha_end timestamp;
ext_minutos int;
BEGIN

	LOCK TABLE SUBASTA;

	SELECT SUBASTA.fecha_end INTO fecha_end FROM SUBASTA WHERE id_sub = $2;
	SELECT SUBASTA.fecha_init INTO fecha_init FROM SUBASTA WHERE id_sub = $2;
	SELECT SUBASTA.ext_minutos INTO ext_minutos FROM SUBASTA WHERE id_sub = $2;

	-- revisa si ya se termino la subasta
	IF (NOW()::timestamp > fecha_end) THEN
		RETURN;
	END IF;

	-- revisa si ya comenzo la subasta
	IF (NOW()::timestamp < fecha_init) THEN
		RETURN;
	END IF;

	-- revisa si es necesario extender la subasta y si lo es, entonces la extiende
	IF (fecha_end - (ext_minutos * (INTERVAL '1 minute') ) <= NOW()::timestamp) THEN
		UPDATE subasta
		SET fecha_end = fecha_end + ext_minutos * (INTERVAL '1 minute')
		WHERE id_sub = $2;
	END IF;

	SELECT SUBASTA.precio_actual INTO precio_actual FROM SUBASTA WHERE id_sub = $2;
	SELECT min_bid_monto INTO precio_min FROM SUBASTA WHERE id_sub = $2;
	SELECT * INTO userid FROM USUARIO WHERE id_usr = $1;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Solo los usuarios registrados pueden participar en subastas';
	END IF;	
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