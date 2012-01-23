
(*
let rec factorial = function
    | 0 -> 1
    | n -> n * factorial (n - 1)

let nchoosek n k =
    (factorial n) / (factorial k * factorial (n - k))
*)

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


