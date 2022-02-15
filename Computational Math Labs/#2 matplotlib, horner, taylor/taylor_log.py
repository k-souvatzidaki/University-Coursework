import numpy as np
import matplotlib.pyplot as plt
import math

def Taylor_log( x0, order=50 ): # default: order 1 to 50
    series_sum= x0
    errors = np.zeros((order+1,1)) # the errors are all 0 at start
    expected = np.log(x0+1) # estimation
    errors[0] = np.abs(x0 - expected) 
    sign = -1
    for i in range(2,order+1):
        step = math.pow(x0,2) / i
        series_sum += step*sign
        sign *= -1
        errors[i] = np.abs( series_sum - expected ) # all errors are the estimated value divided by the actual value
    return series_sum,errors

# main
if __name__ == "__main__":
    x = [-0.9, -0.75, -0.5, -0.25, 0 , 0.25, 0.5, 1]
    # plot errors for Taylor order 1 to 50 of log(x+1) for all x values
    plt.figure()
    i = 1
    for val in x:
        series_sum,errors = Taylor_log(val)
        plt.subplot(2,4,i)
        i += 1
        print(val+1)
        print(np.log(val+1))
        plt.plot(errors/np.log(val+1))
        plt.xlabel( 'order' )
        plt.title( 'x = ' + str(val) )
    plt.show()

    # plot values for Taylor order 1 to 20 of log(x+1) in a single graph
    L = np.linspace(-0.9,1, 20)
    plt.figure()
    plt.plot(L,np.log(L+1), label = "log(x+1")
    for i in range (0,20):
        estimations = []
        for k in range(0,20):
            series_sum,errors = Taylor_log(L[k],i)
            estimations.append(series_sum)
        plt.plot(L,estimations,label = "order ="+str(i))
    plt.legend()
    plt.show()