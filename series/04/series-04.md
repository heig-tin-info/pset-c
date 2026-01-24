# Série 4 — Boucles

## -

Considérons le cas d'un système de vision industrielle qui inspecte des pièces fabriquées au sein d'une ligne d'assemblage. Le programme de ce système de vision comporte certaines variables internes permettant de mémoriser le décompte des pièces analysées. Ces variables sont les suivantes :

```c
int nb_parts = 2000;
int nb_parts_bad = 200;
double percent_good = (nb_parts - nb_parts_bad) / nb_parts;
```

### -

Quel résultats espérait le développeur ?

!!! solution { lines=2 }

    Avec 200 pièces mauvaises sur 2000 pièces produites, le programmeur attendait un résultat de 0.9, signifiant 90 % de pièces bonnes.

### -

Qu'obtient-il dans la pratique ?

!!! solution { lines=1 }

    0.0

### -

Expliquez les défaut constaté ?

!!! solution { lines=2 }

    Le calcul effectue la division entière 1800 / 2000, qui donne comme résultat 0. Ensuite, le résultat est transformé en float et donne 0.0

### -

Que corriger pour obtenir un résultat correct ?

!!! solution

    ```c
    int nb_parts = 2000;
    int nb_parts_bad = 200;
    double percent_good = (double)(nb_parts - nb_parts_bad) / nb_parts;
    ```

## -

Indiquer si les affirmations suivantes sont justes ou fausses. Dans les cas où elles sont fausses, expliquer ce qui serait correct pour une instruction `do..while` :

### -

Les instructions de la boucle sont toujours exécutées au moins une fois.

!!! solution { lines=1 }

    Correct

### -

Comme un mot réservé spécifique commence et termine la boucle, on n'a pas besoin de créer un bloc lorsque l'on a plusieurs instructions.

!!! solution { lines=1 }

    Incorrect, il faut utiliser un bloc s'il y a plusieurs instructions dans la boucle.

### -

La condition se trouvant en fin de boucle, on sort de la boucle lorsque la condition est vraie.

!!! solution { lines=1 }

    Incorrect, on sort de la boucle lorsque la condition est fausse.

### -

Le type de la condition peut être char.

!!! solution { lines=1 }

    Correct

### -

Les instructions de la boucle ne peuvent pas être une autre boucle `do..while`.

!!! solution { lines=1 }

    Incorrect. Une boucle do while peut se trouver à l'intérieur d'une boucle `do..while`.

## -

### -

Écrire un programme qui affiche les nombres entiers de 1 à 100 en employant une boucle `for`.

!!! solution { lines=5 }

    ```c
    #include <stdio.h>

    int main() {
        for (int i = 1; i <= 100; i++)
            printf("%d\n", i);
    }
    ```

### -

Écrire ce même programme en utilisant une boucle `while`.

!!! solution { lines=5 }

    ```c
    #include <stdio.h>

    int main() {
        int i = 1;
        while (i <= 100)
            printf("%d\n", i++);
    }
    ```

### -

Même question avec une boucle `do..while`.

!!! solution { lines=6 }

    ```c
    #include <stdio.h>

    int main() {
        int i = 1;
        do {
            printf("%d\n", i++);
        } while (i <= 100);
    }
    ```

### -

Parmi ces trois implémentations laquelle est la plus adaptée au problème ?

!!! solution { lines=2 }

    Lorsque le nombre d'itérations est connu à l'avance, la boucle `for` est la plus adaptée.

## Boucles `for` : renseignez ce qu'affiche ces boucles

### -

```c
for (i = 'a'; i < 'd'; printf("%i-", ++i));
```

!!! solution { lines=1 }

    98-99-100-

### -

```c
for (i = 'a'; i < 'd'; printf("%c-", ++i));
```

!!! solution { lines=1 }

    b-c-d-

### -

```c
for (i = 'a'; i++ < 'd'; printf("%c-", i ));
```

!!! solution { lines=1 }

    b-c-d

### -

```c
for (i = 'a'; i <= 'a' + 25; printf("%c-", i++ ));
```

!!! solution { lines=1 }

    a-b-c-d-...z-

### -

```c
for (i = 1 / 3; i ; printf("%i\n", i++ ));
```

!!! solution { lines=1 }

    (rien)

### -

```c
for (i = 0; i != 1  ; printf("%i", i += 1 / 3 ));
```

!!! solution { lines=1 }

    0000 ...

### -

```c
for (i = 12, k = 1; k++ < 5 ; printf("%i ", i-- ));
```

!!! solution { lines=1 }

    12 11 10 9 

## Boucles `while` : renseignez ce qu'affiche ces boucles

### -

```c
int i = 0;
while (i - 10) { i += 2; printf ( "%i.", i ); }
```

!!! solution { lines=1 }

    2.4.6.8.10.

### -

```c
int i = 0;
while (i - 10)
i += 2; printf("%i-", i);
```

!!! solution { lines=1 }

    10-

### -

```c
short i = 0;
while ( i < 11 ) { i += 2; printf("%i-", i); }
```

!!! solution { lines=1 }

    2-4-6-8-10-12-

### -

```c
for (i = 'a'; i <= 'a' + 25; printf("%c-", i++ ));
```

!!! solution { lines=1 }

    a-b-c-d-...z-

### -

```c
char i = 11;
while (i--) { printf("%i/", i--); }
```

!!! solution { lines=1 }

    10/8/6/4/2/0/-2/-4/-6/-8 ... (à l'infini)

### -

```c
long i = 12l;
while (i--) { printf("%i%%", --i); }
```

!!! solution { lines=1 }

    10%8%6%4%2%0%

### -

```c
int i = 0;
while (i++ < 10) { printf("%i", i--); }
```

!!! solution { lines=1 }

    1111111111 ... (à l'infini)

### -

```c
int i = 1;
while (i <= 5) { printf("%i/", 2 * i++); }
```

!!! solution { lines=1 }

    2/4/6/8/10/

### -

```c
int i = 1;
while (i != 9) { printf ( "%i-", i = i + 2 ); }
```

!!! solution { lines=1 }

    3-5-7-9-

### -

```c
int i = 1;
while ( i < 9 ) { printf ( "%i", i += 2 ); break; }
```

!!! solution { lines=1 }

    3
