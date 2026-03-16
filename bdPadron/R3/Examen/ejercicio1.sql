DROP PROCEDURE IF EXISTS prPobMedia;
DELIMITER //
CREATE PROCEDURE prPobMedia(IN _anio INT)
BEGIN
    DECLARE _iFinCursor INT;
    DECLARE _pobComunidad, _numProvincias, _iCodComunidad INT;
    DECLARE _media DECIMAL(14,2);
    DECLARE _vaNomComunidad VARCHAR(50);

    DECLARE CONTINUE CURSOR HANDLER FOR NOT FOUND SET _iFinCursor = 1;

    DECLARE curComunidades CURSOR FOR
    SELECT iCodComunidad, vaNomComunidad FROM taComunidades;

    SET _iFinCursor = 0;

    CREATE TEMPORARY TABLE taSalida (
        nombreComunidad VARCHAR(50),
        Año INT,
        Poblacion DECIMAL(14,2)
    );

    OPEN curComunidades;

    FETCH curComunidades INTO _iCodComunidad, _vaNomComunidad;
    WHILE _iFinCursor = 0 DO
        SET _pobComunidad = (SELECT iPoblacion
        FROM taPoblacion, taMunicipios, taProvincias
        WHERE iRefMunicipio = iCodMunicipio AND iRefProvincia = iCodProvincia
        AND iAnio = _anio AND iRefComunidad = _iCodComunidad);

        SET _numProvincias = (SELECT DISCTINCT count(iCodProvincia)
        FROM taProvincias
        WHERE iRefComunidad = _iCodComunidad);

        SET _media = _pobComunidad / _numProvincias;

        INSERT INTO taSalida (
            nombreComunidad, Año, Poblacion
        ) VALUES ( _vaNomComunidad, _anio, _media );
        
        FETCH curComunidades INTO _iCodComunidad, _vaNomComunidad;
    END WHILE;

    SELECT * FROM taSalida;

    DROP TEMPORARY TABLE taSalida;
END //
DELIMITER ;
