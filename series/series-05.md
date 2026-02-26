---
title: Série 0x05
subtitle: Opérateurs logiques
tags:
- logical-operators
- precedence
- bitwise-operations
- conditional-operator
exam:
  course: INFO1-TIN
---
## Opérateurs de relation et opérateurs logiques

Considérez l'expression suivante :

```c
double x, y;
int z = x >= 0 && x <= 20 && y > x || y == 50 && x == 1 * 2 || y == 30 + 30;
```

### - { points=2 }

Ajouter à l'expression suivante toutes les parenthèses montrant l'ordre d'exécution des opérations.

!!! solution { lines=4 }

    ```c
    double x, y;
    int z = ((((x >= 0) && (x <= 20)) && (y > x)) ||
    ((y == 50) && (x == (1 * 2))) || (y == (30 + 30)));
    ```

### -

Quelle est la valeur de `z` évaluées avec les valeurs suivantes ?

#### - { points=1 answer="`(int)1`" }

`x = -1.0; y = 60.0;`

#### - { points=1 answer="`(int)1`" }

`x = 0.0 ; y = 1.0;`

#### - { points=1 answer="`(int)0`" }

`x = 19.0 ; y = 1.0;`

#### - { points=1 answer="`(int)1`" }

`x = 0.0 ; y = 50.0;`

#### - { points=1 answer="`(int)1`" }

`x = 2.0 ; y = 50.0;`

#### - { points=1 answer="`(int)1`" }

`x = -10.0 ; y = 60.0;`

## Cas particuliers

### - { points=2 answer="`32768`"}

Que vaut `i` ?

```c
uint16_t i = 32767;
i++;
```

### - { points=2 answer="`0.`"}

Que vaut `i` ?

```c
int16_t i = 0;
--i; i--; i++; ++i;
```

### - { points=2 answer="`'D'`, soit 68"}

Que vaut `i` ?

```c
short i = 'A' > 'B' ? 'C' : 'D';
```

### - { points=2 answer="i: `1`, j: `0`, k: `5`"}

Que valent `i`, `j` et `k` ?

```c
short i = 0, j = 1, k;
k = (k = 5, i++) >= j ? i++ : --j;
```

### - { points=2 answer="i: `3`, j: `1`, k: `8`"}

Que valent `i`, `j` et `k` ?

```c
short i = 2, j = 1, k;
k = i >= j << 1 ? i++ << 2 : --j << 3;
```

## Calcul de masques { points=4 }

Que vaut `m` en binaire dans les cas suivants ?

```c
char m, n = 2;
char d = 0x55, e = 0xaa;
```

### - { points=1 answer="`0b00000100`" }

`m = 1 << n;` — []{w=5cm}

### - { points=1 answer="`0b11111011`" }

`m = ~(1 << n);`

### - { points=1 answer="`0b01010101`" }

`m = d | (1 << n);`

### - { points=1 answer="`0b10101110`" }

`m = e | (1 << n);`

### - { points=1 answer="`0b01010001`" }

`m = d ^ (1 << n);`

### - { points=1 answer="`0b10101110`" }

`m = e ^ (1 << n);`

### - { points=1 answer="`0b01010001`" }

`m = d & ~(1 << n);`

### - { points=1 answer="`0b10101010`" }

`m = e & ~(1 << n);`

---

## Oneliners

Résoudre les problèmes suivant avec une seule ligne de code.

### - { points=2 }

Mettre à 1 (*set*) le n-ième bit de la variable `x`.

!!! solution { lines=1 }

    x |= 1 << n;

### - { points=2 }

Mettre à 0 (*clear*) le n-ième bit de la variable `x`.

!!! solution { lines=1 }

    ```c
    x &= ~(1 << n);
    ```

### - { points=2 }

Inverser (*toggle*) le n-ième bit de la variable `x`.

!!! solution { lines=1 }

    ```c
    x ^= 1 << n;
    ```

## Programmation { points=5 }

Écrire une fonction en C qui inverse les chiffres d'un entier. Utilisez le prototype suivant :

```c
int32_t reverse(int32_t num);
```

Exemple : `123` donne `321` et `208478933` donne `339874802`.

!!! solution { lines=10cm }

    ```c
    int32_t reverse(int32_t num) {
      int32_t reversed = 0;

      while (num != 0) {
        // Extraire le dernier chiffre
        int32_t digit = num % 10;

        // Ajouter ce chiffre à la valeur retournée
        reversed = reversed * 10 + digit;

        // Retirer le dernier chiffre
        num /= 10;
      }

      return reversed;
    }
    ```
