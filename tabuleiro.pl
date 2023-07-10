%% vertices - vertice(id, x, y)
vertice(v0, 0, 0).
vertice(v1, 0, 1).
vertice(v2, 0, 2).
vertice(v3, 0, 3).
vertice(v4, 1, 0).
vertice(v5, 1, 1).
vertice(v6, 1, 2).
vertice(v7, 1, 3).
vertice(v8, 2, 0).
vertice(v9, 2, 1).
vertice(v10, 2, 2).
vertice(v11, 2, 3).
vertice(v12, 3, 0).
vertice(v13, 3, 1).
vertice(v14, 3, 2).
vertice(v15, 3, 3).

%% arestas - aresta(custo, id_vertice1, id_vertice2)
aresta(1, v0, v4).
aresta(1, v0, v1).
aresta(1, v1, v5).
aresta(1, v1, v2).
aresta(1, v2, v6).
aresta(1, v2, v3).
aresta(1, v3, v7).
aresta(1, v4, v8).
aresta(1, v4, v5).
aresta(1, v5, v9).
aresta(1, v5, v6).
aresta(1, v6, v10).
aresta(1, v6, v7).
aresta(1, v7, v11).
aresta(1, v8, v12).
aresta(1, v8, v9).
aresta(1, v9, v13).
aresta(1, v9, v10).
aresta(1, v10, v14).
aresta(1, v10, v11).
aresta(1, v11, v15).
aresta(1, v12, v13).
aresta(1, v13, v14).
aresta(1, v14, v15).

%% obstaculos
obstaculo(3).
obstaculo(5).
obstaculo(10).
obstaculo(13).

%% sujeiras
sujeira(0).
sujeira(8).
sujeira(9).
