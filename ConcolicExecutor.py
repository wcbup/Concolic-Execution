from __future__ import annotations
from Parser import Parser
from typing import Dict


class ConcolicExecutor:
    def __init__(self, parser: Parser) -> None:
        self.parser = parser
        self.register_dict: Dict[str, int] = {}
        self.memory_array = [0] * 10000


# test code
if __name__ == "__main__":
    parser = Parser("TestCode\\foo.c")
    # parser = Parser("TestCode\\div.c")
    # parser = Parser("TestCode\\userDefinedException.c")

    executor = ConcolicExecutor(parser)
