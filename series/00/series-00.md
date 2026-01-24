# Série 0 — Introduction

## Quelques généralités

### -

Quels sont les noms des deux inventeurs du langage C ?

!!! solution { lines=1 }

    Brian Kernighan et Dennis Ritchie.

### -

Citez au moins deux paradigmes de programmation que le C supporte ?

!!! solution { lines=1 }

    Impératif, structuré et procédural.

### -

La [compilation] est le nom de l'étape permettant de transformer du code source en un programme exécutable.

### -

L'unité de mesure de la quantité d'information est le [bit] qui est par définition la quantité minimale d'information transmise par un message.

### -

L'octet aujourd'hui équivalent à un [byte] offre une taille suffisante pour encoder un caractère ASCII étendu.

### -

Soit deux mains humaines dont chaque doigt peut être levé ou baissé, quel est le nombre de configurations qui peuvent être exprimées ?

!!! solution { lines=1 }

    1024.

### -

Parmi les choix suivants, sur quel site internet peut-on poser des questions liées à la programmation en C ?

- [ ] http://heig-vd.ch
- [ ] http://kernighan.us
- [x] http://stackoverflow.com/
- [ ] https://learnxinyminutes.com//
- [ ] https://puzzling.stackexchange.com/

### -

En quelle année a été inventé le langage C ?

- [ ] 1941
- [ ] 1969
- [x] 1972
- [ ] 1997
- [ ] 2004

## -

Complétez la table suivante avec les valeurs qui conviennent. Utilisez la convention d'écriture C, soit le préfixe `0` pour l'octal, le `0b` pour le binaire et le `0x` pour l'hexadécimal.

| Binaire | Octal | Décimal | Hexadécimal |
| --- | --- | --- | --- |
| [0b0000] | [000] | [0] | [0x0] |
| [0b0001] | [001] | [1] | [0x1] |
| [0b0010] | [002] | [2] | [0x2] |
| [0b0011] | [003] | [3] | [0x3] |
| [0b0100] | [004] | [4] | [0x4] |
| [0b0101] | [005] | [5] | [0x5] |
| [0b0110] | [006] | [6] | [0x6] |
| [0b0111] | [007] | [7] | [0x7] |
| [0b1000] | [010] | [8] | [0x8] |
| [0b1001] | [011] | [9] | [0x9] |
| [0b1010] | [012] | [10] | [0xA] |
| [0b1011] | [013] | [11] | [0xB] |
| [0b1100] | [014] | [12] | [0xC] |
| [0b1101] | [015] | [13] | [0xD] |
| [0b1110] | [016] | [14] | [0xE] |
| [0b1111] | [017] | [15] | [0xF] |

## -

Afin de préserver la méthode d'addition et de soustraction standard avec retenue, la technique du complément à $(b - 1) + 1$ est utilisée. Ainsi en binaire la base étant $2$, on nomme la technique le « Complément à 2 » qu'il faut lire « Complément à (2 - 1), plus 1 ». Dans les valeurs ci-dessous la base est exprimée en indice p. ex. $253_{64}$ exprimé en base 64.

### -

Quel est le complément à 1 du nombre 8-bit $10011011_2$ ?

!!! solution { lines=1 }

    $01100100_2$

### -

Quel est le complément à 5 du nombre 8-bit $124530_6$ ?

!!! solution { lines=1 }

    $431025_6$

### -

Quelle est la représentation binaire signée 8-bit du nombre $13_{10}$ ?

!!! solution { lines=1 }

    $00001101_2$

## -

Complétez le tableau ci-dessous qui comporte dans chaque ligne une valeur 8-bits à exprimer en utilisant les autres systèmes de numération vus en cours. **Note : ne pas utiliser la calculatrice**.

| Binaire | Octal | Décimal non signé | Décimal signé | Hexadécimal |
| --- | --- | --- | --- | --- |
| [0b00000001] | [0001] | [1] | [1] | [0x1] |
| [0b11111111] | [0377] | [255] | -1 | [0xFF] |
| [0b11111001] | [0371] | [249] | [-7] | [0xF9] |
| [0b10101011] | [0253] | [171] | [-85] | [0xAB] |
| [0b00001100] | [014] | [12] | [12] | [0xC] |
