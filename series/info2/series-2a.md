---
title: Série 0x21
subtitle: Fichiers
tags:
- file-io
- streams
- fopen
- text-processing
exam:
  course: INFO2-TIN
---

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
