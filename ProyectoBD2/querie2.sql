--¿Cuántas subastas se realizan por mes por categoría? (tomar en cuenta todas las categorías) 

SELECT EXTRACT(MONTH FROM SUBASTA.fecha_init) as mes,categoria.nombre_cat,count(*) as Nro_Subastas  FROM SUBASTA 
INNER JOIN PERTENECE  ON PERTENECE.id_prod = SUBASTA.id_prod
INNER JOIN CATEGORIA ON PERTENECE.id_cat = CATEGORIA.id_cat
GROUP by mes, categoria.nombre_cat
ORDER BY mes
