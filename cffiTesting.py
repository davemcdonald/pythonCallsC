from _pi_cffi import  ffi, lib


if __name__ == "__main__":
    print(lib.pi_approx(1000))
