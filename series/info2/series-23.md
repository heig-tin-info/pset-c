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
# Connaissances générales

## - { points=1 }

Quel est l'effet du mot-clé `static` sur une variable déclarée au **niveau fichier** ?

- [ ] Elle est allouée sur la pile
- [x] Elle est visible uniquement dans l'unité de traduction
- [ ] Elle est réinitialisée à chaque appel de fonction
- [ ] Elle doit être initialisée obligatoirement

## - { points=1 }

Quel mot-clé doit être utilisé dans un fichier d'en-tête pour **déclarer** une variable globale définie dans une autre unité ?

- [ ] `static`
- [x] `extern`
- [ ] `register`
- [ ] `volatile`

## - { points=1 }

À propos de `volatile`, quelle affirmation est correcte ?

- [ ] Le compilateur peut mettre en cache la valeur dans un registre
- [x] Le compilateur doit relire la valeur en mémoire à chaque accès
- [ ] `volatile` rend la variable constante
- [ ] `volatile` supprime tout risque de data race

## - { points=1 }

Considérez la déclaration `const int *p = {1,2,3};`. Quelle(s) affirmation(s) est/sont correcte(s) ?

- [ ] On peut modifier les éléments pointés par `p`
- [x] On ne peut pas modifier les éléments pointés par `p`
- [ ] On peut modifier le pointeur `p` pour qu'il pointe vers un autre tableau
- [x] Les valeurs associées à `p` sont stockées dans une section de mémoire en lecture seule
- [ ] Le code ne compile pas à cause de l'initialisation incorrecte de `p`

## - { points=1 }

Une fonction arbore le prototype suivant `void f(const struct Data *const d);`. Quelles sont les implications de ce prototype ?

- [ ] La fonction peut modifier les champs de la structure pointée par `d`;
- [ ] La fonction peut modifier le pointeur `d` pour qu'il pointe vers une autre structure;
- [x] La fonction ne peut pas modifier les champs de la structure pointée par `d`;
- [x] La fonction utilise le passage par adresse par souci de performance;
- [ ] La fonction ne peut pas modifier l'adresse du pointeur `d` copié sur le stack.

## - { points=1 }

Quel est l'effet de la déclaration `register int counter;` ?

- [ ] `counter` est stocké dans un registre et ne peut pas être adressé via un pointeur;
- [ ] `counter` est stocké dans un registre et peut être adressé via un pointeur;
- [x] `counter` est une suggestion pour le compilateur de stocker la variable dans un registre, mais ce n'est pas garanti;
- [ ] `counter` est une variable globale accessible dans toutes les unités de traduction.

## - { points=1 }

Comment accéder à une variable `int g` définie dans une autre unité de traduction ?

- [ ] `static int g;`
- [ ] `register int g;`
- [x] `extern int g;`
- [ ] `volatile int g;`

## - { points=1 }

Laquelle de ces classes de stockage n'appartient pas au langage C ?

- [ ] `auto`
- [x] `dynamic`
- [ ] `register`
- [ ] `static`
- [ ] `extern`

## - { points=1 }

À quoi faire attention quand une structure est utilisée pour communiquer entre différentes architectures matérielles ?

- [ ] Boutisme/Endianess
- [ ] Alignement
- [ ] Padding
- [x] Toutes les réponses ci-dessus

# - { points=2 }

Analysez le code suivant et indiquez ce qui est affiché sur la sortie standard.

```c
#include <stdio.h>
int next_id(void) { static int id = 0; return ++id; }
int main(void) { printf("%d %d %d\n", next_id(), next_id(), next_id()); }
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

Déclarez une structure `Flags` contenant 3 indicateurs booléens: `ready`, `error`, `busy` (sur 1 bit), ainsi qu'un champ `code` sur 5 bits.

!!! solution { lines=6 }

    ```c
    typedef struct flags {
        unsigned ready : 1;
        unsigned error : 1;
        unsigned busy  : 1;
        unsigned code  : 5;
    } Flags;
    ```

## - { points=3 }

Écrire une fonction `set_error` qui reçoit un pointeur sur un `Flags` et met à 1 le flag `error` ainsi que met à 0 le flag `ready`:

!!! solution { lines=4 }

    ```c
    void set_error(Flags *f) {
        f->error = true;
        f->ready = false;
    }
    ```

## - { points=3 }

Que se passe-t-il si on affecte la valeur `42` au champ `code` de la structure `Flags` ?

!!! solution { lines=3 }

    La valeur est tronquée aux 5 bits de poids faible, soit la valeur `10`.

