---
title: Série 0x22
subtitle: Les structures de données
tags:
- structs
- typedef
- date-handling
- arrays-of-structs
exam:
  course: INFO2-TIN
---
# Anniversaires

## - { points=2 }

Écrire la déclaration d'un type de structure de données `Date` permettant de mémoriser une date (jour, mois, année).

!!! solution { lines=6 }

    ```c
    typedef struct date {
        uint8_t day;
        uint8_t month;
        uint16_t year;
    } Date;
    ```

## - { points=2 }

Écrire une fonction permettant de saisir sur l'entrée standard une date au format ISO8601 (YYYY-MM-DD). Cette date est retournée dans le type `Date`. La fonction retourne `0` en cas de succès ou `1` en cas d'erreur de saisie.

!!! solution { lines=6 }

    ```c
    int read_date(FILE *fp, Date *dt)
    {
        return fscanf(fp, "%hu-%hhu-%hhu",
            &dt->year, &dt->month, &dt->day) != 3;
    }
    ```

## - { points=2 }

Écrire une fonction qui reçoit 2 dates et retourne `0` si elles sont égales `1` si `date1 > date2` ou `-1` si `date1 < date2`.

!!! solution { lines=6 }

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

## - { points=2 }

Déclarez un nouveau type basé sur une structure `Birthday` contenant un nom et une date d'anniversaire (`Date`).

!!! solution { lines=5 }

    ```c
    typedef struct birthday {
        char name[64];
        Date birthday;
    } Birthday;
    ```

## - { points=2 }

Déclarez un tableau de `Birthday` de taille `10`. Initialisez la première entrée avec le nom `John Doe` et la date `2000-01-01`.

!!! solution { lines=4 }

    ```c
    Birthday birthdays[10] = {
        { .name = "John Doe", .birthday = { .year=2000, .month=1, .day=1 } }
    };
    ```

## -

Quelle est la taille en octets des structures suivantes :

### - { points=1 }

```c
struct { int32_t a; int32_t b; };
```

!!! solution { lines=1 }

    8 bytes

### - { points=1 }

```c
struct { char *name; int32_t age; };
```

!!! solution { lines=1 }

    16 bytes sur une machine 64 bits

### - { points=1 }

```c
struct { char k[8]; short s[2]; };
```

!!! solution { lines=1 }

    12 bytes

### - { points=1 }

```c
struct { char a; short b; };
```

!!! solution { lines=1 }

    4 bytes (à cause de l'alignement)

---

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

!!! solution { lines=2 }

    ```c
    printf("%d\n", data->data[4].bar[1]);
    ```

# Tableau Périodique { points=5 }

Le tableau périodique des éléments de Mendeleev regroupe tous les éléments chimiques. Ces éléments sont caractérisés par un nom pouvant comporter jusqu'à 20 lettres, un symbole comportant au maximum 3 lettres, un numéro périodique représentant la position dans le tableau (c'est-à-dire le nombre de protons du noyau), et une valeur logique indiquant si la substance est radioactive ou non.

Déclarez les types de données et une variable permettant de stocker les caractéristiques mentionnées ci-dessus pour un nombre variable d'éléments compris entre 0 et 120 éléments inclus.

!!! solution { lines=10 }

    ```c
    typedef struct element {
        char name[20];
        char symbol[3];
        int period;
        bool is_radioactive;
    } Element;

    Element[121] elements;
    ```
