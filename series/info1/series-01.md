---
title: Série 0x01
subtitle: Numération et Arguments
tags:
- numeration
- numeric-literals
- two-complement
- command-line-arguments
exam:
  course: INFO1-TIN
---

# Quelques généralités

## - { points=2 }

Comment écrire en C une constante littérale hexadécimale correspondant à la valeur $1ab4_{16}$ ?

!!! solution { lines=1 }

    0x1ab4

## - { points=2 }

Comment écrire en C une constante littérale octale représentant la valeur $2642_{8}$ ?

!!! solution { lines=1 }

    02642

## - { points=2 }

Bien qu'il ne soit pas normalisé dans C11, le préfixe [0b] est utilisé pour représenter une constante littérale binaire.

## - { points=2 }

Le signe d'un nombre en complément à deux peut être connu en observant son bit de poids [fort] tandis que le bit de poids [faible] renseigne sur sa parité (pair ou impair).

## - { points=2 }

Le programme suivant est appelé. Combien d'arguments le programme reçoit-il ?

```c
./a.out 1 2 3
```

!!! solution { lines=1 }

    4 arguments

## - { points=2 }

Comment s'appelle le flux qui permet à un programme de recevoir des informations par exemple saisies au clavier ?

!!! solution { lines=1 }

    L'entrée standard

## - { points=2 }

Combien de bytes y a-t-il dans un Mebibyte (MiB) ?

!!! solution { lines=1 }

    $1024\cdot 1024 = 1'048'576\ \text{Bytes}$

## - { points=2 }

Combien de bits faut-il pour représenter un Gigabyte (GB) de données ?

!!! solution { lines=1 }

    $\lceil \log_2\left(1 \cdot 10^9 \right)\rceil \approx \lceil 29.89 \rceil = 30\ \text{bits}$

---

# Effectuer les additions suivantes à la main en binaire sur 8 bits { points=8 }

Exemple:

```c
    11
  00001001 = 0x09 = 9
+ 00011000 = 0x18 = 24
  --------
  00100001 = 0x21 = 33
```

## - { points=2 }

$1 + 51$

!!! solution { box=3cm }

    ```c
            11
      00000001 = 0x01 = 1
    + 00110011 = 0x33 = 51
    ----------
      00110100 = 0x34 = 52
    ```

## - { points=2 }

$51 - 7$

!!! solution { box=3cm }

    ```c
     1111  11
      00110011 = 0x33 = 51
    + 11111001 = (~00000111 + 1) = 0xF9 = -7
    ----------
      00101100 = 0x2C = 44
    ```

## - { points=2 }

$204 + 51$

!!! solution { box=3cm }

    ```c
      11001100 = 0xCC = 204
    + 00110011 = 0x33 = 51
    ----------
      11111111 = 0xFF = 255
    ```

## - { points=2 }

$204 + 204$

!!! solution { box=3cm }

    ```c
         11
      11001100 = 0xCC = 204
    + 11001100 = 0xCC = 204
    ----------
      10011000 = 0x98 = (408-256) = 152
    ```

---

# Programmation

## - { points=2 }

Écrire un programme qui lit le premier nombre passé en argument depuis la ligne de commande et l'affiche à l'écran.

!!! solution { lines=4 }

    ```c
    int main(int argc, char *argv[]) {
        printf("Votre nombre est : %d\n", atoi(argv[1]));
    }
    ```

## - { points=4 }

Écrire un programme qui affiche explicitement la somme de deux nombres. Ces deux nombres sont déclarés dans des variables entières nommées `a` et `b`.

Voici ce que produit le programme :

```c
./a.out
42 + 23 = 65
```

!!! solution { lines=4 }

    ```c
    int main() {
        int a = 42;
        int b = 23;
        printf("%d + %d = %d", a, b, a + b);
    }
    ```
