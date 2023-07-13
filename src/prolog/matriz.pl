/*
    ######################################

    Arquivo que funcoes necessárias para usar o tabuleiro

    ######################################

*/


:- consult('tabuleiro.pl').


% da pra melhorar essa funcao com memoization, criando relações que já foram calculadas
vertice(Id, X, Y):-
	matriz(M),
	nth0(X, M, Linha),
	nth0(Y, Linha, Id).



% da pra melhorar essa funcao, tentar percorrer matriz uma vez só
sGB(1, V1, V2):-
    vertice(V1, X1, Y1),
    vertice(V2, X2, Y2),
    V1 \== V2,
    (
        (abs(X1 - X2) =:= 0, abs(Y1 - Y2) =:= 1);
        (abs(X1 - X2) =:= 1, abs(Y1 - Y2) =:= 0)
    ).


listaSujeiras(L):-
    findall(X, sujeira(X), L).


listaSujeirasOrdenadas(VerticeInicial, SujeirasOrdenadas) :-    
    findall(Distancia-Sujeira, (sujeira(Sujeira), distancia_manhattan(VerticeInicial, Sujeira, Distancia)), DistanciasSujeiras),
    keysort(DistanciasSujeiras, Sorted),
    pairs_values(Sorted,  SujeirasOrdenadas).