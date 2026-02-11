DROP PROCEDURE IF EXISTS prComMasMunicipios;
DELIMITER //
CREATE PROCEDURE prComMasMunicipios(OUT _vaNomComunidadMasMunicipios VARCHAR(50))
BEGIN
    DECLARE _iFinCursor INT;
    DECLARE _iMaxMunicipios INT;
    DECLARE _iCodComunidad INT;
    DECLARE _iCodComunidadMax INT;
    DECLARE _iSumaMunicipios INT;
    
    DECLARE curComunidades CURSOR FOR
    SELECT iCodComunidad FROM taComunidades
    WHERE iCodComunidad != 18 AND iCodComunidad != 19;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET _iFinCursor = 1;

    SET _iFinCursor = 0;
    SET _iMaxMunicipios = -1;

    OPEN curComunidades;

    FETCH curComunidades INTO _iCodComunidad;
    WHILE _iFinCursor = 0 DO
        SET _iSumaMunicipios = (
            SELECT count(iCodMunicipio)
            FROM taMunicipios, taProvincias
            WHERE iRefProvincia = iCodProvincia and iRefComunidad = _iCodComunidad
        );
        IF _iSumaMunicipios > _iMaxMunicipios THEN
            SET _iMaxMunicipios = _iSumaMunicipios;
            SET _iCodComunidadMax = _iCodComunidad;
        END IF;
        FETCH curComunidades INTO _iCodComunidad;
    END WHILE;
    SET _vaNomComunidadMasMunicipios = (
        SELECT vaNomComunidad FROM taComunidades
        WHERE iCodComunidad = _iCodComunidadMax
    );

    CLOSE curComunidades;
END //
DELIMITER ;

