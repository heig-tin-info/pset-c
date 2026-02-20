---
title: Série 21
subtitle: Les fichiers
tags:
- file-io
- streams
- fopen
- text-processing
exam:
  course: INFO2-TIN
---
# Généralités

## - { points=3 }

Tout programme exécuté ouvre trois flux (fichiers) quels sont leur noms et leur direction (entrée/sortie), selon la convention de numérotation des flux ?

1. [stdin, entrée]{w=4cm}
2. [stdout, sortie]{w=4cm}
3. [stderr, sortie]{w=4cm}

## - { points=1 }

Quelle est la fonction utilisée pour positionner manuellement le curseur dans un fichier ?

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

# Programmation

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

## - { points=5 }

Écrire un programme qui retourne la taille de la ligne la plus longue dans un fichier texte. Le programme prend soit un nom de fichier passé en arguments, soit utilise l'entrée standard.

!!! solution { lines=15 }

    ```c
    int main(int argc, char *argv[]) {
        char *filename = argc > 1 ? argv[1] : stdin;
        FILE *fp = fopen(filename, "r");
        assert(fp != NULL);
        size_t max_len = 0;
        size_t count = 0;
        char c;
        while(c = fgetc(fp)) {
            if (c == '\n' || c == EOF) {
                if (count > max_len) {
                    max_len = count;
                }
                count = 0;
                continue;
            }
            count++;
        }
    }
    ```
