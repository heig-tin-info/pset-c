---
title: Série 0x00
subtitle: Généralités et Numération
tags:
  - basics
  - numeration
  - binary
  - information-units
exam:
  course: INFO1-TIN
---
# Quelques généralités { points=16 }

## - { points=2 }

Quels sont les noms des deux inventeurs du langage C ?

!!! solution { lines=1 }

    Brian Kernighan et Dennis Ritchie.

## - { points=2 }

Citez au moins deux paradigmes de programmation que le C supporte ?

!!! solution { lines=1 }

    Impératif, structuré et procédural.

## - { points=2 }

La [compilation] est le nom de l'étape permettant de transformer du code source en un programme exécutable.

## - { points=2 }

L'unité de mesure de la quantité d'information est le [bit] qui est par définition la quantité minimale d'information transmise par un message.

## - { points=2 }

L'octet aujourd'hui équivalent à un [byte] offre une taille suffisante pour encoder un caractère ASCII étendu.

## - { points=2 }

Soit deux mains humaines dont chaque doigt peut être levé ou baissé, quel est le nombre de configurations qui peuvent être exprimées ?

!!! solution { lines=1 }

    1024.

## - { points=2 }

Parmi les choix suivants, sur quel site internet peut-on poser des questions liées à la programmation en C ?

- [ ] http://heig-vd.ch
- [ ] http://kernighan.us
- [x] http://stackoverflow.com/
- [ ] https://learnxinyminutes.com/
- [ ] https://puzzling.stackexchange.com/
- [ ] https://www.reddit.com/r/programming/

## - { points=2 }

En quelle année a été inventé le langage C ?

- [ ] 1941
- [ ] 1969
- [x] 1972
- [ ] 1997
- [ ] 2004

---

# Conversions { points=4 }

Complétez la table suivante avec les valeurs qui conviennent. Utilisez la convention d'écriture C, soit le préfixe `0` pour l'octal, le `0b` pour le binaire et le `0x` pour l'hexadécimal.

| Binaire             | Octal            | Décimal | Hexadécimal      |
| ------------------- | ---------------- | ------- | ---------------- |
| [0b0000]{width=2cm} | [000]{width=2cm} | 0       | [0x0]{width=2cm} |
| [0b0001]{width=2cm} | [001]{width=2cm} | 1       | [0x1]{width=2cm} |
| [0b0010]{width=2cm} | [002]{width=2cm} | 2       | [0x2]{width=2cm} |
| [0b0011]{width=2cm} | [003]{width=2cm} | 3       | [0x3]{width=2cm} |
| [0b0100]{width=2cm} | [004]{width=2cm} | 4       | [0x4]{width=2cm} |
| [0b0101]{width=2cm} | [005]{width=2cm} | 5       | [0x5]{width=2cm} |
| [0b0110]{width=2cm} | [006]{width=2cm} | 6       | [0x6]{width=2cm} |
| [0b0111]{width=2cm} | [007]{width=2cm} | 7       | [0x7]{width=2cm} |
| [0b1000]{width=2cm} | [010]{width=2cm} | 8       | [0x8]{width=2cm} |
| [0b1001]{width=2cm} | [011]{width=2cm} | 9       | [0x9]{width=2cm} |
| [0b1010]{width=2cm} | [012]{width=2cm} | 10      | [0xA]{width=2cm} |
| [0b1011]{width=2cm} | [013]{width=2cm} | 11      | [0xB]{width=2cm} |
| [0b1100]{width=2cm} | [014]{width=2cm} | 12      | [0xC]{width=2cm} |
| [0b1101]{width=2cm} | [015]{width=2cm} | 13      | [0xD]{width=2cm} |
| [0b1110]{width=2cm} | [016]{width=2cm} | 14      | [0xE]{width=2cm} |
| [0b1111]{width=2cm} | [017]{width=2cm} | 15      | [0xF]{width=2cm} |

# Complément { points=6 }

Afin de préserver la méthode d'addition et de soustraction standard avec retenue, la technique du complément à $(b - 1) + 1$ est utilisée. Ainsi en binaire la base étant $2$, on nomme la technique le « Complément à 2 » qu'il faut lire « Complément à (2 - 1), plus 1 ». Dans les valeurs ci-dessous la base est exprimée en indice p. ex. $253_{64}$ exprimé en base 64.

## - { points=2 }

Quel est le complément à 1 du nombre 8-bit $10011011_2$ ?

!!! solution { lines=1 }

    $01100100_2$

## - { points=2 }

Quel est le complément à 5 du nombre 8-bit $124530_6$ ?

!!! solution { lines=1 }

    $431025_6$

## - { points=2 }

Quelle est la représentation binaire signée 8-bit du nombre $13_{10}$ ?

!!! solution { lines=1 }

    $00001101_2$

---

# Conversion de bases { points=4 }

Complétez le tableau ci-dessous qui comporte dans chaque ligne une valeur 8-bits à exprimer en utilisant les autres systèmes de numération vus en cours. **Note : ne pas utiliser la calculatrice**.

| Binaire                 | Octal             | Décimal non signé | Décimal signé    | Hexadécimal       |
| ----------------------- | ----------------- | ----------------- | ---------------- | ----------------- |
| [0b00000001]{width=2cm} | [0001]{width=2cm} | 1                 | [1]{width=2cm}   | [0x1]{width=2cm}  |
| [0b11111111]{width=2cm} | [0377]{width=2cm} | [255]{width=2cm}  | -1               | [0xFF]{width=2cm} |
| 0b11111001              | [0371]{width=2cm} | [249]{width=2cm}  | [-7]{width=2cm}  | [0xF9]{width=2cm} |
| [0b10101011]{width=2cm} | [0253]{width=2cm} | [171]{width=2cm}  | [-85]{width=2cm} | 0xAB              |
| [0b00001100]{width=2cm} | 014               | [12]{width=2cm}   | [12]{width=2cm}  | [0xC]{width=2cm}  |
