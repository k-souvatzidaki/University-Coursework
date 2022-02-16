import numpy as np
import matplotlib.pyplot as plt

# declare f
def f(x):
    return np.exp(x) - 2

# declare df
def df(x):
    return np.exp(x)

# Newton Raphson 
def Newton(x0, tol= 1e-6):
    errors = []
    while(True):
        x_next = x0 - f(x0)/df(x0)
        errors.append(x_next - x0)
        if np.abs(x_next - x0) < tol:
            break
        x0 = x_next
    return x_next, errors

# bisection (Bolzano)
def bisection(lo, hi, tol = 1e-6):
    errors = [hi-lo]
    while(hi-lo > tol):
        mid = lo + ( hi-lo ) / 2
        f_mid = f(mid)
        f_hi = f(hi)
        if f_mid * f_hi < 0:
            lo = mid
        else:
            hi = mid
        errors.append(hi-lo)
    return lo + (hi-lo) / 2, errors

# main
if __name__ == "__main__":
    b_sol, b_errors = bisection(-10,10)
    n_sol, n_errors = Newton(20)
    print(b_sol,n_sol)
    l = np.linspace(0,2,20)
    plt.figure()
    plt.subplot(2,1,1)
    plt.plot(l,f(l), label = "f")
    plt.subplot(2,1,2)
    plt.plot(b_errors, label = "bisection errors")
    plt.plot(n_errors, label = "newton raphson errors")
    plt.legend()
    plt.show()