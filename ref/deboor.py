#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# via https://stackoverflow.com/questions/34803197/fast-b-spline-algorithm-with-numpy-scipy

import numpy as np

def cox_deboor(knots, u, k, d):
    if d == 0:
        if (knots[k] <= u) & (u < knots[k + 1]):
            return 1
        return 0
    else:
        den1 = knots[k + d] - knots[k]
        den2 = knots[k + d + 1] - knots[k + 1]

        if den1 > 0:
            eq1 = ((u - knots[k]) / den1) * cox_deboor(knots, u, k, (d - 1))
        else:
            eq1 = 0

        if den2 > 0:
            eq2 = ((knots[k + d + 1] - u) / den2) * \
                cox_deboor(knots, u, (k + 1), (d - 1))
        else:
            eq2 = 0

        return eq1 + eq2

def bspline(cv, n=100, d=3, closed=False):
    # cv = np.array of 3d control vertices
    # n = number of samples (default: 100)
    # d = curve degree (default: cubic)
    # closed = is the curve closed (periodic) or open? (default: open)
    count = len(cv)
    if not closed:
        u = np.arange(0, n, dtype="float") / (n - 1) * (count - d)
        knots = np.array( [0] * d
                        + list(range(count - d + 1))
                        + [count - d] * d, dtype="int"
                        )
    else:
        u = ( (np.arange(0, n, dtype="float") / (n - 1) * count)
            - (0.5 * (d - 1))
            ) % count
        knots = np.arange(0 - d, count + (d * 2) - 1, dtype="int")

    samples = np.zeros((n, 3))
    for i in range(n):
        if not closed:
            if u[i] == count - d:
                samples[i] = np.array(cv[-1])
            else:
                for k in range(count):
                    samples[i] += cox_deboor(knots, u[i], k, d) * cv[k]
        else:
            for k in range(count + d):
                samples[i] += cox_deboor(knots, u[i], k, d) * cv[k % count]

    return samples

def init_cv():
    return np.asarray([ [ 50.0, 25.0,  0.0]
                      , [ 59.0, 12.0, -1.0]
                      , [ 50.0, 10.0,  1.0]
                      , [ 57.0,  2.0,  2.0]
                      , [ 40.0,  4.0, -1.0]
                      , [ 40.0, 14.0,  0.0]
                      ])

if __name__ == "__main__":
    import matplotlib.pyplot as plt

    def test(closed):
        cv = init_cv()
        p = bspline(cv, n=100, d=3, closed=closed)
        x, y, _ = p.T
        cv = cv.T

        plt.plot(cv[0], cv[1], "o-", label="Control Points")
        plt.plot(x, y, "k-", label="Curve")
        plt.xlabel("x")
        plt.ylabel("y")

        plt.legend()
        plt.gca().set_aspect("equal", adjustable="box")
        plt.tight_layout()
        plt.show()

    test(closed=False)