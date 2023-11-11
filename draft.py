from z3 import *

a = Int('a')
b = Int('b')
c = Int('c')
print(a % b)
solver = Solver()
solver.add(a == 3)
solver.add(b == 2)
solver.add(c == a / b)

print(solver.check())
print(solver.model())