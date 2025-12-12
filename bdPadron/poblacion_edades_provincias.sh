#!/bin/bash

echo -e "USE  bdPadron;\n"

hombres=$1
mujeres=$2
if  [[ $# -ne 2 ]];then
    echo "Uso: poblacionEdadesProvincias ficheroHombres.csv ficheroMujeres.csv" 1>&2
    exit 1
fi
if [[ ! -f "$hombres" || ! -f "$mujeres" ]];then
    echo "Uso: poblacionEdadesProvincias ficheroHombres.csv ficheroMujeres.csv" 1>&2
    echo "Alguno de los ficheros especificados no existe" 1>&2
    exit 2
fi
    
echo "CREATE TABLE taPoblacionEdadesProvincias ("
echo "    iRefProvincia     INT             NOT NULL,"
echo "    iAnio             INT             NOT NULL,"
echo "    iPeriodo          INT             NOT NULL,"
echo "    cSexo             CHAR(1)         NOT NULL,"
echo "    iEdad             INT             NOT NULL,"
echo "    dPoblacion        DECIMAL(14,2)   NOT NULL,"
echo
echo "    PRIMARY KEY       (iRefProvincia, iAnio, iPeriodo, cSexo, iEdad)"
echo ");"
echo

for datos in H$hombres M$mujeres;do
    sexo=${datos:0:1}
    fichero=${datos:1}

    while read linea;do
        # Borra por la derecha lo que coincida con este patron ( *) cualquier caracter y un espacio
        edad=${linea%% *}

        # Leemos la primera para tirarla, ya que no la necesitamos
        read linea
        #for ((i=1;i <= 52; i++))
        for i in {1..52};do
            read linea
            iRefProvincia=${linea%% *}
            # Borra por la izquierda el trozo mas corto con el patron `lo que sea` seguido de almoadilla
            linea=${linea#*#}
            anio=2022
            for j in {1..21};do
                periodo2=${linea%%#*}
                linea=${linea#*#}
                periodo1=${linea%%#*}
                linea=${linea#*#}
                # Expandeme esta variable pero antes sustituyeme esta expresion/caracter
                periodo1=${periodo1//.}
                # Expandeme esta variable pero antes sustituyeme la oprimero aparicion de una coma por un punto
                periodo1=${periodo1/,/.}
                # Expandeme esta variable pero antes sustituyeme esta expresion/caracter
                periodo2=${periodo2//.}
                # Expandeme esta variable pero antes sustituyeme la oprimero aparicion de una coma por un punto
                periodo2=${periodo2/,/.}
                echo "INSERT INTO taPoblacionEdadesProvincias VALUES ($iRefProvincia, $anio, '1', \"$sexo\", $edad, $periodo1);"
                echo "INSERT INTO taPoblacionEdadesProvincias VALUES ($iRefProvincia, $anio, '2', \"$sexo\", $edad, $periodo2);"
                anio=$((anio-1))
            done
        done


    done < $fichero 

done
