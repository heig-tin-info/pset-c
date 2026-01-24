# Série 5 — Opérateurs logiques

## Opérateurs de relation et opérateurs logiques { points=4 }

### - { points=2 }

Ajouter à l'expression suivante toutes les parenthèses montrant l'ordre d'exécution des opérations.

```c
double x, y;
int z = x >= 0 && x <= 20 && y > x || y == 50 && x == 1 * 2 || y == 30 + 30;
```

!!! solution

    ```c
    double x, y;
    int z = ((((x >= 0) && (x <= 20)) && (y > x)) ||
    ((y == 50) && (x == (1 * 2))) || (y == (30 + 30)));
    ```

### - { points=2 }

Quelle est la valeur de `z` évaluées avec les valeurs suivantes ?

- `x = -1.0; y = 60.0;` — [1]{w=5cm}
- `x = 0.0 ; y = 1.0;` — [1]{w=5cm}
- `x = 19.0 ; y = 1.0;` — [0]{w=5cm}
- `x = 0.0 ; y = 50.0;` — [1]{w=5cm}
- `x = 2.0 ; y = 50.0;` — [1]{w=5cm}
- `x = -10.0 ; y = 60.0;` — [1]{w=5cm}

## Cas particuliers { points=10 }

### - { points=2 }

Que vaut `i` ?

```c
uint16_t i = 32767;
i++;
```

[\texttt{i} vaut 32768]{w=5cm}

### - { points=2 }

Que vaut `i` ?

```c
int16_t i = 0;
--i; i--; i++; ++i;
```

[\texttt{i} vaut 0.]{w=5cm}

### - { points=2 }

Que vaut `i` ?

```c
short i = 'A' > 'B' ? 'C' : 'D';
```

[\texttt{i} vaut 'D', soit 68.]{w=5cm}

### - { points=2 }

Que valent `i`, `j` et `k` ?

```c
short i = 0, j = 1, k;
k = (k = 5, i++) >= j ? i++ : --j;
```

[i: 1, j: 0, k: 5]{w=5cm}

### - { points=2 }

Que valent `i`, `j` et `k` ?

```c
short i = 2, j = 1, k;
k = i >= j << 1 ? i++ << 2 : --j << 3;
```

[i: 3, j: 1, k: 8]{w=5cm}

## Calcul de masques : que vaut `m` en binaire ? { points=4 }

```c
char m, n = 2;
char d = 0x55, e = 0xaa;
```

- `m = 1 << n;` — [0b00000100]{w=5cm}
- `m = ~(1 << n);` — [0b11111011]{w=5cm}
- `m = d | (1 << n);` — [0b01010101]{w=5cm}
- `m = e | (1 << n);` — [0b10101110]{w=5cm}
- `m = d ^ (1 << n);` — [0b01010001]{w=5cm}
- `m = e ^ (1 << n);` — [0b10101110]{w=5cm}
- `m = d & ~(1 << n);` — [0b01010001]{w=5cm}
- `m = e & ~(1 << n);` — [0b10101010]{w=5cm}

## Résoudre le problème avec une ligne de code { points=6 }

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

## - { points=4 }

Écrire une fonction en C qui inverse les chiffres d'un entier. Utilisez le prototype suivant :

```c
int32_t reverse(int32_t num);
```

Exemple : 123 donne 321 et 208478933 donne 339874802.

!!! solution { box=10cm }

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
