import numpy as np
import matplotlib.pyplot as plt

# estimate area between two functions with Monte Carlo
# 1. Generate random points in a rectangle where we want to estimate the area
# 2. Calculate % of the points that are inside the graph of both functions
# 3. The area = area of the rectangle 
np.random.seed(0)
def random( a, b ):
    return a + (b-a)*np.random.random() # random numbers in [a,b]

def S(x, x_1, y_1, x_2, y_2):
    return y_1 + ((y_2-y_1) / (x_2 - x_1)) * (x-x_1) # linear spline

def monte_carlo(y,z,n):
    minFG = min(min(y),min(z))
    maxFG = max(max(y),max(z))
    n_points = len(y)
    intervals_x = np.linspace(0, 2, n_points) # uniform diamerismos of [0,2] (x values) 
                                              # in as many intervals as the points we have
    print("Intervals: ",intervals_x)
    total_points_in = 0
    for i in range(n):
        # generate point (a,b)
        # a is in [0,2]
        # b in (minFG,maxFG)
        p_x,p_y = random(0,2) , random(minFG,maxFG)

        # find interval where the point is in, and calculate spline
        index = n_points - 2
        for j in range(1,n_points-1):
           if(intervals_x[j-1] < p_x < intervals_x[j]): # a < p_x < b : the point is interval [a,b]
               index = j-1
               break
        spline_y = S( p_x, intervals_x[index], y[index], intervals_x[index+1], y[index+1] )
        spline_z = S( p_x, intervals_x[index], z[index], intervals_x[index+1], z[index+1] )

        # plot: if point is in area between the 2 splines: red cross, else green cross
        if min(spline_y, spline_z) < p_y < max(spline_y, spline_z):
            plt.plot(p_x, p_y, 'r+')
            total_points_in += 1
        else:
            plt.plot(p_x, p_y, 'g+')
    # estimate the area
    # integral = (2-0) * (maxFG-minFG) * (total_points_in/total_points_generated)
    # (it's from monte carlo theory)
    integral = ((intervals_x[n_points-1] - intervals_x[0]) * (maxFG - minFG))  * (total_points_in/n)
    print( 'Integral := ', integral )
    plt.title( 'Integral %s' % (integral) )
    plt.show()

if __name__ == "__main__":
    # the functions are given as 2 sets of points (not analytic)
    y = [ 1.000000, 0.731689, 0.070737, -0.628174, -0.989992, -0.820559, -0.210796, 0.512085, 0.960170 ]
    z = [ 0.00000, 0.68164, 0.99749, 0.77807, 0.14112, -0.57156, -0.97753, -0.85893, -0.27942  ]
    # for F,G in [0,2] where:
    # y[0] = F[0], y[len(y)-1] = F[2]
    # z[0] = G[0], z[len(z)-1] = G[2]
    # goal: generate n=2000 random point in [0,2]x[min(F,G),max(F,G)] and plot
    # use linear splines to approach F ang G
    monte_carlo(y,z,2000)

