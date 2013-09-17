#!/usr/bin/python

'''
Solution to http://projecteuler.net/problem=83
using Dijkstra's algorithm.

https://github.com/denis-ryzhkov/training/blob/master/projecteuler_net/problem83_dijkstra.py
Copyright (C) 2013 by Denis Ryzhkov <denisr@denisr.com>
MIT License, see http://opensource.org/licenses/MIT
'''

#### Import.

from collections import defaultdict

#### Input data.

data = [map(int, line.strip().split(',')) for line in open('problem83_matrix.txt')]
rows = len(data)
cols = len(data[0])

start = (0, 0)
stop = (rows - 1, cols - 1)

#### Init helpers.

'''
2,3
5,4

-->

start--2>*<2--3>*
         ^      ^
         2      3
         |      |
         5      4
         v      v
         *<5--4>*-->stop
'''

infinity = float('+inf') # No int infinity in Python: type(sys.maxint + 1) == long, unlimited precision.

distances = defaultdict(lambda: infinity)

current_row, current_col = start
distances[(current_row, current_col)] = data[current_row][current_col] # Distance to the start node.

visited = defaultdict(lambda: False)

#### Minimal path sum.

result = infinity

while True:

    #### Unvisited neighbors.

    neighbors = [
        (neighbor_row, neighbor_col)
        for neighbor_row, neighbor_col in [
            (current_row + 1, current_col),
            (current_row - 1, current_col),
            (current_row, current_col + 1),
            (current_row, current_col - 1),
        ]
        if 0 <= neighbor_row < rows
            and 0 <= neighbor_col < cols
            and not visited[(neighbor_row, neighbor_col)]
    ]

    #### Update distances.

    to_current = result = distances[(current_row, current_col)]

    for neighbor_row, neighbor_col in neighbors:
        to_neighbor = distances[(neighbor_row, neighbor_col)]
        edge = data[neighbor_row][neighbor_col]
        distances[(neighbor_row, neighbor_col)] = min(to_neighbor, to_current + edge)

    #### Mark as visited and maybe stop.

    visited[(current_row, current_col)] = True

    if (current_row, current_col) == stop:
        break

    #### Select next.

    next_row = next_col = min_distance = infinity

    for row_col, distance in distances.iteritems():
        if min_distance > distance and not visited[row_col]:
            min_distance = distance
            next_row, next_col = row_col

    current_row, current_col = next_row, next_col

#### Result.

assert result == 425185
print('OK')
