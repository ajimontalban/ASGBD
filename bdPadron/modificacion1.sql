USE bdPadron;

UPDATE taProvincias SET vaNomProvincia = "Álava" WHERE vaNomProvincia LIKE 'Araba%';
UPDATE taProvincias SET vaNomProvincia = "Alicante" WHERE vaNomProvincia LIKE 'Alicante%';
UPDATE taProvincias SET vaNomProvincia = "Islas Baleares" WHERE vaNomProvincia LIKE 'Balears%';
UPDATE taProvincias SET vaNomProvincia = "Castellón" WHERE vaNomProvincia LIKE 'Castell%';
UPDATE taProvincias SET vaNomProvincia = "Coruña, La" WHERE vaNomProvincia LIKE 'Coruña%';
UPDATE taProvincias SET vaNomProvincia = "Gerona" WHERE vaNomProvincia LIKE 'Girona';
UPDATE taProvincias SET vaNomProvincia = "Guipúzcoa" WHERE vaNomProvincia LIKE 'Gipuzk%';
UPDATE taProvincias SET vaNomProvincia = "Lérida" WHERE vaNomProvincia LIKE 'Lleida';
UPDATE taProvincias SET vaNomProvincia = "Orense" WHERE vaNomProvincia LIKE 'Oure%';
UPDATE taProvincias SET vaNomProvincia = "Valencia" WHERE vaNomProvincia LIKE 'Valencia%';
UPDATE taProvincias SET vaNomProvincia = "Vizcaya" WHERE vaNomProvincia LIKE 'Bizkaia';


ALTER TABLE taPoblacion
ADD COLUMN iPoblacion INTEGER AS (iHombres + iMujeres) VIRTUAL;


CREATE TABLE IF NOT EXISTS taComunidades (
    iCodComunidad int NOT NULL AUTO_INCREMENT,
    vaNomComunidad varchar(50) NOT NULL,
    PRIMARY KEY (iCodComunidad)
);

INSERT INTO taComunidades (vaNomComunidad) VALUES ("Andalucía");
INSERT INTO taComunidades (vaNomComunidad) VALUES ("Aragón");
INSERT INTO taComunidades (vaNomComunidad) VALUES ("Asturias");
INSERT INTO taComunidades (vaNomComunidad) VALUES ("Islas Baleares");
INSERT INTO taComunidades (vaNomComunidad) VALUES ("Canarias");
INSERT INTO taComunidades (vaNomComunidad) VALUES ("Cantabria");
INSERT INTO taComunidades (vaNomComunidad) VALUES ("Castilla-La Mancha");
INSERT INTO taComunidades (vaNomComunidad) VALUES ("Castilla y León");
INSERT INTO taComunidades (vaNomComunidad) VALUES ("Cataluña");
INSERT INTO taComunidades (vaNomComunidad) VALUES ("Valencia");
INSERT INTO taComunidades (vaNomComunidad) VALUES ("Extremadura");
INSERT INTO taComunidades (vaNomComunidad) VALUES ("Galicia");
INSERT INTO taComunidades (vaNomComunidad) VALUES ("La Rioja");
INSERT INTO taComunidades (vaNomComunidad) VALUES ("Madrid");
INSERT INTO taComunidades (vaNomComunidad) VALUES ("Murcia");
INSERT INTO taComunidades (vaNomComunidad) VALUES ("Navarra");
INSERT INTO taComunidades (vaNomComunidad) VALUES ("País Vasco");
INSERT INTO taComunidades (vaNomComunidad) VALUES ("Ceuta");
INSERT INTO taComunidades (vaNomComunidad) VALUES ("Melilla");

ALTER TABLE taProvincias
ADD COLUMN iRefComuniad INT NOT NULL;

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "Andalucía")
WHERE vaNomProvincia in ('Almería','Cádiz','Córdoba','Granada','Huelva','Sevilla','Jaén','Málaga');

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "Aragón")
WHERE vaNomProvincia in ('Huesca','Teruel','Zaragoza');

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "Asturias")
WHERE vaNomProvincia = 'Asturias';

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "Islas Baleares")
WHERE vaNomProvincia  'Islas Baleares';

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "Canarias")
WHERE vaNomProvincia in  ('Palmas, Las','Santa Cruz de Tenerife');

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "Cantabria")
WHERE vaNomProvincia in 'Cantabria';

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "Castilla y León")
WHERE vaNomProvincia in  ('Ávila','Burgos','León','Palencia','Salamanca','Segovia','Soria','Valladolid','Zamora');

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "Castilla-La Mancha")
WHERE vaNomProvincia in ('Albacete','Ciudad Real','Cuenca','Guadalajara','Toledo');

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "Cataluña")
WHERE vaNomProvincia in ('Barcelona','Gerona','Lérida','Tarragona');

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "Extremadura")
WHERE vaNomProvincia in ('Badajoz','Cáceres');

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "Galicia")
WHERE vaNomProvincia in ('Coruña, La','Lugo','Orense','Pontevedra');

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "Rioja, La")
WHERE vaNomProvincia = 'Rioja, La';

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "Madrid")
WHERE vaNomProvincia = 'Madrid';

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "Murcia")
WHERE vaNomProvincia = 'Murcia';

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "Navarra")
WHERE vaNomProvincia = 'Navarra';

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "País Vasco")
WHERE vaNomProvincia in ('Álava','Gipúzcoa','Vizcaya');

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "Valencia")
WHERE vaNomProvincia in ('Alicante','Castellón','Valencia');

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "Ceuta")
WHERE vaNomProvincia = 'Ceuta';

UPDATE taProvincias 
SET iRefComunidad = (SELECT iCodComunidad FROM taComunidades WHERE vaNomComunidad = "Melilla")
WHERE vaNomProvincia 'Melilla';
