from __future__ import annotations
from Parser import Parser, OpType, Address, ArrayAddress
from typing import Dict, List, Tuple
from z3 import ArithRef, BoolRef, Not, And, Solver, Int, simplify, IntNumRef, sat


class ConcolicVar:
    def __init__(self, value: int, variable: None | ArithRef = None) -> None:
        self.value = value
        self.variable = variable

    def __str__(self) -> str:
        return f"({self.value}, {self.variable})"

    def __sub__(self, other: ConcolicVar) -> ConcolicVar:
        if not isinstance(other, ConcolicVar):
            raise Exception(other)
        result_value = self.value - other.value
        if self.variable == None:
            if other.variable == None:
                return ConcolicVar(result_value)
            else:
                return ConcolicVar(result_value, self.value - other.variable)
        else:
            if other.variable == None:
                return ConcolicVar(result_value, self.variable - other.value)
            else:
                return ConcolicVar(result_value, self.variable - other.variable)

    def __add__(self, other: ConcolicVar) -> ConcolicVar:
        if not isinstance(other, ConcolicVar):
            raise Exception(other)
        result_value = self.value + other.value
        if self.variable == None:
            if other.variable == None:
                return ConcolicVar(result_value)
            else:
                return ConcolicVar(result_value, self.value + other.variable)
        else:
            if other.variable == None:
                return ConcolicVar(result_value, self.variable + other.value)
            else:
                return ConcolicVar(result_value, self.variable + other.variable)

    def __lshift__(self, other: ConcolicVar) -> ConcolicVar:
        if not isinstance(other, ConcolicVar):
            raise Exception(other)
        result_value = self.value * 2**other.value
        if self.variable == None:
            if other.variable == None:
                return ConcolicVar(result_value)
            else:
                return ConcolicVar(result_value, self.value * 2**other.variable)
        else:
            if other.variable == None:
                return ConcolicVar(result_value, self.variable * 2**other.value)
            else:
                return ConcolicVar(result_value, self.variable * 2**other.variable)

    def __truediv__(self, other: ConcolicVar) -> ConcolicVar:
        if not isinstance(other, ConcolicVar):
            raise Exception(other)
        result_value = int(self.value / other.value)
        if self.variable == None:
            if other.variable == None:
                return ConcolicVar(result_value)
            else:
                return ConcolicVar(result_value, self.value / other.variable)
        else:
            if other.variable == None:
                return ConcolicVar(result_value, self.variable / other.value)
            else:
                return ConcolicVar(result_value, self.variable / other.variable)

    def __mod__(self, other: ConcolicVar) -> ConcolicVar:
        if not isinstance(other, ConcolicVar):
            raise Exception(other)
        result_value = self.value % other.value
        if self.variable == None:
            if other.variable == None:
                return ConcolicVar(result_value)
            else:
                return ConcolicVar(result_value, self.value % other.variable)
        else:
            if other.variable == None:
                return ConcolicVar(result_value, self.variable % other.value)
            else:
                return ConcolicVar(result_value, self.variable % other.variable)

    def __mul__(self, other: ConcolicVar) -> ConcolicVar:
        if not isinstance(other, ConcolicVar):
            raise Exception(other)
        result_value = self.value * other.value
        if self.variable == None:
            if other.variable == None:
                return ConcolicVar(result_value)
            else:
                return ConcolicVar(result_value, self.value * other.variable)
        else:
            if other.variable == None:
                return ConcolicVar(result_value, self.variable * other.value)
            else:
                return ConcolicVar(result_value, self.variable * other.variable)

    def __gt__(self, other: ConcolicVar) -> Tuple[bool, BoolRef]:
        """
        return (result: bool, constraint: BoolRef)
        """
        if not isinstance(other, ConcolicVar):
            raise Exception(other)

        result = self.value > other.value
        if self.variable == None:
            if other.variable == None:
                constraint = True
            else:
                constraint = self.value > other.variable
        else:
            if other.variable == None:
                constraint = self.variable > other.value
            else:
                constraint = self.variable > other.variable
        if not result and constraint is not True:
            constraint = Not(constraint)

        return result, constraint

    def __ne__(self, other: ConcolicVar) -> Tuple[bool, BoolRef]:
        """
        return (result: bool, constraint: BoolRef)
        """
        if not isinstance(other, ConcolicVar):
            raise Exception(other)

        result = self.value != other.value
        if self.variable == None:
            if other.variable == None:
                constraint = True
            else:
                constraint = self.value != other.variable
        else:
            if other.variable == None:
                constraint = self.variable != other.value
            else:
                constraint = self.variable != other.variable
        if not result and constraint is not True:
            constraint = Not(constraint)

        return result, constraint

    def __ge__(self, other: ConcolicVar) -> Tuple[bool, BoolRef]:
        """
        return (result: bool, constraint: BoolRef)
        """
        if not isinstance(other, ConcolicVar):
            raise Exception(other)

        result = self.value >= other.value
        if self.variable == None:
            if other.variable == None:
                constraint = True
            else:
                constraint = self.value >= other.variable
        else:
            if other.variable == None:
                constraint = self.variable >= other.value
            else:
                constraint = self.variable >= other.variable
        if not result and constraint is not True:
            constraint = Not(constraint)

        return result, constraint


class ConcolicExecutor:
    def __init__(self, parser: Parser) -> None:
        self.parser = parser
        self.register_dict: Dict[str, ConcolicVar | None] = {}
        self.memory_array: List[None | ConcolicVar] = [None] * 10_000

    def run(self, label_name: str, para_list: List[int]) -> Tuple[None | int, BoolRef]:
        """
        return result: None | int, constraint: BoolRef
        if result is None, the execution fails
        """
        total_constraint: BoolRef = True

        # reset the state
        parameter_list: List[ConcolicVar] = []
        for i in range(len(para_list)):
            parameter_list.append(ConcolicVar(para_list[i], Int(f"x{i}")))

        # init return address
        self.register_dict["ret"] = None
        # init register
        self.register_dict["rsp"] = ConcolicVar(9000)
        self.register_dict["rbp"] = ConcolicVar(9000)
        self.register_dict["eax"] = None
        self.register_dict["ebx"] = None
        self.register_dict["ecx"] = None
        self.register_dict["edx"] = None
        self.register_dict["r8d"] = None
        self.register_dict["r9d"] = None

        # init parameters
        para_len = len(parameter_list)
        if para_len >= 1:
            self.register_dict["ecx"] = parameter_list[0]
        if para_len >= 2:
            self.register_dict["edx"] = parameter_list[1]
        if para_len >= 3:
            self.register_dict["r8d"] = parameter_list[2]
        if para_len >= 4:
            self.register_dict["r9d"] = parameter_list[3]
        if para_len > 4:
            for i in range(4, para_len):
                self.memory_array[
                    self.register_dict["rsp"] + 8 * (i + 1)
                ] = parameter_list[i]

        def push(x: ConcolicVar | None) -> None:
            # push x on the stack
            self.register_dict["rsp"] = self.register_dict["rsp"] - ConcolicVar(8)
            self.memory_array[self.register_dict["rsp"].value] = x

        def pop() -> int | None | str:
            # pop the stack
            value = self.memory_array[self.register_dict["rsp"].value]
            self.register_dict["rsp"] = self.register_dict["rsp"] + ConcolicVar(8)
            return value

        def get_value(x: int | str | Address | ArrayAddress) -> ConcolicVar | None:
            if isinstance(x, int):
                return ConcolicVar(x)
            elif isinstance(x, str):
                return self.register_dict[x]
            elif isinstance(x, Address):
                return self.memory_array[get_value(x.operand).value + x.offset]
            elif isinstance(x, ArrayAddress):
                return self.memory_array[
                    get_value(x.operand1).value
                    + 4 * get_value(x.operand2).value
                    + x.offset
                ]
            else:
                raise Exception(x)

        def assign_value(destination: str | Address, value: ConcolicVar | None) -> None:
            if not isinstance(value, ConcolicVar | None):
                raise Exception(value)

            if isinstance(destination, str):
                self.register_dict[destination] = value
            elif isinstance(destination, Address):
                self.memory_array[
                    get_value(destination.operand).value + destination.offset
                ] = value
            else:
                raise Exception(destination)

        print()
        print()
        print("---begin running---", label_name)
        operation_index = self.parser.label_dict[label_name]
        while operation_index < len(self.parser.code_list):
            code = self.parser.operation_list[operation_index]
            print(f"index: {operation_index}")
            code.print()
            operation = code.operation

            match operation.type:
                case OpType.PUSH:
                    operand = operation.operand_list[0]
                    print(f" rsp: {get_value('rsp')}")
                    if isinstance(operand, int):
                        push(operand)
                        print(" push", operand)
                    elif isinstance(operand, str):
                        push(get_value(operand))
                        print(f" push {operand:} [{get_value(operand)}]")
                    else:
                        raise Exception(operand)
                    print(f" rsp: {get_value('rsp')}")

                case OpType.POP:
                    operand = operation.operand_list[0]
                    print(f" {operand}: {get_value(operand)}")
                    print(f" rsp: {get_value('rsp')}")
                    value = pop()
                    assign_value(operand, value)
                    print(f" {operand}: {get_value(operand)}")
                    print(f" rsp: {get_value('rsp')}")

                case OpType.MOV:
                    destination = operation.operand_list[0]
                    source = operation.operand_list[1]
                    
                    # check array index bound
                    if isinstance(source, ArrayAddress):
                        index: ConcolicVar = (
                            get_value(source.operand1)
                            + ConcolicVar(4) * get_value(source.operand2)
                            + ConcolicVar(source.offset)
                        )
                        low_bound = get_value("rsp")
                        up_bound = get_value("rbp")
                        # print(low_bound, up_bound, index)
                        if (
                            index.value < low_bound.value
                            or index.value > up_bound.value
                        ):
                            print("Index out of bound!")
                            print(f"low bound: {low_bound}")
                            print(f"up bound: {up_bound}")
                            print(f"index: {index}")

                            return None, total_constraint
                        else:
                            if index.variable != None:
                                total_constraint = simplify(
                                    And(
                                        total_constraint,
                                        index.variable >= low_bound.value,
                                        index.variable <= up_bound.value,
                                    )
                                )
                    print(f" {destination}: {get_value(destination)}")
                    print(f" {source}: {get_value(source)}")
                    assign_value(destination, get_value(source))
                    print(f" {destination}: {get_value(destination)}")

                case OpType.IDIV:
                    operand = operation.operand_list[0]
                    print(f" {operand}: {get_value(operand)}")
                    print(f" eax: {get_value('eax')}")
                    print(f" edx: {get_value('edx')}")

                    # check divided by zero
                    divisor = get_value(operand)
                    if divisor.value == 0:
                        print(f"Divided by Zero! Exiting!")
                        return None, total_constraint
                    elif divisor.variable != None:
                        total_constraint = simplify(
                            And(total_constraint, divisor.variable != 0)
                        )

                    quotient = get_value("eax") / get_value(operand)
                    remainder = get_value("eax") % get_value(operand)
                    assign_value("eax", quotient)
                    assign_value("edx", remainder)
                    print(f" {operand}: {get_value(operand)}")
                    print(f" eax: {get_value('eax')}")
                    print(f" edx: {get_value('edx')}")

                case OpType.IMUL:
                    if len(operation.operand_list) == 3:
                        for i in operation.operand_list:
                            print(f" {i}: {get_value(i)}")
                        result = get_value(operation.operand_list[1]) * get_value(
                            operation.operand_list[2]
                        )
                        assign_value(operation.operand_list[0], result)
                        print(
                            f" {operation.operand_list[0]}: {get_value(operation.operand_list[0])}"
                        )
                    elif len(operation.operand_list) == 2:
                        for i in operation.operand_list:
                            print(f" {i}: {get_value(i)}")
                        result = get_value(operation.operand_list[0]) * get_value(
                            operation.operand_list[1]
                        )
                        assign_value(operation.operand_list[0], result)
                        print(
                            f" {operation.operand_list[0]}: {get_value(operation.operand_list[0])}"
                        )
                    else:
                        raise Exception

                case OpType.SUB:
                    operand1 = operation.operand_list[0]
                    operand2 = operation.operand_list[1]
                    print(f" {operand1}: {get_value(operand1)}")
                    print(f" {operand2}: {get_value(operand2)}")
                    result = get_value(operand1) - get_value(operand2)
                    assign_value(operation.operand_list[0], result)
                    print(f" {operand1}: {get_value(operand1)}")

                case OpType.ADD:
                    operand1 = operation.operand_list[0]
                    operand2 = operation.operand_list[1]
                    print(f" {operand1}: {get_value(operand1)}")
                    print(f" {operand2}: {get_value(operand2)}")
                    result = get_value(operand1) + get_value(operand2)
                    assign_value(operation.operand_list[0], result)
                    print(f" {operand1}: {get_value(operand1)}")

                case OpType.SAL:
                    operand1 = operation.operand_list[0]
                    operand2 = operation.operand_list[1]
                    print(f" {operand1}: {get_value(operand1)}")
                    print(f" {operand2}: {get_value(operand2)}")
                    result = get_value(operand1) << get_value(operand2)
                    assign_value(operation.operand_list[0], result)
                    print(f" {operand1}: {get_value(operand1)}")

                case OpType.LEA:
                    operand1 = operation.operand_list[0]
                    operand2 = operation.operand_list[1]
                    if operand2.operand == "rip":
                        print(" Assertion failed!")
                        print(" Exiting!")
                        return 0, total_constraint
                    if not isinstance(operand2, Address):
                        raise Exception
                    print(f" {operand1}: {get_value(operand1)}")
                    print(f" {operand2}: {get_value(operand2.operand)}")
                    result = get_value(operand2.operand) + ConcolicVar(operand2.offset)
                    assign_value(operation.operand_list[0], result)
                    print(f" {operand1}: {get_value(operand1)}")

                case OpType.CDQ:
                    pass
                    # destination = "edx"
                    # source = "eax"
                    # print(f" {destination}: {get_value(destination)}")
                    # print(f" {source}: {get_value(source)}")
                    # assign_value(destination, get_value(source))
                    # print(f" {destination}: {get_value(destination)}")

                case OpType.CMP:
                    operand1 = operation.operand_list[0]
                    operand2 = operation.operand_list[1]
                    print(f" {operand1}: {get_value(operand1)}")
                    print(f" {operand2}: {get_value(operand2)}")
                    self.cmp_operand1 = get_value(operand1)
                    self.cmp_operand2 = get_value(operand2)

                case OpType.JG:
                    print(f" constraint: {total_constraint}")
                    result, constraint = self.cmp_operand1 > self.cmp_operand2
                    if result:
                        operation_index = self.parser.label_dict[
                            operation.operand_list[0]
                        ]
                        operation_index -= 1
                    total_constraint = simplify(And(total_constraint, constraint))
                    print(f" constraint: {total_constraint}")

                case OpType.JGE:
                    print(f" constraint: {total_constraint}")
                    result, constraint = self.cmp_operand1 > self.cmp_operand2
                    if result:
                        operation_index = self.parser.label_dict[
                            operation.operand_list[0]
                        ]
                        operation_index -= 1
                    total_constraint = simplify(And(total_constraint, constraint))
                    print(f" constraint: {total_constraint}")

                case OpType.JS:
                    print(f" constraint: {total_constraint}")
                    result, constraint = self.cmp_operand1 < self.cmp_operand2
                    if result:
                        operation_index = self.parser.label_dict[
                            operation.operand_list[0]
                        ]
                        operation_index -= 1
                    total_constraint = simplify(And(total_constraint, constraint))
                    print(f" constraint: {total_constraint}")

                case OpType.JNE:
                    print(f" constraint: {total_constraint}")
                    result, constraint = self.cmp_operand1 != self.cmp_operand2
                    if result:
                        operation_index = self.parser.label_dict[
                            operation.operand_list[0]
                        ]
                        operation_index -= 1
                    total_constraint = simplify(And(total_constraint, constraint))
                    print(f" constraint: {total_constraint}")

                case OpType.JNS:
                    print(f" constraint: {total_constraint}")
                    result, constraint = self.cmp_operand1 >= self.cmp_operand2
                    if result:
                        operation_index = self.parser.label_dict[
                            operation.operand_list[0]
                        ]
                        operation_index -= 1
                    total_constraint = simplify(And(total_constraint, constraint))
                    print(f" constraint: {total_constraint}")

                case OpType.JLE:
                    print(f" constraint: {total_constraint}")
                    result, constraint = self.cmp_operand1 <= self.cmp_operand2
                    if result:
                        operation_index = self.parser.label_dict[
                            operation.operand_list[0]
                        ]
                        operation_index -= 1
                    total_constraint = simplify(And(total_constraint, constraint))
                    print(f" constraint: {total_constraint}")

                case OpType.JMP:
                    operation_index = self.parser.label_dict[operation.operand_list[0]]
                    operation_index -= 1

                case OpType.CALL:
                    if operation.operand_list[0] == "userDefinedException":
                        print(" Raise userDefinedException!")
                        print(f" Constraint is {total_constraint}")
                        print(" Exiting!")
                        return None, total_constraint
                    push(operation_index)  # push return address
                    operation_index = self.parser.label_dict[operation.operand_list[0]]
                    operation_index -= 1

                case OpType.RET:
                    result_address: str | None = pop()
                    if result_address is None:
                        print(" Finishing!")
                        print(f" Result is {get_value('eax')}")
                        print(f" Constraint is {total_constraint}")
                        return get_value("eax"), total_constraint
                    elif isinstance(result_address, int):
                        print(" Returning")
                        print(f" result is {get_value('eax')}")
                        operation_index = result_address

                    else:
                        raise Exception(result_address)
                
                case OpType.NOP:
                    pass

                case _:
                    raise Exception(operation.type)

            operation_index += 1

        raise Exception

    def test(self, label_name: str, para_number: int, max_loop: int) -> bool:
        """
        test the function
        return True is not harmful input can be found
        """
        print()
        print()
        print("---begin testing---")
        solver = Solver()
        para_var_list: List[ArithRef] = []
        for i in range(para_number):
            tmp_x = Int(f"x{i}")
            para_var_list.append(tmp_x)
            solver.add(tmp_x > -2147483648, tmp_x < 2147483647)

        index = 0
        while index < max_loop and solver.check() == sat:
            model = solver.model()
            para_list: List[int] = [model[i].as_long() for i in para_var_list]
            print("---input---")
            print(para_list)
            result, constraint = self.run(label_name, para_list)
            solver.add(Not(constraint))
            if result == None:
                print(f"Find an input that can cause error in {index + 1} loops")
                print(para_list)
                return False
            print("Current Constraint:")
            print(solver.assertions())
            index += 1

        if solver.check() != sat:
            print("Can not find more inputs!")
        else:
            print("More inputs can be found!")
        print(f"Not harmful input is found in {index} loops")
        return True


# test code
if __name__ == "__main__":
    # parser = Parser("TestCode\\foo.c")
    # parser = Parser("TestCode\\div.c")
    parser = Parser("TestCode\\userDefinedException.c")
    # parser = Parser("TestCode\\array.c")

    executor = ConcolicExecutor(parser)

    # executor.run("loop", [8])
    # executor.run("loop", [3])
    # executor.run("fib2", [-1])
    # executor.run("loop")
    # executor.run("sum")
    # executor.run("div0", [1])
    # executor.run("div_a_b1", [1, 2])
    # executor.run("div_a_b5", [1, 2])
    # executor.run("array1", [2])
    # executor.run("array2", [2])
    # executor.run("array3", [4])

    # executor.test("fib3", 1, 10)
    # executor.test("div0", 1, 10)
    # executor.test("div_a_b1", 2, 10)
    # executor.test("div_a_b2", 2, 10)
    # executor.test("div_a_b3", 2, 10)
    # executor.test("div_a_b4", 2, 5)
    # executor.test("div_a_b5", 2, 5)
    # executor.test("array6", 2, 5)
    executor.test("user1", 3, 16)
    # executor.test("user2", 3, 5)
