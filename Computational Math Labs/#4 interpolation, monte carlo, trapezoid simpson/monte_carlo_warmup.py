import numpy as np

# estimate pi value with random numbers:
# Acircle = πr^2 = π if radius = 1
# Acircle/Asquare = |inCircle|/|points|
# inCircle = all points in unit circle = points (a,b) with a^2 + b^2 <= 1
# Esquare = (2r)^2 = 4 if radius = 1
# ==> Acircle = 4(|inCircle|/|points|) = π
def random():
    return np.random.random()

def warmup(points):
    # generate random points in [0,1]
    points_list = [( random(), random() ) for i in range(points)]
    #count points that are withing the unit circle
    in_circle = sum([ 1 for i in points_list if i[0]*i[0] + i[1]*i[1] <= 1 ])
    return 4* in_circle/points

if __name__ == "__main__":
    print("Pi estimation =",warmup(20000))
    print("Pi actual value =",np.pi)
