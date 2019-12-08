-- Autors: Neil Villamizar 15-11523
--		   Marco Benitez   13-10137
--
--¿Cuántas subastas se realizan por mes por categoría? (tomar en cuenta todas las categorías) 

\c subastas_15_11523_13_10137

SELECT EXTRACT(YEAR FROM SUBASTA.fecha_init)as  year_, EXTRACT(MONTH FROM SUBASTA.fecha_init) as month_,categoria.nombre_cat,count(*) as Nro_Subastas  FROM SUBASTA 
INNER JOIN PERTENECE  ON PERTENECE.id_prod = SUBASTA.id_prod
INNER JOIN CATEGORIA ON PERTENECE.id_cat = CATEGORIA.id_cat
GROUP by month_,year_, categoria.nombre_cat
ORDER BY year_,month_
