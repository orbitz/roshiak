CAMLP4=

OCAMLDEP_OPTS=-package core,async,sexplib.syntax,riakc -syntax camlp4o
OCAMLC_OPTS=$(OCAMLDEP_OPTS) -w '@f@p@u@s@40'
OCAMLOPT_OPTS=$(OCAMLDEP_OPTS)

LIB_MODULES=roshiak.ml
NON_LIB_MODULES=

BYTE_TARGETS=roshiak.cma
NATIVE_TARGETS=roshiak.cmxa

.PHONY: all test install

all: native-code byte-code

install: all
	ocamlfind install roshiak META $(BYTE_TARGETS) $(NATIVE_TARGETS) roshiak.a *.cmx *.cmi *.mli


test:

# Dependencies
include ../Ocamlrules.mk.in
