.POSIX:

# Lots of stuff adapted form https://wiki.haskell.org/Calling_Haskell_from_C
# But I guess it is a bit outdated and wrong... but it works I guess

all:sshc

sshc main.o:Main.hi Main.o Main_stub.h
	stack ghc -- --make -no-hs-main -optc-O main.c Main -o sshc

Main.hi Main.o Main_stub.h:Main.hs
	stack ghc -- -c -O Main.hs

clean:
	rm -f Main.hi Main.o Main_stub.h sshc main.o
