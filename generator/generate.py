#!/usr/bin/env python3

import argparse
import json

cfile = """
#include <stdio.h>

int main(int argc, char **argv) {{
{body}
  return 0;
}}
"""


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("genfile", metavar="INPUT", type=argparse.FileType(mode="r"))
    ap.add_argument("outfile", metavar="OUTPUT")
    ap.add_argument("--count", type=int, default=1)
    args = ap.parse_args()

    data = json.load(args.genfile)
    msg = data["msg"]

    body = args.count * f"""  printf("{msg}\\n");\n"""
    with open(args.outfile, "w") as fp:
        print(cfile.format(body=body).strip(), file=fp)


main()
