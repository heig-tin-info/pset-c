---
title: Série 0x26
subtitle: Compilation séparée et bibliothèques
tags:
- separate-compilation
- headers
- static-library
- linker
- make
exam:
  course: INFO2-TIN
---

# Généralités

## - { points=2 }

Parmi les propositions suivantes, lesquelles sont vraies pour un projet C en compilation séparée ?

- [x] Chaque fichier `.c` est compilé indépendamment en fichier objet `.o`
- [x] L'éditeur de liens (linker) assemble les fichiers objets
- [ ] Les fichiers `.h` sont compilés en `.o`
- [x] Un symbole global peut être défini dans un seul fichier `.c`

## - { points=2 }

Quel est le rôle d'un fichier d'en-tête `.h` ?

- [x] Déclarer les fonctions, types et constantes accessibles aux autres fichiers
- [ ] Contenir des définitions de variables globales sans `extern`
- [ ] Remplacer le besoin de compiler les `.c`
- [ ] Contenir le code exécutable final

## - { points=2 }

On dispose de `main.c` et `maths.c`, avec un en-tête `maths.h`.
Quelle commande compile et lie correctement l'exécutable `app` ?

- [ ] `cc -o app main.c maths.h`
- [ ] `cc -c main.c maths.c -o app`
- [x] `cc -c main.c && cc -c maths.c && cc -o app main.o maths.o`
- [ ] `cc -o app main.o maths.h`

---

# Analyse de code

## - { points=4 }

On considère les fichiers suivants :

```c
// maths.h
#ifndef MATHS_H
#define MATHS_H

double mean(const double *values, size_t n);

double sum(const double *values, size_t n);

#endif
```

```c
// maths.c
#include "maths.h"

double sum(const double *values, size_t n) {
    double s = 0.0;
    for (size_t i = 0; i < n; i++) s += values[i];
    return s;
}

double mean(const double *values, size_t n) {
    return sum(values, n) / n;
}
```

```c
// main.c
#include <stdio.h>
#include "maths.h"

int main(void) {
    double v[] = {1.0, 2.0, 3.0, 4.0};
    printf("%g\n", mean(v, 4));
}
```

1. Quel fichier doit contenir les **définitions** des fonctions ?
2. Quel fichier doit contenir les **déclarations** des fonctions ?
3. Pourquoi le `#ifndef` est-il utile ?

!!! solution { lines=6 }

    1. Les définitions doivent être dans `maths.c`.
    2. Les déclarations doivent être dans `maths.h`.
    3. Le garde d'inclusion évite les inclusions multiples et les redéfinitions.

---

# Programmation

## - { points=6 }

Créez un module `stats` qui expose les fonctions suivantes :

- `double stats_min(const double *v, size_t n);`
- `double stats_max(const double *v, size_t n);`

Indiquez ce qui doit se trouver dans `stats.h` et dans `stats.c`.

!!! solution { lines=10 }

    ```c
    // stats.h
    #ifndef STATS_H
    #define STATS_H
    #include <stddef.h>
    double stats_min(const double *v, size_t n);
    double stats_max(const double *v, size_t n);
    #endif
    ```

    ```c
    // stats.c
    #include "stats.h"
    double stats_min(const double *v, size_t n) {
        double m = v[0];
        for (size_t i = 1; i < n; i++) if (v[i] < m) m = v[i];
        return m;
    }
    double stats_max(const double *v, size_t n) {
        double m = v[0];
        for (size_t i = 1; i < n; i++) if (v[i] > m) m = v[i];
        return m;
    }
    ```

## - { points=4 }

On souhaite créer une bibliothèque statique `libgeom.a` contenant `geom.c` et `geom.h`.
Donnez les commandes nécessaires pour :

1. Compiler `geom.c` en fichier objet.
2. Créer la bibliothèque statique.
3. Lier un programme `main.c` avec cette bibliothèque.

!!! solution { lines=6 }

    ```bash
    cc -c geom.c -o geom.o
    ar rcs libgeom.a geom.o
    cc main.c -L. -lgeom -o app
    ```

## - { points=3 }

Complétez le `Makefile` minimal suivant pour construire `app` à partir de `main.c` et `maths.c`.

```make
CC = cc
CFLAGS = -Wall -Wextra -std=c11

app: main.o maths.o
	# TODO

main.o: main.c maths.h
	# TODO

maths.o: maths.c maths.h
	# TODO
```

!!! solution { lines=6 }

    ```make
    app: main.o maths.o
    	$(CC) $(CFLAGS) -o app main.o maths.o

    main.o: main.c maths.h
    	$(CC) $(CFLAGS) -c main.c

    maths.o: maths.c maths.h
    	$(CC) $(CFLAGS) -c maths.c
    ```
