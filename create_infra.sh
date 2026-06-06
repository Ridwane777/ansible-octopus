#!/bin/bash

# Liste des machines Octopus restantes à créer
# (redis-1 est déjà créée, donc on ne la remet pas)
MACHINES=("postgresql-1" "poll-1" "result-1" "worker-1")

echo "Lancement de la création de l'infrastructure Octopus avec Multipass..."
echo "----------------------------------------------------------------------"

# Boucle sur chaque machine de la liste
for VM in "${MACHINES[@]}"; do
    echo "Création de la VM : $VM ..."
    
    # Commande native Multipass pour lancer l'instance
    multipass launch --name "$VM" --cpus 1 --memory 1G 22.04
    
    if [ $? -eq 0 ]; then
        echo "$VM a été créée avec succès !"
    else
        echo "Erreur lors de la création de $VM"
    fi
    echo "----------------------------------------------------------------------"
done

echo "Toutes les machines ont été traitées !"
echo "Voici l'état actuel de ton infrastructure :"
echo ""

# Affichage de la liste finale pour récupérer toutes les IPs
multipass list

for VM in postgresql-1 poll-1 result-1 worker-1; do \
  echo "Injection de la clé dans $VM..."; \
  cat ~/.ssh/id_ed25519.pub | multipass exec $VM -- sh -c "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"; \
done
