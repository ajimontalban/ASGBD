DROP PROCEDURE IF EXISTS prProvinciaMasHombres;
DELIMITER //
CREATE PROCEDURE prProvinciaMasHombres()
BEGIN

    DECLARE _iFinCursor INT;
    DECLARE _iCodProvincia INT;
    DECLARE _dHombres, _dMujeres DECIMAL(14,2);
    DECLARE _vaNomProvincia VARCHAR(40);

    DECLARE curProvincias CURSOR FOR
        SELECT iCodProvincia FROM taProvincias;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET _iFinCursor = 1;

    CREATE TEMPORARY TABLE IF NOT EXISTS taSalida (
 
        NombreProvincia VARCHAR(40),
        PobHombres DECIMAL(14,2),
        PobMujeres DECIMAL(14,2)
    );

    SET _iFinCursor = 0;
    
    OPEN curProvincias;

    FETCH curProvincias INTO _iCodProvincia;
    WHILE _iFinCursor = 0 DO
        select  sum(dPoblacion) INTO _dHombres FROM taPoblacionEdadesProvincias 
        WHERE iRefProvincia = _iCodProvincia AND iAnio = 2022 
        AND iPeriodo = 2 AND cSexo = 'H' AND iEdad >= 18;

        select  sum(dPoblacion) INTO _dMujeres FROM taPoblacionEdadesProvincias 
        WHERE iRefProvincia = _iCodProvincia AND iAnio = 2022 
        AND iPeriodo = 2 AND cSexo = 'M' AND iEdad >= 18;

        IF _dHombres > _dMujeres THEN
            SET _vaNomProvincia = (SELECT vaNomProvincia FROM taProvincias
            WHERE iCodProvincia = _iCodProvincia);
            INSERT INTO taSalida (NombreProvincia, PobHombres, PobMujeres)
            VALUES (_vaNomProvincia, _dHombres, _dMujeres);
        END IF;
        FETCH curProvincias INTO _iCodProvincia;
    END WHILE;

    SELECT *  FROM taSalida;

    CLOSE curProvincias;
    DROP TEMPORARY TABLE taSalida;
END //
DELIMITER ;
