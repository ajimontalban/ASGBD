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
