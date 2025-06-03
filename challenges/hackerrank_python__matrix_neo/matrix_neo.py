import math
import os
import random
import re
import sys

first_multiple_input = input().rstrip().split()

n = int(first_multiple_input[0])

m = int(first_multiple_input[1])

matrix = []

for _ in range(n):
    matrix_item = input()
    matrix.append(matrix_item)

decoded_matrix = []
for col in range(m):
    for row in range(n):
        decoded_matrix.append(matrix[row][col])

decoded_matrix = ''.join(decoded_matrix)

regex_str = r'[A-Za-z0-9]+'
readable = ' '.join(re.findall(r'[A-Za-z0-9]+', decoded_matrix))
groups = re.split(r'([A-Za-z0-9]+)', decoded_matrix)
left = ''.join(re.findall(r'[^A-Za-z0-9]+', groups[0]))
right = ''.join(re.findall(r'[^A-Za-z0-9]+', groups[-1]))
print(''.join([left, readable, right]))
