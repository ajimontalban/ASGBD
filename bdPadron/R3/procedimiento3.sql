DROP PROCEDURE IF EXISTS prComunidadesMasMunicipios;
DELIMITER //
CREATE PROCEDURE prComunidadesMasMunicipios()
BEGIN
    DECLARE _iFinCursor INT;
    DECLARE _sumamunicipios INT;
    DECLARE _municipiosmin INT;
    DECLARE _iCodComunidad INT;
    DECLARE _NombreCom VARCHAR(50);

    DECLARE curComunidades CURSOR FOR
        SELECT iCodComunidad FROM taComunidades;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET _iFinCursor = 1;

    CREATE TEMPORARY TABLE taSalida (
        _vaNomComunidad VARCHAR(50),
        _numMunicipios INT    
    );

    SET _iFinCursor = 0;
    OPEN curComunidades;
    FETCH curComunidades INTO _iCodComunidad;

    SET _municipiosmin = (SELECT count(*) FROM taMunicipios, taProvincias
    WHERE iRefProvincia=iCodProvincia AND iRefComunidad = _iCodComunidad);

    FETCH curComunidades INTO _iCodComunidad;
    WHILE _iFinCursor = 0 DO
        SELECT  count(*) INTO _sumamunicipios FROM taMunicipios, taProvincias
        WHERE iRefProvincia=iCodProvincia AND iRefComunidad = _iCodComunidad;
        IF _sumamunicipios < _municipiosmin THEN
            SET _municipiosmin = _sumamunicipios;
        END IF;
        FETCH curComunidades INTO _iCodComunidad;
    END WHILE;

    CLOSE curComunidades;

    SET _iFinCursor = 0;
    OPEN curComunidades;

    FETCH curComunidades INTO _iCodComunidad;
    WHILE _iFinCursor = 0 DO
        SELECT  count(*) INTO _sumamunicipios FROM taMunicipios, taProvincias
        WHERE iRefProvincia=iCodProvincia AND iRefComunidad = _iCodComunidad;
        IF _sumamunicipios = _municipiosmin THEN
            SET _NombreCom = (SELECT vaNomComunidad FROM taComunidades
            WHERE iCodComunidad = _iCodComunidad);
            INSERT INTO taSalida(_vaNomComunidad,_numMunicipios)
            VALUES (_NombreCom, _sumamunicipios);
        END IF;
        FETCH curComunidades INTO _iCodComunidad;
    END WHILE;

    CLOSE curComunidades;

    SELECT * FROM taSalida;

    DROP TEMPORARY TABLE taSalida;
END //
DELIMITER ;
