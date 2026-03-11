DROP PROCEDURE IF EXISTS prProvinciaMenorPoblacion;
DELIMITER //
CREATE PROCEDURE prProvinciaMenorPoblacion()
BEGIN
    DECLARE _iFinCursor INT;
    DECLARE _iCodProvincia, _sumaMunicipios, _sumaMunicipiosMenor INT;
    DECLARE _vaNomProvincia, _vaNomProvinciaMin VARCHAR(40);

    DECLARE curProvincia CURSOR FOR 
    SELECT iCodProvincia, vaNomProvincia FROM taProvincias;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET _iFinCursor = 1;

    CREATE TEMPORARY TABLE IF NOT EXISTS taSalida (
        NombreProvincia VARCHAR(40)
    );

    SET _iFinCursor = 0;

    OPEN curProvincia;
    
    FETCH curProvincia INTO _iCodProvincia, _vaNomProvincia;
    SET _sumaMunicipiosMenor = (select sum(iPoblacion) from (select iPoblacion from taPoblacion, taMunicipios where iRefMunicipio = iCodMunicipio and iRefProvincia = _iCodProvincia and iAnio = 2024 order by iPoblacion asc limit 3) as t1);


    FETCH curProvincia INTO _iCodProvincia, _vaNomProvincia;
    WHILE(_iFinCursor = 0) DO
        SET _sumaMunicipios = (select sum(iPoblacion) from (select iPoblacion from taPoblacion, taMunicipios where iRefMunicipio = iCodMunicipio and iRefProvincia = _iCodProvincia and iAnio = 2024 order by iPoblacion asc limit 3) as t1);

        IF(_sumaMunicipiosMenor > _sumaMunicipios) THEN
            SET _sumaMunicipiosMenor = _sumaMunicipios;
        END IF;
        FETCH curProvincia INTO _iCodProvincia, _vaNomProvincia;
    END WHILE;

    CLOSE curProvincia;

    SET _iFinCursor = 0;

    OPEN curProvincia;

    FETCH curProvincia INTO _iCodProvincia, _vaNomProvincia;
    WHILE(_iFinCursor = 0) DO
        SET _sumaMunicipios = (select sum(iPoblacion) from (select iPoblacion from taPoblacion, taMunicipios where iRefMunicipio = iCodMunicipio and iRefProvincia = _iCodProvincia and iAnio = 2024 order by iPoblacion asc limit 3) as t1);

        IF(_sumaMunicipios = _sumaMunicipiosMenor) THEN
            INSERT INTO taSalida (NombreProvincia)
            VALUES (_vaNomProvincia);
        END IF;
        FETCH curProvincia INTO _iCodProvincia, _vaNomProvincia;
    END WHILE;

    CLOSE curProvincia;

    SELECT * FROM taSalida;

    DROP TEMPORARY TABLE taSalida;

END //
DELIMITER ;
