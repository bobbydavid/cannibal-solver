
TGT=cannibal
SRC=solver.ml main.ml

#############################################

OBJ=$(SRC:.ml=.cmo) $(SRC:.ml=.cmi)
.phony: target bear clean

$(TGT):
	ocamlc $(SRC) -o $(TGT)

bear: $(TGT)
	./$(TGT) ../scenarios/threeBears.inp

clean:
	rm -rf $(OBJ) $(TGT)
