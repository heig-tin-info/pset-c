---
title: Série 22
subtitle: Les structures de données
tags:
- structs
- typedef
- date-handling
- arrays-of-structs
exam:
  course: INFO2-TIN
---

# Série 22 — Les structures de données

## Anniversaires { points=10 }

### - { points=2 }

Écrire la déclaration d'un type de structure de données `Date` permettant de mémoriser une date (jour, mois, année).

!!! solution

    ```c
    typedef struct date {
        uint8_t day;
        uint8_t month;
        uint16_t year;
    } Date;
    ```

### - { points=2 }

Écrire une fonction permettant de saisir sur l'entrée standard une date au format ISO8601 (YYYY-MM-DD). Cette date est retournée dans le type `Date`. La fonction retourne `0` en cas de succès ou `1` en cas d'erreur de saisie.

!!! solution

    ```c
    int read_date(FILE *fp, Date *dt)
    {
        return fscanf(fp, "%hu-%hhu-%hhu",
            &dt->year, &dt->month, &dt->day) != 3;
    }
    ```

### - { points=2 }

Écrire une fonction qui reçoit 2 dates et retourne `0` si elles sont égales `1` si `date1 > date2` ou `-1` si `date1 < date2`.

!!! solution

    ```c
    /**
     * Convert a YMD date into an integer allowing comparison.
     */
    int date2int(Date dt)
    {
        return dt.year * 10000 + dt.month * 100 + dt.day;
    }

    int compare_date(const Date *a, const Date *b)
    {
        if (date2int(*a) > date2int(*b))
            return 1;
        if (date2int(*a) < date2int(*b))
            return -1;
        return 0;
    }
    ```

### - { points=2 }

Déclarez un nouveau type basé sur une structure `Birthday` contenant un nom et une date d'anniversaire (`Date`).

!!! solution

    ```c
    typedef struct birthday {
        char name[64];
        Date birthday;
    } Birthday;
    ```

### - { points=2 }

Déclarez un tableau de `Birthday` de taille `10`. Initialisez la première entrée avec le nom `John Doe` et la date `2000-01-01`.

!!! solution

    ```c
    Birthday birthdays[10] = {
        { .name = "John Doe", .date = { .year=2000, .month=1, .day=1 } }
    };
    ```

## - { points=4 }

Quelle est la taille en octets des structures suivantes :

- `struct { int32_t a; int32_t b; };` — [8 bytes]
- `struct { char *name; int32_t age; };` — [12 bytes sur une machine 64 bits]
- `struct { char k[8]; short s[2]; };` — [12 bytes]
- `struct { char a; short b; };` — [4 bytes (à cause de l'alignement)]

## - { points=4 }

Comment dans `function` afficher sur la sortie standard la valeur de la deuxième entrée `bar` du cinquième élément ?

```c
typedef struct {
    int32_t foo;
    int32_t bar[8];
} Element;

typedef struct {
    int32_t count;
    Element data[100];
} Data;

void function(Data *data)
{
    ...
}

int main() {
    Data data;
    function(&data);
}
```

!!! solution

    ```c
    printf("%d\n", data->data[4].bar[1]);
    ```

## - { points=4 }

Le tableau périodique des éléments de Mendeleev regroupe tous les éléments chimiques. Ces éléments sont caractérisés par un nom pouvant comporter jusqu'à 20 lettres, un symbole comportant au maximum 3 lettres, un numéro périodique représentant la position dans le tableau (c'est-à-dire le nombre de protons du noyau), et une valeur logique indiquant si la substance est radioactive ou non.

Déclarez les types de données et une variable permettant de stocker les caractéristiques mentionnées ci-dessus pour un nombre variable d'éléments compris entre 0 et 120 éléments inclus.

!!! solution

    ```c
    typedef struct element {
        char name[20];
        char symbol[3];
        int period;
        bool is_radioactive;
    } Element;

    Element[121] elements;
    ```
