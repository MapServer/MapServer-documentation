import os
import types
import inspect
import io
import mapscript

OUTPUT_FUNCTIONS_FILE = r"../../en/mapscript/mapscript-api/functions.rst"
OUTPUT_CLASSES_FILE = r"../../en/mapscript/mapscript-api/classes.rst"


def write_output(output_file, header, output):

    with io.open(output_file, "w", newline="\n") as f:
        f.write(header)
        for p in sorted(output):
            f.write("    {}\n".format(p))


def get_properties():

    props = dir(mapscript)
    constants = [p for p in props if isinstance(getattr(mapscript, p), int)]

    properties = [
        p
        for p in props
        if p not in constants
        and not p.endswith("_swigregister")
        and not p.startswith("_")
        # the following don't have docstrings and are hidden for now
        and p not in ("MapServerError", "MapServerChildError", "intarray", "CompositingFilter", 
                      "LayerCompositer", "intarray_frompointer")
    ]

    return properties


def output_classes(output_file):

    properties = get_properties()
    print("The following classes are available in mapscript:")
    classes = [p for p in properties if inspect.isclass(getattr(mapscript, p))]

    for c in classes:
        print("    {}".format(c))

    header = """
.. currentmodule:: mapscript

.. autosummary::
    :toctree: stub
    :template: class.rst

"""

    write_output(output_file, header, classes)


def output_functions(output_file):

    properties = get_properties()
    print("The following functions are available on the mapscript object:")

    functions = [
        "mapscript.{}".format(p)
        for p in properties
        if isinstance(getattr(mapscript, p), types.FunctionType)
    ]
    for f in sorted(functions):
        print("    {}".format(f))

    header = """

.. currentmodule:: mapscript

.. autosummary::

"""

    write_output(output_file, header, functions)


def main():
    output_functions(OUTPUT_FUNCTIONS_FILE)
    output_classes(OUTPUT_CLASSES_FILE)


if __name__ == "__main__":
    main()
    print("Done!")
