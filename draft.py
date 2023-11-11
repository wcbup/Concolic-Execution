from z3 import *

x0 = Int("x0")
result = Int("result")
solver = Solver()
solver.add(x0 > -32768, x0 < 32767)
solver.add(x0 == 32766)
solver.add(result == (x0 / 8) * 77 + 8 + 16 + (x0 / 8) * 77 + 8 + x0 + 8 + x0 + 8)
if solver.check() == sat:
    print(solver.model())
else:
    print(unsat)

b = And(x0 > 0, x0 < 1, x0 > 2)
print(simplify(Not(And(x0 < 11, b))))
print(b is not True)
if (False, b):
    print(True)

print(solver.assertions())
