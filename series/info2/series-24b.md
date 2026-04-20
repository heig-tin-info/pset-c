---
title: Série 0x24b
subtitle: Les pointeurs (suite)
tags:
  - pointers
  - pointer-arithmetic
  - strings
  - double-pointer
  - arrays
exam:
  course: INFO2-TIN
---

## Pointeurs sur tableau de chaînes { points=10 }

Considérez la déclaration suivante, puis pour chaque expression, indiquez le texte affiché sur la sortie standard.

```c
char t[][8] = {
    {'A', 'n', 't', 'o', 'i', 'n', 'e', '\0'},
    "Nicolas",
    "Raphael"
};
char *p = t[1];
char (*q)[8] = t;
char **r = &p;
```

### - { points=1 }

`printf("%c", *p);`

!!! solution { lines=1 }

    `N`

### - { points=1 }

`printf("%c", p[5]);`

!!! solution { lines=1 }

    `a`

### - { points=1 }

`printf("%ld", strlen(t[2]));`

!!! solution { lines=1 }

    `7`

### - { points=1 }

`printf("%ld", sizeof(t[0]));`

!!! solution { lines=1 }

    `8`

### - { points=1 }

`printf("%ld", sizeof(t));`

!!! solution { lines=1 }

    `24`

### - { points=1 }

`printf("%c", *(p + 6));`

!!! solution { lines=1 }

    `s`

### - { points=1 }

`printf("%s", p + 3);`

!!! solution { lines=1 }

    `olas`

### - { points=1 }

`printf("%c", (*r)[3]);`

!!! solution { lines=1 }

    `o`

### - { points=1 }

`printf("%s", q[2]);`

!!! solution { lines=1 }

    `Raphael`

### - { points=1 }

`printf("%hhd", (int8_t)t[1][7]);`

!!! solution { lines=1 }

    `0`

---

## Pointeurs et tableaux d'entiers { points=8 }

Considérez la déclaration suivante, puis pour chaque expression, indiquez la valeur affichée sur la sortie standard.

```c
int b[][3] = {
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9}
};
int *p = b[1];
int (*q)[3] = b;
int **r = &p;
```

### - { points=1 }

`printf("%d", *p);`

!!! solution { lines=1 }

    `4`

### - { points=1 }

`printf("%d", p[2]);`

!!! solution { lines=1 }

    `6`

### - { points=1 }

`printf("%ld", sizeof(*q));`

!!! solution { lines=1 }

    `12`

### - { points=1 }

`printf("%ld", sizeof(b));`

!!! solution { lines=1 }

    `36`

### - { points=1 }

`printf("%d", **r);`

!!! solution { lines=1 }

    `4`

### - { points=1 }

`printf("%d", q[2][1]);`

!!! solution { lines=1 }

    `8`

### - { points=1 }

`printf("%d", *(*q + 1));`

!!! solution { lines=2 }

    `2`

    `*q` est équivalent à `q[0]` soit `b[0]`, un `int*` pointant sur `b[0][0]`. `*q + 1` pointe sur `b[0][1]` et la déréférence donne `2`.

### - { points=1 }

`printf("%d", q[p[0] / q[0][2]][2]);`

!!! solution { lines=3 }

    `6`

    `p[0]` vaut `4`, `q[0][2]` vaut `3`. La division entière donne `4 / 3 = 1`. L'expression se réduit à `q[1][2]` soit `b[1][2] = 6`.

---

## Programmation – strcopy avec void* { points=6 }

La bibliothèque standard C utilise `void*` pour les fonctions génériques de manipulation de mémoire (comme `memcpy`). Un `void*` est un pointeur sans type : il peut recevoir n'importe quel pointeur sans cast explicite, ce qui rend la fonction utilisable pour n'importe quel type de données.

En revanche, on **ne peut pas déréférencer** un `void*` directement : il faut d'abord le caster vers un type concret. Pour traiter des octets un par un, on caste en `char*` :

```c
const char *s = (const char *)src;
```

Écrire une fonction qui respecte le prototype ci-dessous. Cette fonction copie une chaîne de caractères (terminée par `'\0'`) depuis `src` vers `dest`.

```c
void strcopy(void *dest, const void *src);
```

Contraintes : ne pas utiliser la notation tableau (`a[b]`), utiliser une boucle `while`.

!!! solution { lines=10 }

    ```c
    void strcopy(void *dest, const void *src)
    {
        char *d = (char *)dest;
        const char *s = (const char *)src;
        while (*s)
            *d++ = *s++;
        *d = '\0';
    }
    ```

---

## Programmation – réécriture sans variable itérative { points=6 }

On souhaite afficher successivement tous les suffixes d'un tableau d'entiers. Le code suivant, utilisant deux indices, produit la sortie :

```text
1 2 3 4 5
2 3 4 5
3 4 5
4 5
5
```

```c
int a[] = {1, 2, 3, 4, 5};
int n = 5;

for (int i = 0; i < n; i++) {
    for (int j = i; j < n; j++)
        printf("%d ", a[j]);
    printf("\n");
}
```

Réécrire ce programme **sans aucune variable entière itérative** (`i`, `j`, etc.) en faisant progresser des pointeurs et en utilisant la **comparaison de pointeurs** comme condition d'arrêt.

!!! solution { lines=12 }

    ```c
    int a[] = {1, 2, 3, 4, 5};
    int *end = a + 5;

    for (int *p = a; p < end; p++) {
        for (int *q = p; q < end; q++)
            printf("%d ", *q);
        printf("\n");
    }
    ```

    `end` pointe un élément **au-delà** du dernier élément du tableau (idiome C classique). La boucle externe fait avancer `p` d'un élément à chaque tour ; la boucle interne parcourt de `p` jusqu'à `end` exclu grâce à la comparaison `q < end`.

---

## Programmation – strrev { points=5 }

Écrire une fonction qui respecte le prototype ci-dessous. Cette fonction inverse une chaîne de caractères **sur place** (*in-place*), sans allouer de mémoire supplémentaire.

```c
void strrev(char *s);
```

Exemples d'utilisation :

```c
char mot[] = "Bonjour";
strrev(mot);   // mot vaut maintenant "ruojnoB"

char vide[] = "";
strrev(vide);  // pas d'effet
```

Contraintes : utiliser deux variables pointeur, ne pas utiliser la notation tableau (`a[b]`).

!!! solution { lines=12 }

    ```c
    void strrev(char *s)
    {
        char *e = s;
        while (*e)
            e++;
        if (e == s) return;
        e--;
        while (s < e) {
            char tmp = *s;
            *s++ = *e;
            *e-- = tmp;
        }
    }
    ```
