#!/bin/bash 
#: Autor: Enrique Antonio Fernandez Torres
#: Fecha: 25 Jun 2022
#: Proposito: Sumar el total de casos por mes y anio
#: Opciones: Ninguna

_obtiene_campo(){
local FECHA=$1 

head -n 1 $ARCHIVO | tr "," "\n" | nl | grep  $FECHA | cut -f 1
}

_suma_resultado(){
local FECHA=$1 

tail -n +2 $ARCHIVO | awk -v CP=$FECHA -F "," '{A += $CP}; END {print A}'

}

_obtener_fechas(){
local MES=$1
local ANIO=$2 
head -n 1 $ARCHIVO | tr "," "\n"  | grep ${MES}-${ANIO}

}

ARCHIVO=$3
test ! -e $ARCHIVO  && echo "el archivo $ARCHIVO no se encuentra ..." && exit 2

FECHAS=$(_obtener_fechas $1 $2)
mes=()
for FECHA in $FECHAS ; do
       echo "++ la fecha es $FECHA: "
       _suma_resultado $(_obtiene_campo $FECHA)       	
       mes=(${mes[@]} $(_suma_resultado $(_obtiene_campo $FECHA)))       	
done       
#echo ${mes[@]}
#echo $FECHA
tot=0
for i in ${mes[@]}; do
	let tot+=$i
done

echo "El total del mes es: $tot"

#_suma_resultado $(_obtiene_campo $1) 


