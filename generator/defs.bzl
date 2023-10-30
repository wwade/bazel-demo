load("@bazel_skylib//lib:paths.bzl", "paths")

def _my_code_gen_impl(ctx):
    outName = paths.split_extension(ctx.files.src[0].basename)[0]
    outputs = [
        ctx.actions.declare_file(outName + ".c"),
    ]
    args = []
    for f in ctx.features:
        if f.startswith("gencount="):
            args += ["--count", f.split("gencount=", 1)[1]]
    args += ctx.attr.gen_opts
    args.append(ctx.files.src[0].path)
    args.append(outputs[0].path)
    ctx.actions.run(
        outputs = outputs,
        inputs = ctx.files.src,
        executable = ctx.attr._generate.files_to_run.executable,
        arguments = args,
    )

    return [DefaultInfo(files = depset(outputs))]

my_code_gen = rule(
    implementation = _my_code_gen_impl,
    attrs = {
        "gen_opts": attr.string_list(),
        "src": attr.label(allow_files = [".gen"]),
        "_generate": attr.label(
            default = Label(":generate"),
            executable = True,
            cfg = "exec",
        ),
    },
)
