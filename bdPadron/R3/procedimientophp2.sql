DROP PROCEDURE IF EXISTS prDatosCirculo;
DELIMITER //
CREATE PROCEDURE prDatosCirculo(IN _radio FLOAT, OUT _perimetro FLOAT, OUT _area FLOAT, OUT _volumen FLOAT)
BEGIN
    SET _perimetro = (SELECT 2 * PI() * _radio);
    SET _area = (SELECT  PI() * (_radio * _radio));
    SET _volumen = (SELECT (4 / 3) * PI() * (_radio * _radio * _radio));
END //
DELIMITER ;
