import sympy as sp
import math
import graphviz
from graphviz import Source

class sympy_examples():

    def __init__(self):
        sp.init_printing(use_unicode = True)

    # ================ Pretty Printing Demo ================
    def demo(self):
        x = sp.symbols( "x" )
        print(sp.Integral( sp.sin(x) ))

    
    # ================ Symbolic Computations ================
    def sqrt(self):
        print(math.sqrt(5))
        print(sp.sqrt(5),'\n') 

    def subs(self):
        x, y = sp.symbols( "x y" )
        expr = x**2 + 10*x + y**10 + 5*y
        print(expr) # x**2 + 10*x + y**10 + 5*y
        #substitute all instances of a variable or expression in a mathematical expression with some other variable or expression or value
        print(expr.subs(x, 5)) # y**10 + 5*y + 75
        print(expr.subs( x, 5).subs( y, 1 )) # 81
        print(expr.subs( [ (x,5), (y,1) ]),'\n') # 81
        Source( sp.dotprint( expr )) # renders a tree visualization of the expression:
        # add |-- pow |-- x
        #     |       |-- 2
        #     |-- pow |-- y
        #     |       |-- 10
        #     |-- mul |-- 5
        #     |       |-- y
        #     |-- mul |-- 10
        #             |-- x
   

    # ================ Factor, Simplify, Expand ================
    def factor(self): 
        print("factor expressions")
        x = sp.symbols("x")
        expr1 = x**2 + 2*x + 1
        print(expr1) # x**2 + 2*x + 1
        print(expr1.factor()) # (x + 1)**2

    def simplify(self):
        print("simplify expressions")
        x = sp.symbols("x")
        expr2 = sp.sin(x)**2 + sp.cos(x)**2
        print(expr2.simplify(),'\n') # 1

    def expand(self):
        print("expand expressions")
        x,y = sp.symbols("x y")
        expr3 = ( x + y )**3
        print(expr3.expand(), '\n') # x**3 + 3*x**2*y + 3*x*y**2 + y**3 

    
    # ================ Exercise 1 ================
    # Factor the expression: 
    def exercise_1(self):
        print(" factoring a bigger expression")
        x = sp.symbols("x")
        expr = ( x ** 3 - 3 * x**2 + 3 * x - 1 ) / (  x**2 + 2*x + 1 ) 
        print(expr.factor(),'\n') # (x - 1)**3/(x + 1)**2


    # ================ Call everything ================
    def call_everything(self):
        for name in dir(self):
            obj = getattr(self, name)
            if callable(obj) and name != 'call_everything' and name[:2] != '__':
                print("======================= RUN ",name,"======================= ")
                obj()


# main
if __name__ == "__main__":
    print("Sympy examples")
    x = sympy_examples()
    x.call_everything()