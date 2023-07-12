# Informações úteis

## link para download prolog
* https://www.swi-prolog.org/download/stable/bin/swipl-9.0.4-1.x64.exe.envelope

## como iniciar prolog no terminal
* executar o comando: "swipl"

## como carregar programa no CLI do prolog: 
* consult('<nome_programa>').

## como fazer para aparecer vario resultados de uma query
* apertar tecla "n" para pegar próximo resultado

## como fazer para sair do terminal do swipl
* inserir o comando "halt."

## para acessar um elemento de lista
* usar predicado nth0(i, <Lista>, Elem) --> Elem = Lista[i]


## para pegar indice de um elemento da lista
* usar predicado nth0(I, <Lista>, <elemento>) --> I = índice do <elemento> na <Lista>


## como importar arquivos no prolog
* usar: :- consult('<nome_arquivo.pl>').


## como rodar executar programa
* em 'testes.pl' executar programa main().
* vai rodar tudo e botar as listas e custo na relação robo
* se rodar ?- robo(V, L, C). não vai aparecer lista toda (pq é mto grande) (e custo tá bugado, precisa consertar isso)
* precisa rodar com ?- robo(V, L, C) ; true.
* dps que rodar isso, vai ter opção de apertar "w" que vai rodar de novo e gerar os valores completos