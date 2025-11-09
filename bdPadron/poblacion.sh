#!/bin/bash

if [[ ! -f municipios.txt ]];then
	echo "No existe el archivo municipios.txt"
	exit 1
fi

# Muestra el archivo con numero de lineas al principio
# primer tr con -s elimina todos los separadores que estén unidos salvo 1.
cat -n municipios.txt | tr -s ' '| tr '\t' ';' | cut -d ' ' -f 2 > municipios_ref.txt

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
			# y nos quedamos con las columnas 1,3,6 y 7 del resultado, lo cual volcamos en el nombre del fichero con la extension .csv
			# Las columnas son cod provincia, cod municipio, numero de hombres y numero de mujeres
			xls2csv -c \; -q 0 $fichero | grep "^[0-9]" | cut -d \; -f 1,3,6,7 > $fichero.csv
		elif [[ "$(basename $fichero | cut -d . -f 2)" == "xlsx" ]];then
			xlsx2csv -d \; $fichero | grep "^[0-9]" | cut -d \; -f 1,3,6,7 > $fichero.csv
		else
			# Si ninguna terminacion ex xls o xlsx, se sale del programa
			exit 1
		fi

		# igual que "$(basename $fichero | cut -c 7,8)"
		anio=20"$(basename $fichero | cut -d . -f 1 | colrm 1 6)"
		# Realiza un bucle 
		while IFS=\; read codProvincia codMunicipio hombres mujeres
		do
			# codigo provncia que comienza por ; , codigo de municipio final
			refMunicipio=$(grep ";$codProvincia;$codMunicipio$" municipios_ref.txt | cut -d \; -f 1)
			if [[ -n "$refMunicipio" ]]; then
				echo "INSERT INTO taPoblacion VALUES ($refMunicipio,$anio, $mujeres, $hombres);"
			else
				rm -f $fichero.csv
				exit 2 
			fi
		done < $fichero.csv
		rm -f $fichero.csv
	fi
done
