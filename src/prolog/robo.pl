/*

    ######################################

    Arquivo que robo e suas funções

    ######################################

*/


:- consult('utils.pl').
:- consult('algoritmosBusca.pl').


/* robo/3

definindo o robo

+ <attr-1> : vertice atual do robo
+ <attr-2> : lista de vertices percorridos, caminho feito pelo robo
+ <attr-3> : custo da distancia percorrida pelo robo

*/

robo(a, [], 0).
:- dynamic(robo/3).


resetaRobo():-
	substituirRelacao(
		robo(_, _, _),
		robo(a, [], 0)
	).



updateListaCaminhosRobo([], NovosCaminhos, NovosCaminhos).

updateListaCaminhosRobo(ListaAntiga, [_|NovosCaminhos], ListaResultante):-
	concat(ListaAntiga, NovosCaminhos, ListaResultante).



atualizaRobo(NovosCaminhos, NovoCusto):-
	robo(VerticeAtual, ListaCaminhos, CustoAtual),
	last(NovosCaminhos, NovoVertice),
	updateListaCaminhosRobo(ListaCaminhos, NovosCaminhos, ListaAtualizada),
	CustoTotal is CustoAtual + NovoCusto,
	substituirRelacao(
		robo(VerticeAtual, ListaCaminhos, CustoAtual),
		robo(NovoVertice, ListaAtualizada, CustoTotal)
	).
	





novoObjetivo(NovoVertice):-
	substituirRelacao(objetivo(_), objetivo(NovoVertice)).





/*
  Limpando a sala utilizando algoritmo: A*
*/
roboLimpaSala([], PosFinal, aEstrela):-
	robo(VerticeAtual, _, _),
	novoObjetivo(PosFinal),
	aEstrela([[0,0,0,VerticeAtual]], ListaCaminhosNovos, CustoNovo),
	atualizaRobo(ListaCaminhosNovos, CustoNovo).
	
roboLimpaSala([ProxSujeira|ListaSujeiras], PosFinal, aEstrela):-
	robo(VerticeAtual, _, _),
	novoObjetivo(ProxSujeira),
	aEstrela([[0,0,0,VerticeAtual]], ListaCaminhosNovos, CustoNovo),
	atualizaRobo(ListaCaminhosNovos, CustoNovo),
	roboLimpaSala(ListaSujeiras, PosFinal, aEstrela).


/*
  Limpando a sala utilizando algoritmo: hill climb
*/
roboLimpaSala([], PosFinal, hillClimb):-
	robo(VerticeAtual, _, _),
	novoObjetivo(PosFinal),
	hillClimb([[_,VerticeAtual]], ListaCaminhosNovos, _),
	length(ListaCaminhosNovos, C),
	CustoNovo is C-1,
	atualizaRobo(ListaCaminhosNovos, CustoNovo).
	
roboLimpaSala([ProxSujeira|ListaSujeiras], PosFinal, hillClimb):-
	robo(VerticeAtual, _, _),
	novoObjetivo(ProxSujeira),
	hillClimb([[_,VerticeAtual]], ListaCaminhosNovos, _),
	length(ListaCaminhosNovos, C),
	CustoNovo is C-1,
	atualizaRobo(ListaCaminhosNovos, CustoNovo),
	roboLimpaSala(ListaSujeiras, PosFinal, hillClimb).


/*
  Limpando a sala utilizando algoritmo: best first
*/
roboLimpaSala([], PosFinal, bestFirst):-
	robo(VerticeAtual, _, _),
	novoObjetivo(PosFinal),
	bestFirst([[_,VerticeAtual]], ListaCaminhosNovos, CustoNovo),
	atualizaRobo(ListaCaminhosNovos, CustoNovo).
	
roboLimpaSala([ProxSujeira|ListaSujeiras], PosFinal, bestFirst):-
	robo(VerticeAtual, _, _),
	novoObjetivo(ProxSujeira),
	bestFirst([[_,VerticeAtual]], ListaCaminhosNovos, CustoNovo),
	atualizaRobo(ListaCaminhosNovos, CustoNovo),
	roboLimpaSala(ListaSujeiras, PosFinal, bestFirst).


/*
  Limpando a sala utilizando algoritmo: branch and bound 
*/
roboLimpaSala([], PosFinal, branchAndBound):-
	robo(VerticeAtual, _, _),
	novoObjetivo(PosFinal),
	branchAndBound([[0,VerticeAtual]], ListaCaminhosNovos, CustoNovo),
	atualizaRobo(ListaCaminhosNovos, CustoNovo).
	
roboLimpaSala([ProxSujeira|ListaSujeiras], PosFinal, branchAndBound):-
	robo(VerticeAtual, _, _),
	novoObjetivo(ProxSujeira),
	branchAndBound([[0,VerticeAtual]], ListaCaminhosNovos, CustoNovo),
	atualizaRobo(ListaCaminhosNovos, CustoNovo),
	roboLimpaSala(ListaSujeiras, PosFinal, branchAndBound).
