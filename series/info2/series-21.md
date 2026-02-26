---
title: Série 0x21
subtitle: Premiers pas avec les fichiers
tags:
- file-io
- streams
- fopen
- text-processing
exam:
  course: INFO2-TIN
---
# Généralités

## - { points=1 }

Qu’est-ce qu’un **flux (stream)** en programmation C (et plus généralement en informatique) ?

- [ ] Un flux est une variable spéciale qui permet de stocker plusieurs valeurs dans la mémoire de l’ordinateur.
- [x] Un flux est un mécanisme permettant de lire ou d’écrire des données de manière séquentielle entre un programme et une source ou une destination (fichier, clavier, écran, réseau, etc.).
- [ ] Un flux est un type de boucle utilisé pour répéter des instructions jusqu’à la fin d’un fichier.
- [ ] Un flux est un composant matériel qui transporte physiquement les données dans l’ordinateur.
- [ ] Un flux est une suite de données qui doit obligatoirement être entièrement chargée en mémoire avant de pouvoir être utilisée.
- [ ] Un flux est une fonction du langage C utilisée uniquement pour afficher du texte à l’écran.

## - { points=1 }

Tout programme exécuté ouvre trois flux; quels sont leur noms et leur direction (entrée/sortie), selon la convention de numérotation des flux ?

1. [stdin, entrée]{w=4cm}
2. [stdout, sortie]{w=4cm}
3. [stderr, sortie]{w=4cm}

## - { points=1 }

Quelle est la fonction de la bibliothèque standard utilisée pour positionner manuellement le **curseur** dans un fichier ?

- [ ] `fopen`
- [ ] `fgets`
- [x] `fseek`
- [ ] `fputc`
- [ ] `feof`

## - { points=1 }

Quel est le mode à transmettre à l'appel `fopen("f.txt", mode)` pour ouvrir un fichier existant en mode **binaire** en **lecture écriture** ?

- [ ] `"r"`
- [ ] `"w"`
- [x] `"rb+"`
- [ ] `"aw"`
- [ ] `"w+"`

## - { points=1 }

Le caractère `\0` peut-il théoriquement apparaître dans quel type de fichier ?

- [ ] Texte
- [x] Binaire

# Lecture de code

Que fait le programme suivant ?

```c
#include <stdio.h>

char map[256] = {0};

int main() {
    FILE *fp = fopen("foo.txt", "r");
    char c;
    map['a'] = 1; map['e'] = 1;
    while ((c = fgetc(fp)) != EOF)
        putchar(map[c % 256] ? '*' : c);
    fclose(fp);
}
```

!!! solution { lines=4 }

    Le programme lit le fichier "foo.txt" caractère par caractère, et affiche chaque caractère à l'écran. Si le caractère est 'a' ou 'e', il affiche '*' à la place.

# Programmation

## - { points=5 }

Réalisez un programme en C qui prend en paramètre le nom d'un fichier texte et affiche sa taille en byte sur la sortie standard. Voici un exemple de fonctionnement du programme :

```bash
echo "Hello, World!" > test.txt
./file_size test.txt
13
```

!!! solution { lines=10 }

    ```c
    #include <stdio.h>
    #include <stdlib.h>

    int main(int argc, char *argv[]) {
        if (argc != 2) {
            fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
            return EXIT_FAILURE;
        }
        FILE *fp = fopen(argv[1], "r");
        if (fp == NULL) {
            perror("Error opening file");
            return EXIT_FAILURE;
        }
        fseek(fp, 0, SEEK_END);
        long size = ftell(fp);
        fclose(fp);
        printf("%ld\n", size);
        return EXIT_SUCCESS;
    }
    ```

## - { points=5 }

Vous disposez d'un pointeur sur un fichier ouvert en lecture `fp` et vous souhaitez connaître la taille de ce fichier. Écrire une fonction `size_t fsize(FILE *fp)` qui retourne la taille du fichier

!!! solution { lines=fill }

    ```c
    size_t fsize(FILE *fp) {
        if (fp == NULL) return 0;
        size_t size = 0;
        fseek(fp, 0, SEEK_END);
        size = ftell(fp);
        fseek(fp, 0, SEEK_SET);
        return size;
    }
    ```

## - { points=5 }

Écrire un programme qui prend le nom d'un fichier texte en argument ainsi qu'un texte à rechercher. Votre programme doit afficher le numéro de toute ligne du fichier contenant le texte recherché.

!!! solution { lines=15 }

    ```c
    int main(int argc, char *argv[]) {
        assert(argc == 3);
        char *filename = argv[1];
        char *search = argv[2];
        FILE *fp = fopen(filename, "r");
        assert(fp != NULL);
        char line[1024];
        size_t line_no = 0;
        while (fgets(line, sizeof(line), fp) != NULL) {
            line_no++;
            if (strstr(line, search) != NULL) {
                printf("%d\n", line_no);
            }
        }
    }
    ```
