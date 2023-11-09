from __future__ import annotations
import os
import re
from enum import Enum
from typing import List, Dict


class CodeType(Enum):
    MISC = 0  # miscellaneous, should be ignore
    LABEL = 1
    OP = 2  # operation


class OpType(Enum):
    PUSH = 1
    MOV = 2
    SUB = 3
    ADD = 4
    POP = 5
    RET = 6
    SAL = 7  # shift arithmetic left
    CDQ = 8  # edx = eax
    IDIV = 9
    IMUL = 10


class Address:
    def __init__(self, raw_str: str) -> None:
        result = re.search(r"[\-]{0,1}[\d]*\[.+\]", raw_str)
        address_str = result.group(0)
        offset_result = re.search(r"-{0,1}\d+", address_str)
        if offset_result != None:
            self.offset = int(offset_result.group(0))
        else:
            self.offset = 0
        operand_result = re.search(r"\[(.+)\]", address_str)
        self.operand = operand_result.group(1)

    def __str__(self) -> str:
        return f"offset: {self.offset}, operand: {self.operand}"


class Operation:
    def __init__(self, raw_str: str) -> None:
        self.operand_list: List[str | int | Address] = []

        if "push" in raw_str:
            if "[" in raw_str:
                raise Exception(raw_str)
            self.type = OpType.PUSH
            result = re.search(r"(\bpush\b)\s+(\b\w+)", raw_str)
            self.operand_list = [result.group(2)]

        elif "mov" in raw_str:
            self.type = OpType.MOV
            result = re.search(r"(\bmov\b)\s+(\b.+),\s+(\b.+)", raw_str)
            for i in range(2, 4):
                operand_str = result.group(i)
                if "[" in operand_str:
                    self.operand_list.append(Address(operand_str))
                elif operand_str.lstrip("-").isdigit():
                    self.operand_list.append(int(operand_str))
                else:
                    self.operand_list.append(operand_str)

        elif "sub" in raw_str:
            if "[" in raw_str:
                raise Exception(raw_str)
            self.type = OpType.SUB
            result = re.search(r"sub\s+(\w+),\s+([\w]+)", raw_str)
            for i in range(1, 3):
                operand_str = result.group(i)
                if operand_str.isdigit():
                    self.operand_list.append(int(operand_str))
                else:
                    self.operand_list.append(operand_str)

        elif "add" in raw_str:
            if "[" in raw_str:
                raise Exception(raw_str)
            self.type = OpType.ADD
            result = re.search(r"add\s+(\w+),\s+([\w]+)", raw_str)
            for i in range(1, 3):
                operand_str = result.group(i)
                if operand_str.isdigit():
                    self.operand_list.append(int(operand_str))
                else:
                    self.operand_list.append(operand_str)

        elif "sal" in raw_str:
            if "[" in raw_str:
                raise Exception(raw_str)
            self.type = OpType.SAL
            result = re.search(r"sal\s+(\w+),\s+([\w]+)", raw_str)
            for i in range(1, 3):
                operand_str = result.group(i)
                if operand_str.isdigit():
                    self.operand_list.append(int(operand_str))
                else:
                    self.operand_list.append(operand_str)

        elif "pop" in raw_str:
            if "[" in raw_str:
                raise Exception(raw_str)
            self.type = OpType.POP
            result = re.search(r"pop\s+(\w+)", raw_str)
            self.operand_list.append(result.group(1))

        elif "ret" in raw_str:
            self.type = OpType.RET

        elif "cdq" in raw_str:
            self.type = OpType.CDQ

        elif "idiv" in raw_str:
            self.type = OpType.IDIV

        elif "imul" in raw_str:
            self.type = OpType.IMUL

        else:
            raise Exception(raw_str)


class Code:
    def __init__(self, raw_str: str) -> None:
        self.raw_str = raw_str
        if ":" in raw_str and '"' not in raw_str:
            self.type = CodeType.LABEL
            self.label_str = raw_str.rstrip(":")

        elif raw_str[0] == ".":
            self.type = CodeType.MISC
        else:
            self.type = CodeType.OP
            self.operation = Operation(raw_str)

    def print(self) -> None:
        match self.type:
            case CodeType.LABEL:
                print(self.type, self.raw_str)
                print(" ", self.label_str)

            case CodeType.OP:
                print(self.type, self.operation.type, self.raw_str)
                match self.operation.type:
                    case OpType.PUSH:
                        print(" ", self.operation.operand_list)

                    case OpType.MOV:
                        print(
                            " ",
                            [
                                str(i) if isinstance(i, Address) else i
                                for i in self.operation.operand_list
                            ],
                        )

                    case OpType.SUB:
                        print(" ", self.operation.operand_list)

                    case OpType.ADD:
                        print(" ", self.operation.operand_list)

                    case OpType.SAL:
                        print(" ", self.operation.operand_list)

                    case OpType.POP:
                        print(" ", self.operation.operand_list)

                    case OpType.CDQ:
                        print()

                    case OpType.RET:
                        print()

                    case _:
                        raise Exception(self.operation.type)

            case _:
                raise Exception


class Parser:
    def __init__(self, c_file_path: str) -> None:
        # convert c code into assembly
        dot_loc = c_file_path.rfind(".")
        assembly_path = c_file_path[:dot_loc] + ".s"
        command = (
            f"gcc -S -fverbose-asm -masm=intel -O0 {c_file_path} -o {assembly_path}"
        )
        os.system(command)

        # load assembly code
        with open(assembly_path, "r") as file:
            # ignore comment
            self.assembly_str_list = re.sub("#.*\n", "\n", file.read()).split("\n")
            # remove spaces
            self.assembly_str_list = [i.strip() for i in self.assembly_str_list]
            # remove empty str
            self.assembly_str_list = list(
                filter(lambda a: a != "", self.assembly_str_list)
            )

        self.code_list: List[Code] = []
        for code_str in self.assembly_str_list:
            tmp_code = Code(code_str)
            if tmp_code.type != CodeType.MISC:
                self.code_list.append(tmp_code)

        for code in self.code_list:
            code.print()

        self.code_dict: Dict[str, List[Code]] = {}
        for code in self.code_list:
            if code.type == CodeType.LABEL:
                self.code_dict[code.label_str] = []
                current_label_str = code.label_str
            else:
                self.code_dict[current_label_str].append(code)

        for labe_str in self.code_dict:
            print(f"---{labe_str}---")
            for code in self.code_dict[labe_str]:
                code.print()


# test code
if __name__ == "__main__":
    parser = Parser("TestCode\\foo.c")
    # parser = Parser("TestCode\\div.c")
    # parser = Parser("TestCode\\userDefinedException.c")
