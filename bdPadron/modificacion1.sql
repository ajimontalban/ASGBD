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
    iCodComunidad int NOT NULL AUTO INCREMENT,
    vaNomComunidad varchar(50),
    PRIMARY KEY iCodComunidad
);




