---
title: Série 0x23
subtitle: Classes de stockage et alignement
tags:
- storage-classes
- const
- volatile
- extern
- alignment
- pragma-pack
- bitfields
exam:
  course: INFO2-TIN
---

# Classes de stockage et qualificateurs

## - { points=2 }

Quel est l'effet du mot-clé `static` sur une variable déclarée au **niveau fichier** ?

- [ ] La variable est allouée sur la pile
- [x] La variable est visible uniquement dans l'unité de traduction
- [ ] La variable est réinitialisée à chaque appel de fonction
- [ ] La variable doit être initialisée obligatoirement

## - { points=2 }

Quel mot-clé doit être utilisé dans un fichier d'en-tête pour **déclarer** une variable globale définie dans un autre fichier ?

- [ ] `static`
- [x] `extern`
- [ ] `register`
- [ ] `volatile`

## - { points=2 }

À propos de `volatile`, quelle affirmation est correcte ?

- [ ] Le compilateur peut mettre en cache la valeur dans un registre
- [x] Le compilateur doit relire la valeur en mémoire à chaque accès
- [ ] `volatile` rend la variable constante
- [ ] `volatile` supprime tout risque de data race

## - { points=2 }

Pour chaque déclaration, indiquez si l'on peut modifier **la valeur pointée** et/ou **le pointeur**.

```c
const int *p1;
int * const p2 = NULL;
const int * const p3 = NULL;
```

!!! solution { lines=6 }

    - `p1` : on ne peut pas modifier la valeur pointée, on peut modifier le pointeur.
    - `p2` : on peut modifier la valeur pointée, on ne peut pas modifier le pointeur.
    - `p3` : on ne peut modifier ni la valeur pointée ni le pointeur.

## - { points=2 }

Analysez le code suivant et indiquez ce qui est affiché.

```c
#include <stdio.h>

int next_id(void) {
    static int id = 0;
    return ++id;
}

int main(void) {
    printf("%d %d %d\n", next_id(), next_id(), next_id());
}
```

!!! solution { lines=1 }

    `1 2 3`

# Alignement et `#pragma pack`

## - { points=3 }

Sur une machine 64-bit avec alignement naturel (`char=1`, `short=2`, `int=4`, `double=8`), calculez `sizeof` pour les structures ci-dessous.

```c
typedef struct {
    char c;
    int i;
    short s;
} A;

#pragma pack(push, 1)
typedef struct {
    char c;
    int i;
    short s;
} B;
#pragma pack(pop)
```

!!! solution { lines=4 }

    `sizeof(A) = 12` (padding après `c` et en fin de structure).
    `sizeof(B) = 7` (structure compactée, aucun padding).

## - { points=2 }

Citez deux risques liés à l'utilisation de `#pragma pack(1)`.

!!! solution { lines=3 }

    - Accès mémoire non alignés, pouvant dégrader les performances.
    - Risque de crash ou de comportement non portable selon l'architecture.

# Champs de bits

## - { points=3 }

Déclarez une structure `Flags` contenant 3 indicateurs booléens (`ready`, `error`, `busy`) sur 1 bit chacun, et un champ `code` sur 5 bits.

!!! solution { lines=6 }

    ```c
    typedef struct {
        unsigned ready : 1;
        unsigned error : 1;
        unsigned busy  : 1;
        unsigned code  : 5;
    } Flags;
    ```

## - { points=3 }

Écrire une fonction qui met à 1 le flag `error` et met à 0 le flag `ready` dans une variable `Flags *f`.

!!! solution { lines=4 }

    ```c
    void set_error(Flags *f) {
        f->error = 1;
        f->ready = 0;
    }
    ```

## - { points=3 }

Que se passe-t-il si on affecte la valeur `17` à un champ de bits défini sur 4 bits ?

!!! solution { lines=3 }

    La valeur est tronquée aux 4 bits de poids faible. Le comportement exact est implémentation-défini.
