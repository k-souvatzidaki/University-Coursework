import numpy as np
from math import *

# print a random number in range [0,1)
def nums_1(): 
    return np.random.random()

# print a random number in range [a,b]
def nums_2(a,b):
    x = b-a
    # print a random number in range [0,x)
    temp = np.random.random()*x
    # print a random number in range [a,b]
    return np.random.random()*x + a

# print a random integer in range [n,m] when n and m are integers
def nums_3(n,m):
    x = m-n
    return np.array(np.random.random()*x + n).astype("int32")

# main
if __name__ == "__main__":
    a,b,c,d = 1,4,2,5
    # print a random number in range [a,b]
    print("Random number in [",a,",",b,"]:",nums_2(1,4))
    # print a random number in range [a,b]x[c,d]
    print("Random number in [",a,",",b,"] x [",c,",",d,"]:",nums_2(a,b),",",nums_2(c,d))
    # print a random integer in range [n,m] when n and m are integers
    print("Random integer in [",a,",",d,"]:",nums_3(a,d))
