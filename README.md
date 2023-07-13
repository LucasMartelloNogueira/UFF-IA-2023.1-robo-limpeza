# Trabalho Prático IA 2023.1

Integrantes:

- Karina Pereira de Lemos
- Lucas Martello Nogueira
- Valesca Moura de Sousa

## Env Config

#### Link para download prolog
- https://www.swi-prolog.org/download/stable/bin/swipl-9.0.4-1.x64.exe.envelope

### Como iniciar prolog no terminal:
- Executar o comando: ```swipl```.

### Como carregar programa no CLI do prolog: 
- ```consult('<nome_programa>')```.

### Como fazer para aparecer vários resultados de uma query:
- Apertar tecla ```n``` para pegar os próximos resultados

### Como fazer para sair do terminal do swipl:
- Inserir o comando ```halt.```

## Dicas:
#### Para acessar um elemento de lista:
- Usar predicado nth0(i, <Lista>, Elem) --> Elem = Lista[i]

#### Para pegar indice de um elemento da lista
- Usar predicado nth0(I, <Lista>, <elemento>) --> I = índice do <elemento> na <Lista>

#### Como importar arquivos no prolog
- Usar: :- consult('<nome_arquivo.pl>').

## Como executar
- Em 'testes.pl' executar programa main().
- Vai rodar tudo e botar as listas e custo na relação robo
- Se rodar ?- robo(V, L, C). não vai aparecer lista toda (pq é mto grande) (e custo tá bugado, precisa consertar isso)
- Precisa rodar com ?- robo(V, L, C) ; true.
- Dps que rodar isso, vai ter opção de apertar "w" que vai rodar de novo e gerar os valores completos