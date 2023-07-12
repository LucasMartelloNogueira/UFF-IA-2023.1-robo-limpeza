/*

    ######################################

    Arquivo que robo e suas funções

    ######################################

*/


:- consult('utils.pl').


/* robo/3

definindo o robo

+ <attr-1> : vertice atual do robo
+ <attr-2> : lista de vertices percorridos, caminho feito pelo robo
+ <attr-3> : custo da distancia percorrida pelo robo

*/

robo(a, [], 0).

:- dynamic(robo/3).



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
