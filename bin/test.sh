#!/bin/bash

# Demander à l'utilisateur d'entrer le nom de l'application
echo "Veuillez entrer le nom de l'application : "
read app_name

# Liste des fichiers dans lesquels vous souhaitez effectuer le remplacement
file_paths=(".env" "./docker/local/docker-compose.yml" "./Makefile")  # Remplacez ces noms de fichiers par les vôtres

# Boucle à travers les fichiers et effectuer le remplacement
for file_path in "${file_paths[@]}"
do
    # Vérifier si le fichier existe
    if [ -e "$file_path" ]; then
        # Remplacer "YOUR_APP_NAME" par le nom de l'application dans le fichier
        sed -i "s/YOUR_APP_NAME/$app_name/g" "$file_path"
        echo "Le nom de l'application a été remplacé par \"$app_name\" dans le fichier : $file_path"
    else
        echo "Fichier non trouvé : $file_path"
    fi
done
