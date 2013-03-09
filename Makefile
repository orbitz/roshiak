.PHONY: all clean test

all:
	$(MAKE) -C lib

test:
	$(MAKE) -C lib test

clean:
	$(MAKE) -C lib clean

