.PHONY: all all_trampoline clean test test_trampoline examples examples_trampoline install

all:
	./env_trampoline all_trampoline

all_trampoline:
	$(MAKE) -C lib

test:
	./env_trampoline test_trampoline

test_trampoline: all
	$(MAKE) -C lib test
	$(MAKE) -C tests test

examples:
	./env_trampoline examples_trampoline

examples_trampoline: all
	$(MAKE) -C examples

install: all
	$(MAKE) -C lib install

clean:
	$(MAKE) -C lib clean
	$(MAKE) -C tests clean
	$(MAKE) -C examples clean

