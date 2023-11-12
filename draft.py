from z3 import *

x0 = Int("x0")
x1 = Int("x1")
x2 = Int("x2")
solver = Solver()
solver.add(Not(x0 <= x1))
solver.add(Not(x0 <= x1))
if solver.check() == sat:
    print(solver.model()["x1"])
else:
    print(unsat)

