import numpy as np
print('Numpy Version:', np.__version__) #prints version of numpy

#create arrays 
print("1) 0-D arrays - scalar values")
a = np.array(20)
print("Type(a) = ", type(a)) #<type 'numpy.ndarray'>
print("a = ", a) #20
print("Shape = ", a.shape) #()
print("Type(a.item()) = " ,type(a.item())) #<type int>
print("a[0] = IndexError: too many indices for array")
print()

print("2) 1-D arrays - list of 0-D arrays")
a = np.array([20,30,40])
print("a = ", a) # [20 30 40]
print("Shape = ", a.shape) #(3,)
print("Type(a.item()) = ValueError: can only convert an array of size 1 to a Python scalar")
print("a[0] = ", a[0]) #20
print()

print("3) 2-D arrays - list of 1-D arrays")
a = np.array([
                [20,30,40],
                [50,60,70]
            ])
print("a = ", a) # [[20 30 40][50 60 70]]
print("Shape = ", a.shape) #(2,3) 2 rows 3 columns
print("a[0] = ", a[0]) # [20 30 40]
print("a[0,1] = ", a[0,1]) # 30
print("a[0][1] = ", a[0][1]) # 30
print()

print("4) 3-D arrays - list of 2-D arrays (N-D = list of (N-1)-D arrays)")
a = np.array([
                [
                    [20,30,40],
                    [50,60,70]
                ],
                [
                    [21,31,41],
                    [51,61,71]
                ]
            ])
print("a = ", a) # [[[20 30 40][50 60 70]] [[21 31 41][51 61 71]]]
print("Shape = ", a.shape) #(2,2,3) 2 rows of 2 arrays with 3 columns
print("a[0] = ", a[0]) # [20 30 40][50 60 70]
print("a[0,1] = ", a[0,1]) # [50 60 70]
print("a[0,1,2] = ", a[0,1,2]) # 70
print()

#array methods
#all zeros 
a = np.zeros((5,5,10)) #a.shape = (5,5,10
print(a, '\n')

#all ones 
a = np.ones((10,10)) #a.shape = (10,10)
print(a,'\n')

#identity matrix
a = np.eye(7) #a.shape = (7,7)
print(a,'\n')
a = np.eye(7,10) #a.shape = (7,10)
print(a , '\n')

#matrix full of a value 
a = np.full((5,5),4) #a.shape = (5,5)
print(a ,'\n')

#2d array iteration
a = np.array( [ [43,42], [10,5], [27,8], [85,52] ] )
for i in range( a.shape[0] ):
    for j in range( a.shape[1] ):
        print(a[ i,j ])
print

#arange(n): return array with numbers from 0 to n-1
a = np.arange(100) #a.shape = (100,)
print(a, '\n')

#subarrays: array[ firstRow:lastRow+1, firstCol:lastCol+1, ... ]
a = np.array([[1,2,3,4,5],[6,7,8,9,10]])
print(a[0:1 , 2:5],'\n') #[[3 4 5]]
a[0:1 , 2:5] = 50
print(a[0:1 , 2:5],'\n') #[[50 50 50]]

#reshape: change the shape of array 
a = np.arange(10).reshape((1,1,1,1,1,1,10))
print(a) #[[[[[[[0 1 2 3 4 5 6 7 8 9]]]]]]]
print(a.shape) #(1, 1, 1, 1, 1, 1, 10)
a = a.reshape((2,5))
print(a) #[[0 1 2 3 4][5 6 7 8 9]]
print(a.shape, '\n') #(2,5)

#transpose: np.tranpose or T attribute 
print(a.T) #[[0 5][1 6][2 7][3 8][4 9]]
print(np.transpose(a).T) #a [[0 1 2 3 4][5 6 7 8 9]]

#1-D arrays have shape (n,)!! transpose : 
a = np.array([1,2,3])
print(a) #[1,2,3]
print(a.T) #[1,2,3]
print(a.shape) #(3,)
print(a.T.shape) #(3,)
print(a.T.T.shape, '\n')#(3,)

#Exercise: What do you notice at the result of the tranpose? Is it correct? Justify your answer.
#Solution: When the shape is (N,), the shape of the tranpose cannot be changed to (,N)
#First solution: We could declare the array as 2D, but that would result in a row-vector. 
#If you would like it in column-vector form use .T attribute at its end.
a = np.array([[1,2,3]])
print(a.shape) #(1,3)
print(a.T) #[[1][2][3]]
print(a.T.shape,'\n') #(3,1)
#Second solution: Use reshape. 
a = np.array([1,2,3]).reshape(-1,1) #same as reshape(3,1), -1 is replaced by 3 as it is the only unknown variable
print(a) #[[1][2][3]]
print(a.shape) #(3,1)
print(a.T) #[[1 2 3]]
print(a.T.shape, '\n') #(1,3)

#copy: with = (DEEP COPY)
a = np.array( [ [1,2,3,4,5], [1,2,3,4,5] ] )
b = a
print(b) #[[1 2 3 4 5][1 2 3 4 5]]
print(a) #[[1 2 3 4 5][1 2 3 4 5]]
a[0,1] = 7 
print(b) #[[1 7 3 4 5][1 2 3 4 5]]
print(a,'\n') #[[1 7 3 4 5][1 2 3 4 5]]

#copy: with .copy() (SHALLOW COPY)
b = a.copy()
a[0,1] = 10
print(b) #[[1 7 3 4 5][1 2 3 4 5]]
print(a,'\n') #[[1 10 3 4 5][1 2 3 4 5]]

#for nested sequences/lists use deepcopy from copy library
from copy import deepcopy

#concatenate
a = np.array( [ [1,2,3,4,5], [1,2,3,4,5] ] )
#horizontal
b = np.concatenate( [ a, a ], axis=0 )
print(b) #[[1 2 3 4 5][1 2 3 4 5][1 2 3 4 5][1 2 3 4 5]]
#vertical
b = np.concatenate( [ a, a ], axis=1 )
print(b, '\n') #[[1 2 3 4 5 1 2 3 4 5][1 2 3 4 5 1 2 3 4 5]]

#EXERCISE 
#Exercise:
# B = [[1 4 7][2 5 8][3 6 9]]
#Create matrix  I3B
#Note: B is the transpose of [[1 2 3][4 5 6][7 8 9]]
#Note: I3 is [[1 0 0][0 1 0][0 0 1]]
b = np.arange(9).reshape(3,3).T +1
i3 = np.eye(3)
i3b = np.concatenate([i3,b], axis=1)
print(i3b) #[1 0 0 1 2 3][0 1 0 4 5 6][0 0 1 7 8 9]]
print()

# split
a = np.arange(20) + 1
b = np.array_split(a , 5) # [array([1 2 3 4]), array([5 6 7 8]), array([9 10 11 12]), array([13 14 15 16]), array([17 18 19 20])]
print(b) 
print()

# random
b = np.random.random((10,3)) #10x3 array of random numbers in [0,1)
print(b)
a = np.random.permutation(10)[0:3] #3 element array of random ints in [0,10)
print(a)
print(b[a]) #prints 3 lines of the array (with the random numbers as indexes)
print()

# Dtype
# Arrays are defined to be within a data type ex. np.float32, np.float64, np.int8, np.int16, np.32, np.in64
a = np.arange(10).reshape( (2,5) )
b = np.array( [ [2.5,3.2], [6.8,8.9] ] )
print(a.dtype) #dtype('int32')
print(b.dtype) #dtype('float64')
#!!!! 
c = np.array( [ [2.5,3.2], [6.8,8.9] ], 
             dtype=np.float32 )
print(c) # array([[2.5, 3.2], [6.8, 8.9]])
print(c.dtype) #float32 insted of float64
#BUT
e = np.array( [ [2.5,3.2], [6.8,8.9] ], 
             dtype=np.int32 )
print(e) #[[2,3][6,8]]
print(e.dtype) #int32

# to convert to another dtype ==> astype function
g = c.astype(np.int32)
print(g) #[[2,3][6,8]]
d = np.array( [ [3,5], [8,13] ], dtype=np.int8 )
f = d.astype( np.float64 ) # [[3.,5.], [8.13.]]
print(f)
print(f.dtype) #dtype('float64')
print()

# Operations between matrices
# Addition - Elementwise
a = np.arange(25).reshape( (5,5) ) 
print(a + a) #array([[ 0,  2,  4,  6,  8],[10, 12, 14, 16, 18],[20, 22, 24, 26, 28],[30, 32, 34, 36, 38],[40, 42, 44, 46, 48]])
# same with subtraction and multiplication
print(a-a)
print(a*a)
print(np.multiply(a,a))

# Matrix Multiplication: AxB=C, NxM × MxN =NxN - np.dot
print(np.dot(a,a)) # array([[ 150,  160,  170,  180,  190],[ 400,  435,  470,  505,  540],[ 650,  710,  770,  830,  890],[ 900,  985, 1070, 1155, 1240],[1150, 1260, 1370, 1480, 1590]])

# Matrix x vector: A × x=b, (N×m) × (M×1) =N×1 - np.dot
x = np.array( [0,5,10,15,20] ).reshape( (-1,1) ) # array with 5 lines and 1 column
print(x) # array([[0][5][10][15][20]])
print(np.dot(a,x)) # array([[ 150], [ 400], [ 650],[ 900],[1150]]) #the first column of a x a

# Vector x Vector
# Dot/Inner/Scalar product 
print(np.dot(x.T,x)) # array([[750]])
# for elementwise: * or np.multiply (like arrays)