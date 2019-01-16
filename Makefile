src = $(wildcard *.c)
obj = $(src:.c=.o)
dep = $(obj:.o=.d)  # one dependency file for each source

LDFLAGS = -L. -lpiapprox
SO_LDFLAGS =
CFLAGS = -fPIC

all: libpiapprox.so _pi_cffi.so

libpiapprox.so: $(obj)
	$(CC) -shared -o $@ $^ $(SO_LDFLAGS)

-include $(dep)   # include all dep files in the makefile

# rule to generate a dep file by using the C preprocessor
# (see man cpp for details on the -MM and -MT options)
%.d: %.c
	@$(CPP) $(CFLAGS) $< -MM -MT $(@:.d=.o) >$@

_pi_cffi.so: libpiapprox.so
	python piapprox_build.py
	rm _pi_cffi.o _pi_cffi.c

.PHONY: clean
clean:
	rm -f $(obj) pi *.so _pi_cffi.o _pi_cffi.c

.PHONY: cleandep
cleandep:
	rm -f $(dep)
