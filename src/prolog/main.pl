/*

    ######################################

    Arquivo que contém função main

    ######################################

*/

:- consult('robo.pl').

main(aEstrela):-
	listaSujeiras(ListaSujeiras),
	objetivo(VerticeFinal),
	roboLimpaSala(ListaSujeiras, VerticeFinal, aEstrela).

main(hillClimb) :-
	listaSujeiras(ListaSujeiras),
	objetivo(VerticeFinal),
	roboLimpaSala(ListaSujeiras, VerticeFinal, hillClimb).

main(bestFirst) :-
	listaSujeiras(ListaSujeiras),
	objetivo(VerticeFinal),
	roboLimpaSala(ListaSujeiras, VerticeFinal, bestFirst).

main(branchAndBound) :-
	listaSujeiras(ListaSujeiras),
	objetivo(VerticeFinal),
	roboLimpaSala(ListaSujeiras, VerticeFinal, branchAndBound).
