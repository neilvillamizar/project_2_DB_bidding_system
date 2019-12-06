CREATE OR REPLACE PROCEDURE BID(int, int,decimal,date) as
$$
DECLARE
precio_actual int;
precio_min int;
BEGIN
	SELECT SUBASTA.precio_actual INTO precio_actual FROM SUBASTA WHERE id_sub = $2;
	SELECT min_bid_monto INTO precio_min FROM SUBASTA WHERE id_sub = $2;
	IF $3-precio_min < precio_actual THEN
		RAISE EXCEPTION 'El monto ofrecido debe ser mayor o igual a %',precio_actual + precio_min;	
	ELSEIF $3-precio_min >= precio_actual THEN
		INSERT INTO BID(id_usr,id_sub,monto_bid,fecha_bid)
		values ($1,$2,$3,$4);
		UPDATE subasta SET precio_actual = $3; 
	END IF;
END;
$$
LANGUAGE plpgsql