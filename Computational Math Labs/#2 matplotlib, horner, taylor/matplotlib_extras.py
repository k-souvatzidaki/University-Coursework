# matplotlib examples from 2022 labs
import numpy as np
import matplotlib.pyplot as plt

class matplotlib_examples():

    # ================ Plot Demo ================
    def plot_demo(self):
        plt.plot([1, 2, 3, 4], [1, 4, 9, 16])
        plt.show()
        plt.plot([1, 2, 3, 4], [1, 4, 9, 16], '+')
        plt.show()

    
    # ================ Text and Annotate ================
    def text_annotate(self):
        x = np.array([1,2,3,4,5])
        plt.title('My first plot',loc = 'right')
        plt.xlabel('x')
        plt.ylabel('y')
        # customize
        plt.yscale('log') # show y scale in log
        plt.grid() # show grid
        plt.text(2,4,'something') # show text "something" at point (2,4)
        plt.annotate('see here', xy=(3, 4), xytext=(2, 2) , arrowprops = dict(facecolor='black')) # show text at (2,2) and arrow pointing at (3,4)
        # plots
        plt.plot(x**2)
        plt.plot(x,x)
        plt.plot(x)
        plt.plot(x,label='x')
        plt.plot(x, color = 'red',linestyle='--',linewidth=1, marker='*')
        plt.plot(x, 'g--')
        plt.legend() # must be declared after a plt.plot() with label = "...", or "No artists with labels found to put in legend.  Note that artists whose label start with an underscore are ignored when legend() is called with no argument."
        plt.show()


    # ================ Many lines in one command ================
    def multiple_lines(self):
        t = np.linspace(0,1,100)
        plt.plot(t, t, 'r--', t, t**2, 'bs', t, t**3, 'g^') # 3 lines
        plt.show()


    # ================ Invalid value ================
    def invalid_log(self):
        x = np.linspace(-10, 10, 1000)
        plt.plot(x, np.log(x), label = 'x=log(x)')
        plt.plot(x, np.sin(x), label = 'x=sin(x)', color = 'g')
        plt.legend()
        plt.xlabel('x')
        plt.ylabel('y')
        plt.title('log and sin')
        plt.show() # RuntimeWarning: invalid value encountered in log plt.plot(x, np.log(x), label = 'x=log(x)')


    # ================ Plot with "subplots" ================
    def subplots_example(self):
        x = np.linspace( 0, 5, 50 )
        fig, ax = plt.subplots(figsize=(10, 10)) # start a 10x10 subplot
        # plot 4 lines to ax subplot
        ax.plot(x, 'o', label='1st') 
        ax.plot(x**2, 'd', label='2nd')
        ax.plot(x**3, 'v', label='3rd')
        ax.plot(x**4, 's', label='4th')
        ax.text(10,100,'something')
        ax.grid() # add grid
        ax.legend(loc='lower left') # add a legend at low left of diagram
        plt.show()


    # ================ Multiple plots with "figure" and "subplots" ================
    def multiple_plots_1(self):
        x = np.linspace( 0, 5, 50 )
        plt.figure() # start a figure
        # first subplot
        plt.subplot(2,1,1) # 2x1 figure
        plt.plot(x, np.sin(6*x), 'b:')
        plt.ylabel('sin6x')
        plt.xlabel('up x')
        # second subplot
        plt.subplot(2,1,2)
        plt.plot(x, np.cos(2*x), 'r--')
        plt.ylabel('cos2x')
        plt.xlabel('down x')
        plt.show()

    def multiple_plots_2(self):
        x = np.linspace( 0, 5, 50 )
        plt.figure(figsize=(15,10)) 
        # first subplot
        plt.subplot(3,3,1)
        plt.plot(x)
        # second subplot
        plt.subplot(3,3,8)
        plt.plot(x**2)
        plt.show()

    def multiple_plots_3(self):
        # first figure
        plt.figure(1)
        # first subplot
        plt.subplot(211)
        plt.plot([1, 2, 3])
        # second subplot
        plt.subplot(212)
        plt.plot([4, 5, 6])
        # second figure
        plt.figure(2)
        plt.plot([4, 5, 6])
        plt.title('plot of Fig2')
        # back to 1st figure - 2nd subplot: add a title
        # MatplotlibDeprecationWarning: Adding an axes using the same arguments as a previous axes 
        # currently reuses the earlier instance.  In a future version, a new instance will always 
        # be created and returned.  Meanwhile, this warning can be suppressed, and the future behavior 
        # ensured, by passing a unique label to each axes instance. del sys.path[0]
        plt.figure(1)
        plt.subplot(212)
        plt.title('plot 212')
        plt.show()

    def multiple_plots_4(self):
        x = np.linspace( 0, 5, 50 )
        plt.figure( figsize=(20,5) )
        # 1st
        plt.subplot(2,2,1)
        plt.plot(x, np.sin( 2*np.pi*x ), 'bo' , label = 'a')
        plt.ylabel('sin')
        # 2nd
        plt.subplot(2,2,2)
        plt.plot(x, np.cos(2*np.pi*x), 'r--', label = 'b')
        plt.ylabel('cos')
        # 3rd
        plt.subplot(2,2,3)
        plt.plot(x, -np.sin(2*np.pi*x), 'mo' , label = 'c')
        plt.ylabel('-sin')
        # 4th 
        plt.subplot(2,2,4)
        plt.plot(x, -np.cos(2*np.pi*x), 'g--', label = 'd')
        plt.ylabel('-cos')
        plt.legend()
        plt.show()


    # ================ Multiple plots as arrays (axes) ================
    def axes_example_1(self): 
        x = np.linspace( 0, 5, 50 )
        fig, (axes) = plt.subplots( 2, 1 ) # new figure with 2 subplots in axes
        fig.suptitle('Subplots referred with array') # title to whole graph
        # 1st
        axes[0].plot(x, np.cos( x ), 'bo' )
        axes[0].set_ylabel('First')
        # 2nd
        axes[1].plot(x, np.sin(x), 'r--')
        axes[1].set_ylabel( 'Second' )
        axes[1].set_xlabel('x')
        plt.show()

    def axes_example_2(self): 
        data1, data2, data3, data4 = np.random.randn(4, 100)  # making 4 random datasets of 100 elements each
        fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(5, 2.7))
        ax1.plot(data1, data2, marker='x',c='m')
        ax2.plot(data3, data4, marker='*',c='r')
        plt.show()

    def axes_example_3(self): 
        x = np.linspace( 0, 5, 50 )
        fig, (axes) = plt.subplots( 3, 2 , figsize = (10,10))
        fig.suptitle('Subplots referred with array')#
        # axes [0][0] remains empty (x = 1.0, y = 1.0)
        axes[0][1].plot( x, x, 'b:' )
        axes[0][1].set_ylabel('First')
        axes[0][1].set_title('First plot')
        # axes [1][1] remains empty but has a title
        axes[1][1].set_title('Empty plot')
        axes[1][0].plot( 4*x, x+5, 'r--')
        axes[1][0].set_ylabel( 'Second' )
        axes[1][0].set_xlabel('x')
        axes[2][0].plot( x, x**4, 'g*')
        axes[2][0].set_ylabel( 'Third' )
        axes[2][0].set_xlabel('x')
        axes[2][0].set_yscale('log')
        # axes[2][1] remains empty
        plt.show()


    # ================ Custom labels ================
    def labels(self): 
        x = np.linspace( 0, 5, 50 )
        # square root x symbol label
        plt.plot(np.sqrt(x))
        plt.xlabel('x')
        plt.ylabel(r'$\sqrt{x}$')
        plt.show()
        # x / 2 fraction label
        plt.plot(x/2)
        plt.xlabel('x')
        plt.ylabel(r'$\frac{x}{2}$')
        plt.show()
        # e ^ x symbol label
        plt.plot(np.exp(x))
        plt.ylabel(r'$e^{x}$')
        plt.show()
        # α, β symbols, Σ (sum) labels
        plt.plot(x)
        plt.text(1,1,r'$\alpha_{i} > \beta_{i}$')
        plt.title(r'$\sum_{i=0}^\infty\alpha_{i}$')
        plt.show()


    # ================ Categorical plots ================
    def categorical_plots(self):
        continents = ['Europe', 'America', 'Asia', 'Africa', 'Oceania']
        salary = [800, 1000, 100, 50, 900]
        plt.figure(figsize=(20, 5))
        # bars
        plt.subplot(1,3,1)
        plt.bar(continents, salary)
        # scatter
        plt.subplot(1,3,2)
        plt.scatter(continents, salary)
        # normal plt (line) (x = continets, y = salary)
        plt.subplot(1,3,3)
        plt.plot(continents, salary)
        plt.suptitle('Categorical Plotting')
        plt.show()


    # ================ Scatter ================
    def scatter_example(self):
        x = np.linspace(10,20,100)
        y = np.random.permutation(x)
        # plot
        plt.plot(x,y,c='r', marker = '.', linestyle = ' ')
        plt.show()
        # scatter
        plt.scatter(x, y, c = np.random.randn(len(x)), s = np.random.randn(len(x))*100,  alpha = 0.5)
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
    print("More Matplotlib examples")
    x = matplotlib_examples()
    x.call_everything()