drop database if exists bdPadron;
create database if not exists bdPadron;
use bdPadron;

-- tabla taProvincias
drop table if exists taProvincias;
create table if not exists taProvincias(
    iCodProvincia int ,
    vaNomProvincia varchar(40) not null ,
    primary key(iCodProvincia)
);

-- tabla taMunicipios
drop table if exists taMunicipios;
create table if not exists taMunicipios(
    iCodMunicipio int auto_increment,
    vaNomMunicipio varchar(80) not null ,
    iCodMunicipioINE int not null ,
    iRefProvincia int not null ,
    primary key(iCodMunicipio),
    foreign key(iRefProvincia) references taProvincias(iCodProvincia) 
);

-- tabla taPoblacion
drop table if exists taPoblacion;
create table if not exists taPoblacion(
    iRefMunicipio int not null,
    iAnio int not null ,
    iMujeres int not null,
    iHombres int not null,
    primary key(iRefMunicipio, iAnio),
    foreign key(iRefMunicipio) references taMunicipios(iCodMunicipio) 
);

