PREFIX ?= /usr/local
LIBDIR ?= $(PREFIX)/lib
INCLUDEDIR ?= $(PREFIX)/include
NACLINCLUDEDIR ?= $(INCLUDEDIR)/nacl
ABI=$(shell build/bin/okabi | head -1)

all:
	./do

install:
	install -d $(LIBDIR)
	install -m 644 build/lib/$(ABI)/libnacl.a $(LIBDIR)
	install -d $(NACLINCLUDEDIR)
	install -m 644 build/include/$(ABI)/*.h $(NACLINCLUDEDIR)

clean:
	rm -rf build

.PHONY: all install clean
