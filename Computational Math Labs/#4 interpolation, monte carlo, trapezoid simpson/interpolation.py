import numpy as np
import matplotlib.pyplot as plt

#define Runge function
def f(x):
    return 1.0 / (1 + 25*x**2)

# Lagrange interpolation
# x and y are the interpolated data points (x,y)
# z are the data points where we want the value of polynomial function
def interpolation( x, y, z ):
    val = np.zeros((z.shape[0],1))
    #for each point in z
    for k in range( z.shape[0] ):
        #calc val[k]
        for i in range( x.shape[0] ):
            #Initialize the product
            prod = 1
            #iterate for all x_j
            for j in range( x.shape[0] ):
                if i != j:
                    prod *= ( z[k] - x[j] )
                    prod /= ( x[i] - x[j] )
            val[k] += prod * y[i]
    return val

if __name__ == "__main__":
    z = np.linspace(-1, 1, 39)
    #Interpolating f using 20 points equally spaced points between -1 and 1
    # with uniform distribution 
    x = np.linspace(-1, 1, 20)
    y = f(x)
    # with chebychev points
    inp = np.arange(1,21).reshape( (-1,1) )
    cheb_x = np.cos( (2*inp - 1) * np.pi / ( 2*inp.shape[0] ) )
    cheb_y = f(cheb_x)

    # run interpolation with uniform partition
    uniform_estimated = interpolation(x, y, z)

    # run interpolation with chebyshev partition
    cheb_estimated = interpolation(cheb_x, cheb_y, z)

    # plot
    plt.plot( z, f(z), label='true values' )
    plt.plot( x, y, '*', label='interpolated points' )
    plt.plot( cheb_x, cheb_y, 'b+', label='chebyshev points' )
    plt.plot( z, uniform_estimated, '--', label='uniform estimated values' )
    plt.plot( z, cheb_estimated, 'y-', label='cheb estimated values' )
    #plt.axis( [-1.5,1.5,-1.5,7] )
    plt.grid()
    plt.legend()
    plt.show()