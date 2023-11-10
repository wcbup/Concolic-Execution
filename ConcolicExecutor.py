from __future__ import annotations
from Parser import Parser, OpType, Address
from typing import Dict, List


class ConcolicExecutor:
    def __init__(self, parser: Parser, parameter_list: List[int]) -> None:
        self.parser = parser
        self.register_dict: Dict[str, int | None] = {}
        self.memory_array: List[None | int] = [None] * 10_000

        # init return address
        self.register_dict["ret"] = None
        # init register
        self.register_dict["rsp"] = 9000
        self.register_dict["rbp"] = 9000
        self.register_dict["rbx"] = None
        self.register_dict["eax"] = None
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

    def run(self, label_name: str) -> int | None:
        def push(x: int | None) -> None:
            # push x on the stack
            self.register_dict["rsp"] -= 8
            self.memory_array[self.register_dict["rsp"]] = x

        def pop() -> int | None | str:
            # pop the stack
            value = self.memory_array[self.register_dict["rsp"]]
            self.register_dict["rsp"] += 8
            return value

        def get_value(x: int | str | Address) -> int | None:
            if isinstance(x, int):
                return x
            elif isinstance(x, str):
                return self.register_dict[x]
            elif isinstance(x, Address):
                return self.memory_array[get_value(x.operand) + x.offset]
            else:
                raise Exception(x)

        def assign_value(destination: str | Address, value: int) -> None:
            if not isinstance(value, int):
                raise Exception(value)

            if isinstance(destination, str):
                self.register_dict[destination] = value
            elif isinstance(destination, Address):
                self.memory_array[
                    get_value(destination.operand) + destination.offset
                ] = value
            else:
                raise Exception(destination)

        print("---begin running---", label_name)
        for code in self.parser.code_dict[label_name]:
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
                    print(f" {destination}: {get_value(destination)}")
                    print(f" {source}: {get_value(source)}")
                    assign_value(destination, get_value(source))
                    print(f" {destination}: {get_value(destination)}")

                case OpType.IDIV:
                    operand = operation.operand_list[0]
                    print(f" {operand}: {get_value(operand)}")
                    print(f" eax: {get_value('eax')}")
                    print(f" edx: {get_value('edx')}")
                    quotient = int(get_value("eax") / get_value(operand))
                    remainder = get_value("eax") % get_value(operand)
                    assign_value("eax", quotient)
                    assign_value("edx", remainder)
                    print(f" {operand}: {get_value(operand)}")
                    print(f" eax: {get_value('eax')}")
                    print(f" edx: {get_value('edx')}")

                case OpType.IMUL:
                    if len(operation.operand_list) != 3:
                        raise Exception
                    operand_list: List[int | str] = []
                    for i in operation.operand_list:
                        print(f" {i}: {get_value(i)}")
                    result = get_value(operation.operand_list[1]) * get_value(
                        operation.operand_list[2]
                    )
                    assign_value(operation.operand_list[0], result)
                    print(
                        f" {operation.operand_list[0]}: {get_value(operation.operand_list[0])}"
                    )

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
                    if not isinstance(operand2, Address):
                        raise Exception
                    print(f" {operand1}: {get_value(operand1)}")
                    print(f" {operand2}: {get_value(operand2.operand)}")
                    result = get_value(operand2.operand) + operand2.offset
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
                    if self.cmp_operand1 > self.cmp_operand2:
                        self.run(operation.operand_list[0])

                case OpType.JNE:
                    if self.cmp_operand1 != self.cmp_operand2:
                        self.run(operation.operand_list[0])

                case OpType.CALL:
                    push(None)  # push placeholder (return address)
                    self.run(operation.operand_list[0])

                case OpType.RET:
                    result_address: str | None = pop()
                    if result_address is None:
                        print(" Returning!")
                        print(f" result is {get_value('eax')}")
                        return get_value("eax")
                    else:
                        raise Exception(result_address)

                case _:
                    raise Exception(operation.type)

        raise Exception


# test code
if __name__ == "__main__":
    parser = Parser("TestCode\\foo.c")
    # parser = Parser("TestCode\\div.c")
    # parser = Parser("TestCode\\userDefinedException.c")

    executor = ConcolicExecutor(parser, [5])

    # executor.run("foo")
    executor.run("fib")
    # executor.run("sum", [1, 2, 3, 4, 5, 6, 7])
