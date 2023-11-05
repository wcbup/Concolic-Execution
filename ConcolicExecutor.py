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
        
        def get_value(x: int | str) -> int | None:
            if isinstance(x, int):
                return x
            elif isinstance(x, str):
                return self.register_dict[x]
            else:
                raise Exception
        
        def assign_value(destination: str, value: int) -> None:
            if not isinstance(value, int):
                raise Exception(value)
            
            if isinstance(destination, str):
                self.register_dict[destination] = value
            else:
                raise Exception(destination)

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

            code.print()
            operation = code.operation

            match operation.type:
                case OpType.PUSH:
                    operand = operation.operand_list[0]
                    if isinstance(operand, int):
                        push(operand)
                        print(" push", operand)
                    elif isinstance(operand, str):
                        push(get_value(operand))
                        print(f" push {operand:} [{get_value(operand)}]")
                    else:
                        raise Exception(operand)
                
                case OpType.MOV:
                    destination = operation.operand_list[0]
                    source = operation.operand_list[1]
                    print(f" {destination}: {get_value(destination)}")
                    print(f" {source}: {get_value(source)}")

                    assign_value(destination, get_value(source))

                    print(f" {destination}: {get_value(destination)}")
                
                case _:
                    raise Exception(operation.type)


# test code
if __name__ == "__main__":
    parser = Parser("TestCode\\foo.c")
    # parser = Parser("TestCode\\div.c")
    # parser = Parser("TestCode\\userDefinedException.c")

    executor = ConcolicExecutor(parser)

    executor.run("foo", [2])
