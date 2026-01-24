# Série 24 — Le Préprocesseur

## - { points=4 }

### - { points=2 }

Quelle sera la valeur affichée par le programme ci-dessous ?

```c
#include <stdio.h>

#define ONE 1
#define NINE 9
#define TEN ONE + NINE

int main() {
    printf("%d\n", NINE * TEN);
}
```

!!! solution { lines=1 }

    L'expression `NINE * TEN` est évaluée comme `9 * 1 + 9`, ce qui donne `18`.

### - { points=2 }

Quelles modifications faut-il apporter pour que le résultat soit correct ?

!!! solution { lines=3 }

    Il est nécessaire de rajouter des parenthèses dans la définition de la macro.

    ```c
    #define TEN (ONE + NINE)
    ```

## - { points=4 }

Expliquer pourquoi ce programme affiche `5`, et comment corriger ce problème.

```c
#include <stdio.h>
#define MAX(i, j) i > j ? i : j

int main(void)
{
    printf("%d\n", MAX(5, 2) + 4);
}
```

!!! solution

    L'appel de la macro `MAX(5,2)` est évalué comme `5 > 2 ? 5 : 2`. Mais l'addition qui suit donne l'expression : `5 > 2 ? 5 : 2 + 4`, soit `true ? 5 : 6` en raison des priorités des opérateurs.

    Afin de résoudre ce problème il est nécessaire de protéger par des parenthèses toutes les variables d'une macro.

    ```c
    #define MAX(i, j) ((i) > (j) ? (i) : (j))
    ```

## - { points=4 }

Expliquez pourquoi ce programme affiche la valeur `7`.

```c
#define ABS(x) ((x) >= 0 ? (x) : -(x))

int main(void)
{
    int i = 5;
    int res = ABS(++i);
    printf("%d\n", res);
}
```

!!! solution

    Une fois de plus le préprocesseur agit comme du remplacement de chaînes, et donc l'expression `ABS(++i)` est évaluée comme `((++i) >= 0 ? (++i) : -(++i))`. Comme `++i` est supérieur à 0, l'opérateur conditionnel évalue et retourne la première expression soit `++i`. Au final, `i` aura été incrémenté deux fois.

    Il n'existe pas de solution pour éviter ce genre de problème, en revanche on prendra l'habitude de bien saisir les macros en MAJUSCULES pour bien les identifier, et éviter de donner à une macro des expressions qui peuvent poser problème.

    L'approche correcte consiste à ne pas utiliser de macros, mais plutôt utiliser une fonction *inline*.

    ```c
    inline int abs_int(int x) {
        return x >= 0 ? x : -x;
    }
    ```

## - { points=4 }

Qu'affichent les programmes ci-dessous ?

### - { points=2 }

```c
#include <stdio.h>

#define TEST 0

int main(void)
{
#ifdef TEST
    printf("#ifdef\n");
#else
    printf("#else\n");
#endif
#ifndef TEST
    printf("#ifndef\n");
#endif
#if !defined TEST
    printf("#if !defined\n");
#endif
#if defined TEST
    printf("#if defined\n");
#endif
#if TEST
    printf("#if\n");
#endif
}
```

!!! solution

    ```c
    #ifdef
    #if defined
    ```

### - { points=2 }

```c
#include <stdio.h>

//#define TEST 0

int main()
{
#ifdef TEST
    printf("#ifdef\n");
#else
    printf("#else\n");
#endif
#ifndef TEST
    printf("#ifndef\n");
#endif
#if !defined TEST
    printf("#if !defined\n");
#endif
#if defined TEST
    printf("#if defined\n");
#endif
#if TEST
    printf("#if\n");
#endif
}
```

!!! solution

    ```c
    #else
    #ifndef
    #if !defined
    ```

## - { points=10 }

Calcul du taux d'intérêt.

```c
#include <stdio.h>
#include <stdlib.h>

#define ZONE_SWISS

#ifdef ZONE_SWISS
#define ZONE_NAME "Suisse"
#define CURRENCY "CHF"
#elif defined ZONE_EUROPE
#define ZONE_NAME "Europe"
#define CURRENCY "EUR"
#elif defined ZONE_AFRICA
#define ZONE_NAME "Afrique"
#define CURRENCY "CFA"
#elif defined ZONE_USA
#define ZONE_NAME "États-Unis"
#define CURRENCY "USD"
#else
#error Ce programme n'est pas compatible pour cette zone géographique
#endif

int main(void)
{
    double capital;
    printf("Programme de calcul des intérêts au %s pour la %s.\n",
        __DATE__, ZONE_NAME
    );
    printf("Capital en %s ?", CURRENCY);
    scanf("%lf", &capital);
    printf("Taux d'intérêts annuel en %% \? : ");
    double interest_rate;
    scanf("%lf", &interest_rate);
    printf("Montant annuel des intérêts : %g %s\n",
        capital * interest_rate / 100,
        CURRENCY);
}
```

### - { points=2 }

Que fait ce programme ? Que voit l'utilisateur à l'écran ?

```c
echo "1000\n5\n" | ./a.out
```

!!! solution

    ```c
    Programme de calcul des intérêts au 2022-04-11 pour la Suisse.
    Capital en CHF ? 1000
    Taux d'intérêts annuel % \? 5
    Montant annuel des intérêts : 50 CHF
    ```

### - { points=2 }

Que faut-il faire pour adapter rapidement ce programme à une autre zone géographique ?

!!! solution { lines=1 }

    Il suffit de remplacer la définiton du symbole `ZONE_SWISS` par le symbole d'une autre zone.

### - { points=2 }

Quel changement y aura-t-il si on remplace la définition `ZONE_SWISS` par `ZONE_AFRICA` ?

!!! solution { lines=1 }

    Le nom de la zone géographique affichée sera `Afrique` et l'unité monétaire utilisée sera `CFA`.

### - { points=2 }

Quel changement y aura-t-il si on remplace la définition `ZONE_SWISS` par `ZONE_JAPAN` ?

!!! solution { lines=1 }

    Le programme n'a pas été prévu pour fonctionner avec cette zone. Lors de la compilation du programme un message d'erreur sera affiché.

### - { points=2 }

Comment compiler le programme depuis la ligne de commande pour n'importe quelle zone ?

!!! solution

    Il faut tout d'abord retirer la définition `ZONE_SWISS` du programme, puis compiler en utilisant par exemple :

    ```c
    cc -DZONE_SWISS interest.c -ointerest
    ```
