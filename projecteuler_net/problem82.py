#!/usr/bin/python

'''
Solution to http://projecteuler.net/problem=82
using dynamic programming.

https://github.com/denis-ryzhkov/training/blob/master/projecteuler_net/problem82.py
Copyright (C) 2013 by Denis Ryzhkov <denisr@denisr.com>
MIT License, see http://opensource.org/licenses/MIT
'''

# Input data.
data = [map(int, line.strip().split(',')) for line in open('problem82_matrix.txt')]
rows = len(data)
cols = len(data[0])

# No int infinity in Python: type(sys.maxint + 1) == long, unlimited precision.
inf = float('+inf')

# Minimal path sums,
# padded with extra column and extra row of infinities,
# that exploits Python's "negative index is reverse index"
# to access sums[... +/- 1] safely.
sums = [[inf] * (cols + 1) for row in xrange(rows + 1)]

for col in xrange(cols):
    row = 0
    while row < rows:
        old_sum = sums[row][col]

        new_sum = data[row][col] + (min(
            sums[row][col - 1], # From left.
            sums[row - 1][col], # From top.
            sums[row + 1][col], # From bottom.
        ) if col else 0) # Left column is already reached.

        if old_sum <= new_sum:
            row += 1 # Go to next.
            continue

        sums[row][col] = new_sum # Update current cell.

        if row and col:
            row -= 1 # Re-check previous cell on the next iteration.
        else:
            row += 1 # Go to next if in first row or in first column.

result = min(sum_[cols - 1] for sum_ in sums)
assert result == 260324
print('OK')
