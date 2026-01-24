# Série 16 — Révision, fonctions et programmes

## Choix multiples

### -

Cocher les propositions vraies concernant `strncmp` ?

- [x] La fonction compare deux chaînes de caractères jusqu'à un certain nombre de caractères.
- [ ] La fonction compare deux chaînes de caractères jusqu'à la fin.
- [ ] La fonction retourne 1 si les chaînes sont égales.
- [x] La fonction peut s'appeler avec `strncmp("abc", "ab", 2)`.

### -

Quel est le rôle de l'opérateur `^` ?

- [ ] Puissance comme dans `10^3`.
- [x] Ou exclusif.
- [ ] Ou inclusif.
- [ ] Et logique.
- [ ] Modulo.
- [ ] Inversion bit à bit.

### -

Quelles sont les déclarations de tableaux valides ?

- [ ] `int a[] = 0;`
- [x] `int a[10];`
- [x] `int a[10] = {1, 2, 3, 4, 5};`
- [x] `int a[] = {1, 2, 3, 4, 5};`
- [ ] `int a[10] = 0;`
- [ ] `int a[3]; a = {1,2,3};`

### -

Cocher ce qui est vrai concernant `int *p` et `int p[10]` ?

- [x] `int *p` est un pointeur vers un entier, `int p[10]` est un tableau de 10 entiers.
- [x] La taille de `int *p` est la taille d'une adresse, la taille de `int p[10]` est la taille de 10 entiers soit 40 octets.
- [ ] `int *p` est un tableau de 10 entiers, `int p[10]` est un pointeur vers un entier.
- [x] Les deux peuvent être passés à une fonction pour être modifiés.
- [x] L'accès à l'élément 2 s'écrit dans les deux cas `p[2]`.

## Fonctions

### -

Écrire une fonction `vowel` qui prend en paramètre une chaîne de caractère et qui retourne le nombre de voyelles dans la chaîne.

!!! solution

    ```c
    int vowel(char *str) {
        int count = 0;
        while (*str != '\0') {
            char c = tolower(*str);
            if (c == 'a' || c == 'e' || c == 'i' ||
                c == 'o' || c == 'u' || c == 'y')
                count++;
            str++;
        }
        return count;
    }
    ```

### -

Écrire une fonction `max_interval` qui calcule l'intervalle le plus grand dans un tableau d'entiers passé en paramètre. Le second paramètre est la taille du tableau.

!!! solution

    ```c
    int max_interval(int *a, size_t size) {
        int max = 0;
        for (size_t i = 0; i < size; i++) {
            for (size_t j = i + 1; j < size; j++) {
                int interval = a[j] - a[i];
                if (interval > max)
                    max = interval;
            }
        }
        return max;
    }
    ```

### -

Écrire une fonction `is_palindrome` qui retourne vrai si une chaîne de caractères est un palindrome, faux sinon. La chaîne est passée en paramètre.

!!! solution

    ```c
    bool is_palindrome(char *str) {
        size_t size = strlen(str);
        for (size_t i = 0; i < size / 2; i++) {
            if (str[i] != str[size - i - 1])
                return false;
        }
        return true;
    }
    ```

### -

Écrire une fonction qui prend en paramètre deux tableaux d'entiers et qui s'assure que l'un est bien dans l'ordre inverse que l'autre. La fonction prend en paramètre les deux tableaux et leur taille qui est commune.

!!! solution

    ```c
    bool is_reverse(int *a, int *b, size_t size) {
        for (size_t i = 0; i < size; i++) {
            if (a[i] != b[size - i - 1])
                return false;
        }
        return true;
    }
    ```

### -

Écrire un une fonction qui rempli un tableau à deux dimensions de taille 10x10 avec des valeurs aléatoires entre 0 et 100. La fonction prend en paramètre le tableau, le nombre de lignes et le nombre de colonnes.

!!! solution

    ```c
    void fill_random(int a[10][10]) {
        for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 10; j++)
                a[i][j] = rand() % 101;
        }
    }
    ```

## -

Écrire un programme complet qui lit sur les arguments `--min=X` et `--max=Y` où X et Y sont des entiers positifs. Le programme appelle une fonction `compute(x, y)` avec les valeurs capturées sur les arguments. Cette fonction retourne vraie si elle s'est exécutée correctement, sinon faux.

!!! solution

    ```c
    #include <stdio.h>
    #include <stdlib.h>
    #include <stdbool.h>

    extern bool compute(int x, int y);

    int main(int argc, char* argv[]) {
        int x, y;
        for (int arg = 1; arg < argc; arg++) {
            if (strncmp(argv[arg], "--min=", 6) == 0) {
                x = atoi(argv[arg + 1]);
                continue;
            }
            if (strncmp(argv[arg], "--max=", 6) == 0) {
                y = atoi(argv[arg + 1]);
                continue;
            }
            printf("Usage: %s --min=X --max=Y\n", argv[0]);
            return 1;
        }
        return compute(x, y);
    }
    ```
