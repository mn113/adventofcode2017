#! /usr/bin/env python
# Interpolate an image map blockwise repeatedly

from math import sqrt

rules = {}
with open('../inputs/21input.txt') as fp:
    lines = fp.readlines()
    for line in lines:
        parts = line.split(" => ")
        rules[parts[0]] = parts[1].strip()
#print(rules)


def expand(pat):
    return [list(row) for row in pat.split("/")]


def compress(pat):
    return "/".join(["".join(row) for row in pat])


def rotate(pat):
    if len(pat) == 3:
        return [
            [pat[2][0], pat[1][0], pat[0][0]],
            [pat[2][1], pat[1][1], pat[0][1]],
            [pat[2][2], pat[1][2], pat[0][2]]
        ]
    elif len(pat) == 2:
        return [
            [pat[1][0], pat[0][0]],
            [pat[1][1], pat[0][1]]
        ]


def flipH(pat):
    return [row[::-1] for row in pat]


def flipV(pat):
    return pat[::-1]


def breakup(pat):
    blocks = []
    if len(pat) % 3 == 0:
        b = blocksize = 3
    else:
        b = 2
    q = int(len(pat) / b)
    for i in range(q):
        #print('i',i)
        rows = pat[b*i:b*i+b]
        for j in range(q):
            #print('j',j)
            block = [row[b*j:b*j+b] for row in rows]
            #print('block', block)
            blocks.append(block)
    return blocks


def stitch(blocks):    #4
    print(blocks)
    blocks.reverse()
    b = len(blocks)    #4
    bs = len(blocks[0])
    q = int(sqrt(b))    #2
    ns = q*bs
    pat = [[None] * ns for i in range(ns)]
    print(pat)
    for i in range(q):
        i *= q        #0,2
        #print('i',i)
        for j in range(q):
            j *= q        #0,2
            #print('j',j)
            #print('block:')
            d = blocks.pop()    # ok
            print('d',len(d),d) # 3
            for m in range(len(d)): #0,1,2
                for n in range(len(d)):
                    print([i,j,m,n, d[m][n], i+m, j+n])
                    pat[i+m][j+n] = d[m][n]
            #print('/block')
            #print('pat:')
            #print(pat)
    return pat


def find_rule(b):
    # How to try all variations?
    r0 = b
    r1 = rotate(r0)
    r2 = rotate(r1)
    r3 = rotate(r2)

    v0 = flipV(r0)
    v1 = flipV(r1)
    v2 = flipV(r2)
    v3 = flipV(r3)

    h0 = flipH(r0)
    h1 = flipH(r1)
    h2 = flipH(r2)
    h3 = flipH(r3)

    for v in [r0,r1,r2,r3, v0,v1,v2,v3, h0,h1,h2,h3]:
        v = compress(v)
        #print(v)
        if v in rules.keys():
            print('found', v, '=>', rules[v])
            return rules[v]

    print("Not found", compress(b))
    return False

def process(image):
    if len(image) > 3:
        blocks = breakup(image)
    else:
        blocks = [image]

    print(len(blocks), 'block(s)')
    # Find a matching rule for each piece:
    blocks = [expand(find_rule(b)) for b in blocks]
    print('resulting', blocks)

    if len(blocks) > 1:
        return stitch(blocks)
    else:
        return blocks[0]

#print(stitch(breakup(expand("#..#/..../..../#..#"))))

# Start work:
image = ".#./..#/###"
image = expand(image)

for z in range(5):
    image = process(image)
    print('z', z, image)

image = compress(image)
print(image)
print(image.count("#")) # pythonic?
