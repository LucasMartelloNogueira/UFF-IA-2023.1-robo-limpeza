from typing import List, Tuple

def is_there_any_obstacle(elem: str) -> bool:
    if elem == 'O':
        return True
    return False

def is_there_any_dirty(elem: str) -> bool:
    if elem == 'S':
        return True
    return False

def generate_edge_list(matrix: List[List[str]]) -> List[str]:
    n = len(matrix)
    m = len(matrix[0])
    edges = []

    def add_edge(cell_id, neighbor_id):
        edges.append('aresta(1, {}, {}).' .format(cell_id, neighbor_id))

    for i in range(n):
        for j in range(m):
            cell_id = i * m + j
            cell = matrix[i][j]

            # Vizinho acima
            if i > 0:
                neighbor_id = (i - 1) * m + j
                add_edge(cell_id, neighbor_id)

            # Vizinho abaixo
            if i < n - 1:
                neighbor_id = (i + 1) * m + j
                add_edge(cell_id, neighbor_id)

            # Vizinho à esquerda
            if j > 0:
                neighbor_id = i * m + (j - 1)
                add_edge(cell_id, neighbor_id)

            # Vizinho à direita
            if j < m - 1:
                neighbor_id = i * m + (j + 1)
                add_edge(cell_id, neighbor_id)

    return edges

def generate_dirt_and_obstacles_list(matrix: List[List[str]]) -> Tuple[List[str], List[str]]:
    n = len(matrix)
    m = len(matrix[0])
    dirt_list = []
    obstacles_list = []

    for i in range(n):
        for j in range(m):
            cell_id = i * m + j
            cell = matrix[i][j]
            if cell == 'O':
                obstacles_list.append(f'obstaculo({cell_id}).')
            elif cell == 'S':
                dirt_list.append(f'sujeira({cell_id}).')

    return dirt_list, obstacles_list

def persist_facts(edges_list: List[str], obstacles_list: List[str], dirt_list: List[str], filename: str = 'tabuleiro.pl') -> None:
    with open(filename, 'w') as file:
        file.write('%% arestas\n')
        for edge in edges_list:
            file.write(edge + '\n')
        file.write('\n')

        file.write('%% obstaculos\n')
        for obstacle in obstacles_list:
            file.write(obstacle + '\n')
        file.write('\n')

        file.write('%% sujeiras\n')
        for dirt in dirt_list:
            file.write(dirt + '\n')

    print('Base de fatos salva em: ', filename)


matrix = [
    ['*', '*', '*', 'O', 'S'],
    ['*', '*', '*', '*', '*']
]

edges_list = generate_edge_list(matrix)
dirt_list, obstacles_list = generate_dirt_and_obstacles_list(matrix)
persist_facts(edges_list, obstacles_list, dirt_list)

# for edge in edge_list:
#     print(edge)
# print(dirt_list, obstacles_list)
