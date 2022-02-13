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