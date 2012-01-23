TGT=main.native


#############################################

OBJ=$(SRC:.ml=.cmo) $(SRC:.ml=.cmi)
.phony: target bear clean

target:
	ocamlbuild -libs bigarray main.native

bear: $(TGT)
	./$(TGT) ../scenarios/threeBears.inp

big: $(TGT)
	./$(TGT) ../scenarios/big.inp

clean:
	ocamlbuild -clean
