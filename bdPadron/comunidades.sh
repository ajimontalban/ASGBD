#!/bin/bash


echo -e "USE bdPadron;\n"
echo -e "CREATE TABLE IF NOT EXISTS taComunidades (
    iCodComunidad int NOT NULL,
    vaNomComunidad varchar(50),
    PRIMARY KEY iCodComunidad
);\n"

while IFS=\; read cod comunidad;do
    echo "INSERT INTO taComunidades VALUES ($cod, \"$comunidad\");"
done < comunidades_autonomas_ref.txt


echo -e "\nALTER TABLE taProvincias
ADD COLUMN iRefComunidad int NOT NULL"



exit 0
