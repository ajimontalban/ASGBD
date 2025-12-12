# Relación 2 MySQL

## E1
En qué año se creó como población independiente San Martín del Tesorillo, antigua pedanía de
Jerez de la Frontera. Resuelve la consulta de dos formas distintas.

```mysql
SELECT iAnio 
FROM taPoblacion
INNER JOIN taMunicipios
ON iRefMunicipio=iCodMunicipio
WHERE vaNomMunicipio = 'San Martín del Tesorillo'
ORDER BY iAnio ASC LIMIT 1;

SELECT iAnio
FROM taPoblacion
WHERE iRefMunicipio = (
    SELECT iCodMunicipio
    FROM taMunicipios
    WHERE vaNomMunicipio = 'San Martín del Tesorillo')
ORDER BY iAnio ASC LIMIT 1;
```

## E2
Qué pueblos tienen o tuvieron un nombre repetido.
```mysql
SELECT DISTINCT t1.vaNomMunicipio
FROM taMunicipios as t1
JOIN taMunicipios as t2
WHERE t1.vaNomMunicipio = t2.vaNomMuncipio and t1.iCodMunicipio != t2.iCodMunicipio;
```

## E3
Qué municipios hay actualmente en la provincia de Huelva.
```mysql
SELECT vaNomMunicipio
FROM taMunicipios
JOIN taPoblacion
ON iRefMunicipio = iCodMunicipio
WHERE iAnio = 2024 and iRefProvincia in (
    SELECT iCodProvincia
    FROM taProvincias
    WHERE vaNomProvincia = 'Huelva') ;
```

## E4
Qué pueblos ya no existen.
```mysql
SELECT vaNomMunicipio
FROM taMunicipios
WHERE vaNomMunicipio NOT IN (
    SELECT vaNomMunicipio
    FROM taMunicipios,taPoblacion
    WHERE iRefMunicipio = iCodMunicipio and iAnio = 2024);
```

## E5
 Qué municipios tienen un nombre de cinco 
caracteres, comienza por “Al” y existen.
```mysql
SELECT vaNomMunicipio
FROM taMunicipios,taPoblacion
WHERE iRefMunicipio = iCodMunicipio and iAnio = 2024 and vaNomMunicipio
LIKE 'Al___';
```

## E6
 Qué municipios tienen un nombre de cinco 
caracteres, comienza por “Al” y ya no existen.
```mysql
SELECT DISTINCT vaNomMunicipio
FROM taMunicipios,taPoblacion
WHERE iRefMunicipio = iCodMunicipio  and vaNomMunicipio LIKE 'Al___' 
and vaNomMunicipio NOT IN (
    SELECT vaNomMunicipio
    FROM taMunicipios,taPoblacion
    WHERE iRefMunicipio = iCodMunicipio  and iAnio = 2024); 
```

## E7
Qué provincias de España tienen ciudades con una población 
superior a 200000 habitantes.
```mysql
SELECT vaNomProvincia
FROM taProvincias,  taMunicipios
WHERE iRefProvincia = iCodProvincia 
AND iCodMunicipio in (
    SELECT iRefMunicipio
    FROM taPoblacion
    WHERE (iHombres + iMujeres) > 200000)
GROUP BY vaNomProvincias;
```

## E8
Qué provincias de España no tienen ciudades con una 
población superior a 200000 habitantes.
```mysql
SELECT vaNomProvincia
FROM taProvincias,  taMunicipios
WHERE iRefProvincia = iCodProvincia 
AND iCodProvincia not in(
    SELECT iRefProvincia
    FROM taMunicipios
    WHERE iCodMunicipio  in (
    SELECT iRefMunicipio
    FROM taPoblacion
    WHERE (iHombres + iMujeres) > 200000))
GROUP BY vaNomProvincia;
```

## E9
Cuáles son las tres provincias de España con mayor número de 
municipios y cuántos tienen.
```mysql
SELECT vaNomProvincia, count(iCodMunicipio) as NumMunicipios
FROM taProvincias
JOIN taMunicipios
ON iCodProvincia = iRefProvincia
JOIN taPoblacion
ON iCodMunicipio = iRefMunicipio
WHERE iAnio = 2024
GROUP BY vaNomProvincia
ORDER BY NumMunicipios DESC 
LIMIT 3;
```

## E10
Cuáles son las tres provincias de España con más población y cuánta
```mysql
SELECT vaNomProvincia, sum(iHombres + iMujeres)) AS nPoblacion
FROM taProvincias
JOIN taMunicipios
ON iCodProvincia = iRefProvincia
JOIN taPoblacion
ON iCodMunicipio = iRefMunicipio
WHERE iAnio = 2024
GROUP BY vaNomProvincia
ORDER BY nPoblacion DESC 
LIMIT 3;
```

## E11
Qué municipios ya no existen. Muestra también 
la provincia a la que pertenecieron.
```mysql
SELECT vaNomMunicipio, vaNomProvincia
FROM taMunicipios
JOIN taProvincias
ON iRefProvincia = iCodProvincia
WHERE vaNomMunicipio NOT IN (
    SELECT vaNomMunicipio
    FROM taMunicipios,taPoblacion
    WHERE iRefMunicipio = iCodMunicipio and iAnio = 2024);
```

## E12
Qué provincias han perdido población en el último año
```mysql

SELECT vaNomProvincia
from taProvincias
WHERE (
    SELECT SUM(iHombres + iMujeres)
    FROM taMunicipioes
    JOIN taPoblacion
    ON iRefMunicipio = iCodMunicipio
    WHERE  iRefProvincia = iCodProvincia AND iAnio = 2024) < (
    SELECT SUM(iHombres + iMujeres)
    FROM taMunicipioes
    JOIN taPoblacion
    ON iRefMunicipio = iCodMunicipio
    WHERE iRefProvincia = iCodProvincia AND iAnio = 2023);
```
