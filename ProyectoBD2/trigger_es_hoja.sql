-- Autors: Neil Villamizar 15-11523
--		   Marco Benitez   13-10137
--
--	trigger para chequear que las categorias asignadas a los productos sean hojas
--

\c subastas_15_11523_13_10137
-- Funcion del trigger
CREATE FUNCTION check_hoja() 
	RETURNS trigger AS $check_hoja$
	DECLARE
	have_childs integer; -- Para chequear si es hoja
	BEGIN

	-- Asigna a have_childs NULL si no tiene hijos, de otra forma un entero.
	SELECT CAT.child INTO have_childs FROM CATEGORIA AS CAT WHERE CAT.id_cat = NEW.id_cat;
	-- Verifica si la categoria es una hoja.
	IF (have_childs IS NOT NULL) THEN
		-- Si no es una hoja retorna null para que el insert no se haga.
		RETURN NULL;
	END IF;

	-- Si es una hoja retorna NEW para que el insert se haga de forma normal.
	RETURN NEW;

	END;
	$check_hoja$ LANGUAGE plpgsql;

-- Declaracion del trigger
-- Se ejecuta antes del insert.
CREATE  TRIGGER trigger_es_hoja BEFORE INSERT
ON PERTENECE
FOR EACH ROW EXECUTE PROCEDURE check_hoja();