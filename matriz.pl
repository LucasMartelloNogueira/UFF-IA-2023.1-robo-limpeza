vertice(a)
vertice(b)
vertice(c)

aresta(63,a,b).
aresta(110,a,c).
aresta(53,a,e).
aresta(45,e,b).
aresta(65,b,d).
aresta(67,b,c).
aresta(45,c,d).
aresta(70,d,f).
aresta(52,e,f).
aresta(62,b,f).

sujeira(a).

obstaculo(b).


movimento(id, vertice_origem, vertice_destino, movimento).
movimentos_robo().

/*
vertice(a, 2, 6).
vertice(b, 4, 9).
*/


matriz(
	[[a, b, c],
	 [d, e, f],
	 [g, h, i]
	]
).


varrerLinha(Linha, Id, Y):-
	nth0(Y, Linha, Id).


getVertice([Linha|Matriz], Id, X, Y):-
	(member(Id, Linha),
	matriz(M),
	nth0(X, M, Linha),
	varrerLinha(Linha, Id, Y)
	);
	getVertice(Matriz, Id, X, Y).



vertice(Id, X, Y):-
	matriz(M),
	getVertice(M, Id, X, Y), !.


% Regra para o cálculo da distância de Manhattan entre dois pontos
distancia_manhattan(Ponto1, Ponto2, Dist) :-
    vertice(Ponto1, X1, Y1),
    vertice(Ponto2, X2, Y2),
    Dist is abs(X1 - X2) + abs(Y1 - Y2).
