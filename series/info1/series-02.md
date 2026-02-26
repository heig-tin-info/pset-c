---
title: Série 0x02
subtitle: Variables et identificateurs
tags:
  - variables
  - identifiers
  - assignment
  - debugging
exam:
  course: INFO1-TIN
---
## Identificateurs { points=15 }

Pour chacun des identificateurs suivants, indiquez s'il est correct ou incorrect, et donnez une justification.

| Identificateur    | Validité           | Justification / Commentaire                         |
| ----------------- | ------------------ | --------------------------------------------------- |
| `2_pi`            | [Incorrect]{w=2cm} | [commence par un chiffre]{w=8cm}                    |
| `x_2`             | [Correct]{w=2cm}   | [Underscore pas nécessaire]{w=8cm}                  |
| `x__3`            | [Correct]{w=2cm}   | [Double underscore redondant]{w=8cm}                |
| `x  2`            | [Incorrect]{w=2cm} | [contient des espaces]{w=8cm}                       |
| `robotPosition`   | [Correct]{w=2cm}   | [Notation camlCase]{w=8cm}                          |
| `stored_values`   | [Correct]{w=2cm}   | [Notation snake_case]{w=8cm}                        |
| `-output_current` | [Incorrect]{w=2cm} | [tiret interdit]{w=8cm}                             |
| `_alarm_`         | [Correct]{w=2cm}   | [Peu conseillé]{w=8cm}                              |
| `issue#2`         | [Incorrect]{w=2cm} | [signe dièse interdit]{w=8cm}                       |
| `int`             | [Incorrect]{w=2cm} | [mot réservé du langage]{w=8cm}                     |
| `défaillance`     | [Incorrect]{w=2cm} | [mot accentué]{w=8cm}                               |
| `f'`              | [Incorrect]{w=2cm} | [comporte une apostrophe]{w=8cm}                    |
| `INT`             | [Correct]{w=2cm}   | [mais pas recommandé]{w=8cm}                        |
| `main`            | [Correct]{w=2cm}   | [mais plutôt réservé à la fonction d'entrée]{w=8cm} |
| `M_PI`            | [Incorrect]{w=2cm} | [constante réservée]{w=8cm}                         |

## Affectation { points=6 }

Pour chacune des variables suivantes, indiquer leurs valeurs. Les variables non initialisées sont notées avec `?`. Cela signifie que leur contenu n'est pas prévisible.

| Instruction        | a          | b           | c          | d          |
| ------------------ | ---------- | ----------- | ---------- | ---------- |
| `a = 5;`           | [5]{w=2cm} | [?]{w=2cm}  | [?]{w=2cm} | [?]{w=2cm} |
| `b = c;`           | [5]{w=2cm} | [?]{w=2cm}  | [?]{w=2cm} | [?]{w=2cm} |
| `c = a;`           | [5]{w=2cm} | [?]{w=2cm}  | [5]{w=2cm} | [?]{w=2cm} |
| `a = a + 1;`       | [6]{w=2cm} | [?]{w=2cm}  | [5]{w=2cm} | [?]{w=2cm} |
| `b = a * (c + 1);` | [6]{w=2cm} | [36]{w=2cm} | [5]{w=2cm} | [?]{w=2cm} |
| `d = b % 2;`       | [6]{w=2cm} | [36]{w=2cm} | [5]{w=2cm} | [0]{w=2cm} |

## Échange de variables { points=4 }

Écrire une série d'instructions permettant d'échanger les valeurs de `a` et `b`. À la fin de cette séquence d'instruction, la valeur initiale de `a` doit être dans `b` et réciproquement.

!!! solution { lines=5 }

    ```c
    int tmp;
    tmp = a;
    a = b;
    b = tmp;
    ```

## Débogue { points=4 }

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

---

## Programmation { points=4 }

Écrire un programme demandant sur l'entrée standard 2 nombres réels : tension et résistance. Le programme indique ensuite la valeur du courant circulant dans le circuit en utilisant la loi d'Ohm. Un test doit être prévu si la résistance est nulle.

!!! solution { lines=15cm }

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
