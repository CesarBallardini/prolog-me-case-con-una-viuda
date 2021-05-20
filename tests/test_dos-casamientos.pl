/*
 * ejecutar tests con
swipl -v  -f none -g "load_files('tests/test_dos-casamientos.pl')" -t run_tests -- $*
swipl -s tests/test_dos-casamientos.pl -g run_tests,halt -t 'halt(1)'
 */

:- set_prolog_flag(verbose, silent).
:- consult('dos-casamientos.pl').
:- set_prolog_flag(verbose, verbose).


:- begin_tests(doscasamientos).


test(mi_mujer_es_suegra_de_su_suegro) :- mi_mujer_es_suegra_de_su_suegro.

test(mi_hijastra_es_mi_madre) :- mi_hijastra_es_mi_madre.

test(mi_padre_es_mi_yerno, blocked(no_anda)) :- mi_padre_es_mi_yerno.

test(el_hijo_de_mi_madrastra_es_mi_hermano) :- el_hijo_de_mi_madrastra_es_mi_hermano.

test(el_hijo_de_mi_madrastra_es_nieto_de_mi_mujer) :- el_hijo_de_mi_madrastra_es_nieto_de_mi_mujer.

test(yo_soy_abuelo_de_mi_hermano) :- yo_soy_abuelo_de_mi_hermano.

test(el_hijo_de_mi_mujer_es_hermano_de_mi_madre) :- el_hijo_de_mi_mujer_es_hermano_de_mi_madre.

test(el_hijo_de_mi_mujer_es_cuñado_de_mi_padre) :- el_hijo_de_mi_mujer_es_cuñado_de_mi_padre.

test(el_hijo_de_mi_mujer_es_tio_de_sus_hijos, blocked(no_hay_hijos_no_implementado)) :- el_hijo_de_mi_mujer_es_tio_de_sus_hijos.

test(mi_mujer_es_suegra_de_su_hija, blocked(no_anda)) :- mi_mujer_es_suegra_de_su_hija.

test(yo_soy_padre_de_mi_madre) :- yo_soy_padre_de_mi_madre.

test(mi_padre_es_mi_hijo) :- mi_padre_es_mi_hijo.

test(la_mujer_de_mi_padre_es_mi_hijo, blocked(no_anda)) :- la_mujer_de_mi_padre_es_mi_hijo.

test(yo_soy_mi_propio_abuelo) :- yo_soy_mi_propio_abuelo.


:- end_tests(doscasamientos).
