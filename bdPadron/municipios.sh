#!/bin/bash

# elimina el fichero
rm -f municipios.txt
touch municipios.txt

echo -e "USE bdPadron;\n"

#  lo mismo que escribir for fichero in "$@";do
for fichero
do
	# Comprueba que el fichero introducido como argumento existe (pobmun00.xls, pobmun01.xls...)
	if [[ -f $fichero ]];then
		# retira la ruta y corta el nombre del fichero usando . como delimitador, se queda con el segundo campo y comprueba si es xls
		if [[ "$(basename $fichero | cut -d . -f 2)" == "xls" ]];then
			# Si es xls, ejecuta el comando xls2csv, delimitador ; y -q 0 para que no esten los valores entrecomillados
			# Nos quedamos solo con las filas que comiencen por número
			# y nos quedamos con las columnas 1,3 y 4 del resultado, lo cual volcamos en el nombre del fichero con la extension .csv
			xls2csv -c \; -q 0 $fichero | grep "^[0-9]" | cut -d \; -f 1,3,4 > $fichero.csv
		elif [[ "$(basename $fichero | cut -d . -f 2)" == "xlsx" ]];then
			xlsx2csv -d \; $fichero | grep "^[0-9]" | cut -d \; -f 1,3,4 > $fichero.csv
		else
			# Si ninguna terminacion ex xls o xlsx, se sale del programa
			exit 1
		fi

		# Realiza un bucle 
		while IFS=\; read codProvincia codMunicipio nomMunicipio
		do
			if ! grep -q "^$codProvincia;$codMunicipio$" municipios.txt; then
			echo "$codProvincia;$codMunicipio" >> municipios.txt
			echo "INSERT INTO taMunicipios (vaNomMunicipio, iCodMunicipioINE, iRefProvincia) VALUES (\"$nomMunicipio\",$codMunicipio, $codProvincia);"
			fi
		done < $fichero.csv
		rm -f $fichero.csv
	fi
done
