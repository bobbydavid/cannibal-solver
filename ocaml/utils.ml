
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

let rec string_of_comb n k =
    if n = 0 then
        ""
    else
        let mask = 1 lsl (n - 1) in
        let digit = if mask land k > 0 then "1" else "0" in
        digit ^ (string_of_comb (n-1) k)

