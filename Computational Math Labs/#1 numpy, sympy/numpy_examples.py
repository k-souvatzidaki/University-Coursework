import numpy as np
print('Numpy Version:', np.__version__) #prints version of numpy

class numpy_examples():
    # ================ Create Arrays ================
    def create_0d_array(self):
        print("0-D arrays - scalar values")
        a = np.array(20)
        print("Type(a) = ", type(a)) # <type 'numpy.ndarray'>
        print("a = ", a) # 20
        print("Shape = ", a.shape) # ()
        print("Type(a.item()) = " ,type(a.item())) # <type int>
        try:
            print(a[0])
        except:
            print("IndexError: too many indices for array \n")

    def create_1d_array(self):
        print("1-D arrays - list of 0-D arrays")
        a = np.array([20,30,40])
        print("a = ", a) # [20 30 40]
        print("Shape = ", a.shape) # (3,)
        try:
            print(type(a.item()))
        except:
            print("ValueError: can only convert an array of size 1 to a Python scalar")
        print("a[0] = ", a[0], '\n') # 20

    def create_2d_array(self):
        print("2-D arrays - list of 1-D arrays")
        a = np.array([
                        [20,30,40],
                        [50,60,70]
                    ])
        print("a = ", a) # [[20 30 40][50 60 70]]
        print("Shape = ", a.shape) # (2,3) 2 rows 3 columns
        print("a[0] = ", a[0]) # [20 30 40]
        print ("Shape[0] = ",a.shape[0]) # !!! 2
        print("a[0,1] = ", a[0,1]) # 30
        print("a[0][1] = ", a[0][1], '\n') # 30

    def create_3d_array(self):
        print("3-D arrays - list of 2-D arrays (N-D = list of (N-1)-D arrays)")
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
        print("Shape = ", a.shape) # (2,2,3) 2 rows of 2 arrays with 3 columns
        print("a[0] = ", a[0]) # [20 30 40][50 60 70]
        print("a[0,1] = ", a[0,1]) # [50 60 70]
        print("a[0,1,2] = ", a[0,1,2], '\n') # 70


    # ================ Array Methods ================
    # all zeros 
    def all_zeroes(self):
        print("an array of zeros")
        a = np.zeros((5,5,10))
        print("Shape = ", a.shape) # (5,5,10)
        print(a, '\n')

    # all ones
    def all_ones(self): 
        print("an array of ones")
        a = np.ones((10,10)) 
        print("Shape = ", a.shape) # (10,10)
        print(a,'\n')

    # identity matrix
    def identity_matrix(self):
        print("the identity matrix")
        a = np.eye(7) #a.shape = (7,7)
        print("Shape = ", a.shape) # (7,7)
        print(a,'\n')
        a = np.eye(7,10) 
        print("Shape = ", a.shape) # (7,10)
        print(a , '\n')
        a = np.eye(5,10,4) 
        print("Shape = ", a.shape) # !!! (5,10)
        print(a , '\n') #!!!! it's the eye matrix with 4 zero columns first
        a = np.eye(5,10,10)
        print(a,'\n') # array of 0s!!

    # matrix full of a value 
    def full_val(self):
        print("an array full of a value")
        a = np.full((5,5),4)
        print("Shape = ", a.shape) # (5,5)
        print(a ,'\n')

    # array with numbers from 0 to n-1
    def arange_n(self):
        print("an array with numbers from 0 to n-1")
        a = np.arange(100) 
        print("Shape = ", a.shape) # (100,)
        print(a, '\n')

    # linear space
    def lin_space(self):
        print("a linear space")
        l = np.linspace(0,10,5)
        print (l) # [ 0. 2.5  5. 7.5 10. ]
        print("Shape = ", l.shape) # (5,)
        k = np.linspace(0,10,5, endpoint=False)
        print (k) # [0. 2. 4. 6. 8.]
        print("Shape = ", k.shape, '\n') # (5,)


    # ================ 2D Array Iteration ================
    def iter_2d(self):
        print("iterate a 2-d array")
        a = np.array( [ [43,42], [10,5], [27,8], [85,52] ] )
        for i in range( a.shape[0] ):
            for j in range( a.shape[1] ):
                print(a[ i,j ])
        print('\n')


    # ================ Subarrays ================
    def sub_arrays(self):
        print("subarray = array[ firstRow:lastRow+1, firstCol:lastCol+1, ... ]")
        a = np.array([[1,2,3,4,5],[6,7,8,9,10]])
        print(a[0:1 , 2:5],'\n') #[[3 4 5]]
        a[0:1 , 2:5] = 50
        print(a[0:1 , 2:5],'\n') #[[50 50 50]]


    # ================ Array for List or Tuple ================
    def list_vs_tuple(self): 
        print("we can create arrays from lists and tuples")
        list = [1,2,3]
        tuple = (4,5,6)
        arr1 = np.asarray(list)
        arr2 = np.asarray(tuple)
        print (arr1) # [1 2 3]
        print (arr2) # [4 5 6]
        print (type(arr1), '\n') # <class 'numpy.ndarray'>


    # ================ Reshape ================
    #reshape: change the shape of array 
    def reshape_example_1(self):
        print("reshape example 1 (2020)")
        a = np.arange(10).reshape((1,1,1,1,1,1,10))
        print(a) #[[[[[[[0 1 2 3 4 5 6 7 8 9]]]]]]]
        print("Shape = ", a.shape) #(1, 1, 1, 1, 1, 1, 10)
        a = a.reshape((2,5))
        print(a) #[[0 1 2 3 4][5 6 7 8 9]]
        print("Shape = ", a.shape, '\n') #(2,5)

    def reshape_example_2(self): 
        print("reshape example 2 (2021)")
        b = np.arange(20)
        c = b.reshape((2,10))
        print(c) # [[ 0  1  2  3  4  5  6  7  8  9][10 11 12 13 14 15 16 17 18 19]]
        d = b.reshape((5,2,2))
        print(d) # [[[ 0  1][ 2  3]] [[ 4  5][ 6  7]] [[ 8  9][10 11]] [[12 13][14 15]] [[16 17][18 19]]]
        try:
            f = b.reshape((4,3))
        except:
            print("ValueError: cannot reshape array of size 20 into shape (4,3) \n")

    def reshape_example_3(self):
        print("reshape example 3 (2021)")
        a = np.array([1,2,3])
        try:
            b = a.reshape(1,5)
        except:
            print("ValueError: cannot reshape array of size 3 into shape (1,5)")
            b = a.reshape(1,3)
        print (b) # [[1 2 3]] (shape (1,3))
        print (b.T) # [[1] [2] [3]] (shape (3,1))
        c = a.reshape(1,-1)
        print (c) # [[1 2 3]]
        d = a.reshape(-1,1)
        print (d,'\n') # [[1] [2] [3]]


    # ================ Transpose ================
    #transpose: np.tranpose or T attribute 
    def transpose_examples(self):
        print("2d array transpose")
        a = np.arange(10).reshape(2,5)
        print(a.T) #[[0 5][1 6][2 7][3 8][4 9]]
        print(np.transpose(a).T) # a [[0 1 2 3 4][5 6 7 8 9]]
        print(a.T.T) # a
        print(np.transpose(a.T)) # a

    def transpose_1d(self):
        #1-D arrays have shape (n,)!! transpose : 
        print("1d array transpose")
        a = np.array([1,2,3])
        print(a) #[1,2,3]
        print(a.T) #[1,2,3]
        print(a.shape) #(3,)
        print(a.T.shape) #(3,)
        print(a.T.T.shape, '\n')#(3,)


    # ================ Exercise 1 ================
    #Exercise: What do you notice at the result of the tranpose? Is it correct? Justify your answer.
    #Solution: When the shape is (N,), the shape of the tranpose cannot be changed to (,N)
    #First solution: We could declare the array as 2D, but that would result in a row-vector. 
    #If you would like it in column-vector form use .T attribute at its end.
    def exercise_1(self):
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


    # ================ Copy ================
    def deep_copy(self):
        print("copy with = (DEEP COPY)")
        a = np.array( [ [1,2,3,4,5], [1,2,3,4,5] ] )
        b = a
        print(b) #[[1 2 3 4 5][1 2 3 4 5]]
        print(a) #[[1 2 3 4 5][1 2 3 4 5]]
        a[0,1] = 7 
        print(b) #[[1 7 3 4 5][1 2 3 4 5]]
        print(a,'\n') #[[1 7 3 4 5][1 2 3 4 5]]

    def shallow_copy(self):
        print("copy with .copy() (SHALLOW COPY)")
        a = np.array( [ [1,2,3,4,5], [1,2,3,4,5] ] )
        b = a.copy()
        a[0,1] = 10
        print(b) #[[1 2 3 4 5][1 2 3 4 5]]
        print(a,'\n') #[[1 10 3 4 5][1 2 3 4 5]]

    #for nested sequences/lists use deepcopy from copy library
    from copy import deepcopy


    # ================ Concatenate ================
    def concat_examples(self):
        print("concatenate examples")
        a = np.array( [ [1,2,3,4,5], [1,2,3,4,5] ] )
        #horizontal
        b = np.concatenate( [ a, a ], axis=0 )
        print(b) #[[1 2 3 4 5][1 2 3 4 5][1 2 3 4 5][1 2 3 4 5]]
        #vertical
        b = np.concatenate( [ a, a ], axis=1 )
        print(b, '\n') #[[1 2 3 4 5 1 2 3 4 5][1 2 3 4 5 1 2 3 4 5]]


    # ================ Exercise 2 ================
    #Exercise:
    # B = [[1 4 7][2 5 8][3 6 9]]
    #Create matrix  I3B
    #Note: B is the transpose of [[1 2 3][4 5 6][7 8 9]]
    #Note: I3 is [[1 0 0][0 1 0][0 0 1]]
    def exercise_2(self):
        b = np.arange(9).reshape(3,3).T +1
        i3 = np.eye(3)
        i3b = np.concatenate([i3,b], axis=1)
        print(i3b, '\n') #[1 0 0 1 2 3][0 1 0 4 5 6][0 0 1 7 8 9]]


    # ================ Split ================
    def split_example(self):
        print("split array to list of subarrays")
        a = np.arange(20) + 1
        b = np.array_split(a , 5) # [array([1 2 3 4]), array([5 6 7 8]), array([9 10 11 12]), array([13 14 15 16]), array([17 18 19 20])]
        print(b) 
        print(type(b)) # <class 'list'>
        print(b[0]) # [1 2 3 4]
        print(type(b[0]),'\n') # <class 'numpy.ndarray'>


    # ================ Random ================
    def random_example(self):
        print("create arrays with random REAL numbers")
        b = np.random.random((10,3)) #10x3 array of random numbers in [0,1)
        print(b)
        print(b*10) # all elements multiplied with 10
        a = np.random.random((3,4))*10
        print(b, '\n') # 10x3 array of random numbers in [0,1), all elements multiplied with 10

    def permutation_example(self):
        print("permutation changes the order of elements in random")
        b = np.random.random((10,3))
        a = np.random.permutation(10)[0:3] #3 element array of 3 of the ints in [0,9]
        print(a)
        print(b[a]) #use the 3 integers as indexes to print 3 lines of b
        print (np.random.permutation(b),'\n') # randomly change the order of elements in the 1st dimension of the array (in 2d array: lines)


    # ================ DType ================
    def dtype_examples(self):
        print("various examples with dtype")
        # Arrays are defined to be within a data type ex. np.float32, np.float64, np.int8, np.int16, np.32, np.in64
        a = np.arange(10).reshape( (2,5) )
        b = np.array( [ [2.5,3.2], [6.8,8.9] ] )
        print(a.dtype) #dtype('int32')
        print(b.dtype) #dtype('float64')
        #!!!! 
        c = np.array( [ [2.5,3.2], [6.8,8.9] ], dtype=np.float32 )
        print(c) # array([[2.5, 3.2], [6.8, 8.9]])
        print(c.dtype) #float32 insted of float64
        #BUT
        e = np.array( [ [2.5,3.2], [6.8,8.9] ], dtype=np.int32 )
        print(e) #[[2,3][6,8]]
        print(e.dtype) #int32
        # to convert to another dtype ==> astype function
        g = c.astype(np.int32)
        print(g) #[[2,3][6,8]]
        d = np.array( [ [3,5], [8,13] ], dtype=np.int8 )
        f = d.astype( np.float64 ) # [[3.,5.], [8.13.]]
        print(f)
        print(f.dtype, '\n') #dtype('float64')


    # ================ Operations between matrices ================
    def elementwise(self):
        print("elentwise operations")
        # Addition - Elementwise
        a = np.arange(25).reshape( (5,5) ) 
        print(a + a) #array([[ 0,  2,  4,  6,  8],[10, 12, 14, 16, 18],[20, 22, 24, 26, 28],[30, 32, 34, 36, 38],[40, 42, 44, 46, 48]])
        # same with subtraction and multiplication
        print(a-a)
        print(a*a)
        print(np.multiply(a,a),'\n')

    def matrix_x_matrix(self):
        print("multiplication of matrices")
        a = np.arange(25).reshape( (5,5) ) 
        # Matrix Multiplication: AxB=C, NxM × MxN =NxN - np.dot
        print(np.dot(a,a),'\n') # array([[ 150,  160,  170,  180,  190],[ 400,  435,  470,  505,  540],[ 650,  710,  770,  830,  890],[ 900,  985, 1070, 1155, 1240],[1150, 1260, 1370, 1480, 1590]])

    def invalid_dot(self):
        print("more dot examples")
        b = np.arange(10).reshape(2,5)
        c = np.arange(10).reshape(5,2)
        print (b) #[[0 1 2 3 4] [5 6 7 8 9]]
        print (c) # [[0 1] [2 3] [4 5] [6 7] [8 9]]
        print (np.dot(b,c)) # [[ 60  70] [160 195]]
        print (np.dot(c,b)) # [[  5   6   7   8   9] [ 15  20  25  30  35] [ 25  34  43  52  61] [ 35  48  61  74  87] [ 45  62  79  96 113]]
        try:
            print (np.dot(b,b))
        except:
            print("ValueError: shapes (2,5) and (2,5) not aligned: 5 (dim 1) != 2 (dim 0) \n")

    def matrix_x_vector(self):
        print("multiplication of matrix with vector")
        # Matrix x vector: A × x=b, (N×m) × (M×1) =N×1 - np.dot
        a = np.arange(25).reshape( (5,5) ) 
        x = np.array( [0,5,10,15,20] ).reshape( (-1,1) ) # array with 5 lines and 1 column
        print(x) # array([[0][5][10][15][20]])
        print(np.dot(a,x),'\n') # array([[ 150], [ 400], [ 650],[ 900],[1150]]) #the first column of a x a

    def vector_x_vector(self):
        print("multiplication of vector with vector")
        # Vector x Vector
        # Dot/Inner/Scalar product 
        x = np.array( [0,5,10,15,20] ).reshape( (-1,1) )
        print(np.dot(x.T,x),'\n') # array([[750]])
        # for elementwise: * or np.multiply (like arrays)


    # ================ Sum and Average ================
    def sum_avg(self):
        print("elements sum and average examples")
        a = np.array([ [0,1], [0,5], [2,4]])
        print (np.sum(a)) #12
        print (np.sum(a, axis=0)) # [ 2 10]
        print (np.sum(a, axis=1)) # [1 5 6]
        print (np.average(a)) # 2.0
        print (np.average(a,axis=0)) # [0.66666667 3.33333333]
        print (np.average(a,axis=1),'\n') # [0.5 2.5 3. ]


    # ================ Broadcast ================
    def broadcast_example(self):
        print("broadcast example")
        # Broadcast : when there is a mismatch in array shapes during operations, replicate to match the dimension of the matrix the operation is done with 
        #ex. addition
        a = np.zeros( (5,5) )
        b = np.array( [1,2,3,4,5] ).reshape( (-1,1) ) #array([[1],[2],[3],[4],[5]])
        # broadcast per row: 
        print(a + b.T) # array([[1., 2., 3., 4., 5.], [1., 2., 3., 4., 5.], [1., 2., 3., 4., 5.], [1., 2., 3., 4., 5.], [1., 2., 3., 4., 5.]])
        print(a.T + b) # same
        print(a + b, '\n') # same


    # ================ Exercise 3 ================
    def exercise_3(self):
        #Exercise: For each cell calculate its percentage per row
        a = np.array( [ [1,1,2], [24,42,12], [10,20,30], [80,40,20] ] ).T # [[1 24 10 80][1 42 20 40][2 12 30 20]]
        # np.sum( a, axis=0 ) is the sum of each column (that's why we T - the sum of T's column = sum of a's line)
        v = np.sum(a,axis = 0) # [4 78 60 140]
        v = v.reshape(1,-1) # make v in row-vector form -> (1,4) to apply the / operator and broadcast it to each row
        # % = value / total
        print(a/v) # 3 x 4 array of %s (floats in [0,1])
        try: 
            print(a.T/v)
        except: 
            print("ValueError: operands could not be broadcast together with shapes (4,3) (1,4) \n")


    # ================ Tile ================
    def tile_example_1(self):
        print("repeat pattern")
        # Tile : Instead of broadcasting we can repeat the pattern using the np.tile( array, shape )
        a = np.array( [1,2,3] ).reshape( (-1,1) ) # [[1][2][3]]
        print(np.tile(a,(1,1))) # same
        print(np.tile(a,(1,10))) # [[1 1 1 1 1 1 1 1 1 1][2 2 2 2 2 2 2 2 2 2][3 3 3 3 3 3 3 3 3 3]]
        print(np.tile(a,(3,1))) # [[1][2][3][1][2][3][1][2][3]]
        print(np.tile(a, (2,3)),'\n') # [[1 1 1][2 2 2][3 3 3][1 1 1][2 2 2][3 3 3]]

    def tile_example_2(self):
        print("another tile example")
        b = np.arange(10)
        print (np.tile(b, (1,3))) # [[0 1 2 3 4 0 1 2 3 4 0 1 2 3 4] [5 6 7 8 9 5 6 7 8 9 5 6 7 8 9]]
        print (np.tile(b, (4,1))) # [[0 1 2 3 4] [5 6 7 8 9] [0 1 2 3 4] [5 6 7 8 9] [0 1 2 3 4] [5 6 7 8 9] [0 1 2 3 4] [5 6 7 8 9]]
        print (np.tile(b, (2,3)),'\n') # [[0 1 2 3 4 0 1 2 3 4 0 1 2 3 4] [5 6 7 8 9 5 6 7 8 9 5 6 7 8 9] [0 1 2 3 4 0 1 2 3 4 0 1 2 3 4] [5 6 7 8 9 5 6 7 8 9 5 6 7 8 9]]


    # ================ Other Operations (determinant, inversion, argmax) ================
    # Other operations
    # Determinant 
    def determinant(self):
        print('determinant examples')
        a = np.array( [ [10,20], [30,40] ] ) #[[10 20][30 40]]
        b = np.linalg.det(a) 
        print(b,'\n') # |a| = -200.00000000001

    # Inversion 
    def inversion(self):
        print('inversion example')
        a = np.array( [ [10,20], [30,40] ] ) #[[10 20][30 40]]
        b = np.linalg.inv(a) # [[-0.2 0.1][0.15 -0.05]]
        print(b)

    def det_inv(self): 
        print("another example with det and inv")
        # another example
        a = np.array( [[1,1],[0,2]] )
        x = np.linalg.det(a)
        print (x) # 2.0
        b = np.linalg.inv(a)
        print (b) # [[ 1.  -0.5] [ 0.   0.5]]
        print (np.dot(a,b)) # [[1. 0.] [0. 1.]]
        print (np.dot(b,a),'\n') # [[1. 0.] [0. 1.]]

    # Argmax 
    def argmax_example(self):
        # This kind of encoding is known as one-hot vector in machine learning. Instead of zeros and ones it could have real values to represent probabilities. 
        # Each row represent its percentage to be classified to a specific category(e.x. 5 columns = 5 classes/categories ). 
        # So argmax per row would choose the category/index that has the maximum probability/value.
        a = np.eye(5) # remember that it's an array of floats 0. 1. (not ints 0 1)
        a[ np.arange(5) ] = a[ np.random.permutation(5) ] 
        print(a) # rows randomly swapped
        print(np.argmax( a, axis=1 ),'\n')
        # example: 
        # a = [[0. 1. 0. 0. 0.] [1. 0. 0. 0. 0.] [0. 0. 0. 0. 1.] [0. 0. 0. 1. 0.] [0. 0. 1. 0. 0.]]
        # argmax = [1 0 4 3 2] = position of 1 in each row
        b = np.random.permutation(16).reshape(4,4)
        print (b) # [[13 11 14  8] [10  1  0 12] [ 6  4  5  3] [ 2  9 15  7]]
        print (np.argmax(b, axis = 0)) # [0 0 3 1]
        print (np.argmax(b, axis = 1),'\n') # [2 3 0 2]


    # ================ Where ================
    def condition(self):
        print("Given a condition return the indices per dimension")
        a = np.arange( 15 ).reshape(3,5) #[[0 1 2 3 4][5 6 7 8 9][10 11 12 13 14]]
        b = np.where( a <= 5 )
        print(b) # [0 0 0 0 0 1][0 1 2 3 4 0] because the items <=5 are [0,0] [0,1] [0,2] [0,3] [0,4] and [1,0]
        try: 
            print(b.T)
        except:
            print("AttributeError: 'tuple' object has no attribute 'T'")

    def call_everything(self):
        for name in dir(self):
            obj = getattr(self, name)
            if callable(obj) and name != 'call_everything' and name[:2] != '__':
                print("======================= RUN ",name,"======================= ")
                obj()


if __name__ == "__main__":
    print("Numpy examples")
    x = numpy_examples()
    x.call_everything()

