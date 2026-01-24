# Série 20 — Révision du cours Info1

## -

Considérez les déclarations suivantes :

```c
char c = 3;    short s = 7;
int i = 3;     long l = 4;
float f = 3.3; double d = 7.7;
```

Pour chacune des expressions ci-dessous, indiquez leur type et leur valeur.

**Exemple :** `2 / 3 * c`, réponse : `(int)0`.

### -

`c / 2`

!!! solution { lines=1 }

    (int)1

### -

`s + c / 10`

!!! solution { lines=1 }

    (int)7

### -

`l + i / 2.0`

!!! solution { lines=1 }

    (double)5.5

### -

`d + f`

!!! solution { lines=1 }

    (double)11

### -

`(int)d + f`

!!! solution { lines=1 }

    (float)10.3

### -

`(int)d + l`

!!! solution { lines=1 }

    (long)11

### -

`c << 2`

!!! solution { lines=1 }

    (int)12

### -

`s & 0xf0`

!!! solution { lines=1 }

    (int)0

### -

`s && 0xf0`

!!! solution { lines=1 }

    (int)1

### -

`d + f == s + l`

!!! solution { lines=1 }

    (int)0

## -

Dans chacune des structures de contrôle ci-dessous, indiquer la nature de l'erreur.

### -

```c
double x = 100.0;
size_t i = 0;
do
    x = x / 2.0;
    i++;
while (x > 1.0);
```

!!! solution { lines=2 }

    Il manque les accolades autour du bloc `do..while`.

### -

```c
long x = 100;
if (x = 0)
    printf("Erreur : la valeur 0 est interdite !\n");
```

!!! solution { lines=2 }

    Le test d'égalité utilise l'opérateur `==`. L'opérateur d'affectation `=` n'est pas valable.

### -

```c
double x = 100.0;
switch (x) {
    case 0:
        printf("x est nul.\n");
        break;
    default:
        print("OK.\n");
}
```

!!! solution { lines=2 }

    L'instruction `switch` n'est pas applicable à un type à virgule flottante.

### -

```c
for (int i = 0; i < 10; i++);
{
    printf("%d\n", i);
}
```

!!! solution { lines=2 }

    Le point virgule à la fin de l'instruction termine cette dernière. Le bloc formé des accolades n'appartient pas à la boucle.

### -

```c
int i = 0;
while i < 100
{
    printf("%d\n", ++i);
}
```

!!! solution { lines=2 }

    Il manque des parenthèses autour de la condition de l'instruction `while`.

## -

On s'intéresse ici au passage par adresse. Observez le programme suivant et indiquez ce que vous voyez sur la sortie standard.

```c
#include <stdio.h>
#include <stdlib.h>

int test(int a, int *b, int *c, int *d) {
    a = *b;
    *b = *b + 5;
    *c = a + 2;
    d = c;
    return *d;
}

int main() {
  int a = 0, b = 100, c = 200, d = 300, e = 400;
  e = test(a, &b, &c, &d);
  printf("%05d %d %d %d %d", a, b, c, d, e);
}
```

!!! solution { lines=1 }

    00000 105 102 300 102

## -

Algorithme sur les tableaux : écrire une fonction qui reçoit en paramètre un tableau d'entiers et qui retourne la position de la première occurrence d'une valeur dans ce tableau, ou `-1` si la valeur n'est pas présente. Utiliser la syntaxe pointeur pour le paramètre tableau.

!!! solution { lines=5 }

    ```c
    int index(int *array, size_t size, int value) {
      for (int i = 0; i < size; i++)
          if (array[i] == value)
              return i;
      return -1;
    }
    ```

## -

Écrire une fonction qui calcul la longueur totale des segments de droite dont les points sont reçus en paramètre. Les données sont un tableau composé de N par 2. Les indices du sous tableau sont les coordonnées X et Y des points.

!!! solution { lines=9 }

    ```c
    double distance(double x1, double y1, double x2, double y2) {
      return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
    }

    double length(double array[][2], size_t size) {
      double length = 0;
      for (int i = 0; i < size - 1; i++)
          length += distance(
              array[i][0], array[i][1],
              array[i + 1][0], array[i + 1][1]
          );
      return length;
    }
    ```
