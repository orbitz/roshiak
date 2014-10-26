CAMLP4=
OCAMLC_OPTS=-w '@f@p@u@s@40' -package core,async,riakc,roshiak
OCAMLOPT_OPTS=$(OCAMLC_OPTS)

NON_LIB_MODULES=roshiak_cli.ml

EXTERNAL_DEPS=../lib/roshiak/roshiak.cma ../lib/roshiak/roshiak.cmxa

native_bin=$(NON_LIB_MODULES:%.ml=%.native)

byte_bin=$(NON_LIB_MODULES:%.ml=%.byte)

.PHONY: all native-code byte-code test clean

all: native-code byte-code

native-code: $(native_bin)

byte-code: $(byte_bin)

roshiak_cli.native: roshiak_cli.cmx

roshiak_cli.byte: roshiak_cli.cmo

test: all

clean: extra_clean

extra_clean:
	-rm -f *.native *.byte *.cmx *.cmo *.o *.cmi

# Dependencies
include ../lib/Ocamlrules.mk.in
