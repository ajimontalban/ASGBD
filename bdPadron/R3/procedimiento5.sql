DROP PROCEDURE IF EXISTS prNacimientosNinas;
DELIMITER //
CREATE PROCEDURE prNacimientosNinas(IN _anio INT)
BEGIN
    DECLARE _iFinCursor1 INT;
    DECLARE _iCodProvincia INT;
    DECLARE _vaNomProvincia VARCHAR(40);
    DECLARE _dPob1, _dPob2, _dPob3, _dPob4 DECIMAL(14,2);
    DECLARE _anio1, _anio2, _anio3, _anio4 INT;

    DECLARE curProvincia CURSOR FOR 
    SELECT iCodProvincia, vaNomProvincia FROM taProvincias;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET _iFinCursor1 = 1;

    CREATE TEMPORARY TABLE IF NOT EXISTS taSalida (
        NombreProvincia VARCHAR(40),
        Pob1 DECIMAL(14,2),
        Pob2 DECIMAL(14,2),
        Pob3 DECIMAL(14,2),
        Pob4 DECIMAL(14,2)
    );

    SET _iFinCursor1 = 0;
    SET _anio1 = _anio;
    SET _anio2 = _anio1 - 1;
    SET _anio3 = _anio2 - 1;
    SET _anio4 = _anio3 - 1;
    
    OPEN curProvincia;

    FETCH curProvincia INTO _iCodProvincia, _vaNomProvincia;
    WHILE (_iFinCursor1 = 0) DO
        SET _dPob1 = (SELECT sum(dPoblacion) FROM taPoblacionEdadesProvincias
        WHERE iAnio = _anio1 and cSexo = 'M' and iPeriodo = 2 and iEdad = 0 and 
        iRefProvincia = _iCodProvincia);
        SET _dPob2 = (SELECT sum(dPoblacion) FROM taPoblacionEdadesProvincias
        WHERE iAnio = _anio2 and cSexo = 'M' and iPeriodo = 2 and iEdad = 0 and 
        iRefProvincia = _iCodProvincia);
        SET _dPob3 = (SELECT sum(dPoblacion) FROM taPoblacionEdadesProvincias
        WHERE iAnio = _anio3 and cSexo = 'M' and iPeriodo = 2 and iEdad = 0 and 
        iRefProvincia = _iCodProvincia);
        SET _dPob4 = (SELECT sum(dPoblacion) FROM taPoblacionEdadesProvincias
        WHERE iAnio = _anio4 and cSexo = 'M' and iPeriodo = 2 and iEdad = 0 and 
        iRefProvincia = _iCodProvincia);
        IF(_dPob1 < _dPob2 && _dPob2 < _dPob3 && _dPob3 < _dPob4) THEN
            INSERT INTO taSalida (NombreProvincia, Pob1,Pob2, Pob3, Pob4)
            VALUES (_vaNomProvincia, _dPob1,_dPob2,_dPob3,_dPob4);
        END IF;
        FETCH curProvincia INTO _iCodProvincia, _vaNomProvincia;
    END WHILE;

    SELECT * FROM taSalida;

    CLOSE curProvincia;
    DROP TEMPORARY TABLE taSalida;
END //
DELIMITER ;
