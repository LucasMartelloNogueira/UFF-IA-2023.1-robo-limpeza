/*
    ######################################

    Arquivo que contém a matriz e relações necessárias

    ######################################

*/



% definindo matriz 3x3 (de "a" até "i")

/* desenho matriz

    | a  b  c |
    | d  e  f |
    | g  h  i |

*/


% testando representação matricial


matriz(
	[[a, b, c],
	 [d, e, f],
	 [g, h, i]
	]
).



% da pra melhorar essa funcao com memoization, criando relações que já foram calculadas
vertice(Id, X, Y):-
	matriz(M),
	nth0(X, M, Linha),
	nth0(Y, Linha, Id).

	
/* substituido pela maneira de cima, vertices agora são pegos da matriz
% vertice(id, x, y)

vertice(a, 0, 0).
vertice(b, 1, 0).
vertice(c, 2, 0).
vertice(d, 0, 1).
vertice(e, 1, 1).
vertice(f, 2, 1).
vertice(g, 0, 2).
vertice(h, 1, 2).
vertice(i, 2, 2).
*/



% da pra melhorar essa funcao, tentar percorrer matriz uma vez só
sGB(1, V1, V2):-
    vertice(V1, X1, Y1),
    vertice(V2, X2, Y2),
    V1 \== V2,
    (
        (abs(X1 - X2) =:= 0, abs(Y1 - Y2) =:= 1);
        (abs(X1 - X2) =:= 1, abs(Y1 - Y2) =:= 0)
    ).


/*
sGB(1, a, b).
sGB(1, a, d).
sGB(1, b, c).
sGB(1, b, e).
sGB(1, c, f).
sGB(1, d, e).
sGB(1, d, g).
sGB(1, e, f).
sGB(1, e, h).
sGB(1, f, i).
sGB(1, g, h).
sGB(1, h, i).
*/


obstaculo(b).

sujeira(e).
sujeira(c).
sujeira(d).

listaSujeiras(L):-
    findall(X, sujeira(X), L).
