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

import os, random, sys
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
"""
    print(s)





def color(r,g,b): return "\033[38;2;"+str(r)+";"+str(g)+";"+str(b)+"m"
def bg_color(r,g,b): return "\033[48;2;"+str(r)+";"+str(g)+";"+str(b)+"m"

def hexrgb(h): return int(h[:2],base=16),int(h[2:4],base=16),int(h[4:6],base=16)
def huergb(p):
    h = (p*6)%1.0
    c = 255
    x = int(255 * (h))
    i = int(p*6)%6
    return [ (c,x,0), (255-x,c,0), (0,c,x), (0,255-x,c), (x,0,c), (c,0,255-x) ][i]



def solidlines(n=4,part=0.3):
    s = ""
    cp=random.random()
    for x in range(columns):
        s += bg_color(*huergb(cp))+" "
        cp += part/columns
    print(s*n+"\033[0m")

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


def printnoise(n=100):
    s = ""
    b = " \u2596\u2597\u2598\u2599\u259a\u259b\u259c\u259d\u259e\u259f\u2580\u2584\u2588\u2590\u258c"
    for _ in range(columns*n):
        s+=bg_color(*huergb(random.random()))+color(*huergb(random.random()))
        s+=b[random.randint(0,15)]
    print(s)


if __name__ == "__main__":
    n = int(sys.argv[2]) if len(sys.argv) >= 3 else 4
    if len(sys.argv) == 1:
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
    

