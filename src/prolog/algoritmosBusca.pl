/*

    ######################################

    Arquivo que contém os algoritmos de busca

    ######################################

*/

:- consult('matriz.pl').


%Grafo não-dirigido:
sG(G,V1,V2):-
    sGB(G,V1,V2).
sG(G,V1,V2):-
	sGB(G,V2,V1).


%sF(G(n),H(n),F(n),VerticeOrigem,VerticeDestino) - usa a função F
sF(G,H,F,V1,V2):-
	sG(G,V1,V2),
	sH(V2,H),
	F is G + H.


% Regra para o cálculo da distância de Manhattan entre dois pontos
distancia_manhattan(Ponto1, Ponto2, Dist) :-
    vertice(Ponto1, X1, Y1),
    vertice(Ponto2, X2, Y2),
    Dist is abs(X1 - X2) + abs(Y1 - Y2).


% mudando funcao de avaliação para usar distancia_manhattan
sH(V1, H):-
    objetivo(V2),
    distancia_manhattan(V1, V2, H).


% mudando funcao de avaliação para usar distancia_manhattan
sH(H,V1,V2):-
    distancia_manhattan(V1, V2, H).

% s(G(n),H(n),F(n),VerticeOrigem,VerticeDestino) - Não usa nenhuma
% heurística
s(V1,V2):-sG(_,V1,V2).

%Definir o nó (estado) objetivo
objetivo(v0). 
:- dynamic(objetivo/1).

%maior([_,_,F1|_],[_,_,F2|_]) :- F1 > F2.

/*relações acessórias para processamento de listas*/
membro(X,[X|_]):-!.
membro(X,[_|C]):-
    membro(X,C).

concatena([],L,L).
concatena([X|L1],L,[X|L2]):-
    concatena(L1,L,L2).

/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
resolve(Inicio, Estrategia).

Programa que resolve um problema de busca por estratégia cega ou com heurística 
dado um estado inicial do problema

+ <arg-1> Estado Inicial do Problema
+ <arg-2> Estrategia utilizada para resolucao do problema de busca:
profundidade
largura
hillClimb
bestFirst
bBound
aEstrela


Pré-condições: buscaCega/3
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
resolve(Inicio, Estrategia):-
	buscaCega(Estrategia,Inicio,Solucao),
	imprime(Solucao).
resolve(Inicio, Estrategia):-
	buscaHeuristica(Estrategia,Inicio,Solucao,Custo),
	imprime(Solucao,Custo).

imprime(Lista):-
    write('------------------'),nl,
	write('Solucao:'),nl,
	imprimeLista(Lista),nl,
	write('------------------'),nl.

imprime(Lista,Custo):-
    write('------------------'),nl,
	write('Solucao:'),nl,
	imprimeLista(Lista),
    write(' | Custo: '),write(Custo),nl,
	write('------------------'),nl.

imprimeLista([]):-
    !,write('Lista Vazia').
imprimeLista([Elem]):-
    !,write(Elem).
imprimeLista([Elem|Lista]):-
	write(Elem),
    write(' -> '),
	imprimeLista(Lista).

/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
buscaCega(Estrategia,Inicio,Solucao)

Dada uma lista contendo o caminho percorrido e um estado inicial Inicio,
retorna uma solucao para o problema de busca utilizando a estratégia
de busca definida por Estrategia

+ <arg-1> Estrategia utilizada para resolucao do problema de busca
+ <arg-2> Estado Inicial do Problema
- <arg-3> Solucao para o problema

Pre-condicoes:
profundidade/3
largura/2
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/


buscaCega(profundidade,Inicio,Solucao):-
      profundidade([Inicio],Inicio,Solucao).
buscaCega(largura,Inicio,Solucao):-
      largura([[Inicio]],Solucao).

/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
buscaHeuristica(Estrategia,Inicio,Solucao,Custo)

Dada uma lista contendo o caminho percorrido e um estado inicial Inicio,
retorna uma solucao para o problema de busca utilizando a estratégia
de busca definida por Estrategia

+ <arg-1> Estrategia utilizada para resolucao do problema de busca
+ <arg-2> Estado Inicial do Problema
- <arg-3> Solucao para o problema
- <arg-3> Custo da solucao para o problema (quando for usado G)

Pre-condicoes:
profundidade/3
largura/2
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
buscaHeuristica(hillClimb,Inicio,Solucao,Custo):-
      hillClimb([[_,Inicio]],Solucao,Custo).
buscaHeuristica(bestFirst,Inicio,Solucao,Custo):-
      bestFirst([[_,Inicio]],Solucao,Custo).
buscaHeuristica(bBound,Inicio,Solucao,Custo):-
      branchAndBound([[0,Inicio]],Solucao,Custo).
buscaHeuristica(aEstrela,Inicio,Solucao,Custo):-
      aEstrela([[0,0,0,Inicio]],Solucao,Custo).

/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
ordenaF(Caminhos,CaminhosOrd)

Ordena os Caminhos a partir do primeiro valor de heurística dos caminhos em Caminhos
e retorna em CaminhosOrd.
+ <arg-1> Caminhos - lista de caminhos a ser ordenada
- <arg-2> Caminhos ordenados
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
ordenaF(Caminhos,CaminhosOrd):-
	quicksortF(Caminhos,CaminhosOrd).

particionarF(_,[],[],[]).
particionarF(X,[Y|Cauda],[Y|Menor],Maior):-
	maiorF(X,Y),!,
	particionarF(X,Cauda,Menor,Maior).
particionarF(X,[Y|Cauda],Menor,[Y|Maior]):-
	particionarF(X,Cauda,Menor,Maior).

quicksortF([],[]).
quicksortF([X|Cauda],ListaOrd):-
	particionarF(X,Cauda,Menor,Maior),
	quicksortF(Menor,MenorOrd),
	quicksortF(Maior,MaiorOrd),
	concatena(MenorOrd,[X|MaiorOrd],ListaOrd).

%maiorF retorna verdadeiro se o valor de heurística F1 da lista do caminho 
%é maior que o valor F2 da segunda lista
maiorF([F1|_],[F2|_]):-F1 > F2.

%------------------------------
%Relações estende para busca em largura ou utilizando 
%as funções de custo G, de avaliação H e F, somatório de G e H

/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
estende(Caminho,NovosCaminhos).

Gera todos os Caminhos possiveis a partir de Caminho.
+ <arg-1> Caminho
- <arg-2> Novos caminhos possiveis a partir de caminho
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/

estende([No|Caminho],NovosCaminhos):-
    findall([NovoNo,No|Caminho],
	       (
           	   s(No,NovoNo),
               not(membro(NovoNo,[No|Caminho])),
			   not(obstaculo(NovoNo))
           ),
           NovosCaminhos).

/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
estendeG(Caminho,NovosCaminhos).

Gera a partir de [G,NoAtual|Caminho] todos os Caminhos possiveis a partir de Caminho
utilizando somente a função de custo G. O G dos caminhos resultantes deve ser o somatório
do caminho atual G com o custo para os nós visitados
+ <arg-1> Caminho - [G,NoAtual|Caminho]
- <arg-2> Novos caminhos possiveis a partir de caminho 
(lista de todos os caminhos resultantes a partir de NoAtual)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
estendeG([Gc, No|Caminho],NovosCaminhos) :-
	findall([Gnovo,NovoNo,No|Caminho],
	( 
		sG(Gn,No,NovoNo),
		not(member(NovoNo,[No|Caminho])),
		not(obstaculo(NovoNo)),
		Gnovo is Gc + Gn),
		NovosCaminhos
	).

/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
estendeH(Caminho,NovosCaminhos).

Gera a partir de [H,NoAtual|Caminho] todos os Caminhos possiveis a partir de Caminho
utilizando somente a função de avaliação H
+ <arg-1> Caminho - [H,NoAtual|Caminho]
- <arg-2> Novos caminhos possiveis a partir de caminho 
(lista de todos os caminhos resultantes a partir de NoAtual)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/


/*
estendeH([_,No|Caminho],NovosCaminhos) :-
	findall([HNovo,NovoNo,No|Caminho],
	( 
		sH(HN,No,NovoNo),
		not(member(NovoNo,[No|Caminho])),
		not(obstaculo(NovoNo)),
		HNovo is HN),
		NovosCaminhos
	).
*/




estendeH([_,No|Caminho],NovosCaminhos):-
	listaVizinhos(No, ListaVizinhos),
	objetivo(Obj),
	
	findall([HNovo,NovoNo,No|Caminho],
	(
		member(NovoNo, ListaVizinhos),
		sH(HN, NovoNo, Obj),
		not(member(NovoNo,[No|Caminho])),
		not(obstaculo(NovoNo)),
		HNovo is HN),
	NovosCaminhos
	).


/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
estendeF(Caminho,NovosCaminhos).

Gera a partir de [F,G,H,NohAtual|Caminho] todos os Caminhos possiveis a partir de Caminho
utilizando função de custo G, função de avaliação H, e calculando 
F(NohNovo) = G(NohNovo) + H(NohNovo)
+ <arg-1> Caminho - [F,G,H,NoAtual|Caminho]
- <arg-2> Novos caminhos possiveis a partir de caminho
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/

estendeF([_,GC,_,No|Caminho],NovosCaminhos):-
	listaVizinhos(No, ListaVizinhos),

	findall([FNovo,GNovo,HNovo,NovoNo,No|Caminho],
	      (
			  member(NovoNo, ListaVizinhos),
          	  sF(GN,HN,_,No,NovoNo),
              not(member(NovoNo,[No|Caminho])),
			  not(obstaculo(NovoNo)),
              GNovo is GC + GN, 
          	  HNovo is HN, 
              FNovo is GNovo + HNovo
          ),
	      NovosCaminhos).

/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
profundidade(Caminho,Inicio,Solução)

Dado um NoCorrente, juntamente com o Caminho percorrido ate o
momento, o NoCorrente na cabeça do Caminho eh a Solucao se NoCorrente for
um estado objetivo. Caso contrario a recursao continua ateh encontrar um
estado objetivo.

+ <arg-1> Lista contendo o caminho percorrido ateh o momento. Inicia com
vazio
+ <arg-2> Estado Inicial do Problema
- <arg-3> Solucao para o problema

Pré-condições:
-

Chamada a programas externos:
objetivo/1
s/2
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/

profundidade(Caminho, NoCorrente, Solucao):-		 %Gera a solucao se o noh sendo visitado 
							 %eh um noh objetivo
	objetivo(NoCorrente),                            %O noh gerado e colocado no caminho no passo 							 %anterior eh um noh objetivo
	reverse(Caminho,Solucao).

profundidade(Caminho, NoCorrente, Solucao) :-
	s(NoCorrente, NoNovo),				 %Gera um novo estado
	not(membro(NoNovo, Caminho)),                    %Evita ciclos na busca
	not(obstaculo(NoNovo)),
	profundidade([NoNovo|Caminho], NoNovo, Solucao). %Coloca o noh corrente no caminho e 
							 %continua a recursao

/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
largura(PossiveisCaminhos,Solucao)

Dada uma lista de PossiveisCaminhos (inicialmente com somente um
possivel caminho percorrido, contendo somente o nó inicial), este
programa implementa o algoritmo de busca em largura para encontrar o
caminho.

+ <arg-1> Lista contendo os possiveis caminhos
Inicia com vazio - <arg-2> Solucao para o problema

Pre-condicoes:
objetivo/1
estende/2
concatena/3
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/

largura([[No|Caminho]|_],Solucao):-	 %Gera a solucao se o noh sendo visitado eh um noh objetivo
	objetivo(No),                    %O noh gerado no passo anterior eh um noh objetivo
    reverse([No|Caminho],Solucao).
largura([Caminho|Caminhos], Solucao) :-
	estende(Caminho, NovosCaminhos), %Gera novos caminhos
	concatena(Caminhos,NovosCaminhos,CaminhosTotal),
	largura(CaminhosTotal, Solucao). 	 %Coloca o noh corrente no caminho e continua a recursao

/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
hillClimb(PossiveisCaminhos,Solucao)

Dada uma lista de PossiveisCaminhos (inicialmente com somente um
possivel caminho percorrido, contendo somente o nó inicial), na qual o primeiro caminho
[NoAtual|Caminho] é o que deve ser analisado, este programa implementa o algoritmo 
de busca Hill Climbing para encontrar o
melhor caminho. A estratégia consiste em gerar uma lista de possíveis caminhos NovosCaminhos,
ordenar os caminhos de NovosCaminhos segundo a função de avaliação H, concatenar com os Caminhos já existentes
e seguir na busca.

+ <arg-1> Lista contendo os possiveis caminhos
Inicia com vazio - <arg-2> Solucao para o problema

Pre-condicoes:
estendeH/2
concatena/3
ordenaF/2
objetivo/1
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
hillClimb([[_,No|Caminho]|_],Solucao,'-') :-
	objetivo(No),
	reverse([No|Caminho],Solucao).
hillClimb([Caminho|Caminhos], Solucao, Custo) :-
	estendeH(Caminho, NovosCaminhos),
	ordenaF(NovosCaminhos, CaminhosOrd),
	concatena(CaminhosOrd, Caminhos, CaminhosTotal),
	hillClimb(CaminhosTotal, Solucao, Custo).

/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
bestFirst(PossiveisCaminhos,Solucao)

Dada uma lista de PossiveisCaminhos (inicialmente com somente um
possivel caminho percorrido, contendo somente o nó inicial), na qual o primeiro caminho
[NoAtual|Caminho] é o que deve ser analisado, este programa implementa o algoritmo 
de busca Best Fisrt para encontrar o melhor caminho. A estratégia consiste em gerar 
uma lista de possíveis caminhos NovosCaminhos, concatenar com os Caminhos já existentes,
ordenar a lista completa segundo a função de avaliação H e seguir na busca.

+ <arg-1> Lista contendo os possiveis caminhos
Inicia com vazio - <arg-2> Solucao para o problema

Pre-condicoes:
estendeH/2
concatena/3
ordenaF/2
objetivo/1
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
bestFirst([[_,No|Caminho]|_],Solucao, '-'):-
	objetivo(No),
	reverse([No|Caminho],Solucao).
bestFirst([Caminho|Caminhos], Solucao, Custo):-
	estendeH(Caminho, NovosCaminhos),
    concatena(NovosCaminhos, Caminhos, CaminhosTotal),
	ordenaF(CaminhosTotal, CaminhosOrd),
	bestFirst(CaminhosOrd, Solucao, Custo).

/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
branchAndBound(PossiveisCaminhos,Solucao)

Dada uma lista de PossiveisCaminhos (inicialmente com somente um
possivel caminho percorrido, contendo somente o nó inicial), na qual o primeiro caminho
[NoAtual|Caminho] é o que deve ser analisado, este programa implementa o algoritmo 
de busca Best Fisrt para encontrar o melhor caminho. A estratégia consiste em gerar 
uma lista de possíveis caminhos NovosCaminhos, concatenar com os Caminhos já existentes,
ordenar a lista completa segundo a função de avaliação G e seguir na busca.

+ <arg-1> Lista contendo os possiveis caminhos
Inicia com vazio 
- <arg-2> Solucao para o problema
- <arg-3> Custo da solucao encontrada

Pre-condicoes:
estendeH/2
concatena/3
ordenaF/2
objetivo/1
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
branchAndBound([[G,No|Caminho]|_],Solucao,G):-	 %Gera a solucao se o noh sendo visitado eh um 							 %no objetivo
	objetivo(No),                                    %O noh gerado no passo anterior eh um noh 							 %objetivo
    reverse([No|Caminho],Solucao).

branchAndBound([Caminho|Caminhos], Solucao, G) :-
	estendeG(Caminho, NovosCaminhos), %Gera novos caminhos
	concatena(Caminhos,NovosCaminhos,CaminhosTotal),
	ordenaF(CaminhosTotal,CaminhosTotOrd),
	branchAndBound(CaminhosTotOrd, Solucao, G). 

/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
aEstrela(PossiveisCaminhos,Solucao)

Dada uma lista de PossiveisCaminhos (inicialmente com somente um
possivel caminho percorrido, contendo somente o nó inicial), na qual o primeiro caminho
[NoAtual|Caminho] é o que deve ser analisado, este programa implementa o algoritmo 
de busca A* para encontrar o melhor caminho. A estratégia consiste em gerar 
uma lista de possíveis caminhos NovosCaminhos, concatenar com os Caminhos já existentes,
ordenar a lista completa segundo a função de avaliação F = G+H e seguir na busca.

+ <arg-1> Lista contendo os possiveis caminhos - Inicia com vazio
- <arg-2> Solucao para o problema
- <arg-3> Custo da solucao encontrada
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/

aEstrela([[_,G,_,No|Caminho]|_],Solucao,G):-	 %Gera a solucao se o noh sendo visitado eh um 							 %no objetivo
	objetivo(No),                                    %O noh gerado no passo anterior eh um noh 							 %objetivo
    reverse([No|Caminho],Solucao).

aEstrela([Caminho|Caminhos], Solucao, G) :-
	estendeF(Caminho, NovosCaminhos), %Gera novos caminhos
	concatena(Caminhos,NovosCaminhos,CaminhosTotal),
	ordenaF(CaminhosTotal,CaminhosTotOrd),
	aEstrela(CaminhosTotOrd, Solucao, G). 	%Coloca o noh corrente no caminho e continua a recursao

