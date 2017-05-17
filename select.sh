#!/bin/bash
#utilisation: bash select.sh 'Sexe,Année de naissance' < test.csv



count=0
linenb=0
un=1
zero=0
indice=-1
tab=(0,0,0,0)

argument=$#
test 1 -lt $argument
selected=$1
shift
IFS=',' read -ra NAMES2 <<< "$selected"   


while read line
    do


if [ $linenb -eq $zero ] # si on passe la premiere ligne
then

	#Parcourir les colonnes selectionnées
	for mot2 in "${NAMES2[@]}"; do

	    #Decouper toute les colonnes
		STR=$line
		IFS=',' read -ra NAMES <<< "$STR"   
	
		#Parcourir les colonnes selectionnées
		for mot in "${NAMES[@]}"; do
		    if [ "$mot2" == "$mot" ]
	    	   then
		   	tab[i]=1
	    	fi
        i=$(($i+$un))
	done
	i=0
	done
fi





	STR=$line
	IFS=',' read -ra NAMES <<< "$STR"   
	for mot in "${NAMES[@]}"; do
	if [ ${tab[count]} ]
	then
		echo -n $mot'|'
	fi
	count=$(($count+$un)) 
	done

	linenb=$(($linenb+$un)) 
    count=0

		echo 
    done
