/*

    ######################################

    Arquivo que contém função main

    ######################################

*/

:- consult('robo.pl').
:- consult('algoritmosBusca.pl').

main():-
	listaSujeiras(ListaSujeiras),
	objetivo(VerticeFinal),
	roboLimpaSala(ListaSujeiras, VerticeFinal, aEstrela).
