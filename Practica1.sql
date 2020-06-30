

--(Consulta 1)
CREATE TABLE PROFESION(
    cod_prof INTEGER NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT nombre_unique_prof 
    UNIQUE(nombre)
);


CREATE TABLE PAIS(
    cod_pais INTEGER NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT nombre_unique_pais 
    UNIQUE(nombre)
);


CREATE TABLE PUESTO(
    cod_puesto INTEGER NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT nombre_unique_puesto 
    UNIQUE(nombre)
);

CREATE TABLE DEPARTAMENTO(
    cod_depto INTEGER NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT nombre_unique_depto 
    UNIQUE(nombre)
);

CREATE TABLE MIEMBRO(
    cod_miembro INTEGER NOT NULL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    edad INTEGER NOT NULL,
    telefono INTEGER null,
    residencia VARCHAR(100) null,
    PAIS_cod_pais INTEGER NOT NULL,
    PROFESION_cod_prof INTEGER NOT NULL,
    CONSTRAINT FK_cod_pais 
        FOREIGN KEY (PAIS_cod_pais) REFERENCES PAIS (cod_pais) on delete CASCADE,
    CONSTRAINT FK_cod_prof 
        FOREIGN KEY (PROFESION_cod_prof) REFERENCES PROFESIon (cod_prof) on delete CASCADE
);

CREATE TABLE PUESTO_MIEMBRO(
    MIEMBRO_cod_miembro INTEGER NOT NULL,
    PUESTO_cod_puesto INTEGER NOT NULL,
    DEPARTAMENTO_cod_depto INTEGER NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE null, 
    CONSTRAINT PUESTO_MIEMBRO_pkey  
        PRIMARY KEY (MIEMBRO_cod_miembro,PUESTO_cod_puesto,DEPARTAMENTO_cod_depto),
    CONSTRAINT FK_cod_miembro 
        FOREIGN KEY (MIEMBRO_cod_miembro) REFERENCES MIEMBRO (cod_miembro) on delete CASCADE,
    CONSTRAINT FK_cod_puesto  
        FOREIGN KEY (PUESTO_cod_puesto) REFERENCES PUESTO (cod_puesto) on delete CASCADE,
    CONSTRAINT FK_cod_depto  
        FOREIGN KEY (DEPARTAMENTO_cod_depto) REFERENCES DEPARTAMENTO (cod_depto) on delete CASCADE
);

CREATE TABLE TIPO_MEDALLA(
    cod_tipo INTEGER NOT NULL PRIMARY KEY,
    medalla VARCHAR(20) NOT NULL,
    CONSTRAINT medalla_unique_tipo_medalla 
    UNIQUE(medalla)
);

CREATE TABLE MEDALLERO(
    PAIS_cod_pais INTEGER NOT NULL,
    TIPO_MEDALLA_cod_tipo INTEGER NOT NULL,
    cantidad_medallas INTEGER NOT NULL,
    CONSTRAINT MEDALLERO_pkey 
        PRIMARY KEY (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo),
    CONSTRAINT FK_cod_pais  
        FOREIGN KEY (PAIS_cod_pais) REFERENCES PAIS (cod_pais) on delete CASCADE,
    CONSTRAINT FK_cod_tipo  
        FOREIGN KEY (TIPO_MEDALLA_cod_tipo) REFERENCES TIPO_MEDALLA (cod_tipo) on delete CASCADE
);

CREATE TABLE DISCIPLINA(
    cod_disciplina INTEGER NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(150) null
);

CREATE TABLE ATLETA(
    cod_atleta INTEGER NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    edad INTEGER NOT NULL,
    participaciones VARCHAR(100) NOT NULL,
    DISCIPLINA_cod_disciplina INTEGER NOT NULL,
    PAIS_cod_pais INTEGER NOT NULL,
    CONSTRAINT FK_cod_disciplina  
        FOREIGN KEY (DISCIPLINA_cod_disciplina) REFERENCES DISCIPLINA (cod_disciplina) on delete CASCADE,
    CONSTRAINT FK_cod_pais  
        FOREIGN KEY (PAIS_cod_pais) REFERENCES PAIS (cod_pais) on delete CASCADE

);

CREATE TABLE CATEGORIA(
    cod_categoria INTEGER NOT NULL PRIMARY KEY,
    categoria VARCHAR(50) NOT NULL
);

CREATE TABLE TIPO_PARTICIPACION(
    cod_participacion INTEGER NOT NULL PRIMARY KEY,
    tipo_participacion VARCHAR(100) NOT NULL
);

CREATE TABLE EVENTO(
    cod_evento INTEGER NOT NULL PRIMARY KEY,
    fecha DATE NOT NULL,
    UBICACION VARCHAR(50) NOT NULL,
    hora DATE NOT NULL,
    DISCIPLINA_cod_disciplina INTEGER NOT NULL,
    TIPO_PARTICIPACION_cod_participacion INTEGER NOT NULL,
    CATEGORIA_cod_categoria INTEGER NOT NULL,
    CONSTRAINT FK_cod_disciplina  
        FOREIGN KEY (DISCIPLINA_cod_disciplina) REFERENCES DISCIPLINA (cod_disciplina) on delete CASCADE,
    CONSTRAINT FK_cod_participacion  
        FOREIGN KEY (TIPO_PARTICIPACION_cod_participacion) REFERENCES TIPO_PARTICIPACIon (cod_participacion) on delete CASCADE,
    CONSTRAINT FK_cod_categoria  
        FOREIGN KEY (CATEGORIA_cod_categoria) REFERENCES CATEGORIA (cod_categoria) on delete CASCADE
);

CREATE TABLE EVENTO_ATLETA(
    ATLETA_cod_atleta INTEGER NOT NULL,
    EVENTO_cod_evento INTEGER NOT NULL,  
    CONSTRAINT EVENTO_ATLETA_pkey  
        PRIMARY KEY (ATLETA_cod_atleta,EVENTO_cod_evento),
    CONSTRAINT FK_cod_atleta  
        FOREIGN KEY (ATLETA_cod_atleta) REFERENCES ATLETA (cod_atleta) on delete CASCADE,
    CONSTRAINT FK_cod_evento  
        FOREIGN KEY (EVENTO_cod_evento) REFERENCES EVENTO (cod_evento) on delete CASCADE
);

CREATE TABLE TELEVISORA(
    cod_televisora INTEGER NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE COSTO_EVENTO(
    EVENTO_cod_evento INTEGER NOT NULL,
    TELEVISORA_cod_televisora INTEGER NOT NULL,
    Tarifa INTEGER NOT NULL,
    CONSTRAINT COSTO_EVENTO_pkey  
        PRIMARY KEY (EVENTO_cod_evento,TELEVISORA_cod_televisora),
    CONSTRAINT FK_cod_evento  
        FOREIGN KEY (EVENTO_cod_evento) REFERENCES EVENTO (cod_evento) on delete CASCADE,
    CONSTRAINT FK_cod_televisora  
        FOREIGN KEY (TELEVISORA_cod_televisora) REFERENCES TELEVISORA (cod_televisora) on delete CASCADE
);

--Consulta 2
ALTER TABLE EVENTO drop COLUMN fecha;
ALTER TABLE EVENTO drop COLUMN hora;
ALTER TABLE EVENTO add COLUMN fecha_hora TIMESTAMP null;

--Consulta 3
ALTER TABLE EVENTO add CONSTRAINT checar_rango_fecha check (fecha_hora>'2020/7/24 8:59:59' and fecha_hora<'2020/9/8 20:00:01');

--Consulta 4
CREATE TABLE SEDE(
    codigo INTEGER NOT NULL PRIMARY KEY,
    Sede VARCHAR(50) NOT NULL
);

ALTER TABLE EVENTO ALTER COLUMN UBICACION TYPE INTEGER;

ALTER TABLE EVENTO add CONSTRAINT FK_UBICACION FOREIGN KEY (UBICACION) REFERENCES SEDE (codigo);

--Consulta 5
ALTER TABLE MIEMBRO ALTER COLUMN telefono set default 0;

--Consulta 6

insert into  PAIS values(1,'Guatemala');
insert into  PAIS values(2,'Francia');
insert into  PAIS values(3,'Argentina');
insert into  PAIS values(4,'Alemania');
insert into  PAIS values(5,'Italia');
insert into  PAIS values(6,'Brasil');
insert into  PAIS values(7,'Estados Unidos');
insert into  PROFESIon values(1,'Médico');
insert into  PROFESIon values(2,'Arquitecto');
insert into  PROFESIon values(3,'Ingeniero');
insert into  PROFESIon values(4,'Secretaria');
insert into  PROFESIon values(5,'Auditor');
insert into  MIEMBRO values(1,'Scott','Mitchell',32,default,'1092 Highland Drive Manitowoc, WI 54220',7,3);
insert into  MIEMBRO values(2,'Fanette','Poulin',25,25075853,'49, boulevard Aristide Briand 76120 LE GRand-QUEVILLY',2,4);
insert into  MIEMBRO values(3,'Laura','Cunha Silva',55,36985247,'Rua Onze, 86 Uberaba-MG',6,5);
insert into  MIEMBRO values(4,'Juan José','Lòpez',38,391664921,'26 calle 4-10 zona 11',1,2);
insert into  MIEMBRO values(5,'Arcangela','Paicucci',39,default,'Via Santa Teresa, 114 90010-Geraci Siculo PA',5,1);
insert into  MIEMBRO values(6,'Jeuel','Villalpando',31,default,'Acuña de Figeroa 6106 80101 Playa Pascual',3,5);
insert into  DISCIPLINA values(1,'Atletismo','Saltos de longitud y triples, de altura y con pértiga o garrocha; las pruebas de lanzamiento de martillo, jabalina y disco.');
insert into  DISCIPLINA values(2,'Bádminton','');
insert into  DISCIPLINA values(3,'Ciclismo','');
insert into  DISCIPLINA values(4,'Judo','s un arte marcial que se originó en Japón alrededor de 1880');
insert into  DISCIPLINA values(5,'Lucha','');
insert into  DISCIPLINA values(6,'Tenis de Mesa','');
insert into  DISCIPLINA values(7,'Boxeo','');
insert into  DISCIPLINA values(8,'Natación','Está presente como deporte en los Juegos desde la primera edición de la era moderna, en Atenas, Grecia, en 1896, donde se disputo en aguas abiertas.');
insert into  DISCIPLINA values(9,'Esgrima','');
insert into  DISCIPLINA values(10,'Vela','');
insert into  TIPO_MEDALLA values(1,'Oro');
insert into  TIPO_MEDALLA values(2,'Plata');
insert into  TIPO_MEDALLA values(3,'Broce');
insert into  TIPO_MEDALLA values(4,'Platino');
insert into  CATEGORIA values(1,'Clasificatorio');
insert into  CATEGORIA values(2,'Eliminatorio');
insert into  CATEGORIA values(3,'Final');
insert into  TIPO_PARTICIPACIon values(1,'Individual');
insert into  TIPO_PARTICIPACIon values(2,'Parejas');
insert into  TIPO_PARTICIPACIon values(3,'Equipos');
insert into  MEDALLERO values(5,1,3);
insert into  MEDALLERO values(2,1,5);
insert into  MEDALLERO values(6,3,4);
insert into  MEDALLERO values(4,4,3);
insert into  MEDALLERO values(7,3,10);
insert into  MEDALLERO values(3,2,8);
insert into  MEDALLERO values(1,1,2);
insert into  MEDALLERO values(1,4,5);
insert into  MEDALLERO values(5,2,7);
insert into  SEDE values(1,'Gimnasio Metropolitano de Tokio');
insert into  SEDE values(2,'Jardín del Palacio Imperial de Tokio');
insert into  SEDE values(3,'Gimnasio Nacional Yoyogi');
insert into  SEDE values(4,'Nippon Budokan');
insert into  SEDE values(5,'Estadio Olímpico');
insert into  EVENTO values(1,3,2,1,1,'2020/07/24 11:00:00');
insert into  EVENTO values(2,1,6,1,3,'2020/07/26 10:30:00');
insert into  EVENTO values(3,5,7,1,2,'2020/07/30 18:45:00');
insert into  EVENTO values(4,2,1,1,1,'2020/08/01 12:15:00');
insert into  EVENTO values(5,4,10,3,1,'2020/08/08 19:35:00');

--Consulta 7
ALTER TABLE PAIS drop CONSTRAINT nombre_unique_pais;

ALTER TABLE TIPO_MEDALLA drop CONSTRAINT medalla_unique_tipo_medalla;

ALTER TABLE DEPARTAMENTO drop CONSTRAINT nombre_unique_depto;


--Consulta 8
ALTER TABLE ATLETA drop CONSTRAINT FK_cod_disciplina;

CREATE TABLE DISCIPLINA_ATLETA(
    cod_atleta INTEGER NOT NULL,
    cod_disciplina INTEGER NOT NULL,
    CONSTRAINT DISCIPLINA_ATLETA_pkey 
        PRIMARY KEY (cod_atleta,cod_disciplina),
    CONSTRAINT FK_cod_atleta 
        FOREIGN KEY (cod_atleta) REFERENCES ATLETA (cod_atleta),
    CONSTRAINT FK_cod_disciplina 
        FOREIGN KEY (cod_disciplina) REFERENCES DISCIPLINA (cod_disciplina)
);
-- Consulta 9
ALTER TABLE COSTO_EVENTO ALTER COLUMN tarifa set DATA TYPE Numeric(8,2);
-- Consulta 10
delete FROM TIPO_MEDALLA where cod_tipo=4; 
-- Consulta 11
DROP TABLE TELEVISORA DROP;
DROP TABLE COSTO_EVENTO;
-- Consulta 12
delete FROM DISCIPLINA; 
-- Consulta 13
UPDATE MIEMBRO SET telefono = 55464601  WHERE nombre = 'Laura'  AND apellido = 'Cunha Silva';

UPDATE MIEMBRO SET telefono = 91514243  WHERE nombre = 'Jeuel'  AND apellido = 'Villalpando';

UPDATE MIEMBRO SET telefono = 920686670 WHERE nombre = 'Scott'  AND apellido = 'Mitchell';
--Consulta 14
ALTER TABLE ATLETA ADD COLUMN fotografia VARCHAR(10000000);

--(COnsulta 15)
ALTER TABLE ATLETA  ADD CONSTRAINT checar_edad CHECK (edad < 25); 
