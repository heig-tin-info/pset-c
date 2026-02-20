
---

Ajouter une option à la template pour définir le nom d'un "Problème", ici on a des séries d'exercices donc on aura dans le commun.yml l'assignation à "Exercice" au lieu de "Problème" par défaut.

---

Ajouter une option pour avoir une série compacte, sans espaces pour les réponses :
1. Plus de lignes affichées ou de box dans les solutions, on affiche juste la solution si nécessaire. Donc on remplace solutionordottedlines par solution par exemple,
2. Plus de fillin pour les choix multiples
3. On garde les fillin pour les textes à trous

On modifie le makefile pour compiler cette version compacte avec la version standard. Lors du make dist on copie le pset-light qu'on met à disposition dans le site pelican. Si bien qu'on peut télécharger la série avec espace de réponse et la série courte.
