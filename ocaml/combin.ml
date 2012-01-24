open Utils

exception LastCombinError


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



let rec raw_options = function
    | 1 -> [ 1; ]
    | n -> (1 lsl (n - 1)) :: raw_options (n - 1)

let ancestors_of_scenario n k =
    assert (k < 1 lsl n);
    assert (k > 0);
    let rec cull_options options =
        match options with
        | hd :: tl ->
            if hd land k > 0 then
                cull_options tl
            else
                (hd lor k) :: cull_options tl
        | [] -> []
    in
    cull_options (raw_options n)



