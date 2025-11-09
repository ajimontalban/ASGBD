subl #!/bin/bash

# Bucle que itera sobre cada fila/provincia del fichero
# IFS indica la variable de entorno del separador, al situarlo frente al comando que queremos ejecutar
# Hacemos que ese comando concreto use ese valor (;) como separador de campo 

if [[ $# -ne 1 ]];then
	exit 1
fi

if [[ ! -f $1 ]];then
	exit 2
fi

if [[ "$(basename $1 | cut -d . -f 2)" == "xls" ]];then
	xls2csv -c \; -q 0 $1 | grep "^[0-9]" | cut -d \; -f 1,2 | uniq > provincias.txt
elif [[ "$(basename $1 | cut -d . -f 2)" == "xlsx" ]];then
	xlsx2csv -d \; $1 | grep "^[0-9]" | cut -d \; -f 1,2 | uniq > provincias.txt
else
	exit 3
fi

echo -e "USE bdPadron;\n"

while IFS=\; read cod provincia
do
	echo "INSERT INTO taProvincias VALUES ($cod, \"$provincia\");"
done < provincias.txt

rm -f provincias.txt
exit 0
