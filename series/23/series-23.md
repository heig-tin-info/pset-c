# Série 23 — Les pointeurs

## -

Complétez le tableau suivant en indiquant la valeur des variables après chaque instruction.

Pour indiquer que la variable `p` contient l'adresse `a`, on notera `&a` dans la colonne `p`.

Pour indiquer qu'une variable est non initialisée ou que son contenu n'est pas connu, la case sera laissée vide.

| Instruction | a | b | c | p | q |
| --- | --- | --- | --- | --- | --- |
| `int a = 1;` | [1] | [] | [] | [] | [] |
| `int b = 2;` | [1] | [2] | [] | [] | [] |
| `int c = 3;` | [1] | [2] | [3] | [] | [] |
| `int *p = &a;` | [1] | [2] | [3] | [&a] | [] |
| `int *q = &c;` | [1] | [2] | [3] | [&a] | [&c] |
| `*p=(*q)++;` | [3] | [2] | [4] | [&a] | [&c] |
| `p = q;` | [3] | [2] | [4] | [&c] | [&c] |
| `q = &b;` | [3] | [2] | [4] | [&c] | [&b] |
| `*p -= *q;` | [3] | [2] | [2] | [&c] | [&b] |
| `++*q;` | [3] | [3] | [2] | [&c] | [&b] |
| `*p *= *q;` | [3] | [3] | [6] | [&c] | [&b] |
| `a = ++*q**p;` | [24] | [4] | [6] | [&c] | [&b] |
| `p = &a;` | [24] | [4] | [6] | [&a] | [&b] |
| `*q = *p /= *q;` | [6] | [6] | [6] | [&a] | [&b] |
| `int *r[3] = {&a, &b, &c};` | [6] | [6] | [6] | [&a] | [&b] |

## -

Intéressons-nous à l'arithmétique de pointeurs. On considère `p` un pointeur qui *pointe* sur un tableau `a`:

```c
int a[] = {4, 8, 15, 16, 23, 42, 66, 104, 162};
int *p = a;
```

Quelles sont les valeurs ou adresses que fournissent ces expressions ?

- `*p+2` — [6]
- `*(p+2)` — [15]
- `&a[4]-3` — [L'adresse de l'élément `a[1]`]
- `a + 3` — [L'adresse de l'élément `a[3]`]
- `&a[7]-p` — [7]
- `p+(*p-2)` — [L'adresse de l'élément `a[2]`]
- `*(p+*(p+4)-a[3])` — [104]
- `(p+1)[2]` — [16]
- `5[p] // wtf!` — [42]
- `(uintptr_t)(p + 3) - (uintptr_t)a` — [12 (bytes)]
- `(&a)[1][-1]` — [162]

## -

Écrire une fonction qui respecte le prototype ci-dessous. Cette fonction copie une chaîne de caractère de la source vers la destination.

```c
void strcpy(char *dest, const char *src);
```

Ne pas utiliser de boucle for, ni d'accès tableaux (`a[b]`). Utilisez une boucle `while` et l'arithmétique de pointeurs.

!!! solution { lines=8 }

    ```c
    void strcpy(char *dest, const char *src)
    {
        char *p = dest;
        while (*src)
            *p++ = *src++;
        *p = '\0';
    }
    ```
