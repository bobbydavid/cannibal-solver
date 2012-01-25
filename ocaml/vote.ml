
open Bigarray

type pdatum_t = int * int * string
type preference_t = Heavier | Lighter
exception MultipleWinners of pdatum_t list

let ix_of pdatum     = let (i,_,_) = pdatum in i
let weight_of pdatum = let (_,w,_) = pdatum in w
let name_of pdatum   = let (_,_,n) = pdatum in n

let rec collect_players scenario players =
    match players with
    | [] -> []
    | hd :: tl ->
        if scenario land 1 = 1 then
            (hd :: collect_players (scenario lsr 1) tl)
        else
            (collect_players (scenario lsr 1) tl)

let ix_of_winner = function
    | [] -> failwith("Bug: trying to choose winner from the empty set")
    | hd :: [] -> ix_of hd
    | hd :: tl -> raise(MultipleWinners(hd :: tl))

let break_tie_by_weight pref pdata =
    let pdata_subset = match pref with
        | Lighter -> Utils.find_max_set (fun x -> -(weight_of x)) pdata
        | Heavier -> Utils.find_max_set weight_of pdata
    in
    ix_of_winner pdata_subset

let break_tie_by_name pdata =
    (* TODO: Tiebreaking by name! *)
    print_endline("Tiebreaking by name is not supported yet");
    ix_of (List.hd pdata)

let resolve_winner pref pdata =
    try
        ix_of_winner pdata
    with MultipleWinners(pdata) ->
    try
        break_tie_by_weight pref pdata
    with MultipleWinners(pdata_subset) ->
    try
        break_tie_by_name pdata_subset
    with MultipleWinners(pdatum :: _) ->
        failwith("Tiebreaking failed because multiple people had the name: "^(name_of pdatum))

let make_up_your_mind pdata block_slice pdatum =
    let remap_index (_,w,n) ix = (ix,w,n) in
    let rec remap_indexes pdata ix = match pdata with
        | [] -> []
        | hd :: tl -> remap_index hd ix :: remap_indexes tl (ix+1)
    in
    let pdata = remap_indexes pdata 0 in
    let block_list = Utils.list_of_array1 block_slice in
    let zipped_list = List.combine block_list pdata in
    print_endline(
        (name_of pdatum) ^
        " deciding based on days to live: " ^
        (List.fold_left (fun s i -> s^" "^(string_of_int i)) "" block_list)
    );
    let (_, pdata_subset) = List.split (Utils.find_max_set fst zipped_list) in
    resolve_winner Heavier pdata_subset

(*
 * Naive Vote:
 * Each player votes for eating the person who gives them the longest life.
 * The largest plurality wins. If there is a tie, the smaller person is the
 * victim. If they are the same size, the alphabetically earlier person is
 * the victim.
 *)
let naive_vote players block scenario =
    let pdata_array = Array.mapi (fun i p -> (i, fst p, snd p)) players in
    let pdata = collect_players scenario (Array.to_list pdata_array) in
    let sliced_block =
        let dim = Array2.dim1 block in
        List.rev_map (fun x -> Array2.slice_left block x) (Utils.ints_below_n dim)
    in
    let ballots = List.map2 (make_up_your_mind pdata) sliced_block pdata in
    let ballot_boxes = Array.make (List.length pdata) 0 in
    List.iter2 (fun choice pdatum ->
        print_endline((name_of pdatum)^" votes for "^(name_of (List.nth pdata choice)));
        ballot_boxes.(choice) <- ballot_boxes.(choice) + weight_of pdatum
    ) ballots pdata;
    let votes = Array.to_list ballot_boxes in
    List.iter2 (fun x (_,_,y) -> print_endline("Votes for "^y^": "^(string_of_int x))) votes pdata;
    let (victims, _) = List.split (Utils.find_max_set snd (List.combine pdata votes)) in
    print_endline((string_of_int(List.length victims))^" victims were found");
    resolve_winner Lighter victims





(*
 * Candorcet Vote:
 * See README for details.
 *)
let candorcet_vote players block scenario =
    failwith "Candorcet voting not yet implemented."
