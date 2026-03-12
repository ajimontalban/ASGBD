DROP PROCEDURE IF EXISTS prExisteMunicipio;
DELIMITER //
CREATE PROCEDURE prExisteMunicipio(IN _anio INT)
BEGIN
    DECLARE _iFinCursor,_NoHayDato, _iRefMunicipio  INT;
    DECLARE _minAnio, _MaxAnio INT
    DECLARE _anioAnterior INT;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET _iFinCursor = 1;

    DECLARE curMunicipios CURSOR  FOR
    SELECT iRefMunicipio FROM taPoblacion WHERE iAnio = _anio;

    CREATE TEMPORARY TABLE taSalida (
        NombrePueblo VARCHAR(80),
        NoHayDatos INT)

    SET _iFinCursor = 0;
    SET _NoHayDato = 0;
    SET _minAnio = (select DISTINCT min(iAnio) from taPoblacion);
    SET _MaxAnio = (select DISTINCT max(iAnio) from taPoblacion);
    SET _anioAnterior = _anio -1;

    IF (_anio < _minAnio or _anio >_MaxAnio) THEN
        set _NoHayDato = 1;
    ELSE
       OPEN curMunicipios;

    FETCH curMunicipios INTO _iRefMunicipio;
    While _iFinCursor = 0 DO
        set _iRefMunicipio = (SELECT iRefMunicipio FROM taPoblacion, taMunicipios
            WHERE iRefMunicipio = iCodMunicipio and iAnio = _anio and iRefMunicipio
            not in (Select iRefMunicipio FROM taPoblacion where iAnio = _anioAnterior));
        FETCH curMunicipios INTO _iRefMunicipio;
    END WHILE;
        

    

END // 
DELIMITER ;
