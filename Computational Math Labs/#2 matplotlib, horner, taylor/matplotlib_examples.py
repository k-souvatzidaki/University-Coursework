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


    # ================ Legend ================
    def legend(self):
        x = np.linspace( -5, 5, 15 )
        plt.plot( x, x, label='y=x' )
        plt.plot( x, np.abs(x), label='y=|x|')
        plt.legend() 
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
        plt.title( 'First Matplotlib Exercise') # add title
        # add labels to axes
        plt.xlabel( 'x' )
        plt.ylabel( 'y(x)' )
        plt.legend()
        plt.show()
    

    # ================ Scatter (alpha) ================
    def circles(self):
        np.random.seed(1)
        n = 50
        x = np.random.rand(n) # random x
        y = np.random.rand(n) # random y
        colors = np.random.rand(n) # the color of point
        area = (30 * np.random.rand(n))**2 # the radius of point
        plt.scatter(x, y, s=area, c=colors, alpha=0.5) # alpha value for overlapping
        plt.xlabel( 'x' )
        plt.ylabel( 'y' )
        plt.title('Random alpha colorful circles with random radius')
        plt.show()

    
    # ================ Multiple Figures - Subplot ================
    def subplots_syntax1(self):
        x = np.linspace(0,5,50)
        plt.figure() # start new figure
        plt.subplot(211) # start a subplot  (OR: plt.subplot(2,1,1))
        plt.title('Subplots') # add the title to first
        plt.plot(x, np.cos(2*np.pi*x), 'o-b')
        plt.subplot(2,1,2) # (OR: plt.subplot(212))
        plt.plot(x, np.cos(2*np.pi*x), 'o--r')
        plt.show()

    def subplots_syntax2(self):
        x = np.linspace(0,5,50)
        fig, (axes) = plt.subplots( 2, 1 ) # by axes
        fig.suptitle('Subplots in an Array (axes)')
        axes[0].plot( x, np.cos( 2*np.pi*x ), 'o-r' )
        axes[0].set_ylabel('First')
        axes[1].plot( x, np.cos(2*np.pi*x), '--r')
        axes[1].set_ylabel( 'Second' )             
        axes[1].set_xlabel('x')
        plt.show()

    def subplots_4x4(self):
        x = np.linspace( 0, 5, 50 )
        plt.figure( figsize=(20,5) )
        # first
        plt.subplot(2,2,1)
        plt.plot(x, np.sin( 2*np.pi*x ), 'ob')
        plt.ylabel('sin')
        #first
        plt.subplot(2,2,2)
        plt.plot(x, np.cos(2*np.pi*x), '--r')
        plt.ylabel('cos')
        # third
        plt.subplot(2,2,3)
        plt.plot( x, -np.sin(2*np.pi*x), 'om')
        plt.ylabel('-sin')
        # fourth
        plt.subplot(2,2,4)
        plt.plot(x, -np.cos(2*np.pi*x), '--g')
        plt.ylabel('-cos')
        plt.show()


    # ================ Exercise 2 ================
    def aexercise_2(self):
        x = np.linspace(0, 2, 100)
        f, axes = plt.subplots( 3, 1, figsize=(3*7,1*7) )
        axes[0].plot( x, x )#, label='linear' ) 
        axes[1].plot( x, x**2 )#, label='quadratic' )
        axes[2].plot( x, x**3 )#, label='cubic' )
        axes[0].set_ylim( [0,2] )
        axes[1].set_ylim( [0,2] )
        axes[2].set_ylim( [0,2] )
        axes[2].set_xlabel('x label')
        axes[0].set_ylabel('linear')
        axes[1].set_ylabel('quadratic')
        axes[2].set_ylabel('cubic')
        plt.legend()
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