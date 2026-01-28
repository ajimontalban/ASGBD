DROP PROCEDURE IF EXISTS area_circulo;
DELIMITER //
CREATE PROCEDURE area_circulo(IN radio float, out area float)
BEGIN
    SET area = pi()*pow(radio,2);
END//
DELIMITER ;
    
DROP PROCEDURE IF EXISTS area_rombo;
DELIMITER //
CREATE PROCEDURE area_rombo(IN d1 float, IN d2 float, out area float)
BEGIN
    SET area = (d1 * d2) / 2;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS Aleatorios;
DELIMITER //
CREATE PROCEDURE Aleatorios(IN n int)
BEGIN
    DECLARE contador int default 0;

    WHILE contador < n do
        SELECT rand();
        SET contador = contador + 1;
    END WHILE;
END//
DELIMITER ;
    
