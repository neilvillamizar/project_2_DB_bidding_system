--$1 : CLAVE SUBASTA
CREATE OR REPLACE PROCEDURE UndoLastBid(int) AS
$$
DECLARE
idBid int;
new_max_bid int;
sub_exist int;
BEGIN
	SELECT * INTO sub_exist FROM SUBASTA WHERE SUBASTA.id_sub = $1;
	IF NOT FOUND THEN
		RAISE EXCEPTION 'Esta Subasta no existe';
	END IF;	
	SELECT BID.id_bid INTO idBid FROM BID INNER JOIN SUBASTA ON BID.id_sub = $1
	WHERE monto_bid = (SELECT max(monto_bid) FROM BID INNER JOIN SUBASTA ON BID.id_sub = $1);
	DELETE FROM BID WHERE BID.id_bid = idBid;
	SELECT MAX(monto_bid) INTO new_max_bid FROM BID INNER JOIN SUBASTA ON BID.id_sub = $1;
	IF new_max_bid IS NULL THEN
		UPDATE SUBASTA SET precio_actual = precio_inicial WHERE SUBASTA.id_sub = $1;
		
	ELSE
		UPDATE SUBASTA SET precio_actual = new_max_bid WHERE SUBASTA.id_sub = $1;
	END IF;	
	
END
$$
LANGUAGE plpgsql