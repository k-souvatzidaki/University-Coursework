import sympy as sp
import math
import graphviz
from graphviz import Source
from IPython.display import display, Math 

class sympy_examples():

    # ================ Pretty Printing Demo ================
    def demo(self):
        x = sp.symbols( "x" )
        sp.pprint(sp.Integral( sp.sin(x) ))
        print('\n')

    
    # ================ Symbolic Computations ================
    def sqrt(self):
        sp.pprint(math.sqrt(5))
        sp.pprint(sp.sqrt(5)) 
        print('\n')

    def subs(self):
        x, y = sp.symbols( "x y" )
        expr = x**2 + 10*x + y**10 + 5*y
        sp.pprint(expr) # x**2 + 10*x + y**10 + 5*y
        #substitute all instances of a variable or expression in a mathematical expression with some other variable or expression or value
        sp.pprint(expr.subs(x, 5)) # y**10 + 5*y + 75
        sp.pprint(expr.subs( x, 5).subs( y, 1 )) # 81
        sp.pprint(expr.subs( [ (x,5), (y,1) ])) # 81
        Source( sp.dotprint( expr )) # renders a tree visualization of the expression:
        # add |-- pow |-- x
        #     |       |-- 2
        #     |-- pow |-- y
        #     |       |-- 10
        #     |-- mul |-- 5
        #     |       |-- y
        #     |-- mul |-- 10
        #             |-- x
        print('\n')

    def evalf(self):
        # evaluates a given numerical expression upto a given floating point precision (upto 100 digits)
        print("evalf examples")
        sp.pprint(sp.sqrt(5).evalf(100))
        sp.pprint(sp.pi.evalf(20))
        sp.pprint(sp.cos(2).evalf()) # default = 15 digits
        print('\n')
   

    # ================ Factor, Simplify, Expand, Collect ================
    def factor(self): 
        print("factor expressions")
        x = sp.symbols("x")
        expr1 = x**2 + 2*x + 1
        sp.pprint(expr1) # x**2 + 2*x + 1
        sp.pprint(expr1.factor()) # (x + 1)**2
        print('\n')

    def simplify(self):
        print("simplify expressions")
        x = sp.symbols("x")
        expr2 = sp.sin(x)**2 + sp.cos(x)**2
        sp.pprint(expr2.simplify()) # 1
        print('\n')

    def expand(self):
        print("expand expressions")
        x,y = sp.symbols("x y")
        expr3 = ( x + y )**3
        sp.pprint(expr3.expand()) # x**3 + 3*x**2*y + 3*x*y**2 + y**3 
        print('\n')

    # collect: same powers of variables are collected together as a same mathematical expression
    def collect(self):
        print("collect example")
        x,y,z = sp.symbols("x y z")
        expr= x*y + x - 3 + 2*x**2 - z*x**2 + x**3
        sp.pprint(sp.collect(expr,2)) # x**3 - x**2z + 2x**2 + xy + x -3
        print('\n')

    # coeff(x,n): find the coefficient of variables in mathematical expressions
    def coefficient(self):
        print("coefficient example")
        x,y,z = sp.symbols("x y z")
        expr= x*y + x - 3 + 2*x**2 - z*x**2 + x**3
        sp.pprint(expr.coeff(x,2)) # 2 - z
        sp.pprint(expr.coeff(x,3)) # 1
        print('\n')

    # trigonometric and logarithms
    def more_simplify_expand(self):
        print("simplify trigonometric functions")
        x = sp.symbols("x")
        expr = sp.sin(x)**2 + sp.cos(x)**2
        sp.pprint(sp.trigsimp( sp.sin(x)**2 + sp.cos(x)**2 )) # 1
        print("logarithms expand and combine")
        a, b = sp.symbols( "a b", positive=True )
        expr = sp.log(a * b ) # log(ab)
        sp.pprint(sp.expand_log( expr )) # log(a) + log(b)
        expr2 = sp.log( a/ b )
        sp.pprint(sp.expand_log( expr2 )) # log(a) - log(b)
        expr = sp.log(a) - sp.log(b)
        sp.pprint(sp.logcombine( expr )) # log(a/b)
        print('\n')

    
    # ================ Exercise 1 ================
    # Factor the expression: 
    def exercise_1(self):
        print(" factoring a bigger expression")
        x = sp.symbols("x")
        expr = ( x ** 3 - 3 * x**2 + 3 * x - 1 ) / (  x**2 + 2*x + 1 ) 
        sp.pprint(expr.factor()) # (x - 1)**3/(x + 1)**2
        print('\n')


    # ================ Partial Fraction Decomposition ================
    def decomp(self):
        print("factor and decompose a fraction")
        x = sp.symbols("x")
        expr = 1 / ( x**2 - 3*x + 2 )
        sp.pprint(expr.factor()) # 1 / (x - 2)⋅(x - 1)
        sp.pprint(expr.factor().apart()) # - 1 /(x - 1) + 1 / (x - 2)
        print('\n')


    # ================ Powers ================
    def powers(self): 
        print("powers examples")
        x, a, b = sp.symbols( "x a b" )
        sp.pprint(sp.powsimp( x**a * x**b )) # x ** (a+b)
        sp.pprint(sp.expand_power_exp( x**(a+b) )) # x**a * x**b
        print('\n')


    # ================ Solve Equation ================
    def solve_equation(self): 
        print("solving a 2nd degree equation")
        x = sp.symbols( "x" )
        eq = sp.Eq( x**2, 5 )
        display(eq) # x **2 = 5
        sp.pprint(sp.solve( eq )) # [-√5, √5]
        x = sp.symbols( "x", integer=True )
        eq = sp.Eq( x**2 - 5, 0 )
        display(eq) # x**2 - 5 = 0
        sp.pprint(sp.solve( eq )) # []
        x, y = sp.symbols( "x y", integer=True )
        eq1 = sp.Eq( 4*x + 2*y, 8 )
        eq2 = sp.Eq( 5*x + 3*y, 9 )
        display(eq1) # 4*x + 2*y = 8
        display(eq2) #  5*x + 3*y = 9
        sp.pprint(sp.solve( (eq1, eq2) )) # {x: 3, y: -2}
        print('\n')


    # ================ Non-linear Equation ================
    def non_linear(self): 
        print("solving a non linear equation")
        x, y = sp.symbols( "x y" )
        sp.pprint(sp.nonlinsolve(  [ 6 * x**2 + 3*y**2 - 12, x + y - 2 ], [x,y] )) # { (0,2) , (4/3,2/3) }
        print('\n')


    # ================ Assumptions ================
    # Queries are used to ask information about expressions. E.x. is it positive? negative? even?, odd?, composite? etc
    def assumptions(self): 
        print("ask examples")
        print( sp.ask( sp.Q.even( 0 ))) # True
        print( sp.ask( sp.Q.even( 2 ))) # True
        print( sp.ask( sp.Q.even( 3 ))) # False
        print( sp.ask( sp.Q.even( sp.pi ))) # False
        print( sp.ask( sp.Q.finite( sp.oo ))) # False
        print( sp.ask( sp.Q.finite( 1 ))) # True
        print( sp.ask( sp.Q.composite( 3*5*7 ))) # True
        print( sp.ask( sp.Q.composite( 3 ))) # False
        print( sp.ask( sp.Q.imaginary( 15 + sp.I ))) # False
        print( sp.ask( sp.Q.real( 15 ))) # True
        print( sp.ask( sp.Q.imaginary( sp.I ))) # True
        print( sp.ask( sp.Q.positive( 5-10 ))) # False
        print( sp.ask( sp.Q.negative( 5-10 ))) # True
        print( sp.ask( sp.Q.complex( 16 + sp.I ))) # True
        print('\n')


    # ================ Derivatives ================
    def derivatives(self): 
        print("derivatives example") 
        # get the unevaluate expression ==> sp.Derivative
        # get the result ==> sp.diff
        x, y = sp.symbols( "x y" )
        expr = x**2 + 10*x + y**10 + 5*y
        display( expr )
        sp.pprint(sp.Derivative( expr, y )) # θ/θy (x**2 + 10*x + y**10 + 5*y)
        sp.pprint(sp.diff(expr,y)) # 10*y**9 + 5
        sp.pprint(sp.Derivative( expr, x )) # θ/θx (x**2 + 10*x + y**10 + 5*y)
        sp.pprint(sp.diff(expr,y)) # 2*x + 10
        print('\n')

    def more_derivatives(self): 
        print("more derivatives examples") 
        x, y = sp.symbols( "x y" )
        # trigonometric
        sp.pprint(sp.Derivative( sp.cos(x), x )) # d/dx cos(x)
        sp.pprint(sp.diff( sp.diff( sp.diff( sp.cos(x), x ), x ), x )) # sim(x)
        # exponential
        sp.pprint(sp.Derivative( sp.exp(x),x)) # x/dx exp(x)
        sp.pprint(sp.diff(sp.exp(x))) # exp(x)
        # logarithm
        sp.pprint(sp.Derivative( sp.log(x), x )) # x/dx log(x)
        sp.pprint(sp.log(x).diff(x).diff(x).diff(x)) # 2/x**3
        # function f
        f = sp.symbols( "f", cls=sp.Function )
        sp.pprint(f(x).diff(x)) # d/dx f(x)
        # to get 2nd order derivative or greater use nested functions or specify ( function, w.r.t. variable, order )
        sp.pprint(sp.diff( sp.diff( sp.log(x) ) )) # -1/x**2
        sp.pprint(sp.diff( sp.log(x), x, 4 )) # -6/x**4
        print('\n')


    # ================ Integration ================
    def integration(self): 
        print("integration examples") 
        # define limits
        x, a, b = sp.symbols("x a b")
        sp.pprint(sp.Integral( sp.sin(x), (x,0,sp.pi/2) )) # the expression
        sp.pprint(sp.integrate( sp.sin(x), (x,0,sp.pi/2) )) # the result (=1)
        sp.pprint(sp.Integral( sp.exp(x), (x,3,5) ))
        sp.pprint(sp.integrate( sp.exp(x), (x,3,5) )) # -e**3 + e**5
        # double integral
        y = sp.symbols("y")
        sp.pprint(sp.Integral( sp.exp(x) * sp.exp(y), (x,3,5), (y,0,1) ))
        sp.pprint(sp.integrate( sp.exp(x) * sp.exp(y), (x,3,5), (y,0,1) )) # -e**5 + e**3  + e(-e**3 + e**5)
        print('\n')


    # ================ Limits ================
    def limits(self): 
        print("limits examples") 
        x = sp.symbols("x")
        sp.pprint(sp.Limit( sp.sin(x)/x, x, 0, '+-' )) # the expression
        sp.pprint(sp.limit( sp.sin(x)/x, x, 0, '+-' )) # the result (= 1)
        sp.pprint(sp.Limit( 1/x, x, 0, '+' ))
        sp.pprint(sp.limit( 1/x, x, 0, '+' )) # oo
        sp.pprint(sp.Limit( 1/x, x, 0, '-' ))
        sp.pprint(sp.limit( 1/x, x, 0, '-' )) # -oo
        print('\n')


    # ================ Taylor Series ================
    def taylor_series(self): 
        print("get the Taylor series") 
        x = sp.symbols("x")
        f = sp.sin(x)
        # calculated at x0 = 0 
        # When derivatives are evaluated at 0, the Taylor series is also called Maclaurin.
        sp.pprint(f.series()) # Taylor series (3 terms + O(x)) , calculated at 0
        sp.pprint(f.series(x,0,10)) # get more terms (from x**1 to x**9)+ O(x**10)
        sp.pprint(f.series(x,0,20)) # get more terms (from x**1 to x**19)+ O(x**20)
        # calculated at x0 = 5
        sp.pprint(f.series(x,5))
        sp.pprint(f.series(x,5,10))
        print('\n')


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
    sp.init_printing(use_unicode = True)
    x = sympy_examples()
    x.call_everything()