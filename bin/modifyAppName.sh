#!/bin/bash

# Demander à l'utilisateur d'entrer le nom de l'application
echo "Veuillez entrer le nom de l'application : "
read app_name

# Liste des fichiers dans lesquels vous souhaitez effectuer le remplacement
file_paths=(".env" "./docker/local/docker-compose.yml" "./Makefile")  # Remplacez ces noms de fichiers par les vôtres

# Définir une variable pour suivre l'état de remplacement
app_name_replaced=false

# Boucle à travers les fichiers et effectuer le remplacement
for file_path in "${file_paths[@]}"
do
    # Vérifier si le fichier existe
    if [ -e "$file_path" ]; then
        # Vérifier si "YOUR_APP_NAME" existe dans le fichier
        if grep -q "YOUR_APP_NAME" "$file_path"; then
            # Remplacer "YOUR_APP_NAME" par le nom de l'application dans le fichier
            sed -i "s/YOUR_APP_NAME/$app_name/g" "$file_path"
            echo "Le nom de l'application a été remplacé par \"$app_name\" dans le fichier : $file_path"
            # Indiquer que le remplacement a été effectué
            app_name_replaced=true
        else
            echo "Le nom de l'application a déjà été changé dans le fichier : $file_path"
        fi
    else
        echo "Fichier non trouvé : $file_path"
    fi
done

# Vérifier si le remplacement a été effectué dans au moins un fichier
if [ "$app_name_replaced" = false ]; then
    echo "Le nom de l'application n'a pas été changé car \"YOUR_APP_NAME\" n'a pas été trouvé dans les fichiers."
fi
