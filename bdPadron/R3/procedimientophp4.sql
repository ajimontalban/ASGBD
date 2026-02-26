DROP PROCEDURE IF EXISTS prComunidades;
DELIMITER //
CREATE PROCEDURE prComunidades()
BEGIN
    select vaNomComunidad
    from taComunidades
    order by vaNomComunidad asc;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS pr5UltAnio;
DELIMITER //
CREATE PROCEDURE pr5UltAnio()
BEGIN
    select DISTINCT iAnio
    from taPoblacion
    order by iAnio DESC LIMIT 5;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS prPoblacionComunidad;
DELIMITER //
CREATE PROCEDURE prPoblacionComunidad(IN _vaNomComunidad VARCHAR(50), IN _iAnio INT, OUT _Poblacion INT)
BEGIN
    SELECT sum(iPoblacion) as Poblacion
    FROM taPoblacion,taMunicipios,taProvincias,taComunidades
    WHERE iRefMunicipio = iCodMunicipio AND iRefProvincia = iCodProvincia
    AND iRefComunidad = iCodComunidad AND vaNomComunidad = _vaNomComunidad 
    AND iAnio = _iAnio INTO _Poblacion;
END //
DELIMITER ;
