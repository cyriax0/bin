#!/usr/bin/python3

# p
# a paragraph tool for console output
# useful as separator for repeated commands with long or uniform output

# Copyright (c) 2019, Jonathan Cyriax Brast
# 
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
# 
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

import os, sys
from random import random, randint
quarterblocks = " \u2598\u259d\u2580\u2596\u258c\u259e\u259b\u2597\u259a\u2590\u259c\u2584\u2599\u259f\u2588"

columns = int(os.popen('/bin/stty size', 'r').read().split()[1])

def usage():
    s = """
usage:
    p help
    p [TYPE [LINES]]
parameters:
    LINES   tries to print that many lines
    TYPE    one of the following effects
                gradient, grad (default)
                pride, gay
                checker, goal
                noise
                noise2
                gol, game
"""
    print(s)





def color(r,g,b): return "\033[38;2;"+str(r)+";"+str(g)+";"+str(b)+"m"
def bg_color(r,g,b): return "\033[48;2;"+str(r)+";"+str(g)+";"+str(b)+"m"

def hexrgb(h): return int(h[:2],base=16),int(h[2:4],base=16),int(h[4:6],base=16)
def huergb(p):
    p=p%1
    h = (p*6)%1.0
    c = 255
    x = int(255 * (h))
    i = int(p*6)%6
    return [ (c,x,0), (255-x,c,0), (0,c,x), (0,255-x,c), (x,0,c), (c,0,255-x) ][i]



def gradientgen(fgs=random(),bgs=random(),part=0.8):
    if abs(fgs-bgs) < 0.1:
        bgs += 0.1
        fgs -= 0.1
    while True:
        c1 = fgs
        c2 = bgs
        for x in range(columns):
            yield bg_color(*huergb(c1))+color(*huergb(c2))
            c1 += part/columns
            c2 += part/columns

def zipcolor(s,c):
    return "".join((i for x in zip(c,s) for i in x))


def solidlines(n=4,part=0.3):
    s = ""
    cp=random()
    for x in range(columns):
        s += bg_color(*huergb(cp))+" "
        cp += part/columns
    print(s*n)

def printpride(n=3):
    half = n < 5
    s=""
    if half:
        for fg,bg in (("ff0018","ffa52c"),
                      ("ffff41","008018"),
                      ("0000f9","86007d")):
            s+=color(*hexrgb(fg))+bg_color(*hexrgb(bg))+"\u2580"*columns
    else:
        for c in ("ff0018","ffa52c","ffff41","008018","0000f9","86007d"):
            s+=bg_color(*hexrgb(c))+" "*columns*max(1,int(n/6))
    print(s)

def printcheckerboard(n):
    for _ in range(int(n/2)):
        print(" \u2590\u2588"*int(columns/3))
        print("\u2588\u258c "*int(columns/3))

def printnoise(n=4):
    s = ""
    for _ in range(columns*n):
        s+=bg_color(*huergb(random()))+color(*huergb(random()))
        s+=quarterblocks[randint(0,15)]
    print(s)

def printgol(n=6, steps=12, p=0.1):
    f1,f2 = [],[]
    for _ in range(n*2):
        f1.append( [ random() < p for _ in range(columns*2) ])
        f2.append(  [0] * columns*2 )
    for _ in range(steps):
        for x in range(n*2):
            for y in range(columns*2):
                s = 0
                for xo,yo in ((x+1,y-1),(x+1,y  ),(x+1,y+1),
                              (x  ,y-1),          (x  ,y+1),
                              (x-1,y-1),(x-1,y  ),(x-1,y+1)):
                    if xo >= n*2: xo = 0
                    if xo < 0: xo = n*2-1
                    if yo >= columns*2: yo = 0
                    if yo < 0: yo = columns*2-1
                    s += f1[xo][yo]
                if s == 3:
                    f2[x][y] = 1
                elif f1[x][y] and s == 2:
                    f2[x][y] = 1
                else:
                    f2[x][y] = 0
        f1,f2 = f2,f1
    r1 = random()
    r2 = (r1 + 0.1 + random()*0.8)%1
    #s = bg_color(*huergb(r1))+color(*huergb(r2))
    s=""
    for x in range(0,n*2,2):
        for y in range(0,columns*2,2):
            t = f1[x][y] + 2*f1[x][y+1] + 4*f1[x+1][y] + 8*f1[x+1][y+1]
            s += quarterblocks[t]
    s = zipcolor(s,gradientgen())
    print(s)


def printnoise2(n=4):
    if n < 9:
        tb = [2,2,2,3,3,3,4,4,4][n]
    else:
        tb = 5
    a = [[random()  for _ in range(int(columns/(tb+2)))] for _ in range(tb) ]
    for _ in range(n*2): # It's okay to overshoot here...
        place = randint(1,len(a)-1)
        l = [ (x+y+random())/3 for x,y in zip(a[place-1],a[place])]
        a.insert(place,l)
    a=[list(x) for x in list(zip(*a))]
    for _ in range(columns*2):
        place = randint(1,len(a)-1)
        l = [ (x+y+random()/5)/2.2 for x,y in zip(a[place-1],a[place])]
        lp = [ (p-c)/4*random() for p,c in zip(l[:-1],l[1:])]
        ls = [ (s-c)/4*random() for s,c in zip(l[1:],l[:-1])]
        for i in range(len(l)-1):
            l[i] += ls[i]
            l[i+1] += lp[i]
        rot = int(round((2*random()-1)**2))
        l = l[rot:]+l[:rot]
        a.insert(place,l)
    a=[list(x) for x in list(zip(*a))]
    a=[[(x + random()/10)/1.1 for x in l] for l in a]
    s=""
    r = random()/-2
    for x in range(0,2*n,2):
        for y in range(0,2*columns,2):
            nbh = [a[xa][ya] for xa in range(x,x+3) for ya in range(y,y+3)]
            avg = sum(nbh)/9
            inbh = [ [nbh[i] for i in l]
                    for l in ((0,1,3,4),(1,2,4,5),(3,4,6,7),(4,5,7,8)) ]
            ival = [ sum(nbs)/4 for nbs in inbh]
            a1,a2,a3,a4 = ival[0],ival[1],ival[2],ival[3]
            t1,t2,t3,t4 = a1>avg,a2>avg,a3>avg,a4>avg
            t = 1*t1 + 2*t2 + 4*t3 + 8*t4
            c1 = a1*t1 + a2*t2 + a3*t3 + a4*t4
            if c1: c1 /= 1*t1 + 1*t2 + 1*t3 + 1*t4
            c2 = a1*(not t1) + a2*(not t2) + a3*(not t3) + a4*(not t4)
            if c2: c2 /= 1*(not t1) + 1*(not t2) + 1*(not t3) + 1*(not t4)
            c1 = 2*(c1-0.25)
            c2 = 2*(c2-0.25)
            s+=color(*huergb(c1+r))
            s+=bg_color(*huergb(c2+r))
            s+=quarterblocks[t]
    print(s)


 
if __name__ == "__main__":
    n = int(sys.argv[2]) if len(sys.argv) >= 3 else 4
    if n == 0:
        pass
    elif len(sys.argv) == 1:
        solidlines(n)
    elif sys.argv[1] in ["-h","--h","h","help"]:
        usage()
    elif sys.argv[1] in ["grad","gradient"]:
        solidlines(n)
    elif sys.argv[1] in ["pride","gay"]:
        printpride(n)
    elif sys.argv[1] in ["checker","goal"]:
        printcheckerboard(n)
    elif sys.argv[1] in ["noise"]:
        printnoise(n)
    elif sys.argv[1] in ["noise2","noisegrad"]:
        printnoise2(n)
    elif sys.argv[1] in ["gol","game"]:
        printgol(n,p=0.2)
    print("\033[0m",end="")
    

