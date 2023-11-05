from __future__ import annotations
from Parser import Parser, OpType
from typing import Dict, List


class ConcolicExecutor:
    def __init__(self, parser: Parser) -> None:
        self.parser = parser
        self.register_dict: Dict[str, int | str | None] = {}
        self.memory_array = [0] * 10_000

    def run(self, label_name: str, parameter_list: List[int]) -> None:
        # init return address
        self.register_dict["ret"] = None
        # init rsp
        self.register_dict["rsp"] = 9000
        self.register_dict["rbp"] = None

        def push(x: int | None) -> None:
            # push x on the stack
            self.register_dict["rsp"] -= 4
            self.memory_array[self.register_dict["rsp"]] = x

        # init parameters
        para_len = len(parameter_list)
        if para_len >= 1:
            self.register_dict["rcx"] = parameter_list[0]
        if para_len >= 2:
            self.register_dict["rdx"] = parameter_list[1]
        if para_len >= 3:
            self.register_dict["r8"] = parameter_list[2]
        if para_len >= 4:
            self.register_dict["r8"] = parameter_list[2]
        if para_len > 4:
            # TBD
            raise Exception

        print("---begin running---", label_name)
        for code in self.parser.code_dict[label_name]:
            match code.operation.type:
                case OpType.PUSH:
                    code.print()
                    operand = code.operation.operand_list[0]
                    if isinstance(operand, int):
                        push(operand)
                        print(" push", operand)
                    elif isinstance(operand, str):
                        push(self.register_dict[operand])
                        print(f" push {operand:} [{self.register_dict[operand]}]")
                    else:
                        raise Exception(operand)
                
                case _:
                    raise Exception(code.operation.type)


# test code
if __name__ == "__main__":
    parser = Parser("TestCode\\foo.c")
    # parser = Parser("TestCode\\div.c")
    # parser = Parser("TestCode\\userDefinedException.c")

    executor = ConcolicExecutor(parser)

    executor.run("foo", [2])
