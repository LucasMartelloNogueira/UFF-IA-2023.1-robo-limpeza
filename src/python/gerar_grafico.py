import sys
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from typing import List, Dict, Tuple


def generate_grouped_bar_chart(eixo_x: List[str], info: Dict[str, List[str]], output_filename: str, 
                               x_label: str, y_label: str, title: str) -> None:
    x = np.arange(len(eixo_x))  # the label locations
    width = 0.2  # the width of the bars
    multiplier = 0

    fig, ax = plt.subplots(layout='constrained')

    for attribute, measurement in info.items():
        offset = width * multiplier
        rects = ax.bar(x + offset, measurement, width, label=attribute)
        ax.bar_label(rects, padding=3)
        multiplier += 1

    ax.set_ylabel(y_label)
    ax.set_xlabel(x_label)
    ax.set_title(title)
    ax.set_xticks(x + width, eixo_x)
    ax.legend(loc='upper right')
    # ax.set_ylim(0, 250)
    fig = plt.gcf()
    fig.set_size_inches(10, 6)  # Especificar as dimensões desejadas em polegadas
    plt.savefig(output_filename, dpi=300)
    # plt.show()

def load_data(input_filename: str) -> Tuple[List[str], Dict[str, List[str]]]:
    data = pd.read_csv(input_filename)
    x_axis = list(data['-'])
    labels = list(data.iloc[0]._stat_axis._values)[1:]
    dict_ = {}

    for label in labels:
        dict_[label] = list(data[label])

    return x_axis, dict_


if __name__ == '__main__':
    if len(sys.argv) == 3:
        input_filename = sys.argv[1]
        output_filename = sys.argv[2]
    else:
        input_filename = './src/python/data.csv'
        output_filename = './resultados/cost_graph.png'

    # Gráfico de custo
    x, info = load_data(input_filename)
    generate_grouped_bar_chart(x, info, output_filename, 
                               'Tamanho da matriz', 'Custo (unidades de tabuleiro)', 'Custo por algoritmo e tamanho de matriz')

    # Gráfico de tempo de execução
    x, info = load_data('./src/python/time.csv')
    generate_grouped_bar_chart(x, info, './resultados/time_graph.png', 
                               'Tamanho da matriz', 'Tempo (ms)', 'Tempo de execução por algoritmo e tamanho de matriz')
