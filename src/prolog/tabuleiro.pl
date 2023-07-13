%% tabuleiro
matriz([
   [v0, v1, v2],
   [v3, v4, v5],
   [v6, v7, v8]
]).

%% obstaculos
obstaculo(v2).
obstaculo(v4).

%% sujeiras
sujeira(v1).
sujeira(v5).
:- dynamic(sujeira/1).

removeSujeiras([]).

removeSujeiras([S|Sujeiras]):-
   retract(sujeira(S)),
   removeSujeiras(Sujeiras).
