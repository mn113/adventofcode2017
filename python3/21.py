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
    if len(pat) % 2 == 0:
        b = blocksize = 2
    else:
        b = 3
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


# Stitching example:
#
# [1,2,3]   [4,5,6]
# [7,8,9]   [A,B,C]
# [D,E,F]   [G,H,I]
#
# [J,K,L]   [M,N,O]
# [P,Q,R]   [S,T,U]
# [V,W,X]   [Y,Z,0]
#

def stitch(blocks):    # 4 blocks
    #print(blocks)
    blocks.reverse()
    b = len(blocks)    #4
    q = int(sqrt(b))    #2
    bs = len(blocks[0]) #3
    ns = q*bs           #6
    pat = [[None] * ns for i in range(ns)]  # 36 Nones
    #print(pat)
    for i in range(q):  #0,1
        i *= bs         #0,3
        #print('i',i)
        for j in range(q):  #0,1
            j *= bs         #0,3
            #print('j',j)
            #print('block:')
            d = blocks.pop()    # ok
            #print('d',len(d),d) # 3
            for m in range(len(d)): #0,1,2
                for n in range(len(d)): #0,1,2
                    #print([i,j,m,n, d[m][n], i+m, j+n]) #0-5
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

    f0 = flipV(r0)
    f1 = flipV(r1)
    f2 = flipV(r2)
    f3 = flipV(r3)

    h0 = flipH(r0)
    h1 = flipH(r1)
    h2 = flipH(r2)
    h3 = flipH(r3)

    for v in [r0,r1,r2,r3, f0,f1,f2,f3]:
        v = compress(v)
        #print(v)
        if v in rules.keys():
            #print('found', v, '=>', rules[v])
            return rules[v]
    else:
        raise KeyError('Rule not found.', compress(b))
        return False

def process(image):
    if len(image) > 3:
        blocks = breakup(image)
    else:
        blocks = [image]

    print(len(blocks), 'block(s)')
    # Find a matching rule for each piece:
    blocks = [expand(find_rule(b)) for b in blocks]
    #print('resulting', blocks)

    if len(blocks) > 1:
        return stitch(blocks)
    else:
        return blocks[0]

#print(stitch(breakup(expand("#..#/..../..../#..#"))))   # ok

# Start work:
image = ".#./..#/###"
image = expand(image)

for z in range(18):
    image = process(image)
    print('z', z, compress(image))

image = compress(image)
print(image)
print(image.count("#"))
