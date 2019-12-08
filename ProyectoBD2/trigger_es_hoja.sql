
CREATE FUNCTION check_hoja() 
	RETURNS trigger AS $check_hoja$
	DECLARE
	have_childs integer;
	BEGIN

	SELECT CAT.child INTO have_childs FROM CATEGORIA AS CAT WHERE CAT.id_cat = NEW.id_cat;
	IF (have_childs IS NOT NULL) THEN
		RETURN NULL;
	END IF;

	RETURN NEW;

	END;
	$check_hoja$ LANGUAGE plpgsql;


CREATE  TRIGGER trigger_es_hoja BEFORE INSERT
ON PERTENECE
FOR EACH ROW EXECUTE PROCEDURE check_hoja();