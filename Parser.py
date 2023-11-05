from __future__ import annotations
import os
import re
from enum import Enum
from typing import List


class CodeType(Enum):
    MISC = 0  # miscellaneous, should be ignore
    LABEL = 1
    OP = 2  # operation


class Code:
    def __init__(self, raw_str: str) -> None:
        self.raw_str = raw_str
        if ":" in raw_str and '\"' not in raw_str:
            self.type = CodeType.LABEL
        elif raw_str[0] == ".":
            self.type = CodeType.MISC
        else:
            self.type = CodeType.OP


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
            print(code.type, code.raw_str)


# test code
if __name__ == "__main__":
    parser = Parser("TestCode\\foo.c")
