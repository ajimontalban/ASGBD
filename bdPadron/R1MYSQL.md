# Relación de ejercicios 1 SQL 
## Ejercicio 1

```sql
select * from taProvincias;
```

## Ejercicio 2
> Cuantas provincias hay en España
```sql
select count(*) from taProvincias;
```

## Ejercicio 3
> Cuantas provincias hay en España. Debe usarse solo la tabla taMunicipios
```sql
select count(DISTINCT iRefProvincia) AS NProvincias from taMunicipios;
```
## Ejercicio 4
Qué municipios tienen un nombre de cinco caracteres y comienza por “Al”.
```sql
SELECT * FROM taMunicipios WHERE vaNomMunicipio LIKE 'Al___';
```
## Ejercicio 5
Qué municipios tienen un nombre que comience por “Al”.
```sql
SELECT * FROM taMunicipios WHERE vaNomMunicipio LIKE 'Al%';
```
## Ejercicio 6
Cuáles son los municipios de la provincia de Cádiz. Resuélvelo de dos formas distintas.
```sql
# Con Join
SELECT vaNomMunicipio, vaNomProvincia  
FROM taProvincias AS PR 
INNER JOIN taMunicipios AS MU 
ON PR.iCodProvincia=MU.iRefProvincia 
WHERE PR.vaNomProvincia = 'Cádiz';

# Con Subconsulta
SELECT vaNomMunicipio  
FROM taMunicipios AS MU 
WHERE MU.iRefProvincia = (
    SELECT iCodProvincia 
    FROM taProvincias AS PR 
    WHERE vaNomProvincia ='Cádiz'
);
```
## Ejercicio 7
Cuántos son los municipios de la provincia de Sevilla. Resuélvelo de dos formas distintas.
```sql
# Con Join
SELECT count(vaNomMunicipio) AS NumMunicipioSev 
FROM taProvincias AS PR 
INNER JOIN taMunicipios AS MU 
ON PR.iCodProvincia=MU.iRefProvincia  
WHERE PR.vaNomProvincia = 'Sevilla';

# Con Subconsulta
SELECT count(vaNomMunicipio) AS NumMunicipiosSev  
FROM taMunicipios AS MU 
WHERE MU.iRefProvincia = (
    SELECT iCodProvincia 
    FROM taProvincias AS PR 
    WHERE vaNomProvincia ='Sevilla'
);
```
## Ejercicio 8
Cuántos municipios hay en Extremadura. Resuélvelo de dos formas distintas.
```sql
# Con Join
SELECT count(vaNomMunicipio) AS NumMunicipioEXT 
FROM taProvincias AS PR 
INNER JOIN taMunicipios AS MU 
ON PR.iCodProvincia=MU.iRefProvincia  
WHERE PR.vaNomProvincia = 'Cáceres' OR PR.vaNomProvincia = 'Badajoz';

# Con Subconsulta
SELECT count(vaNomMunicipio) AS NumMunicipiosEXT  
FROM taMunicipios AS MU 
WHERE MU.iRefProvincia = ANY (
    SELECT iCodProvincia 
    FROM taProvincias AS PR 
    WHERE vaNomProvincia ='Cáceres' OR vaNomProvincia ='Badajoz'
);
```
## Ejercicio 9
Cuántos municipios hay en Extremadura. Resuélvelo de dos formas distintas.
```sql
# Con Join
SELECT vaNomMunicipio, vaNomProvincia, (iMujeres + iHombres) AS NumHab 
FROM taProvincias as PR 
INNER JOIN taMunicipios AS MU 
ON PR.iCodProvincia = MU.iRefProvincia 
INNER JOIN taPoblacion AS PO 
ON MU.iCodMunicipio = PO.iRefMunicipio  
WHERE PO.iAnio LIKE '2024%' AND PR.vaNomProvincia = 'Cádiz' AND (iMujeres + iHombres) BETWEEN 5000 AND 10000;

# Con Join 2
SELECT vaNomMunicipio, vaNomProvincia, (iMujeres + iHombres) AS NumHab 
FROM taProvincias as PR 
INNER JOIN taMunicipios AS MU 
ON PR.iCodProvincia = MU.iRefProvincia 
INNER JOIN taPoblacion AS PO 
ON MU.iCodMunicipio = PO.iRefMunicipio  
WHERE PO.iAnio LIKE '2024%' AND PR.vaNomProvincia = 'Cádiz'
AND (iMujeres + iHombres) >=  5000 AND (iMujeres + iHombres)<=10000;

# Con Subconsulta
SELECT (iMujeres + iHombres) as Hab, (
    SELECT MU.vaNomMunicipio 
    FROM taMunicipios AS MU 
    WHERE MU.iCodMunicipio=PO.iRefMunicipio) AS Municipio 
FROM taPoblacion AS PO
WHERE PO.iAnio LIKE '2024%' 
AND (iMujeres + iHombres) BETWEEN 5000 AND 10000 
AND iRefMunicipio IN (
    SELECT iCodMunicipio 
    FROM taMunicipios 
    WHERE iRefProvincia = (
        SELECT iCodProvincia 
        FROM taProvincias 
        WHERE vaNomProvincia = 'Cádiz'
    )
);
```

## Ejercicio 10
Cuánta población tiene actualmente la ciudad más grande de la provincia de Jaén.
```sql
SELECT (iHombres + iMujeres) AS Poblacion,MUN.vaNomMunicipio
FROM taPoblacion AS PO 
INNER JOIN taMunicipios AS MUN
ON PO.iRefMunicipio=MUN.iCodMunicipio
INNER JOIN taProvincias AS PR
ON MUN.iRefProvincia=PR.iCodProvincia
WHERE PO.iAnio LIKE '2024%' AND PR.vaNomProvincia = 'Jaén'
AND (PO.iHombres + PO.iMujeres) >= ALL(
    SELECT (iHombres + iMujeres) 
    FROM taPoblacion as POB 
    WHERE POB.iAnio LIKE '2024%' AND POB.iRefMunicipio IN (
        SELECT iCodMunicipio  
        FROM taMunicipios as MU  
        WHERE iRefProvincia = (
            SELECT iCodProvincia  
            FROM taProvincias as PRO 
            WHERE vaNomProvincia = 'Jaén'
        )
    )
);
```
## Ejercicio 11
Qué ciudad de la provincia de Cádiz tenía más habitantes en el año 2010. Muestra el nombre y
la población.
```sql
SELECT (iHombres + iMujeres) AS Poblacion,MUN.vaNomMunicipio
FROM taPoblacion AS PO 
INNER JOIN taMunicipios AS MUN
ON PO.iRefMunicipio=MUN.iCodMunicipio
INNER JOIN taProvincias AS PR
ON MUN.iRefProvincia=PR.iCodProvincia
WHERE PO.iAnio LIKE '2010%' AND PR.vaNomProvincia = 'Cádiz'
AND (PO.iHombres + PO.iMujeres) >= ALL(
    SELECT (iHombres + iMujeres) 
    FROM taPoblacion as POB 
    WHERE POB.iAnio LIKE '2010%' AND POB.iRefMunicipio IN (
        SELECT iCodMunicipio  
        FROM taMunicipios as MU  
        WHERE iRefProvincia = (
            SELECT iCodProvincia  
            FROM taProvincias as PRO 
            WHERE vaNomProvincia = 'Cádiz'
        )
    )
);
```
