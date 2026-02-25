DROP PROCEDURE IF EXISTS prNacimientosNiñas;
DELIMITER //
CREATE PROCEDURE prNacimientosNiñas(IN _anio INT); -- posible variable de entrada `edad` para reusar
BEGIN                                   -- el cursor
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
    
    

END //
DELIMITER ;
