
TGT=cannibal
SRC=utils.ml solver.ml main.ml

#############################################

OBJ=$(SRC:.ml=.cmo) $(SRC:.ml=.cmi)
.phony: target bear clean

$(TGT): $(SRC)
	ocamlc $(SRC) -o $(TGT)

bear: $(TGT)
	./$(TGT) ../scenarios/threeBears.inp

big: $(TGT)
	./$(TGT) ../scenarios/big.inp

clean:
	rm -rf $(OBJ) $(TGT)
