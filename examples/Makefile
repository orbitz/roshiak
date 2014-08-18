CAMLP4=
OCAMLC_OPTS=-w '@f@p@u@s@40'
OCAMLOPT_OPTS=$(OCAMLC_OPTS)

NON_LIB_MODULES=

EXTERNAL_DEPS=

native_bin=$(NON_LIB_MODULES:%.ml=%.native)

byte_bin=$(NON_LIB_MODULES:%.ml=%.byte)

.PHONY: all native-code byte-code test clean

all: native-code byte-code

native-code: $(native_bin)

byte-code: $(byte_bin)

test: all

clean: extra_clean

extra_clean:
	-rm -f *.native *.byte *.cmx *.cmo *.o *.cmi

# Dependencies
include ../lib/Ocamlrules.mk.in
