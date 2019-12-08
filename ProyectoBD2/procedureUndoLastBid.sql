-- Autors: Neil Villamizar 15-11523
--		   Marco Benitez   13-10137
--
-- Procedimiento para deshacer un BID
--
--$1 : CLAVE SUBASTA
\c subastas

CREATE OR REPLACE PROCEDURE UndoLastBid(int) AS
$$
DECLARE
idBid int;			-- id del bid
new_max_bid int;	--nuevo maximo bid
sub_exist int;		-- id subasta
BEGIN
	
	-- se verifica si la subasta existe en la base de datos
	SELECT * INTO sub_exist FROM SUBASTA WHERE SUBASTA.id_sub = $1;
	IF NOT FOUND THEN
		RAISE EXCEPTION 'Esta Subasta no existe';
	END IF;	
	LOCK BID;
	LOCK SUBASTA;
	-- Se busca el bid a deshacer
	SELECT BID.id_bid INTO idBid FROM BID INNER JOIN SUBASTA ON BID.id_sub = $1
	WHERE monto_bid = (SELECT max(monto_bid) FROM BID INNER JOIN SUBASTA ON BID.id_sub = $1);
	IF NOT FOUND THEN
		RAISE EXCEPTION 'No hay bid para deshacer';
	END IF;
	-- Se deshace el bid
	DELETE FROM BID WHERE BID.id_bid = idBid;
	-- Se busca el nuevo bid
	SELECT MAX(monto_bid) INTO new_max_bid FROM BID INNER JOIN SUBASTA ON BID.id_sub = $1;
	-- Si era el unico bid queda el precio inicial como actual sino el del maximo bid que quedo
	IF new_max_bid IS NULL THEN
		UPDATE SUBASTA SET precio_actual = precio_inicial WHERE SUBASTA.id_sub = $1;
	ELSE
		UPDATE SUBASTA SET precio_actual = new_max_bid WHERE SUBASTA.id_sub = $1;
	END IF;	
	COMMIT;
	
END
$$
LANGUAGE plpgsql