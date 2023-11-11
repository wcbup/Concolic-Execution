from z3 import *

x0 = Int("x0")
result = Int("result")
solver = Solver()
solver.add(x0 > -32768)
solver.add(x0 == 12)
solver.add(result == (x0/8)*77 + 8 + 16 + (x0/8)*77 + 8 + x0 + 8 + x0 + 8)
if solver.check() == sat:
    print(solver.model())
else:
    print(unsat)
