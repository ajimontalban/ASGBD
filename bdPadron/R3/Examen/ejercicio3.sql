DROP PROCEDURE IF EXISTS prMayorMenorPoblacion;
DELIMITER //
CREATE PROCEDURE prMayorMenorPoblacion(IN _NombreMunicipio VARCHAR(80),OUT _MenosPob INT, OUT _MasPob INT)
BEGIN
    DECLARE _NumeroPueblos INT;
    SET _NumeroPueblos = (SELECT count(iCodMunicipio) FROM taMunicipios
        WHERE vaNomMunicipio = _NombreMunicipio);
    IF _NumeroPueblos < 2 THEN
        BEGIN
            DECLARE _iFinCursor INT;
            DECLARE _PobMunicipioEntrada, _PobMunicipio, _iCodMunicipio INT;
            DECLARE _vaNomMunicipio VARCHAR(80);
            DECLARE curMunicipios CURSOR FOR 
            SELECT iCodMunicipio, vaNomMunicipio FROM taMunicipios
            WHERE iRefProvincia = (SELECT iRefProvincia FROM taMunicipios 
                WHERE vaNomMunicipio = _NombreMunicipio);

            DECLARE CONTINUE HANDLER FOR NOT FOUND SET _iFinCursor = 1;
            SET _iFinCursor = 0;
            SET _MenosPob = 0;
            SET _MasPob = 0;
            SET _PobMunicipioEntrada = (SELECT iPoblacion FROM taPoblacion,taMunicipios
                WHERE iRefMunicipio = iCodMunicipio AND vaNomMunicipio = _NombreMunicipio
                AND iAnio = 2024); 

            OPEN curMunicipios;

            FETCH curMunicipios INTO _iCodMunicipio, _vaNomMunicipio;
            WHILE _iFinCursor = 0 DO
                SET _PobMunicipio = (SELECT iPoblacion FROM taPoblacion, taMunicipios
                    WHERE iRefMunicipio = iCodMunicipio AND vaNomMunicipio = _vaNomMunicipio
                    AND iAnio = 2024);
                IF _PobMunicipio > _PobMunicipioEntrada THEN
                    SET _MasPob = _MasPob + 1;
                ELSEIF _PobMunicipio < _PobMunicipioEntrada THEN
                    SET _MenosPob = _MenosPob + 1;
                END IF;
                FETCH curMunicipios INTO _iCodMunicipio, _vaNomMunicipio;
            END WHILE;

            CLOSE curMunicipios;
        END ;
    ELSE 
        BEGIN
            DECLARE _iFinCursor1, _iCodMunicipio INT;
            DECLARE _vaNomProvincia VARCHAR(40);
            DECLARE _vaNomMunicipio VARCHAR(80);
            DECLARE _iRefProvincia INT;

            DECLARE curRepetidos CURSOR FOR
            SELECT iCodMunicipio, vaNomMunicipio, iRefProvincia,vaNomProvincia 
            FROM taMunicipios, taProvincias WHERE iRefProvincia = iCodProvincia
            AND vaNomMunicipio = _NombreMunicipio;
            DECLARE CONTINUE HANDLER FOR NOT FOUND SET _iFinCursor1 = 1;
            
            CREATE TEMPORARY TABLE IF NOT EXISTS taSalida (
                NombreProvincia VARCHAR(40),
                vaNomMunicipio VARCHAR(80),
                MayorPoblacion INT,
                MenorPoblacion INT
            );

            SET _iFinCursor1 = 0;
            OPEN curRepetidos;

            FETCH curRepetidos INTO _iCodMunicipio,_vaNomMunicipio,
            _iRefProvincia, _vaNomProvincia;
            WHILE _iFinCursor1 = 0 DO
                BEGIN
                    DECLARE _iFinCursor INT;
                    DECLARE _PobMunicipioEntrada, _PobMunicipio  INT;
                    DECLARE _vaNomMunicipio2 VARCHAR(80);
                    DECLARE _iCodMunicipio2 INT;

                    DECLARE curMunicipios CURSOR FOR 
                    SELECT iCodMunicipio, vaNomMunicipio FROM taMunicipios
                    WHERE iRefProvincia = (SELECT DISTINCT iRefProvincia FROM taMunicipios 
                        WHERE iCodMunicipio = _iCodMunicipio);

                    DECLARE CONTINUE HANDLER FOR NOT FOUND SET _iFinCursor = 1;
                    SET _iFinCursor = 0;
                    SET _MenosPob = 0;
                    SET _MasPob = 0;
                    SET _PobMunicipioEntrada = (SELECT iPoblacion FROM taPoblacion,taMunicipios
                        WHERE iRefMunicipio = _iCodMunicipio AND iAnio = 2024); 

                    OPEN curMunicipios;

                    FETCH curMunicipios INTO _iCodMunicipio2, _vaNomMunicipio2;
                    WHILE _iFinCursor = 0 DO
                        SET _PobMunicipio = (SELECT iPoblacion FROM taPoblacion
                            WHERE iRefMunicipio = _iCodMunicipio2
                            AND iAnio = 2024);
                        IF _PobMunicipio > _PobMunicipioEntrada THEN
                            SET _MasPob = _MasPob + 1;
                        ELSEIF _PobMunicipio < _PobMunicipioEntrada THEN
                            SET _MenosPob = _MenosPob + 1;
                        END IF;
                        FETCH curMunicipios INTO _iCodMunicipio2, _vaNomMunicipio2;
                    END WHILE;

                    INSERT INTO taSalida (
                    NombreProvincia ,
                    vaNomMunicipio ,
                    MayorPoblacion ,
                    MenorPoblacion) VALUES (
                    _vaNomProvincia, 
                    _vaNomMunicipio2,
                    _MasPob,
                    _MenosPob);

                    CLOSE curMunicipios;
                END ;
                FETCH curRepetidos INTO _iCodMunicipio,_vaNomMunicipio,
                _iRefProvincia, _vaNomProvincia;
            END WHILE;
            CLOSE curRepetidos;

            SELECT * FROM taSalida;

            DROP TEMPORARY TABLE taSalida;
        END ;
    END IF;
END // 
DELIMITER ;
