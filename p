#!/usr/bin/python3


import os, random
columns = int(os.popen('/bin/stty size', 'r').read().split()[1])


def set_color(r,g,b): return "\033[38;2;"+str(r)+";"+str(g)+";"+str(b)+"m"
def set_bg_color(r,g,b): return "\033[48;2;"+str(r)+";"+str(g)+";"+str(b)+"m"

def color(p):
    h = (p*6)%1.0
    c = 255
    x = int(255 * (h))
    i = int(p*6)%6
    return [ (c,x,0), (255-x,c,0), (0,c,x), (0,255-x,c), (x,0,c), (c,0,255-x) ][i]



s = ""
cp=random.random()
for x in range(columns):
    s += set_bg_color(*color(cp))+" "
    cp += 1/(columns*3)

print(s*4+"\033[0m")
