TGT=main.native


#############################################

OBJ=$(SRC:.ml=.cmo) $(SRC:.ml=.cmi)
.phony: target bear big clean

target:
	ocamlbuild -libs bigarray main.native

bear:
	ocamlbuild -libs bigarray main.native -- ../scenarios/threeBears.inp

big:
	ocamlbuild -libs bigarray main.native -- ../scenarios/big.inp

clean:
	ocamlbuild -clean
