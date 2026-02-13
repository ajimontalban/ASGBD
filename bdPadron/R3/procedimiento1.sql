-- Metodo 1
DROP PROCEDURE IF EXISTS prComunidadPoblacionMinima;
DELIMITER //
CREATE PROCEDURE prComunidadPoblacionMinima(OUT _vaNomComunidadProvinciaMin VARCHAR(30))
BEGIN
    DECLARE _iCodComunidad INT;
    DECLARE _iFinCursor INT;
    DECLARE _sumaprovincia INT;
    DECLARE _iPoblacionMin, _iCodComunidadMin INT;

    DECLARE curComunidades CURSOR FOR
    SELECT iCodComunidad from taComunidades 
    WHERE iCodComunidad != 18 AND iCodComunidad != 19;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET _iFinCursor = 1;

    SET _iFinCursor = 0;
    SET _iPoblacionMin = 100000000;

    OPEN curComunidades;

    FETCH curComunidades INTO _iCodComunidad;
    WHILE _iFinCursor = 0 DO
        SET _sumaprovincia = (
        select sum(iPoblacion) as sumaprovincia
        from taPoblacion,taMunicipios,taProvincias
        where iRefMunicipio = iCodMunicipio 
        and   iRefProvincia = iCodProvincia
        and iAnio = 2024 and iRefComunidad = _iCodComunidad
        group by iCodProvincia
        order by sumaprovincia asc
        limit 1);
        IF _sumaprovincia < _iPoblacionMin THEN
            SET _iPoblacionMin = _sumaprovincia;
            SET _iCodComunidadMin = _iCodComunidad;
        END IF;
        FETCH curComunidades INTO _iCodComunidad;
    END WHILE;

    SELECT vaNomComunidad into _vaNomComunidadProvinciaMin
    FROM taComunidades
    WHERE iCodComunidad = _iCodComunidadMin;

    CLOSE curComunidades;
END //
DELIMITER ;

-- Metodo 2
DROP PROCEDURE IF EXISTS prComunidadPoblacionMinima;
DELIMITER //
CREATE PROCEDURE prComunidadPoblacionMinima(OUT _vaNomComunidadProvinciaMin VARCHAR(30))
BEGIN
    DECLARE _iCodComunidad INT;
    DECLARE _iFinCursor INT;
    DECLARE _sumaprovincia INT;
    DECLARE _iPoblacionMin, _iCodComunidadMin INT;

    DECLARE curComunidades CURSOR FOR
    SELECT iCodComunidad from taComunidades 
    WHERE iCodComunidad != 18 AND iCodComunidad != 19;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET _iFinCursor = 1;

    SET _iFinCursor = 0;
    SET _iPoblacionMin = (
        select sum(iPoblacion) as sumaprovincia
        from taPoblacion,taMunicipios,taProvincias
        where iRefMunicipio = iCodMunicipio 
        and   iRefProvincia = iCodProvincia
        and iAnio = 2024 and iRefComunidad = 1
        group by iCodProvincia
        order by sumaprovincia asc
        limit 1);
    SET _iCodComunidadMin = 1;

    OPEN curComunidades;

    FETCH curComunidades INTO _iCodComunidad;
    WHILE _iFinCursor = 0 DO
        SET _sumaprovincia = (
        select sum(iPoblacion) as sumaprovincia
        from taPoblacion,taMunicipios,taProvincias
        where iRefMunicipio = iCodMunicipio 
        and   iRefProvincia = iCodProvincia
        and iAnio = 2024 and iRefComunidad = _iCodComunidad
        group by iCodProvincia
        order by sumaprovincia asc
        limit 1);
        IF _sumaprovincia < _iPoblacionMin THEN
            SET _iPoblacionMin = _sumaprovincia;
            SET _iCodComunidadMin = _iCodComunidad;
        END IF;
        FETCH curComunidades INTO _iCodComunidad;
    END WHILE;

    SELECT vaNomComunidad into _vaNomComunidadProvinciaMin
    FROM taComunidades
    WHERE iCodComunidad = _iCodComunidadMin;

    CLOSE curComunidades;
END //
DELIMITER ;

-- Metodo 3
DROP PROCEDURE IF EXISTS prComunidadPoblacionMinima;
DELIMITER //
CREATE PROCEDURE prComunidadPoblacionMinima(OUT _vaNomComunidadProvinciaMin VARCHAR(30))
BEGIN
    DECLARE _iCodComunidad INT;
    DECLARE _iFinCursor INT;
    DECLARE _sumaprovincia INT;
    DECLARE _iPoblacionMin, _iCodComunidadMin INT;

    DECLARE curComunidades CURSOR FOR
    SELECT iCodComunidad from taComunidades 
    WHERE iCodComunidad != 18 AND iCodComunidad != 19;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET _iFinCursor = 1;

    SET _iFinCursor = 0;

    OPEN curComunidades;

    FETCH curComunidades INTO _iCodComunidad;

    SET _iPoblacionMin = (
        select sum(iPoblacion) as sumaprovincia
        from taPoblacion,taMunicipios,taProvincias
        where iRefMunicipio = iCodMunicipio 
        and   iRefProvincia = iCodProvincia
        and iAnio = 2024 and iRefComunidad = _iCodComunidad
        group by iCodProvincia
        order by sumaprovincia asc
        limit 1);

    SET _iCodComunidadMin = _iCodComunidad;

    WHILE _iFinCursor = 0 DO
        SET _sumaprovincia = (
        select sum(iPoblacion) as sumaprovincia
        from taPoblacion,taMunicipios,taProvincias
        where iRefMunicipio = iCodMunicipio 
        and   iRefProvincia = iCodProvincia
        and iAnio = 2024 and iRefComunidad = _iCodComunidad
        group by iCodProvincia
        order by sumaprovincia asc
        limit 1);
        IF _sumaprovincia < _iPoblacionMin THEN
            SET _iPoblacionMin = _sumaprovincia;
            SET _iCodComunidadMin = _iCodComunidad;
        END IF;
        FETCH curComunidades INTO _iCodComunidad;
    END WHILE;

    SELECT vaNomComunidad into _vaNomComunidadProvinciaMin
    FROM taComunidades
    WHERE iCodComunidad = _iCodComunidadMin;

    CLOSE curComunidades;
END //
DELIMITER ;
