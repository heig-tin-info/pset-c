---
title: Série 0x07
subtitle: Chaînes de caractères
tags:
- strings
- c-strings
- string-library
- mutability
exam:
  course: INFO1-TIN
---
## Tableaux { points=14 }

Pour les exemples ci-dessous, indiquez successivement s'ils compilent sans erreur et le cas échéant, si les chaînes de caractères sont modifiables ou non.

### - { points=2 }

```c
char s[] = 'foo';
```

!!! solution { lines=1 }

    Erreur, guillemet simple utilisé pour une chaîne de caractères.

### - { points=2 }

```c
char s[42] = "Les carottes sont cuites.";
```

!!! solution { lines=1 }

    L'expression compile et la chaîne est modifiable.

### - { points=2 }

```c
char s[2] = "Babel Fish";
```

!!! solution { lines=1 }

    Erreur : la taille de la chaîne est trop courte.

### - { points=2 }

```c
char s[] = "foo\0bar\0";
```

!!! solution { lines=1 }

    L'expression compile et la chaîne est modifiable. Elle vaut "foo".

### - { points=2 }

```c
char *s = "Prix Béton 1981";
```

!!! solution { lines=1 }

    L'expression compile mais la chaîne est non modifiable.

### - { points=2 }

```c
char *s[] = {"foo", "bar", "baz"};
```

!!! solution { lines=1 }

    L'expression compile mais les chaînes sont non modifiables.

### - { points=2 }

```c
char s[] = {"foo" "bar" "baz"};
```

!!! solution { lines=1 }

     L'expression compile et la chaîne est modifiable. Elle vaut "foobarbaz".

## Manipulation des chaînes de caractères { points=10 }

Que retournent chacunes de ces fonctions ?

### - { points=2 }

```c
int foo() { char s[] = "foo"; return strlen(s); }
```

!!! solution { lines=1 }

    3

### - { points=2 }

```c
int foo() { char s[] = "foo"; return sizeof(s); }
```

!!! solution { lines=1 }

    4

### - { points=2 }

```c
int foo() { char s[] = "foo"; return s[3]; }
```

!!! solution { lines=1 }

    0 (caractère nul)

### - { points=2 }

```c
int foo() { char s[] = "foo"; return s[4]; }
```

!!! solution { lines=1 }

    Indéterminé, on accède à une zone mémoire qui n'est pas allouée pour la chaîne. Une erreur de segmentation peut survenir.

### - { points=2 }

```c
int foo() { char s[] = "foo\n\t\0bar"; return strlen(s); }
```

!!! solution { lines=1 }

    5 (caractère nul après le \t)

## - { points=4 }

En utilisant la bibliothèque *ctype.h*, écrire une fonction qui transforme une chaîne de caractères reçue en majuscules. Le prototype de la fonction est `void majuscule(char *s)`.

!!! solution { lines=7 }

    ```c
    void majuscule(char *s) {
      while (*s) {
        *s = toupper(*s);
        s++;
      }
    }
    ```

## - { points=4 }

Soit un texte d'entrée, indiquer la position à laquelle se trouve une sous-chaîne, si elle existe. Sinon retourne -1. Le prototype de la fonction est `int position(char s[], char sub[])`. Aidez-vous également de la bibliothèque *ctype.h*.

!!! solution { lines=7 }

    ```c
    int position(char s[], char sub[]) {
      if (strstr(s, sub) == NULL) {
        return -1;
      }
      return strstr(s, sub) - s;
    }
    ```

## - { points=4 }

Que fait cette fonction et que retourne-t-elle ?

```c
int mysterious()
{
    char v[] = "aeiouy";
    char s[] = "Hello, world!";
    size_t c = 0, k = 0;
    while (s[k] != '\0')
    {
        int n = 0;
        while (v[n] != '\0')
            c += s[k] == v[n++];
        k++;
    }
    return c;
}
```

!!! solution { lines=4 }

    La fonction compte le nombre de voyelles dans la chaîne `s`. Elle retourne la valeur 3.

## Problème Difficile { points=4 }

Il existe trois types de modifications qui peuvent être appliquées à une chaîne de caractère : insérer un caractère, supprimer un caractère, ou remplacer un caractère. Considérant deux chaînes de caractères, écrivez une fonction qui retourne si les deux chaînes ne sont qu'à une modification près.

- `pale, ple -> true`
- `pales, pale -> true`
- `pale, bale -> true`
- `pale, bake -> false`

!!! solution { lines=20 }

    ```c
    bool one_away(char s1[], char s2[])
    {
        int i = 0, j = 0, k = 0;
        while (s1[i] != '\0' && s2[j] != '\0')
        {
            if (s1[i] == s2[j])
            {
                i++;
                j++;
            }
            else if (s1[i] != s2[j])
            {
                if (s1[i + 1] == s2[j] || s1[i] == s2[j + 1])
                {
                    i++;
                    j++;
                }
                else
                {
                    return 0;
                }
            }
        }
        if (s1[i] == '\0' && s2[j] == '\0')
        {
            return 1;
        }
        else if (s1[i] == '\0')
        {
            while (s2[j] != '\0')
            {
                if (s2[j + 1] == s2[j])
                {
                    return 0;
                }
                j++;
            }
            return 1;
        }
        else if (s2[j] == '\0')
        {
            while (s1[i] != '\0')
            {
                if (s1[i + 1] == s1[i])
                {
                    return 0;
                }
                i++;
            }
            return 1;
        }
        return 0;
    }
    ```
