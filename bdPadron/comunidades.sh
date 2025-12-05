#!/bin/bash

if [[ ! -f comunidades_autonomas_ref.txt ]];then
    echo "No existe el fichero"
    exit 1
fi


while IFS=\; read cod comunidad;do
    echo "INSERT INTO taComunidades (vaNomComunidad) VALUES (\"$comunidad\");"
done < comunidades_autonomas_ref.txt

