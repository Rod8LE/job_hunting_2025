# Enter your code here. Read input from STDIN. Print output to STDOUT

if __name__ == '__main__':
    import fileinput
    from itertools import product
    row = 0
    all_elements = []
    for line in fileinput.input():
        if row == 0:
            k, m = line.rstrip().split(' ')
            k = int(k)
            m = int(m)
            assert(1 <= k) and (k <= 7), 'k'
            assert(1 <= m) and (m <= 1000), 'm'
        else:
            if row <= k:
                elements = line.rstrip().split(' ')
                elements = list(map(int, elements))
                n = elements[0]
                assert(1 <= n) and (n <= 7), 'n'
                all_elements.append(set(elements[1:n+1]))
        row += 1
    S_max = 0
    for combination in product(*all_elements):
        S = sum(x**2 for x in combination) % m
        if S > S_max:
            S_max = S
    print(S_max)