/*
 * dos casamientos
 *
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

Los personajes: 

  * yo
  * mi_mujer (la viuda)

  * hija_de_mi_mujer
  * mi_padre
  * mi_madre (fallecida)

  * hijo_de_hija_de_mi_mujer
  * hijo_de_mi_mujer

*/

% Student exercise profile
:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space

persona(mi_madre).
persona(mi_padre).
persona(yo).

persona(mi_mujer).
persona(hija_de_mi_mujer).

persona(hijo_de_hija_de_mi_mujer).
persona(hijo_de_mi_mujer).

% no se usan, estan por completitud: vive/1, no_vive/1
no_vive(mi_madre).
vive(X) :- persona(X), \+ no_vive(X).

hombre(mi_padre).
hombre(yo).
hombre(hijo_de_hija_de_mi_mujer).
hombre(hijo_de_mi_mujer).

mujer(mi_madre).
mujer(mi_mujer).
mujer(hija_de_mi_mujer).

madrastra_de(Mujer, Persona) :-
    mujer(Mujer), persona(Mujer),
    casado(Esposo, Mujer), persona(Esposo),
    hijo_de(Persona, Esposo).

padrastro_de(Hombre, Persona) :-
    hombre(Hombre), persona(Hombre),
    casado(Hombre, Esposa), persona(Esposa),
    hijo_de(Persona, Esposa).

padre_de(mi_padre,yo).


padre_general_de(Hombre, Persona) :-
    (
      padre_de(Hombre, Persona)%, !
       ;
      padrastro_de(Hombre, Persona)
    ).

madre_de(mi_madre,yo).
madre_de(mi_mujer,hija_de_mi_mujer).
madre_de(hija_de_mi_mujer, hijo_de_hija_de_mi_mujer).
madre_de(mi_mujer,hijo_de_mi_mujer).



madre_general_de(Mujer, Persona) :-
    (
      madre_de(Mujer, Persona)%, !
        ;
      madrastra_de(Mujer, Persona)
    ).


hijo_de(Hijo, Progenitor) :-
    persona(Hijo), persona(Progenitor),
  ( padre_de(Progenitor, Hijo)%, !
          ;
    madre_de(Progenitor, Hijo)
  ).


/* casado(Esposo, Esposa) */
casado(mi_padre, mi_madre).
casado(yo, mi_mujer).
casado(mi_padre, hija_de_mi_mujer).

suegra_de(Suegra, Persona) :-
  mujer(Suegra),
    persona(Suegra),
    persona(Esposo),
    persona(Persona),
  (
    casado(Esposo, Persona),
    madre_general_de(Suegra, Esposo), !
         ;
    casado(Persona, Esposa),
    madre_general_de(Suegra, Esposa)
  ).

suegro_de(Suegro, Persona) :-
  hombre(Suegro),
    persona(Suegro),
    persona(Esposo),
    persona(Persona),
  (
    casado(Esposo, Persona),
    padre_general_de(Suegro, Esposo), !
         ;
    casado(Persona, Esposa),
    padre_general_de(Suegro, Esposa)
  ).

hijastra_de(Hijastra, Padrastro) :-
    mujer(Hijastra),
    hombre(Padrastro),
    hijo_de(Hijastra, Madre),
    casado(Padrastro, Madre).


yerno_de(Hombre, Persona) :-
    hombre(Hombre),
    persona(Hombre),
    persona(Persona),
    ( suegra_de(Persona, Hombre)
           ;
      suegro_de(Persona, Hombre)
    ).

hermano_de(Persona1, Persona2) :-
    (
    madre_general_de(M, Persona1),
    madre_general_de(M, Persona2)
       ;
    padre_general_de(M, Persona1),
    padre_general_de(M, Persona2)
    ).

nieto_de(Nieto, Persona) :-
    persona(Nieto), persona(Persona),
    (
      madre_general_de(Madre, Nieto),
      madre_general_de(Persona, Madre)
          ;
      madre_general_de(Madre, Nieto),
      padre_general_de(Persona, Madre)
          ;
      padre_general_de(Padre, Nieto),
      padre_general_de(Persona, Padre)
          ;
      padre_general_de(Padre, Nieto),
      madre_general_de(Persona, Padre)
    ).

cuñado_de(Cuñado, Persona) :-
    hombre(Cuñado),
    (
      casado(Cuñado, Esposa),
      hermano_de(Esposa, Persona)
        ;
      hermano_de(Cuñado, Hermana),
      mujer(Hermana),
      casado(Persona, Hermana)
     ).

/* Conclusiones */

mi_mujer_es_suegra_de_su_suegro :-
  casado(yo, MiMujer),
  suegra_de(MiMujer, X),
  suegro_de(X, MiMujer), !.

mi_hijastra_es_mi_madre :-
    hijastra_de(Hijastra, yo),
    madre_general_de(Hijastra, yo), !.

/* no anda */
mi_padre_es_mi_yerno :-
    padre_de(Padre, yo),
    yerno_de(yo, Padre).

el_hijo_de_mi_madrastra_es_mi_hermano :-
    madrastra_de(Madrastra, yo),
    hijo_de(Hijo, Madrastra), hombre(Hijo), 
    hermano_de(Hijo, yo), !.

el_hijo_de_mi_madrastra_es_nieto_de_mi_mujer :-
    madrastra_de(Madrastra, yo),
    hijo_de(Hijo, Madrastra), hombre(Hijo),
    nieto_de(Hijo, mi_mujer), !.

yo_soy_abuelo_de_mi_hermano :-
    persona(Persona), Persona \= yo,
    nieto_de(Persona, yo),
    hermano_de(Persona, yo), !.

el_hijo_de_mi_mujer_es_hermano_de_mi_madre :-
    hijo_de(Hijo, mi_mujer), hombre(Hijo),
    madre_general_de(Madre, yo),
    hermano_de(Hijo, Madre), !.

el_hijo_de_mi_mujer_es_cuñado_de_mi_padre :-
    hijo_de(Hijo, mi_mujer), hombre(Hijo),
    padre_de(Padre, yo),
    cuñado_de(Hijo, Padre), !.

/* el_hijo_de_mi_mujer_es_tio_de_sus_hijos */

/* no anda */
mi_mujer_es_suegra_de_su_hija :-
    suegra_de(mi_mujer, X),
    mujer(X),
    hijo_de(X, mi_mujer).


yo_soy_padre_de_mi_madre :-
    mujer(X),
    padre_general_de(yo, X),
    madre_general_de(X, yo).


mi_padre_es_mi_hijo :-
	padre_de(Padre, yo),
    hijo_de(yo, Padre).

la_mujer_de_mi_padre_es_mi_hijo :-
    padre_de(Padre, yo),
    casado(Padre, Mujer),
    mujer(Mujer),
    hijo_de(yo, Mujer).

yo_soy_mi_propio_abuelo :-
    nieto_de(yo, yo), !.

