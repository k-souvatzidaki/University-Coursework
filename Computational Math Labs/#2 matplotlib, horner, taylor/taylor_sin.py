import numpy as np
import matplotlib.pyplot as plt
import math

def Taylor_sin( x0, order=50 ): # default: order 1 to 50
    series_sum= x0
    errors = np.zeros((order+1,1)) # the errors are all 0 at start
    expected = np.sin(x0) # estimation
    errors[0] = np.abs(x0 - expected) 
    sign = -1
    for i in range(2,order+1):
        step = math.pow(x0,2*i+1) / np.math.factorial(2*i+1)
        series_sum += step*sign
        sign *= -1
        errors[i] = np.abs( series_sum - expected ) # all errors are the estimated value divided by the actual value
    return series_sum,errors

# main
if __name__ == "__main__":
    x = np.linspace(-np.pi,np.pi,8)
    # plot errors for Taylor order 1 to 50 of sin for all x values
    plt.figure()
    i = 1
    for val in x:
        series_sum,errors = Taylor_sin(val)
        plt.subplot(2,4,i)
        i += 1
        print(val+1)
        print(np.log(val+1))
        plt.plot(errors/np.sin(val))
        plt.xlabel( 'order' )
        plt.title( 'x = ' + str(val) )
    plt.show()

    # plot values for Taylor order 1 to 20 of sin in a single graph
    L = np.linspace(-np.pi,np.pi, 200)
    plt.figure()
    plt.plot(L,np.sin(L), label = "sin")
    for i in range (0,20):
        estimations = []
        for k in range(0,200):
            series_sum,errors = Taylor_sin(L[k],i)
            estimations.append(series_sum)
        plt.plot(L,estimations,label = "order ="+str(i))
    plt.legend()
    plt.show()