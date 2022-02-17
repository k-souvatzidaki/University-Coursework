import numpy as np
import matplotlib.pyplot as plt

# real integral/area value
_real_value = 0.74682413279
# number of intervals
# e.x. 10 means 10 subintervals and 11 equally distanced points
_trapezoid_subs = [10,20,40,80,160]
_simpson_subs = [2,4,8,16,32]

trapezoid_error = []
simpson_error = []

def f(x):
    return np.exp(-np.square(x))

def trapezoid(h, y):
    s = y[0]/2.0 #first term
    for i in range(1,len(y)-1):
        s += y[i]
    s += y[len(y)-1]/2.0 # last term
    return h * s

def simpson(h, y):
    s = y[0] # first term
    for i in range(1,len(y)):
        val = 2
        if i % 2 == 1:
            val = 4
        s += val * y[i]
    s += y[len(y)-1] # last term
    return h * s / 3.0

def execute_trapezoid(hi,lo):
    for num in _trapezoid_subs:
        h = (hi-lo)/num # calculate the step (h)
        # store num+1 points into x
        # Use np.arange( start=..., stop=..., step=... )
        x = np.arange(start=lo, stop=hi+h, step=h) # using arange to create an array
        y = f(x)
        estimated = trapezoid(h, y)
        trapezoid_error.append(np.abs(_real_value - estimated))

def execute_simpson(hi,lo):
    for num in _simpson_subs:
        h = (hi-lo)/num # calculate the step (h)
        # store num+1 points into x
        x = np.arange(start=lo, stop=hi+h, step=h)
        y = f(x)
        estimated = simpson(h, y)
        simpson_error.append(np.abs(_real_value - estimated))

def make_plots():
    # trapezoid
    plt.subplot( 2, 1, 1 )
    plt.plot(_trapezoid_subs, trapezoid_error)
    plt.title('Trapezoid')
    plt.ylabel('Error')
    plt.grid()
    # simpson
    plt.subplot( 2, 1, 2 )
    plt.plot(_simpson_subs, simpson_error)
    plt.title('Simpson 1/3')
    plt.ylabel('Error')
    plt.xlabel('Num of intervals')
    plt.grid()
    plt.show()


if __name__ == "__main__":
    #x-axis is between [0,1]
    lo, hi = 0,1
    # execute trapezoid
    for num in _trapezoid_subs:
        h = (hi-lo)/num # calculate the step (h)
        # store num+1 points into x
        # Use np.arange( start=..., stop=..., step=... )
        x = np.arange(start=lo, stop=hi+h, step=h) # using arange to create an array
        y = f(x)
        estimated = trapezoid(h, y)
        trapezoid_error.append(np.abs(_real_value - estimated))
    # execute simpson
    for num in _simpson_subs:
        h = (hi-lo)/num # calculate the step (h)
        # store num+1 points into x
        x = np.arange(start=lo, stop=hi+h, step=h)
        y = f(x)
        estimated = simpson(h, y)
        simpson_error.append(np.abs(_real_value - estimated))
    # trapezoid: see if the error-x4 when intervalsx2
    for i in range(1, len(trapezoid_error)):
        print(trapezoid_error[i-1]/trapezoid_error[i]) # should be ~4
    # SIMPSON: see if the error-x16 when intervalsx2
    for i in range(1, len(simpson_error)):
        print(simpson_error[i-1]/simpson_error[i]) # should be ~16
    make_plots()