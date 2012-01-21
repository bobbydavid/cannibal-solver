
TGT=cannibal

.phony: target bear clean

$(TGT):
	ocamlc cannibal.ml -o $(TGT)

bear: $(TGT)
	./$(TGT) ../scenarios/threeBears.inp

clean:
	rm -rf cannibal.cmi cannibal.cmo $(TGT)
