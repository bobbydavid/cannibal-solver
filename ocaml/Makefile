TGT=main.native


#############################################

OBJ=$(SRC:.ml=.cmo) $(SRC:.ml=.cmi)
.phony: debug fast bear big clean

debug:
	ocamlbuild -cflag -g -lflag -g -lib bigarray main.byte

fast:
	ocamlbuild -lib bigarray main.native

bear: debug
	ocamlrun -b ./main.byte < ../scenarios/threeBears.inp

big: debug
	ocamlrun -b ./main.byte < ../scenarios/big.inp

clean:
	ocamlbuild -clean
