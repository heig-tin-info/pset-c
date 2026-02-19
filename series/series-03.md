---
title: Série 3
subtitle: Types et Formats
tags:
- data-types
- format-specifiers
- printf
- scanf
exam:
  course: INFO1-TIN
---

# Types et Formats

## - { points=4 }

Pour chacune des constantes littérales suivantes indiquez si elles sont correctes ou non.

| Constante littérale | Validité                                          |
| ------------------- | ------------------------------------------------- |
| `'a'`               | [Correct]{w=10cm}                                 |
| `'A'`               | [Correct]{w=10cm}                                 |
| `'ab'`              | [Incorrect, seulement 1 caractère]{w=10cm}        |
| `'\x41'`            | [Correct]{w=10cm}                                 |
| `'\041'`            | [Correct]{w=10cm}                                 |
| `'\0x41'`           | [Incorrect]{w=10cm}                               |
| `'\n'`              | [Correct]{w=10cm}                                 |
| `'\w'`              | [Incorrect]{w=10cm}                               |
| `'\t'`              | [Correct (tabulation)]{w=10cm}                    |
| `'\xp2'`            | [Incorrect, p2 n'est pas hexadécimal]{w=10cm}     |
| `"abc"`             | [Correct]{w=10cm}                                 |
| `"\abc\ndef"`       | [Correct]{w=10cm}                                 |
| `"'"`               | [Incorrect, la chaîne n'est pas terminée]{w=10cm} |

## - { points=4 }

Quel est le **type** résultant puis la **valeur** des expressions suivantes ?

```c
int n, p;  float x;
n = 10;    p = 7;     x = 2.5;
```

| Expression      | Type            | Valeur        |
| --------------- | --------------- | ------------- |
| `x + n % p`     | [float]{w=5cm}  | [5.5]{w=2cm}  |
| `x + p / n`     | [float]{w=5cm}  | [2.5]{w=2cm}  |
| `(x + p) / n`   | [float]{w=5cm}  | [0.95]{w=2cm} |
| `.5 * n`        | [double]{w=5cm} | [5.0]{w=2cm}  |
| `.5 * (float)n` | [double]{w=5cm} | [5.0]{w=2cm}  |
| `(int).5 * n`   | [int]{w=5cm}    | [0]{w=2cm}    |
| `(n + 1) / n`   | [int]{w=5cm}    | [1]{w=2cm}    |
| `(n + 1.0) / n` | [double]{w=5cm} | [1.1]{w=2cm}  |

# Entrées sorties

## - { points=2 }

Que voyez-vous sur la sortie standard ?

| Expression                          | Sortie standard               |
| ----------------------------------- | ----------------------------- |
| `printf("%d\n", 42);`               | [`"42\n"`]{width=5cm}         |
| `printf("u% 5d\n", 42);`            | [`"u   42\n"`]{width=5cm}     |
| `printf("%05d\n", 42);`             | [`"00042\n"`]{width=5cm}      |
| `printf("%-5d<", 42);`              | [`"42   <"`]{width=5cm}       |
| `printf("%-05d\n", 42);`            | [`"42   \n"`]{width=5cm}      |
| `printf("%0*d\n", 10, 42);`         | [`"0000000042\n"`]{width=5cm} |
| `printf("%.1f\n", 3.1415);`         | [`"3.1\n"`]{width=5cm}        |
| `printf("%05.1f\n", 3.1415);`       | [`"003.1\n"`]{width=5cm}      |
| `printf("%d%d%d\n", 42, 23, 42);`   | [`"422342\n"`]{width=5cm}     |
| `printf("%d %d %d\n", 42, 23, 42);` | [`"42 23 42\n"`]{width=5cm}   |
| `printf(">%c.<", 'a' + 1);`         | [`">b.<"`]{width=5cm}         |

## - { points=4 }

Quels sont les valeurs des variables modifiées ? Indiquer pour chaque expression les variables affectées uniquement. Ne pas remplir les variables qui n'ont pas été modifiées.

```c
int i = 0;
int j = 0;
int r = 0;
char c = '\0';
```

| Expression                                   | i             | j             | r   | c            |
| -------------------------------------------- | ------------- | ------------- | --- | ------------ |
| `r = sscanf("42", "%d", &i);`                | [42]{w=1cm}   | [?]{w=1cm}    | [1]{w=1cm} | [?]{w=1cm}   |
| `r = sscanf("4 8", "%d", &i);`               | [4]{w=1cm}    | [?]{w=1cm}    | [1]{w=1cm} | [?]{w=1cm}   |
| `r = sscanf("4 8", "%d %d", &i, &j);`        | [4]{w=1cm}    | [8]{w=1cm}    | [2]{w=1cm} | [?]{w=1cm}   |
| `r = sscanf("4 8", "%d%d", &i, &j);`         | [4]{w=1cm}    | [8]{w=1cm}    | [2]{w=1cm} | [?]{w=1cm}   |
| `r = sscanf("15x16", "%d%c%d", &i, &c, &j);` | [15]{w=1cm}   | [16]{w=1cm}   | [3]{w=1cm} | ['x']{w=1cm} |
| `r = sscanf("1568", "%1d%2d", &i, &j);`      | [1]{w=1cm}    | [56]{w=1cm}   | [2]{w=1cm} | [?]{w=1cm}   |
| `r = sscanf("1568", "%c%c", &i, &j);`        | [0x30]{w=1cm} | [0x35]{w=1cm} | [2]{w=1cm} | [?]{w=1cm}   |
| `r = sscanf("1568", "%*c%c", &i);`           | [0x35]{w=1cm} | [?]{w=1cm}    | [1]{w=1cm} | [?]{w=1cm}    |
