import numpy as np

# solve system Ax = b
def lower_triangular_solver(A, b):
    x = np.zeros_like(b, dtype='float')
    n = x.shape[0]
    # calculate all xi
    for i in range(n):
        s = 0
        for j in range(0, i):
            s += A[i][j] * x[j]
        x[i]= (b[i] - s)/A[i][i]
    return x

def upper_triangular_solver(A, b):
    ret = lower_triangular_solver(A.T, b.T) # !!!
    return ret

if __name__ == "__main__":
    A = np.array( [ [1,0,0,0,0], [1,2,0,0,0], [1,2,3,0,0], [1,2,3,4,0], [1,2,3,4,5] ], dtype='float' )
    b = np.array( [1,2,3,4,5], dtype='float' ).reshape( (-1,1) )
    # lower triangular solver 
    x = lower_triangular_solver(A,b)
    dot = np.dot(A,x)
    print(x,"\n", dot) # should be = b
    # upper triangular solver 
    x2 = upper_triangular_solver(A.T,b.T)
    dot2 = np.dot(x2.T,A.T) # !!!!
    print(x2,"\n",dot2)