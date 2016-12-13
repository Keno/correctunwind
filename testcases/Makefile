CC_INVOKE=export PATH=$(CURDIR)/../usr/bin/:$$PATH && \
	gcc -v -Wl,--rpath=$(CURDIR)/../usr/lib/ \
	  -Wl,--dynamic-linker=$(CURDIR)/../usr/lib/ld-linux-x86-64.so.2 \
     -nodefaultlibs -nostartfiles $(CURDIR)/../usr/lib/Scrt1.o $(CURDIR)/../usr/lib/crti.o \
	 $(CURDIR)/../usr/lib/gcc/x86_64-pc-linux-gnu/7.0.0/crtbeginS.o
CC_INVOKE_POSTFIX=$(CURDIR)/../usr/lib/gcc/x86_64-pc-linux-gnu/7.0.0/crtendS.o $(CURDIR)/../usr/lib/crtn.o \
     $(CURDIR)/../usr/lib/libc_nonshared.a $(CURDIR)/../usr/lib/libc.so
all: obj/hello obj/rr_block
obj:
	mkdir obj
obj/hello: hello.c obj
	$(CC_INVOKE) -o obj/hello hello.c $(CC_INVOKE_POSTFIX)
obj/rr_block: rr_block.c obj
	$(CC_INVOKE) -g -o obj/rr_block rr_block.c $(CC_INVOKE_POSTFIX) \
		$(CURDIR)/../usr/lib/libpthread.so
