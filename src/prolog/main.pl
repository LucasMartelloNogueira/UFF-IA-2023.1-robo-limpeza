/*

    ######################################

    Arquivo que contém função main

    ######################################

*/

:- consult('robo.pl').

main(aEstrela, VerticeInicial, VerticeFinal):-
	listaSujeirasOrdenadas(VerticeInicial, SujeirasOrdenadas),
	resetaRobo(VerticeInicial),
	roboLimpaSala(SujeirasOrdenadas, VerticeFinal, aEstrela).

main(hillClimb, VerticeInicial, VerticeFinal) :-
	listaSujeirasOrdenadas(VerticeInicial, SujeirasOrdenadas),
	resetaRobo(VerticeInicial),
	roboLimpaSala(SujeirasOrdenadas, VerticeFinal, hillClimb).

main(bestFirst, VerticeInicial, VerticeFinal) :-
	listaSujeirasOrdenadas(VerticeInicial, SujeirasOrdenadas),
	resetaRobo(VerticeInicial),
	roboLimpaSala(SujeirasOrdenadas, VerticeFinal, bestFirst).

main(branchAndBound, VerticeInicial, VerticeFinal) :-
	listaSujeirasOrdenadas(VerticeInicial, SujeirasOrdenadas),
	resetaRobo(VerticeInicial),
	roboLimpaSala(SujeirasOrdenadas, VerticeFinal, branchAndBound).
