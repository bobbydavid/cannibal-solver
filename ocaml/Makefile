TGT=main.native


#############################################

OBJ=$(SRC:.ml=.cmo) $(SRC:.ml=.cmi)
.phony: target bear big clean

target:
	ocamlbuild -lib bigarray main.native

bear:
	ocamlbuild -lib bigarray main.native -- ../scenarios/threeBears.inp

big:
	ocamlbuild -lib bigarray main.native -- ../scenarios/big.inp

clean:
	ocamlbuild -clean
