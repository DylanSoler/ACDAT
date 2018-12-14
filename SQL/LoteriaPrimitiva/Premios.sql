--USE *Tu base de datps*

--SELECT * FROM DesarrolloPremios

CREATE TABLE DesarrolloPremios(
	pronostico tinyint  NOT NULL
	,numerosAcertados tinyint NOT NULL
	,catEspecial tinyint NOT NULL
	,cat1 tinyint NOT NULL
	,cat2 tinyint NOT NULL
	,cat3 tinyint NOT NULL
	,cat4 tinyint NOT NULL
	,cat5 tinyint NOT NULL

	,CONSTRAINT PK_DesarrolloPremios PRIMARY KEY (pronostico,numerosAcertados)
)

/*
Significado valores de la columna numerosAcertados:

	0  - 6 + R + C
	1  - 6 + R
	2  - 6 + C
	3  - 6
	4  - 5 + C
	5  - 5 + R
	6  - 5
	7  - 4 + C
	8  - 4
	9  - 3
	10 - 2
*/

INSERT INTO DesarrolloPremios (pronostico,numerosAcertados,catEspecial,cat1,cat2,cat3,cat4,cat5) 
	VALUES
		 (5,5,1,1,1,42,0,0)
		,(5,6,0,1,1,42,0,0)
		,(5,7,0,0,2,0,42,0)
		,(5,8,0,0,0,2,42,0)
		,(5,9,0,0,0,0,3,41)
		,(5,10,0,0,0,0,0,4)

		,(7,0,1,1,6,0,0,0)
		,(7,1,1,1,0,6,0,0)
		,(7,2,0,1,6,0,0,0)
		,(7,3,0,1,0,6,0,0)
		,(7,4,0,0,1,1,5,0)
		,(7,6,0,0,0,2,5,0)
		,(7,8,0,0,0,0,3,4)
		,(7,9,0,0,0,0,0,4)

		,(8,0,1,1,6,6,15,0)
		,(8,1,1,1,0,12,15,0)
		,(8,2,0,1,6,6,15,0)
		,(8,3,0,1,0,12,15,0)
		,(8,4,0,0,1,2,15,0)
		,(8,6,0,0,0,3,15,10)
		,(8,8,0,0,0,0,6,16)
		,(8,9,0,0,0,0,0,10)

		,(9,0,1,1,6,12,45,20)
		,(9,1,1,1,0,18,45,20)
		,(9,2,0,1,6,12,45,20)
		,(9,3,0,1,0,18,45,20)
		,(9,4,0,0,1,3,30,40)
		,(9,6,0,0,0,4,30,40)
		,(9,8,0,0,0,0,10,40)
		,(9,9,0,0,0,0,0,20)

		,(10,0,1,1,6,18,90,80)
		,(10,1,1,1,0,24,90,80)
		,(10,2,0,1,6,18,90,80)
		,(10,3,0,1,0,24,90,80)
		,(10,4,0,0,1,4,50,100)
		,(10,6,0,0,0,5,50,100)
		,(10,8,0,0,0,0,15,80)
		,(10,9,0,0,0,0,0,35)

		,(11,0,1,1,6,24,150,200)
		,(11,1,1,1,0,30,150,200)
		,(11,2,0,1,6,24,150,200)
		,(11,3,0,1,0,30,150,200)
		,(11,4,0,0,1,5,75,200)
		,(11,6,0,0,0,6,75,200)
		,(11,8,0,0,0,0,21,140)
		,(11,9,0,0,0,0,0,56)