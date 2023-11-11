from z3 import *

a = Int('x')
n = a >= 3
x = 2 ** a

print(x)