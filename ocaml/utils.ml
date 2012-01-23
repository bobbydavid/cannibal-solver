
(*
let rec factorial = function
    | 0 -> 1
    | n -> n * factorial (n - 1)

let nchoosek n k =
    (factorial n) / (factorial k * factorial (n - k))
*)

let rec count_bits = function
    | 0 -> 0
    | x -> (x mod 2) + count_bits (x lsr 1)

let divide_round_up x y =
    x / y + (if x mod y = 0 then 0 else 1)

let print_matrix mat =
    let print_i i = print_string (" " ^ (string_of_int i)) in
    let print_row r =
        print_string "[";
        Array.iter print_i r;
        print_endline " ]"
    in
    Array.iter print_row mat

let get_bit n bitnum =
    if (1 lsl bitnum) land n > 0 then 1 else 0

let set_bit n bitnum value =
    let mask = 1 lsl bitnum in
    if value = 1 then
        n lor mask
    else
        n land lnot mask

let string_of_bin num =
    if num = 0 then
        "0"
    else
        let rec do_print_bin n =
            if n = 0 then
                ""
            else
                (do_print_bin (n lsr 1)) ^ (string_of_int (n land 1))
        in
        do_print_bin num

