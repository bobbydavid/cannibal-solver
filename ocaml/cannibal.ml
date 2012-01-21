type player = string * int;;

let print_usage () =
    print_newline ();
    print_endline "OCaml Cannibal Program Solver";
    print_newline ();
    print_endline "  Usage:";
    print_endline (" " ^ Sys.argv.(0) ^ " <input file>");
    print_newline () ;;

let lines_of_filename filename =
    let lines = ref[] in
    let chan = open_in filename in
    try
        while true; do
            lines := input_line chan :: !lines
        done; []
    with End_of_file ->
        close_in chan;
        List.rev !lines ;;

let player_of_line line =
    try
        let len = String.length line in
        let loc = String.rindex line ' ' - 1 in
        let weight_str = String.sub line (len - loc) loc in
        let weight = int_of_string weight_str in
        let name = String.sub line 0 (len - loc + 1) in
        (name, weight)
    with Not_found ->
        raise (Failure("Badly formatted input file"))

let print_player p =
    print_endline ("Name: " ^ (fst p) ^ "\t Weight: " ^ (string_of_int(snd p))) ;;




if Array.length Sys.argv != 2 then
    print_usage ()
else
    let lines = lines_of_filename Sys.argv.(1) in
    let x = List.map player_of_line lines in
    List.map print_player x; ()
