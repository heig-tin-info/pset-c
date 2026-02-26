---
title: Série 0x24
subtitle: Les pointeurs
tags:
  - pointers
  - pointer-arithmetic
  - indirection
  - string-copy
exam:
  course: INFO2-TIN
---

## Pointeurs et arithmétique de pointeurs { points=10 }

Complétez le tableau suivant en indiquant la valeur des variables après chaque instruction.

Pour indiquer que la variable `p` contient l'adresse `a`, on notera `&a` dans la colonne `p`.

Pour indiquer qu'une variable est non initialisée ou que son contenu n'est pas connu, utiliser `?`.

| Instruction                 | a           | b          | c          | p           | q           |
| --------------------------- | ----------- | ---------- | ---------- | ----------- | ----------- |
| `int a = 1;`                | [1]{w=1cm}  | [?]{w=1cm} | [?]{w=1cm} | [?]{w=1cm}  | [?]{w=1cm}  |
| `int b = 2;`                | [1]{w=1cm}  | [2]{w=1cm} | [?]{w=1cm} | [?]{w=1cm}  | [?]{w=1cm}  |
| `int c = 3;`                | [1]{w=1cm}  | [2]{w=1cm} | [3]{w=1cm} | [?]{w=1cm}  | [?]{w=1cm}  |
| `int *p = &a;`              | [1]{w=1cm}  | [2]{w=1cm} | [3]{w=1cm} | [&a]{w=1cm} | [?]{w=1cm}  |
| `int *q = &c;`              | [1]{w=1cm}  | [2]{w=1cm} | [3]{w=1cm} | [&a]{w=1cm} | [&c]{w=1cm} |
| `*p=(*q)++;`                | [3]{w=1cm}  | [2]{w=1cm} | [4]{w=1cm} | [&a]{w=1cm} | [&c]{w=1cm} |
| `p = q;`                    | [3]{w=1cm}  | [2]{w=1cm} | [4]{w=1cm} | [&c]{w=1cm} | [&c]{w=1cm} |
| `q = &b;`                   | [3]{w=1cm}  | [2]{w=1cm} | [4]{w=1cm} | [&c]{w=1cm} | [&b]{w=1cm} |
| `*p -= *q;`                 | [3]{w=1cm}  | [2]{w=1cm} | [2]{w=1cm} | [&c]{w=1cm} | [&b]{w=1cm} |
| `++*q;`                     | [3]{w=1cm}  | [3]{w=1cm} | [2]{w=1cm} | [&c]{w=1cm} | [&b]{w=1cm} |
| `*p *= *q;`                 | [3]{w=1cm}  | [3]{w=1cm} | [6]{w=1cm} | [&c]{w=1cm} | [&b]{w=1cm} |
| `a = ++*q**p;`              | [24]{w=1cm} | [4]{w=1cm} | [6]{w=1cm} | [&c]{w=1cm} | [&b]{w=1cm} |
| `p = &a;`                   | [24]{w=1cm} | [4]{w=1cm} | [6]{w=1cm} | [&a]{w=1cm} | [&b]{w=1cm} |
| `*q = *p /= *q;`            | [6]{w=1cm}  | [6]{w=1cm} | [6]{w=1cm} | [&a]{w=1cm} | [&b]{w=1cm} |
| `int *r[3] = {&a, &b, &c};` | [6]{w=1cm}  | [6]{w=1cm} | [6]{w=1cm} | [&a]{w=1cm} | [&b]{w=1cm} |

---

## Pointeurs { points=11 }

Intéressons-nous à l'arithmétique de pointeurs. On considère `p` un pointeur qui _pointe_ sur un tableau `a`:

```c
int a[] = {4, 8, 15, 16, 23, 42, 66, 104, 162};
int *p = a;
```

Quelles sont les valeurs ou adresses que fournissent ces expressions ? Pour indiquer l'adresse utiliser par exemple `&a[3]` pour indiquer l'adresse de l'élément `a[3]`. Pour indiquer la valeur d'un élément du tableau, utiliser par exemple `15` pour indiquer la valeur de l'élément `a[2]`.

| Expression                          | Valeur ou adresse   |
| ----------------------------------- | ------------------- |
| `*p+2`                              | [6]{w=2cm}          |
| `*(p+2)`                            | [15]{w=2cm}         |
| `&a[4]-3`                           | [`&a[1]`]{w=2cm}    |
| `a + 3`                             | [`&a[3]`]{w=2cm}    |
| `&a[7]-p`                           | [7]{w=2cm}          |
| `p+(*p-2)`                          | [`&a[2]`]{w=2cm}    |
| `*(p+*(p+4)-a[3])`                  | [104]{w=2cm}        |
| `(p+1)[2]`                          | [16]{w=2cm}         |
| `5[p] // wtf!`                      | [42]{w=2cm}         |
| `(uintptr_t)(p + 3) - (uintptr_t)a` | [12 (bytes)]{w=2cm} |
| `(&a)[1][-1]`                       | [162]{w=2cm}        |

## Programmation { points=5 }

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
