DROP PROCEDURE IF EXISTS prPoblacion;
DELIMITER //
CREATE PROCEDURE prPoblacion(IN _municipio VARCHAR(80), IN _iAnio INT, OUT _PoblacionHombres INT,
OUT _PoblacionMujeres INT, OUT _PoblacionTotal INT )
BEGIN
    SELECT iHombres,iMujeres, iPoblacion INTO _PoblacionHombres, _PoblacionMujeres, _PoblacionTotal FROM taPoblacion 
    WHERE iAnio = _iAnio AND iRefMunicipio = (SELECT iCodMunicipio
    FROM taMunicipios WHERE vaNomMunicipio = _municipio);
END //
DELIMITER ;
