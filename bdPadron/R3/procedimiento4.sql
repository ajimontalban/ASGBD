DROP PROCEDURE IF EXISTS prProvinciaMasHombres;
DELIMITER //
CREATE PROCEDURE prProvinciaMasHombres()
BEGIN
    CREATE TEMPORARY TABLE test (
    
        NombreProvincia VARCHAR(40),
        PobHombres DECIMAL(14,2),
        PobMujeres DECIMAL(14,2)
    )

    DECLARE _iFinCursor,_iCodProvincia INT;
    DECLARE _dHombres, _dMujeres DECIMAL(14,2);
    DECLARE _vaNomProvincia VARCHAR(40);

    DECLARE curProvincias CURSOR FOR
        SELECT iCodProvincias FROM taProvincias;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET _iFinCursor = 1;

    SET _iFinCursor = 0;
    
    OPEN curProvincias;

    FETCH curProvincias INTO _iCodProvincia;
    WHILE _iFinCursor = 0 DO
        select _dHombres:= dPoblacion FROM taPoblacionEdadesProvincias 
        WHERE iRefProvincia = _iCodProvincia AND iAnio = 2024 
        AND iPeriodo = 2 AND cSexo = 'H' AND iEdad >= 18;

        select _dMujeres:= dPoblacion FROM taPoblacionEdadesProvincias 
        WHERE iRefProvincia = _iCodProvincia AND iAnio = 2024 
        AND iPeriodo = 2 AND cSexo = 'M' AND iEdad >= 18;

        IF(_dHombres > _dMujeres) THEN
            SET _vaNomProvincia = (SELECT vaNomProvincia FROM taProvincias
            WHERE iCodProvincia = _iCodProvincia);
        INSERT INTO test (_vaNomProvincia, _dHombres, _dMujeres);
        END IF;
        FETCH curProvincias INTO _iCodProvincia;
    END WHILE;

    SELECT test;

    CLOSE curProvincias;
    DROP test;
END //
DELIMITER ;
