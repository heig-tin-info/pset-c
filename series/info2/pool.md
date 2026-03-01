# Algorithmique { points=6 }

## - { points=2 }

On souhaite développer un programme qui analyse un fichier de mesures passé sur l'entrée standard. Proposez une décomposition en sous-problèmes (raffinage successif) en listant 4 à 6 fonctions possibles, avec un nom clair pour chaque fonction.

!!! solution { lines=6 }

    Voici une proposition de décomposition en fonctions pour le programme d'analyse de mesures :

    1. `read_input` : lire l'entrée standard et stocker les données dans une structure appropriée
    2. `parse_measurement` : parser une ligne en structure de mesure
    3. `compute_stats` : calculer min, max, moyenne
    4. `print_report` : afficher le rapport
    5. `save_csv` : exporter les résultats

## - { points=2 }

Pour chaque tâche ci-dessous, indiquez si elle doit être réalisée dans une fonction distincte ou peut rester dans `main`, et justifiez en une phrase.

1. Lecture d'un argument de ligne de commande
2. Validation du format d'une date ISO8601
3. Calcul d'une distance euclidienne
4. Écriture d'un rapport dans un fichier

!!! solution { lines=6 }

    1. Peut rester dans `main` (simple, spécifique au programme).
    2. Fonction distincte (réutilisable et testable).
    3. Fonction distincte (réutilisable, calcul pur).
    4. Fonction distincte (sépare I/O et logique).

## - { points=2 }

Complétez le pseudo-code en détaillant le raffinage successif (2 niveaux) pour l'algorithme suivant : "compter le nombre de valeurs positives dans un tableau".

!!! solution { lines=6 }

    Niveau 1 :

    - parcourir le tableau
    - compter les valeurs positives
    - retourner le compteur

    Niveau 2 (détail du parcours) :

    - initialiser `count` à 0
    - pour chaque élément `x`, si `x > 0` alors `count++`
