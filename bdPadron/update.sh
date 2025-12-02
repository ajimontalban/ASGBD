#!/bin/bash
#
#


if [[ ! -f "provincias.txt" ]];then
    echo "El fichero provincias.txt no existe"
    exit 1
fi


echo -e  "USE bdPadron;\n"
while IFS=\; read cod nombre;do
    echo "UPDATE taProvincias SET vaNomProvincia = \"$nombre\" WHERE iCodProvincia = $cod;"
done < provincias.txt

exit 0

