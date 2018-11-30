#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from functools import reduce
from time import time

import matplotlib.pyplot as plt
import numpy as np

def distance(a, b):
    ax, ay = a
    bx, by = b
    return np.sqrt(((bx - ax) ** 2) + ((by - ay) ** 2))

def point_along(point, ab):
    a, b = ab
    return distance(a, point) + distance(b, point) == distance(a, b)

def on_line(point, line):
    return reduce( lambda a, b: a | b
                 , map( lambda ab: point_along(point, ab)
                      , zip(line[:-1], line[1:])
                      )
                 )

def ccw(a, b, c):
    ax, ay = a
    bx, by = b
    cx, cy = c
    return ((cy - ay) * (bx - ax)) > ((by - ay) * (cx - ax))

def check_endpoints(ab, cd):
    a, b = ab
    c, d = cd
    if on_line(a, cd):
        return True
    elif on_line(b, cd):
        return True
    elif on_line(c, ab):
        return True
    elif on_line(d, ab):
        return True
    else:
        return False

def intersect(ab, cd):
    a, b = ab
    c, d = cd
    if ((ccw(a, c, d) != ccw(b, c, d)) & (ccw(a, b, c) != ccw(a, b, d))):
        return True
    else:
        return check_endpoints(ab, cd)

def line_vectors(ab):
    a, b = ab
    ax, ay = a
    bx, by = b
    return ([ax, bx], [ay, by])

def random_point():
    return (round(np.random.random(), 2), round(np.random.random(), 2))

def main():
    a = random_point()
    b = random_point()
    c = random_point()
    d = random_point()
    ab = (a, b)
    cd = (c, d)

    start = time()
    result = intersect(ab, cd)
    timer = time() - start

    for l in [ab, cd]:
        plt.plot(*line_vectors(l), marker="o")
    plt.gca().set_title("{}\nelapsed: {}".format(result, timer))
    plt.tight_layout()
    plt.savefig("intersect.png")
    plt.close()

if __name__ == "__main__":
    main()
