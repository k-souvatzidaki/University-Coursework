import sympy as sp

class sympy_examples():

    def __init__(self):
        sp.init_printing(use_unicode = True)

    # ================ Pretty Printing Demo ================
    def demo(self):
        x = sp.symbols( "x" )
        print(sp.Integral( sp.sin(x) ))

    def call_everything(self):
        for name in dir(self):
            obj = getattr(self, name)
            if callable(obj) and name != 'call_everything' and name[:2] != '__':
                print("======================= RUN ",name,"======================= ")
                obj()


if __name__ == "__main__":
    print("Sympy examples")
    x = sympy_examples()
    x.call_everything()