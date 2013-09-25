.PHONY: all clean test

all:
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

clean:
	$(MAKE) -C lib clean
	$(MAKE) -C tests clean
	$(MAKE) -C examples clean

