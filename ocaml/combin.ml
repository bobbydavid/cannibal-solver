open Utils

exception FinalSuccessor


let rec n_choose_1 = function
    | 1 -> [ 1; ]
    | n -> (1 lsl (n - 1)) :: n_choose_1 (n - 1)

let n_choose_n n =
    [ ((1 lsl n) - 1); ]

(* Return a list of every n-choose-k *)
let rec get_all_combinations n k =
    assert (k > 0);
    assert (n > 0);
    if k = 1 then
        n_choose_1 n
    else if k = n then
        n_choose_n n
    else
        let grab =
            List.map ((+) (1 lsl (n-1))) (get_all_combinations (n-1) (k-1))
        in
        let dontgrab =
            get_all_combinations (n-1) k
        in
        List.append grab dontgrab

let slide_lsb_down x additional_ones =
    let rec shift_right (n, depth) =
        (* print_endline("shift_right n:"^(string_of_int n)^"; depth:"^(string_of_int depth)); *)
        if (n land 1 = 0) then
            shift_right (n lsr 1, depth + 1)
        else
            (n, depth)
    in
    let rec shift_left n depth ones =
        (* print_endline("shift_left n:"^(string_of_int n)^"; depth:"^(string_of_int depth)^"; ones:"^(string_of_int ones)); *)
        match depth with
        | 0 -> n
        | d ->
            if ones > 0 then
                shift_left ((n lsl 1) + 1) (d-1) (ones-1)
            else
                shift_left (n lsl 1) (d-1) 0
    in
    let (x, depth) = shift_right (x, 0) in
    let x = (x lsr 1) lsl 1 in
    shift_left x (depth + additional_ones) (1 + additional_ones)




let rec succ_combination n x accu =
    (* print_endline("n: "^(string_of_int n)^"; x: "^(string_of_int x)^"; accu: "^(string_of_int accu)); *)
    if x = 0 then (
        if n = 0 then
            raise FinalSuccessor
        else
            ((1 lsl (accu+1)) - 1) lsl (n - 1)
    ) else if (x land 1 = 0) then
        slide_lsb_down x accu
    else
        let new_n = n - 1 in
        let new_x = x lsr 1 in
        let new_accu = accu + 1 in
        succ_combination new_n new_x new_accu

(* Find the successor combination to 'x' in n-choose-k *)
let succ_combination n x =
    succ_combination n x 0




