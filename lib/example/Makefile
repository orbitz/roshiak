CAMLP4=
OCAMLC_OPTS=
OCAMLOPT_OPTS=

cources=

sources=$(cources)

sources_mli=$(cources:%.ml=%.mli)

native_cmx=$(sources:%.ml=%.cmx)

byte_cmo=$(sources:%.ml=%.cmo)

native_cmi=$(sources_mli:%.mli=%.cmi)

.PHONY: all native byte native-code byte-code test clean

all: native byte

native-code: native

byte-code: byte

test:

native:

byte:

# Dependencies
include ../Ocamlrules.mk.in
