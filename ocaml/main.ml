

let print_usage () =
    print_newline ();
    print_endline "OCaml Cannibal Program Solver";
    print_newline ();
    print_endline "  Usage:";
    print_endline (" " ^ Sys.argv.(0) ^ " <input file>");
    print_newline ()

let players_of_filename filename =
    let lines_of_filename filename =
        let lines = ref[] in
        let chan = open_in filename in
        try
            while true; do
                lines := input_line chan :: !lines
            done; []
        with End_of_file ->
            close_in chan;
            List.rev !lines
    in
    let lines = lines_of_filename filename in
    let weightname_of_line line =
        let len = String.length line in
        let loc = String.rindex line ' ' - 1 in
        let weight_str = String.sub line (len - loc) loc in
        let weight = int_of_string weight_str in
        let name = String.sub line 0 (len - loc - 1) in
        (weight, name)
    in
    let add_player players line =
        let (weight, name) =
            try
                weightname_of_line line
            with Not_found ->
                raise (Failure("Badly formatted input file on line " ^
                (string_of_int(List.length players + 1))))
        in
        (weight, name) :: players
    in
    List.fold_left add_player [] lines


let _ =
    if Array.length Sys.argv != 2 then
        print_usage ()
    else
        let players = players_of_filename Sys.argv.(1) in
        let result = Solver.solve players in
        let print_event (day, name) =
            print_endline ("Day " ^ (string_of_int day) ^ ": " ^ name ^ " dies.")
        in
        List.iter print_event result

