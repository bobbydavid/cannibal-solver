open Utils

exception LastCombinError

let s_of_i i = "'" ^ (string_of_bin i) ^ "' (" ^ (string_of_int i) ^ ")"

(* Return the first permutation of k 1's in an n-digit number *)
let do_first_combin n k =
    let ones = (1 lsl k) - 1 in
    ones lsl (n - k)

(* Return the next permutation, given the current (and n-digits) *)
let do_next_combin n k =
    assert(k > 0);
    if get_bit k 0 = 0 then
        (* Move the farthest-right 1 *)
        let rec slide k ix =
            print_endline((string_of_int k) ^ " " ^ (string_of_int ix) ^ " " ^ (string_of_int(get_bit k ix)));
            if get_bit k ix = 1 then
                set_bit (set_bit k ix 0) (ix - 1) 1
            else
                slide k (ix + 1)
        in
        slide k 1
    else
        (* Rollover *)
        let rec roll k ix =
            if k lsr ix = 0 then raise LastCombinError else
            if get_bit k ix = 0 then
                ((k lsr ix) + 1) lsl (ix - 1)
            else
                roll k (ix + 1)
        in
        roll k 0

let first_combin n k =
    let ret = do_first_combin n k in
    print_endline("First permuate: " ^ (s_of_i ret));
    ret

let next_combin n k =
    print_string("combin " ^ (s_of_i k));
    let ret = do_next_combin n k in
    print_endline(" -> " ^ (s_of_i ret));
    ret



