DROP PROCEDURE IF EXISTS prUltAnio;
DELIMITER //
CREATE PROCEDURE prUltAnio(OUT iUltAnio INT)
BEGIN
    SET iUltAnio = (SELECT max(iAnio) from taPoblacion);
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS priPoblacionMunicipio;
DELIMITER //
CREATE PROCEDURE priPoblacionMunicipio(IN _municipio VARCHAR(80), IN _entero INT)
BEGIN
    SELECT iPoblacion FROM taPoblacion, taMunicipios
    WHERE iRefMunicipio=iCodMunicipio and vaNomMunicipio = _municipio
    ORDER BY iAnio DESC
    LIMIT _entero;
END //
DELIMITER ;
