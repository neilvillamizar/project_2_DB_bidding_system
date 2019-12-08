-- Autors: Neil Villamizar 15-11523
--		   Marco Benitez   13-10137
--
-- Se insertan filas a las tablas para
-- poder probar el proyecto
--

\c subastas
--
-- Se hacen inserts a la tabla CATEGORIA
--
INSERT INTO CATEGORIA(nombre_cat,child,next_brother,parent) VALUES
	('Moda',null,null,null),
	('Media',null,null,null),
	('Electronicos',null,null,null),
	('Hogar',null,null,null),
	('Deportes',null,null,null),
	('Juguetes',null,null,null),
	('Salud y Belleza',null,null,null),
	('Arte',null,null,null),
	('Otros',null,null,null),
	('Ropa/Caballero',null,null,1),
	('Ropa/Dama',null,10,1),
	('Accesorios/Dama',null,11,1),
	('Accesorios/Hombres',null,12,1),
	('Joyas',null,13,1),
	('Instrumentos',null,null,2),
	('Libros',null,15,2),
	('Musica',null,16,2),
	('Telefonos',null,null,3),
	('Computadoras,Tv y Audio',null,18,3),
	('Video Juegos',null,19,3),
	('Camaras',null,20,3),
	('Decoracion',null,null,4),
	('Herramientas',null,22,4),
	('Jardineria',null,23,4),
	('Cocina',null,24,4),
	('Deportes de equipo',null,null,5),
	('Pesca',null,26,5),
	('Equipamineto de gimnasio',null,27,5),
	('Deportes de interior ',null,28,5),
	('Juegos de mesa',null,null,6),
	('Figuras de Accion',null,30,6),
	('CR Vehiculos',null,31,6),
	('Vitamina',null,null,7),
	('Cuidados cabello y piel',null,33,7),
	('Perfumes',null,34,7),
	('Maquillaje',null,35,7),
	('Coleccionables',null,null,8),
	('Pinturas',null,37,8),
	('Monedas',null,38,8),
	('Antiguedades',null,39,8);

--
-- 
--
UPDATE CATEGORIA SET CHILD = 14 WHERE nombre_cat = 'Moda';
UPDATE CATEGORIA SET CHILD = 17 WHERE nombre_cat = 'Media';
UPDATE CATEGORIA SET CHILD = 16 WHERE nombre_cat = 'Media';
UPDATE CATEGORIA SET CHILD = 21 WHERE nombre_cat = 'Electronicos';
UPDATE CATEGORIA SET CHILD = 25 WHERE nombre_cat = 'Hogar';
UPDATE CATEGORIA SET CHILD = 29 WHERE nombre_cat = 'Deportes';
UPDATE CATEGORIA SET CHILD = 32 WHERE nombre_cat = 'Juguetes';
UPDATE CATEGORIA SET CHILD = 36 WHERE nombre_cat = 'Salud y Belleza';
UPDATE CATEGORIA SET CHILD = 40 WHERE nombre_cat = 'Arte';

--
-- Se hacen inserts a la tabla PRODUCTO
--
INSERT INTO PRODUCTO(nombre_prod,descripcion,especificaciones) VALUES
	('IPHONE', 'Telefono Inteligente','Marca: Apple, Modelo: 11Pro, Capacidad: 256 GB, Estado: Nuevo'),
	('Fit 9','Suplemento para perdida de grasa','Marca: Sasha Fitness, Cantidad: 120 capsulas, Estado: Nuevo'),
	('Nintendo64','Consula de video juego','Marca: Nintendo, Estado: Poco Uso'),
	('Papa Leon X','Arte en lienzo','Artista: Fernando Botero, Genero: Retrato, Año: 1964'),
	('Charizard 1st Edition','Carta Coleccionable de Pokemon Original','Estado: Poco Uso, Año de impresion: 2002, Edicion: Primera'),
	('The Infinity Gauntlent','Escultura coleccionable','Estado: Nuevo, Artista: Jasenko Dordevic, Material: Pencil'),
	('Moneda 100 bs Fuertes','Moneda Fiat Venezolana','Estado: Poco uso, Año: 2016, Pais: Venezuela'),
	('Cartera Bandolero Gucci','Cartera de Lujo','Estado: Nuevo, Color: Marron, Modelo: Bandolero'),
	('Televisor Sony Bravia','Telivisor Pantalla plana','Estado: Nuevo, Modelo: Bravia, Pulgadas: 32'),
	('Mi pequeño Pony','Juguete Antiguo','Estado: Conservado, Marca : Matel, Año : 1986'),
	('Laptop Dell','Computador Portatil','Estado: Nuevo, Marca: Dell, Modelo: Inspirion 15, Ram: 8GB, Disco Duro: 1TB'),
	('Serrucho','Herramienta para jardineria','Marca: Altuna, Medidas: 33cm, Estado: Nuevo'),
	('Blastoise 1st Edition','Carta Coleccionable de Pokemon Original','Estado: Poco Uso, Año de impresion: 2002, Edicion: Primera'),
	('Raqueta de Tennis','Raqueta de Tennis Firmana por Nadal','Estado: Poco Uso, Marca: Head, Color: Azul y blanco'),
	('La Odisea','Novela Antigua','Estado: Conservado, Autor: Homero, Año: 1858'),
	('Disco Vinilo Queen','Disco Antiguo de Vinilo Queen','Estado: Mal Estado, Genero: Rock, Año: 1975, Album: A Night at Opera'),
	('Cuadro Abstracto','Cuadro Para Decorar Hogar','Estado: Nuevo, Dimension: 30cmx40cm'),
	('Telefono','Telefono Antiguo de coleccion','Estado: Poco uso, Marca: Kare, Año: 1960'),
	('Channel Five', 'Perfume de dama','Estado: nuevo, Marca: Channel, Contenido: 500ml, Modelo: nr5'),
	('PlayStation4','Consola de Video juego','Estado: nuevo, Marca: Sony, Almacenamiento: 1TB, Modelo: Slim'),
	('Violin','Instrumento Musical','Marca: Leidi Blunt, Año: 1721, Estado: Conservado'),
	('Diamante','Piedra Preciosa','Estado: Conservado, Peso: 250gr, Pureza: 98%'),
	('Lentes de Sol', 'Lentes de lujo para el sol','Estado: Nuevo, Marca: Ray Ban, Modelo: Aviador Classic, color: Dorado'),
	('Mago Oscuro','Carta Coleccionable de Yu-Gi-Oh', 'Estado: Conservado, Marca: Konami, Año: 2002'),
	('Libro Matematicas','Libro Antigua de Matematicas','Autor: Aurelio Baldor, Año: 1941, Edicion: 7, Idioma: Español'),
	('Atari','Consola de video juego','Estado: Conservado, Marca: Atari, Modelo: cx2600, Año: 1978'),
	('Caña de Pescar', 'Caña de pescar de rio','Marca: Ugly Stick, Modelo: Pezca, Largo: 2.1m'),
	('Monopoly','Juego de mesa familiar antiguo','Marca: Hasbro, Idioma: Ingles, Estado: Conservado, Año: 1990'),
	('Proteinas','Proteinas para ganar mosculatura','Marca: Sasha Fitnnes, Sabor: Caramelo, Contenido: 907gr'),
	('Las meninas','Pintura Barroco','Artista: Diego Velazquez, Año 1656, Medidas: 3.18mx2.76m');

--
-- Se hacen inserts a la tabla PERTENECE
--
INSERT INTO PERTENECE VALUES 
	(18,1),
	(33,2),
	(20,3),
	(37,3),
	(38,4),
	(40,4),
	(37,5),
	(37,6),
	(37,7),
	(39,7),
	(12,8),
	(19,9),
	(31,10),
	(40,10),
	(31,11),
	(24,12),
	(23,12),
	(37,13),
	(26,14),
	(16,15),
	(40,15),
	(40,16),
	(17,16),
	(22,17),
	(38,17),
	(40,18),
	(18,18),
	(35,19),
	(20,20),
	(15,21),
	(40,21),
	(14,22),
	(13,23),
	(37,24),
	(16,25),
	(20,26),
	(40,26),
	(27,27),
	(30,28),
	(40,28),
	(33,29),
	(38,30),
	(40,30);

--
-- Se hacen inserts a la tabla USUARIO
--
INSERT INTO USUARIO(nombre_usr,apellido) VALUES
	('Marco','Benitez'),
	('Andreina','Gonzalez'),
	('Arturo','Ginesta'),
	('Juan','Mendoza'),
	('Enrique','Capriles'),
	('Devora','Mastique'),
	('Carlos','Cerrada'),
	('Miguel','Paredes'),
	('Alessandro','Ciccone'),
	('Carmelo','Rodriguez'),
	('Gonzalo','Castellano'),
	('Maria','Cedeno'),
	('Codorniz','Paredes'),
	('Kevin','Chacon'),
	('Alexander','Romero');

--
-- Se hacen inserts a la tabla METODO_PAGO
--
INSERT INTO METODO_PAGO(id_usr,tipo_tarjeta,nro_tarjeta) VALUES
	(1,'Debito',54889),
	(2,'Debito',44855),
	(6,'Credito',30246),
	(8,'Debito',45234),
	(9,'Credito',49297),
	(10,'Credito',33715),
	(14,'Debito',44855),
	(7,'Debito',83754),
	(5,'Credito',15319),
	(3,'Debito',19290);

--
-- Se hacen inserts a la tabla SUBASTA
--
INSERT INTO SUBASTA(id_usr,id_prod,precio_actual,precio_inicial,precio_reserva,fecha_init,fecha_end,min_bid_monto) VALUES
	(1,5,1,1,50,'2018-1-15 13:00:10','2020-1-16 13:00:10',5),		
	(1,7,10,10,50,'2018-1-20 13:00:10','2020-1-22 13:00:10',5),
	(3,10,0.5,0.5,40,'2018-2-12 4:00:10','2020-2-13 13:00:10',2),
	(4,9,5,5,80,'2018-2-20 18:00:10','2020-2-22 7:00:10',10),
	(6,15,0.8,0.8,300,'2018-2-25 5:40:10','2020-2-26 14:00:10',5),
	(7,17,0.5,0.5,50,'2018-3-5 7:00:10','2020-3-6 12:00:10',1),
	(12,23,1,1,70,'2018-3-10 03:00:10','2020-3-14 08:20:10',1),
	(2,22,1000,1000,10000,'2018-4-24 10:00:10','2020-4-24 11:00:10',50),
	(8,24,0.5,0.5,50,'2018-4-13 12:20:10','2020-4-15 13:00:10',2),
	(1,28,5,5,50,'2018-6-20 13:00:10','2020-6-22 13:00:10',5),
	(7,16,20,20,500,'2018-7-14 13:00:10','2020-7-16 13:00:10',20),
	(3,11,80,80,700,'2018-8-14 12:00:10','2020-8-15 13:00:10',2),
	(5,2,10,10,200,'2018-12-14 13:00:10','2020-1-16 13:00:10',2),
	(14,3,0.4,0.4,0.1,'2018-12-14 13:00:10','2019-1-17 18:00:10',10),
	(5,13,1,1,0.1,'2018-12-10 13:00:10','2019-1-16 13:00:10',1),
	(9,12,1,1,0.1,'2018-12-13 4:00:10','2019-1-15 13:00:10',1),
	(6,28,8,8,0.1,'2018-12-9 13:00:10','2019-1-16 13:00:10',5);


-- Pujas para simular la subasta
CALL BID(1,1,333);
CALL BID(2,2,555);
CALL BID(3,3,111);
CALL BID(4,4,666);
CALL BID(5,5,888);
CALL BID(6,6,999);
CALL BID(7,7,666);
CALL BID(8,8,1333);
CALL BID(9,9,999);
CALL BID(10,10,555);
CALL BID(11,11,4344);
CALL BID(12,12,567);
CALL BID(13,13,466);
CALL BID(13,1,345);
CALL BID(12,2,2234);
CALL BID(11,3,123);
CALL BID(10,4,876);
CALL BID(9,5,1567);
CALL BID(8,11,8765);
CALL BID(7,10,987);
