def merge_the_tools(string, k):
    # your code goes here
    import re
    from collections import OrderedDict
    splits = re.findall(r".{%s}" % k, string)
    for x in splits:
        print(''.join(OrderedDict.fromkeys(x).keys()))

if __name__ == '__main__':
    string, k = input(), int(input())
    merge_the_tools(string, k)