

CREATE OR REPLACE FUNCTION inicia_menor_1(int) RETURNS decimal AS
$$
BEGIN
	SELECT AVG(S.precio_actual) FROM SUBASTA AS S
	JOIN PRODUCTO AS P ON S.id_prod = P.id_prod
	JOIN PERTENECE AS PE ON PE.id_prod = P.id_prod
	JOIN CATEGORIA AS C ON C.id_cat = PE.id_cat
	WHERE C.id_cat = $1 AND S.precio_inicial < 1 AND NOW::timestamp > S.fecha_end;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION inicia_mayor_1(int) RETURNS decimal AS
$$
BEGIN
	SELECT AVG(S.precio_actual) FROM SUBASTA AS S
	JOIN PRODUCTO AS P ON S.id_prod = P.id_prod
	JOIN PERTENECE AS PE ON PE.id_prod = P.id_prod
	JOIN CATEGORIA AS C ON C.id_cat = PE.id_cat
	WHERE C.id_cat = $1 AND S.precio_inicial >= 1 AND NOW::timestamp > S.fecha_end;
END;
$$ LANGUAGE plpgsql;

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
