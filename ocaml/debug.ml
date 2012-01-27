



(* TODO:
 * 1. Add some cool debug printing functions here
 * 2. Add switches to turn them on in main.ml
 * 3. Add description of the switches to print_usage()
 *)

let show_verbose = ref false


let block_freq = ref 0x7FFF
let print_block_num k =
    if !show_verbose && (k land !block_freq) = 1 then
        print_endline("Allocating block: "^(string_of_int k))
    else
        ()


let previous_max_ones = ref (-1)
let print_biggest_combination zeros ones =
    if !show_verbose && ones > !previous_max_ones then (
        previous_max_ones := ones;
        let n = zeros + ones in
        let ones = ones + 1 in
        print_endline("Beginning combinations of "^(string_of_int n)^"-choose-"^(string_of_int ones))
    ) else
        ()

