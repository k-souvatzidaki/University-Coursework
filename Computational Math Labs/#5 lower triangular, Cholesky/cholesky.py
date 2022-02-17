import numpy as np

def cholesky(a):
    L = np.zeros_like(a)
    n = a.shape[0]
    for j in range(n): 
        for i in range(j,n):   
            if i == j:
                s = 0
                for k in range(j):
                    s += L[i][k]**2
                L[i][j] = (a[i][j] - s) ** 0.5
            else:
                s = 0
                for k in range(j):
                    s += L[i][k] * L[j][k]
                L[i][j] = (a[i][j] - s) / L[j][j]
    return L

if __name__ == "__main__":
    A = np.array( [ [1,0,0,0,0], [1,2,0,0,0], [1,2,3,0,0], [1,2,3,4,0], [1,2,3,4,5] ], dtype='float' )
    S = np.dot(A.T, A) # matrix multiplication
    print(S)
    L = cholesky(S)
    print(L)
    print(np.dot(L,L.T)) # must be same as S