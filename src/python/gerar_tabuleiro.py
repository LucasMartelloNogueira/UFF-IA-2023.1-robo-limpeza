import sys
import random
from typing import List, Tuple
import numpy as np
from PIL import Image, ImageDraw, ImageFont


def is_there_any_obstacle(elem: str) -> bool:
    if elem == 'O':
        return True
    return False

def is_there_any_dirty(elem: str) -> bool:
    if elem == 'S':
        return True
    return False

def generate_matrix_fact(matrix: List[List[str]]) -> List[List[str]]:
    n = len(matrix)
    m = len(matrix[0])
    m_aux = []
    
    for i in range(n):
        m_line = []
        for j in range(m):
            cell_id = i * m + j
            m_line.append(f'v{cell_id}')
        m_aux.append(m_line)

    return m_aux

def old_generate_vertice_and_edge_list(matrix: List[List[str]]) -> Tuple[List[str], List[str]]:
    n = len(matrix)
    m = len(matrix[0])
    vertices = []
    edges = []

    def add_edge(cell_id, neighbor_id):
        edges.append('aresta(1, v{}, v{}).' .format(cell_id, neighbor_id))

    def add_vertice(cell_id, x, y):
        vertices.append(f'vertice(v{cell_id}, {x}, {y}).')

    for i in range(n):
        for j in range(m):
            cell_id = i * m + j
            cell = matrix[i][j]

            add_vertice(cell_id, i, j)

            # Vizinho acima
            if i > 0:
                neighbor_id = (i - 1) * m + j
                if cell_id < neighbor_id:
                    add_edge(cell_id, neighbor_id)

            # Vizinho abaixo
            if i < n - 1:
                neighbor_id = (i + 1) * m + j
                if cell_id < neighbor_id:
                    add_edge(cell_id, neighbor_id)

            # Vizinho à esquerda
            if j > 0:
                neighbor_id = i * m + (j - 1)
                if cell_id < neighbor_id:
                    add_edge(cell_id, neighbor_id)

            # Vizinho à direita
            if j < m - 1:
                neighbor_id = i * m + (j + 1)
                if cell_id < neighbor_id:
                    add_edge(cell_id, neighbor_id)

    return vertices, edges

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
                obstacles_list.append(f'obstaculo(v{cell_id}).')
            elif cell == 'S':
                dirt_list.append(f'sujeira(v{cell_id}).')

    return dirt_list, obstacles_list

def persist_facts(matrix_fact: List[List[str]], obstacles_list: List[str], dirt_list: List[str], filename: str = './src/prolog/tabuleiro.pl') -> None:
    with open(filename, 'w') as file:
        file.write('%% tabuleiro\n')
        file.write('matriz([\n')
        for line in matrix_fact:
            l_aux = f'{", ".join(line)}'
            virg = '' if line == matrix_fact[-1] else ','
            file.write(f'   [{l_aux}]{virg}\n')
        file.write(']).\n\n')

        file.write('%% obstaculos\n')
        for obstacle in obstacles_list:
            file.write(obstacle + '\n')
        file.write('\n')

        file.write('%% sujeiras\n')
        for dirt in dirt_list:
            file.write(dirt + '\n')
        file.write(':- dynamic(sujeira/1).\n')

    print('Base de fatos salva em: ', filename)

def old_persist_facts(vertices_list: List[str], edges_list: List[str], obstacles_list: List[str], dirt_list: List[str], filename: str = './src/prolog/tabuleiro.pl') -> None:
    with open(filename, 'w') as file:
        file.write('%% vertices - vertice(id, x, y)\n')
        for vertice in vertices_list:
            file.write(vertice + '\n')
        file.write('\n')
        
        file.write('%% arestas - aresta(custo, id_vertice1, id_vertice2)\n')
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

def generate_random_matrix_func(n: int, m: int) -> List[List[str]]:
    random_matrix = []
    for _ in range(n):
        line = []
        for _ in range(m):
            elem = random.choice(['*', 'S', 'O', '*', '*', '*', '*'])
            line.append(elem)
        random_matrix.append(line)
    return random_matrix

def gerar_imagem_matriz(matriz, celula_tamanho, rótulos):
    altura, largura = matriz.shape
    imagem_largura = largura * celula_tamanho
    imagem_altura = altura * celula_tamanho

    # Criar uma imagem vazia
    imagem = Image.new('RGB', (imagem_largura, imagem_altura), 'white')
    draw = ImageDraw.Draw(imagem)
    fonte = ImageFont.truetype('arial.ttf', 14)

    # Preencher a imagem com os valores da matriz e os rótulos
    for i in range(altura):
        for j in range(largura):
            valor = matriz[i, j]
            x = j * celula_tamanho
            y = i * celula_tamanho
            # Desenhar o retângulo da célula
            draw.rectangle([(x, y), (x + celula_tamanho, y + celula_tamanho)], outline='black')
            # Adicionar o rótulo da célula
            rótulo = str(valor) if rótulos else ''
            draw.text((x + celula_tamanho // 2, y + celula_tamanho // 2), rótulo, fill='black',
                      font=fonte, anchor='mm')

    return imagem


if __name__ == '__main__':
    print('Uso:')
    print('- python gerar_tabuleiro.py')
    print('     Será gerado como output um arquivo tabuleiro.pl com fatos relacionados a matriz definida hard-coded neste script.')
    print('- python gerar_tabuleiro.py n m')
    print('     Será gerado como output um arquivo tabuleiro.pl com fatos relacionados a uma matriz gerada aleatoriamente.')
    print('     -   n representa o número de linhas do tabuleiro')
    print('     -   m representa o número de colunas do tabuleiro')

    if len(sys.argv) != 1 and len(sys.argv) != 3:
        print('Número de argumentos incorreto.')
        exit(0)
    
    generate_random_matrix = True if len(sys.argv) == 3 else False
    if generate_random_matrix:
        n = sys.argv[1]
        m = sys.argv[2]
        matrix = generate_random_matrix_func(int(n), int(m))
    else:
        matrix = [
            ['*', '*', '*', 'O', 'S'],
            ['*', '*', '*', '*', '*']
        ]

    final_matrix = generate_matrix_fact(matrix)
    dirt_list, obstacles_list = generate_dirt_and_obstacles_list(matrix)
    persist_facts(final_matrix, obstacles_list, dirt_list)

    matriz = np.array(matrix)
    # Tamanho da célula e rótulos
    celula_tamanho = 50
    rótulos = True
    # Gerar a imagem da matriz
    imagem_matriz = gerar_imagem_matriz(matriz, celula_tamanho, rótulos)
    # Salvar a imagem
    imagem_matriz.save(f'./resultados/imagem_matriz_{len(matriz)}x{len(matriz[0])}.png')
