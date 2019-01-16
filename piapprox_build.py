from cffi import FFI
ffibuilder = FFI()

# cdef() expects a string listing the C types, functions and
# globals needed from Python. The string follows the C syntax.
ffibuilder.cdef("""
    float pi_approx(int n);
""")

# This describes the extension module "_pi_cffi" to produce.
ffibuilder.set_source("_pi_cffi",
"""
     #include "pi.h"   // the C header of the library
""",
     libraries=['piapprox'],extra_link_args=["-L."])   # library name, for the linker

if __name__ == "__main__":
    ffibuilder.compile(verbose=True)
