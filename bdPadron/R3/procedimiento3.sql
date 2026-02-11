DROP PROCEDURE IF EXISTS prComunidadesMasMunicipios;
DELIMITER //
CREATE PROCEDURE prComunidadesMasMunicipios()
BEGIN
    DECLARE _iFinCursor INT;
    DECLARE _sumamunicipios INT;
    DECLARE _municipiosmax INT;
    DECLARE _iCodComunidad INT;
    DECLARE _iCodComunidadMax INT;

    CREATE TEMPORARY TABLE tabla_temporal (
        _comunidad VARCHAR(80);
        _municipios  INT;
    );

    DECLARE curComunidades CURSOR FOR
        SELECT iCodComunidad FROM taComunidades;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET _iFinCursor = 1;

    SET _iFinCursor = 0;
    SET _municipiosmax = -1;

    OPEN curComunidades;
    FETCH curComunidades INTO _iCodComunidad;
    WHILE _iFinCursor = 0 DO
        SELECT _sumamunicipios := count(*) FROM taMunicipios, taProvincias
        WHERE iRefProvincia=iCodProvincia AND iRefComunidad = _iCodComunidad;
        IF _sumamunicipios > _municipiosmax THEN
            SET _municipiosmax = _sumamunicipios;
            SET _iCodComunidadMax = _iCodComunidad;
        END IF;
        FETCH curComunidades INTO _iCodComunidad;
    END WHILE;

END //
DELIMITER ;
