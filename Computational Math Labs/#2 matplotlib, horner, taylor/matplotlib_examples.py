

class matplotlib_examples():



    # ================ Call everything ================
    def call_everything(self):
        for name in dir(self):
            obj = getattr(self, name)
            if callable(obj) and name != 'call_everything' and name[:2] != '__':
                print("======================= RUN ",name,"======================= ")
                obj()

# main
if __name__ == "__main__":
    print("Matplotlib examples")
    x = matplotlib_examples()
    x.call_everything()