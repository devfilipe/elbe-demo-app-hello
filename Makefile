CC      ?= gcc
PREFIX  ?= /usr
BINDIR   = $(PREFIX)/bin

all: hello

hello: hello.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<

install: hello
	install -Dm755 hello $(DESTDIR)$(BINDIR)/hello

clean:
	rm -f hello
