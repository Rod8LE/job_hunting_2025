# Enter your code here. Read input from STDIN. Print output to STDOUT

import itertools

string = input() # 1222311

plop = list()
for k, g in itertools.groupby(string, None):
    plop.append(str((len(list(g)), int(k))))

print(' '.join(plop)) # (1, 1) (3, 2) (1, 3) (2, 1)