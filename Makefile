PREFIX ?= /usr/local
LIBDIR ?= $(PREFIX)/lib
INCLUDEDIR ?= $(PREFIX)/include
NACLINCLUDEDIR ?= $(INCLUDEDIR)/nacl
ABI=$(shell build/bin/okabi | head -1)

all:
	./do
	gcc -E shared.c -o build/work/shared-$(ABI)-expanded.c -I "build/include/$(ABI)"; \
	sed 's/export_//' < build/work/shared-$(ABI)-expanded.c > build/work/shared-$(ABI)-exports.c; \
	gcc -fPIC -shared -Wl,--no-undefined -o build/lib/$(ABI)/libnacl.so build/work/shared-$(ABI)-exports.c build/lib/$(ABI)/libnacl.a build/lib/$(ABI)/randombytes.o; \

install:
	install -d $(LIBDIR)
	install -m 755 build/lib/$(ABI)/libnacl.so $(LIBDIR)
	install -m 644 build/lib/$(ABI)/libnacl.a $(LIBDIR)
	install -d $(NACLINCLUDEDIR)
	install -m 644 build/include/$(ABI)/*.h $(NACLINCLUDEDIR)

clean:
	rm -rf build

.PHONY: all install clean
