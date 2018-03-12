INPUTS = -I menhir -I main -I ast
PACKAGES = -package llvm
OCB_FLAGS = -use-ocamlfind -use-menhir $(INPUTS) $(PACKAGES)
OCB = ocamlbuild $(OCB_FLAGS)

.PHONY: all

all:
	$(OCB) leet.native

hello: all
	./leet.native example/hello.leet

usage: all
	./leet.native