
let print_usage () =
    print_newline ();
    print_endline  "OCaml Cannibal Program Solver";
    print_newline ();
    print_endline  "  Usage:";
    print_endline ("  " ^ Sys.argv.(0) ^ " [option flag(s)]");
    print_newline ();
    print_endline  "  Flags:";
    print_endline  "    -h\tPrint this help information";
    print_endline  "    ??\tFlags are not fully implemented yet :("

(* Given a filename, return the tuples that represent the players *)
let players_of_filename chan =
    let lines =
        let lines = ref[] in
        try
            while true; do
                lines := input_line chan :: !lines
            done; []
        with End_of_file ->
            close_in chan;
            List.rev !lines
    in
    let add_player players line =
        try
            let len = String.length line in
            let loc = String.rindex line ' ' + 1 in
            let weight_str = String.sub line loc (len - loc) in
            let weight =
                try
                    int_of_string weight_str
                with Failure(s) -> failwith ("Could not parse integer: '" ^
                weight_str ^ "' in line '" ^ line ^ "'")
            in
            let name = String.sub line 0 (loc - 1) in
            (weight, name) :: players
        with Not_found ->
            raise (Failure("Badly formatted input file on line " ^
            (string_of_int(List.length players + 1))))
    in
    List.fold_left add_player [] lines

let rec handle_args = function
    | [] -> ()
    | hd :: tl -> (
        match hd with
        | "-v" -> Debug.show_verbose.contents <- true
        | "-h"
        | "-help"
        | "--help" -> print_usage (); exit 0
        | s -> failwith("Unknown parameter: "^s)
    );
    handle_args tl

(* MAIN *)
let _ =
    handle_args(List.tl(Array.to_list Sys.argv));
    let input_channel = stdin (* open_in Sys.argv.(1) *) in
    let players = players_of_filename input_channel in
    let results = Solver.solve players in
    let print_event (day, name) =
        print_endline ("Day " ^ (string_of_int day) ^ ": " ^ name ^ " dies.")
    in
    List.iter print_event results

