SELECT iCodMunicipio, vaNomMunicipio
FROM taPoblacion inner join taMunicipios
ON iRefMunicipio = iCodMunicipio
WHERE iAnio = 2024 and iRefProvincia = 11
ORDER BY iPoblacion ASC
LIMIT 3;
