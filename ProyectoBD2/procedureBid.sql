-- $1 : CLAVE DE USUARIO
-- $2 : CLAVE DE SUBASTA
-- $3 : MONTO OFRECIDO
-- $4 : FECHA DE LA PUJA
CREATE OR REPLACE PROCEDURE BID(int, int,decimal,date) as
$$
DECLARE
precio_actual int;
precio_min int;
userid int;
subastaid int;
BEGIN
	SELECT SUBASTA.precio_actual INTO precio_actual FROM SUBASTA WHERE id_sub = $2;
	SELECT min_bid_monto INTO precio_min FROM SUBASTA WHERE id_sub = $2;
	SELECT * INTO userid FROM USUARIO WHERE id_usr = $1;
	IF NOT FOUND THEN
		RAISE EXCEPTION 'Solo los usuarios registrados pueden participar en subastas';
	END IF;
	SELECT * INTO subastaid FROM SUBASTA WHERE id_sub = $2;
	IF NOT FOUND THEN
		RAISE EXCEPTION 'La subasta no existe';
	END IF;		
	IF $3-precio_min < precio_actual THEN
		RAISE EXCEPTION 'El monto ofrecido debe ser mayor o igual a %',precio_actual + precio_min;	
	ELSEIF $3-precio_min >= precio_actual THEN
		INSERT INTO BID(id_usr,id_sub,monto_bid,fecha_bid)
		values ($1,$2,$3,$4);
		UPDATE subasta SET precio_actual = $3 WHERE subasta.id_sub = $2; 
	END IF;
END;
$$
LANGUAGE plpgsql