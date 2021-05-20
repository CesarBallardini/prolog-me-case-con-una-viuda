# README - Dos casamientos

Una humorada que me pasaron en [vídeo](https://user-images.githubusercontent.com/642255/119041128-9e759c80-b98c-11eb-9695-c7b1bf5e7605.mp4), relata una historia, que puede pasarse a PROLOG.


# El relato


Tuve la desgracia de casarme con una viuda.

Ella tenía una hija. De haberlo sabido nunca me hubiera casado.

Mi padre para mayor desgracia era viudo, se enamoró y se casó con la hija de mi mujer.

De manera que mi mujer era suegra de su suegro.

Mi hijastra se convirtió en mi madre, y mi padre al mismo tiempo era mi yerno.

Al poco tiempo mi madrastra trajo al mundo un varón, que era mi hermano, pero era nieto de mi mujer.

De manera que yo era abuelo de mi hermano.

Con el correr del tiempo, mi mujer trajo al mundo un varón, y como era hermano de mi madre, 
era el cuñado de mi padre y tío de sus hijos.

Mi mujer era suegra de su hija.

Yo en cambio soy padre de mi madre, y mi padre y su mujer son mis hijos.

Además yo soy mi propio abuelo.


# Requisitos previos

* SWI Prolog
* Git

# Cómo usar este repositorio

Obtenemos el código

```bash
git clone https://github.com/CesarBallardini/dos-casamientos
cd dos-casamientos/
```

Corremos los tests:

```bash
swipl -s tests/test_dos-casamientos.pl -g run_tests,halt -t 'halt(1)'
```

Lo cual nos va a mostrar algo como:

```text

% PL-Unit: doscasamientos .......... done
% All 10 tests passed

```

Al hacer commit en este repositorio, Travis se ocupa de correr los tests para saber que está funcionando y que no.



