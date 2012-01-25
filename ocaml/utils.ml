open Bigarray

let rec count_bits = function
    | 0 -> 0
    | x -> (x mod 2) + count_bits (x lsr 1)

let divide_round_up x y =
    x / y + (if x mod y = 0 then 0 else 1)

let rec ints_below_n n =
    if n = 0 then
        []
    else
        (n - 1) :: ints_below_n (n - 1)

(*
let rec find_nth_bit n skips =
    let this_bit = n land 1 in
    if (this_bit = 1 && skips = 0) then
        0
    else
        1 + find_nth_bit (n lsr 1) (skips - this_bit)
*)
let find_nth_bit n k =
    let kth = 1 lsl k in
    assert(count_bits(n land kth) = 1);
    count_bits(n land (kth - 1))

let print_matrix mat =
    let x_dim = Array2.dim1 mat in
    let y_dim = Array2.dim2 mat in
    print_endline("<"^(string_of_int x_dim)^" x "^(string_of_int y_dim)^">");
    let print_cell x y = print_string ("\t" ^ (string_of_int mat.{x,y})) in
    let rec print_row x y =
        if y < y_dim then (
            print_cell x y;
            print_row x (succ y)
        ) else
            ()
    in
    let rec print_col x =
        if x < x_dim then (
            print_string "[";
            print_row x 0;
            print_endline "]";
            print_col (succ x)
        ) else
            ()
    in
    print_col 0

let rec string_of_comb n k =
    if n = 0 then
        ""
    else
        let mask = 1 lsl (n - 1) in
        let digit = if mask land k > 0 then "1" else "0" in
        digit ^ (string_of_comb (n-1) k)

let find_max_set fn set =
    let do_find_max_set fn (max, max_value) cur =
        match max with
        | [] -> ([ cur; ], fn cur)
        | max -> (
            let cur_value = fn cur in
            match compare cur_value max_value with
            | -1 -> (max, max_value)
            |  0 -> (cur :: max, max_value)
            |  1 -> ([ cur; ], cur_value)
            |  n -> failwith "Unexpected result from compare"
        )
    in
    fst (List.fold_left (do_find_max_set fn) ([], 0) set)




