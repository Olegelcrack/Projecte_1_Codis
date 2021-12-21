DROP DATABASE IF EXISTS Projecte;

create database Projecte;
USE Projecte;


DROP TABLE IF EXISTS productes; 
DROP TABLE IF EXISTS proveidor;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS equivalent;
DROP TABLE IF EXISTS pertany;

create table proveidor (
	Codi_pro INT(8) PRIMARY KEY auto_increment,
    Nom_pro VARCHAR(15));
    
create table productes (
	Codi_id INT(8) PRIMARY KEY auto_increment,
    Nom VARCHAR(100),
    Stock INT(8),
    Codi_prov INT(8),
    Materials VARCHAR(50),
    Descr VARCHAR(200),
    Preu FLOAT(6),
	FOREIGN KEY (Codi_prov) REFERENCES proveidor(Codi_pro));
    
create table categories (
	Codi_cat INT(8) PRIMARY KEY auto_increment,
    Nom VARCHAR(25));

create table equivalent (
	Codi_id INT(8),
    Codi_id_2 INT(8),
    PRIMARY KEY (Codi_id, Codi_id_2),
    FOREIGN KEY (Codi_id) REFERENCES productes (Codi_id),
    FOREIGN KEY (Codi_id_2) REFERENCES productes (Codi_id));

create table pertany (
	Codi_id INT(8) PRIMARY KEY,
    Codi_cat INT(8),
    FOREIGN KEY (Codi_id) REFERENCES productes (Codi_id),
    FOREIGN KEY (Codi_cat) REFERENCES categories (Codi_cat));
    
desc productes;
desc proveidor;
desc categories;
show tables;



INSERT INTO proveidor VALUES(1,'Corsair');
INSERT INTO proveidor VALUES(2,'Logitech');
INSERT INTO proveidor VALUES(3,'NitroPC');
INSERT INTO proveidor VALUES(4,'AEG');
INSERT INTO proveidor VALUES(5,'Orbegozo');
INSERT INTO proveidor VALUES(6,'AMD');
INSERT INTO proveidor VALUES(7,'NVidia');
INSERT INTO proveidor VALUES(8,'Mars Gaming');
INSERT INTO proveidor VALUES(9,'HyperX');



INSERT INTO productes VALUES(1,'Logitech SuperLight G pro X ',3, 2, 'Alumini, Plastic', 'Pes: 63g, Velocitat Resposta: 1ms, Microprocesador: ARM 32 bits, Batería: 70h.', 155);
INSERT INTO productes VALUES(2,'Cascos Logitech g pro',0, 2, 'Alumini, Plastic','Cable: 2m, Resposta FreQ: 20HZ-20KHZ', 79.47);
INSERT INTO productes VALUES(3,'RAM Corsair Vengeance 2X16GB DDR4 3200MHz',5, 1, 'Alumini, Oro', '2X16GB, DDR4, 3200MHz, CL16,', 182);
INSERT INTO productes VALUES(4,'PC GAMING Gold',7, 3, 'Alumini, Acer, Vidre', 'Ryzen 5 3600, GTX 1650 4GB, 16GB, M.2 512GB, HDD 1TB', 920);
INSERT INTO productes VALUES(5,'AEG L6FBI821U Lavadora blanca 8KG',19, 4, 'Acer, Plàstic', 'PES: 8KG, VELOCITAT: 1200 RPM, CLASE: E, POTES: 4, POTÈNCIA: 2200W', 445);
INSERT INTO productes VALUES(6,'MÀQUINA Cafè Filtro Orbegozo - CG 4014',12, 5, 'Plàstic, Vidre', 'Capacitat de 6 tases de cafè, Filtre permanent, Jarra de vidre, Cafè calent durant 30 minuts, Potència: 650W', 17.46);
INSERT INTO productes VALUES(7,'Ratoli Gaming Pro ',40, 2, 'Alumini, Plastic', 'Ratoli Gaming', 75);
INSERT INTO productes VALUES(8,'Cascos Gaming',10, 2, 'Alumini, Plastic','Cascos Gaming', 49.47);
INSERT INTO productes VALUES(9,'RAM HyperX',26, 9, 'Alumini, Oro', '2X16GB, DDR4, 3200MHz, CL16,', 142);
INSERT INTO productes VALUES(10,'PC GAMING Silver',15, 3, 'Alumini, Acer, vidre', 'Ryzen 5 2600, GTX 1060 3GB, 16GB, M.2 512GB, HDD 1TB', 720);
INSERT INTO productes VALUES(11,'Lavadora Balay',2, 4, 'Acer, Plàstic', 'PES: 8KG, VELOCITAT: 1200 RPM, CLASE: E, POTES: 4, POTÈNCIA: 2200W', 395);
INSERT INTO productes VALUES(12,'Màquina cafè Nespresso - CG 4014',32, 5, 'Plàstic, Vidre', 'Capacitat de 6 tases de cafè, Filtre permanent, Jarra de vidre, Cafè calent durant 30 minuts, Potència: 650W', 29.46);
INSERT INTO productes VALUES(13,'Procesador AMD 1700',80, 6, 'Alumini, Oro','Procesador AMD 1700', 150.47);
INSERT INTO productes VALUES(14,'Torre PC Gaming',10, 1, 'Alumini', 'Torre Gran Negra,', 102);
INSERT INTO productes VALUES(15,'Gigabyte RTX 3060',0, 7, 'Alumini, Oro, Plastic', 'RTX 3060', 820);
INSERT INTO productes VALUES(16,'Font de alimentacio 750W Gold ',0, 1, 'Alumini', '750W Potència', 90);
INSERT INTO productes VALUES(17,'Teclat + Ratoli Mars Gaming',3, 8, 'Alumini, Plastic', 'Teclat Gaming i Ratoli Gaming', 30);


INSERT INTO categories VALUES(1, 'Components');
INSERT INTO categories VALUES(2, 'Electrodomèstics');
INSERT INTO categories VALUES(3, 'PC');
INSERT INTO categories VALUES(4, 'Perifèrics');

INSERT INTO pertany VALUES(1, 4);
INSERT INTO pertany VALUES(2, 4);
INSERT INTO pertany VALUES(3, 1);
INSERT INTO pertany VALUES(4, 3);
INSERT INTO pertany VALUES(5, 2);
INSERT INTO pertany VALUES(6, 2);
INSERT INTO pertany VALUES(7, 4);
INSERT INTO pertany VALUES(8, 4);
INSERT INTO pertany VALUES(9, 1);
INSERT INTO pertany VALUES(10, 3);
INSERT INTO pertany VALUES(11, 2);
INSERT INTO pertany VALUES(12, 2);
INSERT INTO pertany VALUES(13, 1);
INSERT INTO pertany VALUES(14, 1);
INSERT INTO pertany VALUES(15, 1);
INSERT INTO pertany VALUES(16, 1);
INSERT INTO pertany VALUES(17, 4);


INSERT INTO equivalent VALUES(1, 7);
INSERT INTO equivalent VALUES(2, 8);
INSERT INTO equivalent VALUES(3, 9);
INSERT INTO equivalent VALUES(4, 10);
INSERT INTO equivalent VALUES(5, 11);
INSERT INTO equivalent VALUES(6, 12);