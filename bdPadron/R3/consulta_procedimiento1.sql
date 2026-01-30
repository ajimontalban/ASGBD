select sum(iPoblacion) as sumaprovincia
from taPoblacion,taMunicipios,taProvincias
where iRefMunicipio = iCodMunicipio 
and   iRefProvincia = iCodProvincia
and iAnio = 2024 and iRefComunidad = 8
group by iCodProvincia
order by sumaprovincia asc
limit 1;


