#!/bin/bash

#Insérer des données dans une table

#EX : Méthode 1 :  ./insert into test values "(M, Bob, 1950)"

#Méthode 2 :  ./insert into test "(Année de naissance, Sexe, Prénom)" values "(1932, M, Robert)"

#Méthode 3 :  ./insert into test "(Année de naissance, Sexe, Prénom)" values "(1932, M, Robert)" #"(1990,F,Lisa)" "(1992,M,Max)" 
#	        ^ séparer les entrées par un espace


# -z $chaine : vérifie si la chaine est vide
if [ -z $1 ] 
then
	echo "Entrez une commande"

# si la commande into est entrée
elif [ $1 = "into" ]
then
	# -e fichier : vérifie si le fichier/la table existe
	if [ -e "$2".csv ]
	then
		# fichier existant, donc on peut y insérer des données
		echo "Fichier existant"		
		fichier1="$2".csv
		
		#METHODE 1 : indiquer toutes les données et respecter l'ordre des colonnes
		# $./insert into table values "(M, Bob, 1950)"
		if [[ $3 = "values" ]]
		then
			INPUT="$4"
			INPUT=$( echo "$INPUT" | tr '(' ' ')
			INPUT=$( echo "$INPUT" | tr ')' ' ')
			IFS=',' read -ra NAMES <<< "$INPUT"   
			count=0
			max=${#NAMES[@]}

			# On écrit les chaines (séparées par des ',') dans le fichiers
			for mot in "${NAMES[@]}"; do
				echo -n $mot >> $fichier1
	
				if [ $(($count+1)) -ne $max ]
				then	
					echo -n "," >> $fichier1
				fi
		
				count=$(($count+1))
			done
			echo "" >> $fichier1


		#METHODES 2 ET 3 : indiquer les colonnes de la table (peu importe l'ordre), puis 			#indiquer les valeurs à y entrer 
		
		elif [ $4 = "values" ]
		then
			# colonnes de notre table
			IFS=',' read -ra COLONNES < "$fichier1"

			# colonnes entrées par l'user
			# tr -d 'caractère' : supprime le caractère désigné 
			USERCOL="$3" 
			USERCOL=$( echo "$USERCOL" | tr '(' ' ' )
			USERCOL=$( echo "$USERCOL" | tr ')' ' ' )
			IFS=',' read -ra COLUMNS <<< "$USERCOL"

			#tant qu'il y a un argument dans $5
			while [ "$5" ]
			do
				# données entrées par l'user
				USERDATA="$5"
				USERDATA=$( echo "$USERDATA" | tr '(' ' ' )
				USERDATA=$( echo "$USERDATA" | tr ')' ' ' )
				IFS=',' read -ra DATA <<< "$USERDATA"

				# position de la donnée entrée
				pos=0
				i=0
				#nbre de colonnes dans notre table
				maxCol=${#COLONNES[@]}
	
				#Compare les Colonnes entrées avec celles de la table
				#puis met les données entrées dans le bon ordre via le talbeau TEMP
				for mot1 in "${COLUMNS[@]}"
				do

				#retirer les espaces avant et après chaque mot
				mot1=$( echo "$mot1" | sed 's/^ *//g' | sed 's/ *$//g')

					for mot2 in "${COLONNES[@]}"
					do		
						if [ "$mot2" = "$mot1" ]
						then	
							TEMP[pos]="${DATA[i]}"
							i=$(($i+1))
	
							break
						else
							pos=$(($pos+1))
												
							#indique si un nom de colonne entrée par l'user 
							#n'a pas été trouvé 
							if [ $pos -eq $maxCol ]
							then
								echo "Aucune colonne au nom de : $mot1"
							fi
						fi
					done
			
					pos=0
				done
	
				# Ecrire les données dans notre table
		
				# max2 : Nb d'elements dans TEMP	
				max2=${#TEMP[@]}
	
				count2=0
	
				for mot3 in "${TEMP[@]}"
				do			
					echo -n $mot3 >> $fichier1
			 
					if [ $(($count2+1)) -ne $max2 ]
					then	
						echo -n "," >> $fichier1
					fi
					count2=$(($count2+1))
				done 
				echo "" >> $fichier1

			#Décaler les arguments suivant vers le $5
			shift

			done
			#FIN boucle while[ $5 ]

		else 
			echo "ERREUR DE SYNTAXE"
		fi

	else
		echo "Ce fichier n'existe pas"
	fi

else
	echo "Commande non reconnue : $1"
fi
