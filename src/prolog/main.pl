/*

    ######################################

    Arquivo que contém função main

    ######################################

*/

:- consult('robo.pl').

/* main

faz o setup e faz com que o robo percorra a sala, limpe as sujeiras e vá até o ponto final

+ <arg-1> : algoritmo de busca usado. Pode ser entre os seguintes (aEstrela, hillClimb, bestFirst e branchAndBound)
+ <arg-2> : vértice inicial do robô, ponto de partida para algortimo de busca
+ <arg-2> : vértice final, ponto de chegada para o robô
- <arg-3> : tempo que a função demorou para rodar, em milisegundos (ms)

*/

main(aEstrela, VerticeInicial, VerticeFinal, Time):-
	listaSujeirasOrdenadas(VerticeInicial, SujeirasOrdenadas),
	resetaRobo(VerticeInicial),
	statistics(walltime, [T0, _]),
	roboLimpaSala(SujeirasOrdenadas, VerticeFinal, aEstrela),
	statistics(walltime, [T2, _]),
	removeSujeiras(SujeirasOrdenadas),
	Time is T2 - T0.

main(hillClimb, VerticeInicial, VerticeFinal, Time):-
	listaSujeirasOrdenadas(VerticeInicial, SujeirasOrdenadas),
	resetaRobo(VerticeInicial),
	statistics(walltime, [T0, _]),
	roboLimpaSala(SujeirasOrdenadas, VerticeFinal, hillClimb),
	statistics(walltime, [T2, _]),
	removeSujeiras(SujeirasOrdenadas),
	Time is T2 - T0.

main(bestFirst, VerticeInicial, VerticeFinal, Time):-
	listaSujeirasOrdenadas(VerticeInicial, SujeirasOrdenadas),
	resetaRobo(VerticeInicial),
	statistics(walltime, [T0, _]),
	roboLimpaSala(SujeirasOrdenadas, VerticeFinal, bestFirst),
	statistics(walltime, [T2, _]),
	removeSujeiras(SujeirasOrdenadas),
	Time is T2 - T0.

main(branchAndBound, VerticeInicial, VerticeFinal, Time):-
	listaSujeirasOrdenadas(VerticeInicial, SujeirasOrdenadas),
	resetaRobo(VerticeInicial),
	statistics(walltime, [T0, _]),
	roboLimpaSala(SujeirasOrdenadas, VerticeFinal, branchAndBound),
	statistics(walltime, [T2, _]),
	removeSujeiras(SujeirasOrdenadas),
	Time is T2 - T0.
