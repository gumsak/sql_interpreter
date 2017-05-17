#!/bin/bash

#ex) ./create.sh table file "(nom, prenom, date de naissance)"




# Créer un nouveau fichier + y écrire le nom des colonnes de notre table

# vérifie que l'utilisateur a entré qq chose
# -z $chaine : vérifie si la chaine est vide
if [ -z $1 ] 
then
	echo "Entrez une commande"

# si la commande tab est entrée
elif [ $1 = "table" ]
then

	# -e fichier : vérifie si le fichier existe déjà
	if [ -e "$2".csv ]
	then
		# fichier déjà existant, donc on ne fait rien
		echo "Ce fichier existe déjà"

	else
		# fichier inexistant, donc on peut le créer
		echo "Ce fichier n'existe pas"

		# on crée un fichier .csv
		# -n pour éviter des sauts de lignes
		echo -n '' > "$2".csv
		
		fichier1="$2".csv

		# on écrit la chaine dans le fichier en retirant les '(' ')'

		INPUT="$3"
		INPUT=$( echo "$INPUT" | tr '(' ' ')
		INPUT=$( echo "$INPUT" | tr ')' ' ')
		IFS=',' read -ra NAMES <<< "$INPUT"   
		count=0
		max=${#NAMES[@]}

		for mot in "${NAMES[@]}"; do
			echo -n $mot >> $fichier1

			if [ $(($count+1)) -ne $max ]
			then	
				echo -n "," >> $fichier1
			fi
	
			count=$(($count+1))
		done

		#while [ "$3" ]
		#do	


		#	echo -n "$3" >> $fichier1
		#	shift
		#done		
		


		# réécrire la chaine correctement et dans le bon fichier 
		#while 
		#do 

		#done

	fi

# si autre chose que 'table' est entré
else
	echo "Commande non reconnue"
fi
	



