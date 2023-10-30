load("@generator//:defs.bzl", _my_code_gen = "my_code_gen")

def my_code_gen(*args, **kwargs):
    if "gen_opts" not in kwargs:
        kwargs["gen_opts"] = ["--count", "3"]
    _my_code_gen(*args, **kwargs)
