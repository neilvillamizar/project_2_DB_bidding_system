-- Autors: Neil Villamizar 15-11523
--		   Marco Benitez   13-10137
--
-- Query 1: En promedio, Cuales productos tienen precios de venta mas altos, 
-- 			los que empiezan con un precio base menor a 1$ o los que 
--			empiezan con un precio base mayor o igual a 1$ ?
--			(Se comparan los productos por categorias)

\c subastas
--	funcion que retorna el promedio de los precios de venta de los productos
--  con en la categoria indicada por $1 que tienen un precio inicial menor a 1$
--
-- $1 id de la categoria por la cual se saca el promedio
CREATE OR REPLACE FUNCTION inicia_menor_1(int) RETURNS decimal AS
$$
DECLARE
answer decimal;
BEGIN
	
	SELECT AVG(S.precio_actual) INTO answer FROM SUBASTA AS S
	JOIN PRODUCTO AS P ON S.id_prod = P.id_prod
	JOIN PERTENECE AS PE ON PE.id_prod = P.id_prod
	JOIN CATEGORIA AS C ON C.id_cat = PE.id_cat
	WHERE C.id_cat = $1 AND S.precio_inicial < 1 
	AND NOW()::timestamp > S.fecha_end
	AND S.precio_actual >= S.precio_reserva;
	IF answer IS NULL THEN
		RETURN 0;
	END IF;
	RETURN answer;
END;
$$ LANGUAGE plpgsql;

--	funcion que retorna el promedio de los precios de venta de los productos
--  con en la categoria indicada por $1 que tienen un precio inicial mayor a 1$
--
-- $1 id de la categoria por la cual se saca el promedio
CREATE OR REPLACE FUNCTION inicia_mayor_1(int) RETURNS decimal AS
$$
DECLARE
answer decimal;
BEGIN

	SELECT AVG(S.precio_actual) INTO answer FROM SUBASTA AS S
	JOIN PRODUCTO AS P ON S.id_prod = P.id_prod
	JOIN PERTENECE AS PE ON PE.id_prod = P.id_prod
	JOIN CATEGORIA AS C ON C.id_cat = PE.id_cat
	WHERE C.id_cat = $1 AND S.precio_inicial >= 1 
	AND NOW()::timestamp > S.fecha_end 
	AND S.precio_actual >= S.precio_reserva;
	IF answer IS NULL THEN
		RETURN 0;
	END IF;
	RETURN answer;
END;
$$ LANGUAGE plpgsql;

-- 
-- Query que responde la pregunta de la query 1 del enunciado
--
SELECT  cat.nombre_cat,
		inicia_menor_1(cat.id_cat) AS promedio_precio_inicial_menor_a_1,
		inicia_mayor_1(cat.id_cat) AS promedio_precio_inicial_mayor_a_1,
		CASE WHEN inicia_menor_1(cat.id_cat) > inicia_mayor_1(cat.id_cat) 
				THEN 'Precio inicial menor a 1'
			WHEN inicia_menor_1(cat.id_cat) < inicia_mayor_1(cat.id_cat)
				THEN 'Precio inicial mayor a 1'
			ELSE 'Ambos precios iniciales tienen igual promedio'
			END AS mejor_promedio
FROM CATEGORIA AS cat
WHERE cat.child IS NULL;
