#!/bin/bash


echo -e "USE  bdPadron;\n"


sexo="H"

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
            echo "INSERT INTO taPoblacionEdades VALUES ($iRefProvincia, $anio, '1', $sexo, $edad, $periodo1);"
            echo "INSERT INTO taPoblacionEdades VALUES ($iRefProvincia, $anio, '2', $sexo, $edad, $periodo2);"
            anio=$((anio-1))
        done
    done


done < hombres.csv

