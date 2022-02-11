import numpy as np
import matplotlib.pyplot as plt

class matplotlib_examples():

    # ================ Plot Demo ================
    def plot_demo(self):
        x = [1,2,3,4] # a set of points
        plt.plot( x, x, '*' )
        plt.show()

    def plot_demo_2(self):
        x = [1,2,3,4] # a set of points
        # format strimg: [marker][line][color] (Other combinations such as [color][marker][line] are also supported, but note that their parsing may be ambiguous)
        # [marker (. , o v ^ < >)]
        # [line (- = solid, -- = dashed, -. = dash-dot,  : = dotted)]
        # [color (b = blue, g = green, r = red, c = cyan, m = magenta, y = yellow, k = black, w = white)] 
        plt.plot( x, x, 'o-k' )
        plt.show()

    
    # ================ Linespace ================
    def linespace(self):
        #from 0 to 10 divide to 15 equally spaced bins, and convert to vector
        plt.plot(np.linspace( 0, 10, 15 ).reshape( (-1,1) ), '^r')
        plt.show()


    # ================ Exercise 1 ================
    def exercise_1(self):
        #from -2 to 2 divide to 10 equally spaced bins, and convert to vector
        x = np.linspace( -2,2, 10 ).reshape((-1,1))
        #plot x^2 with red circles
        plt.plot( x, x*x, 'ro', label='x^2' )
        #plot exp(x) with blue dashed line
        plt.plot( x, np.exp(x), 'b--', label='exp' )
        #plot sin(x) with solid green
        plt.plot( x, np.sin(x), '-g', label='sin' )
        plt.title( 'First Matplotlib Exercise')
        plt.xlabel( 'x' )
        plt.ylabel( 'y(x)' )
        plt.show()


    # ================ Call everything ================
    def call_everything(self):
        for name in dir(self):
            obj = getattr(self, name)
            if callable(obj) and name != 'call_everything' and name[:2] != '__':
                print("======================= RUN ",name,"======================= \n")
                obj()

# main
if __name__ == "__main__":
    print("Matplotlib examples")
    x = matplotlib_examples()
    x.call_everything()