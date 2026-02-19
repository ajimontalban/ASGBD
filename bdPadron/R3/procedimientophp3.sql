DROP PROCEDURE IF EXISTS prMunicipiosProvincia;
DELIMITER //
CREATE PROCEDURE prMunicipiosProvincia(IN _vaNomProvincia varchar(40))
BEGIN
    select vaNomMunicipio
    from taMunicipios,taProvincias
    where iRefProvincia = iCodProvincia 
    and vaNomProvincia = _vaNomProvincia
    order by vaNomMunicipio asc;
END //
DELIMITER ;
