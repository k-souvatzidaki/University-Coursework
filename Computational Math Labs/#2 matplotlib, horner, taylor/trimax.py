import numpy as np

class triangular():

    def isLowerTrig(A):
        for i in range(A.shape[0]): # for each line
            for j in range(i): # checks: [1,0], [2,0] [2,1], [3,0] [3,1] [3,2] : all elements above the diagonal
                if A[i][j] != 0:
                    return False
        return True

    def msg(i):
        if i == -1: return 'not square'
        if i == 0: return 'just square'
        if i == 1: return 'upper triangle'
        if i == 2: return 'lower triangle'
        if i == 3: return 'diagonal'

    def type(a):
        if len(a.shape) != 2: # if not 3 lines
            return -1
        if a.shape[0] != a.shape[1]: # if 1st and 2nd line don't have same length
            return -1
        c1 = triangular.isLowerTrig(a)
        c2 = triangular.isLowerTrig(a.T) # == lower trig
        if c1 and c2:
            return 3 # if upper and lower triangular => diagonal
        elif c1:
            return 2
        elif c2:
            return 1
        else:
            return 0 # just a square matrix


# main
if __name__ == "__main__":
    A = np.eye(7) # diagonal
    B = np.zeros( (7,7) ) # diagonal 
    C = np.ones( (10,3) ) # not square
    D = np.eye(7)
    D[0,6] = 1 # upper triangular, D.T == lower triangular
    E = D + D.T # just square
    matrices = [A,B,C,D,D.T,E]
    for a in matrices:
        result = triangular.type(a)
        print(triangular.msg(result))