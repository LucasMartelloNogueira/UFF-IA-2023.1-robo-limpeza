/*

    ######################################

    Arquivo que contém funções auxiliares

    ######################################

*/


substituirRelacao(RelacaoAntiga, RelacaoNova):-
    retract(RelacaoAntiga),
    assertz(RelacaoNova).

pop([_], []).

pop([X|XS], [X|Resto]):-
    pop(XS, Resto).

removePrimeiro([_|XS], XS).

concat([], L2, L2).

concat([X|L1], L2, [X|L3]):-
    concat(L1, L2, L3).