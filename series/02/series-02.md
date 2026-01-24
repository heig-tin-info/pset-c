# Série 2 — Variables et identificateurs

## -

Pour chacun des identificateurs suivants, indiquez s'il est correct ou incorrect, et donnez une justification.

- `2_pi` — [Incorrect, commence par un chiffre]{w=10cm}
- `x_2` — [Correct]{w=10cm}
- `x__3` — [Correct]{w=10cm}
- `x  2` — [Incorrect, contient des espaces]{w=10cm}
- `robotPosition` — [Correct]{w=10cm}
- `stored_values` — [Correct]{w=10cm}
- `-output_current` — [Incorrect, tiret interdit]{w=10cm}
- `_alarm_` — [Correct]{w=10cm}
- `issue#2` — [Incorrect, signe dièse interdit]{w=10cm}
- `int` — [Incorrect, mot réservé du langage]{w=10cm}
- `défaillance` — [Incorrect, mot accentué]{w=10cm}
- `f'` — [Incorrect, comporte une apostrophe]{w=10cm}
- `INT` — [Correct, mais pas recommandé]{w=10cm}
- `main` — [Correct, mais plutôt réservé à la fonction d'entrée]{w=10cm}

## -

Pour chacune des variables suivantes, indiquer leurs valeurs. Les variables non initialisées sont notées avec `?`. Cela signifie que leur contenu n'est pas prévisible.

| Instruction | a | b | c | d |
| --- | --- | --- | --- | --- |
| `a = 5;` | [5] | [?] | [?] | [?] |
| `b = c;` | [5] | [?] | [?] | [?] |
| `c = a;` | [5] | [?] | [5] | [?] |
| `a = a + 1;` | [6] | [?] | [5] | [?] |
| `b = a * (c + 1);` | [6] | [36] | [5] | [?] |
| `d = b % 2;` | [6] | [36] | [5] | [0] |

## -

Écrire une fonction permettant d'échanger les valeurs de `a` et `b`. À la fin de cette séquence d'instruction, la valeur initiale de `a` doit être dans `b` et réciproquement.

!!! solution { box=5cm }

    ```c
    int tmp;
    tmp = a;
    a = b;
    b = tmp;
    ```

## -

Le programme suivant comporte 13 erreurs. Trouvez-les et corrigez-les.

```c
/*
/* Programme exemple */
*/

#include <std_io.h>
#jnclude <stdlib.h>

INT Main()
{
    int a, sum;
    printf("Addition de 2 entiers a et b.\n");

    printf("a:");
    scanf("%d", a);

    printf("b:");
    scanf("%d", &b);

    somme = a + b;
    Printf("%f + %d = %d\n", a, b, sum);

    retturn 1;
}
}
```

!!! solution

    ```c
    // /* 1. Ouverture de commentaire inutile
    /* Programme exemple */
    // */ 2. Fermeture de commentaire inutile

    #include <std_io.h> // 3. S'écrit <stdio.h>
    #jnclude <stdlib.h>
    // 4. S'écrit #include, et inutile dans ce programme

    INT Main() // 5. S'écrit int, 6. S'écrit main()
    {
        int a, sum;
        printf("Addition de 2 entiers a et b.\n");

        printf("a:");
        scanf("%d", a); // 7. Manque le & devant a

        printf("b:");
        scanf("%d", &b); // 8. La variable b n'est pas déclarée

        somme = a + b; // 9. Probablement `sum` pas `somme`
        Printf("%f + %d = %d\n", a, b, sum);
        // 10. printf en minuscule, 11. %d pas %f

        retturn 1; // 11. Return avec un t, 12. Retourne 0 si pas d'erreur
    }
    } // 13. Une accolade en trop.
    ```

## -

Écrire un programme demandant sur l'entrée standard 2 nombres réels : tension et résistance. Le programme indique ensuite la valeur du courant circulant dans le circuit en utilisant la loi d'Ohm. Un test doit être prévu si la résistance est nulle.

!!! solution { box=10cm }

    ```c
    #include <stdio.h>

    int main() {
      printf("Application de la loi d'Ohm, calcul du courant.\n");
      printf("-----------------------------------------------\n\n");

      double resistor;
      printf("Résistance en Ohm : ");
      scanf("%lf", &resistor);

      if (resistor <= 0) {
        printf("Erreur: valeur de résistance incorrecte !\n");
        return 1;
      }

      double voltage;
      printf("Tension en Volts : ");
      scanf("%lf", &voltage);

      printf("Le courant est de %g Ampères\n", voltage / resistor);
      return 0;
    }
    ```
