import numpy as np
import matplotlib.pyplot as plt
import math

def Taylor( x0, order=50 ): # default: order 1 to 50
    ans, num, term, series_sum, pow_x = 1,1,1,1,1
    errors = np.zeros((order+1,1)) # the errors are all 0 at start
    expected = np.exp(x0) # estimation
    errors[0] = np.abs( 1 - expected) 
    for i in range(1,order+1):
        step = math.pow(x0,i) / math.factorial(i)
        series_sum += step
        errors[i] = np.abs( series_sum - expected ) # all errors are the estimated value divided by the actual value
    return series_sum,errors

# main
if __name__ == "__main__":
    x = [ -5.5, -10, -5, -1, 0, 1, 5, 10 ]
    # plot errors for Taylor order 1 to 50 of e^x for all x values
    plt.figure()
    i = 1
    for val in x:
        series_sum,errors = Taylor(val)
        plt.subplot(2,4,i)
        i += 1
        plt.plot(errors/np.exp(val))
        plt.xlabel( 'order' )
        plt.title( 'x = ' + str(val) )
    plt.show()

    # plot values for Taylor order 1 to 4 of e^x in a single graph
    L = np.linspace(-2.5,2.5, 20)
    plt.figure()
    plt.plot(L,np.exp(L), label = "exp")
    for i in range (0,4):
        estimations = []
        for k in range(0,20):
            series_sum,errors = Taylor(L[k],i)
            estimations.append(series_sum)
        plt.plot(L,estimations,label = "order ="+str(i))
    plt.legend()
    plt.show()