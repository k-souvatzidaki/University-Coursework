import numpy as np
from math import *

def horner(a,x0):
    b = np.zeros_like( a ) # an array of zeroes with the same shape as a [[0][0][0][0][0][0]]
    b[0] = a[0] # start with the first a0 of first term a0*x^n
    for i in range(1, b.shape[0]): # for all terms of the equation
        b[i] = x0 * b[i-1] + a[i] # b[1] = x0 * a0 + a1, b[2] = x0 * a1 + a2, etc...
    return(b,b[-1].item()) # return the last b (horner's result)

def derivative(a,x0,k):
    k_factorial = factorial(k)
    for i in range (0,k+1):
        a, n = horner(a,x0)
        a = a[0:a.size-1]
    return n*k_factorial

# main
if __name__ == "__main__":
    a = np.array( [ [ 3, 0, -2, 0, 1, 0 ] ] ).T #[[3][0][-2][0][1][0]]
    # or
    # b = np.array( [ [ 3, 0, -2, 0, 1, 0 ] ]).reshape(-1,1)
    # print(a == b) # [[True][True][True][True][True][True]]
    x0 = -2
    print("the result is",horner(a,x0))

    # bonus: calculate kth derivative
    k = 1
    n = derivative(a,x0,k)
    print("the", k,"derivative is ",n)