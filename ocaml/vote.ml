
open Bigarray

type pdatum_t = int * int * string

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

let make_up_your_mind block_slice pdatum =
    let rec zip block_slice ix =
        if (ix = Array1.dim block_slice) then
            []
        else
            (ix, block_slice.{ix}) :: zip block_slice (ix + 1)
    in
    let block_list = zip block_slice 0 in
    print_endline(
        (name_of pdatum) ^
        " deciding based on days to live: " ^
        (List.fold_left (fun s (_,i) -> s^" "^(string_of_int i)) "" block_list)
    );
    let choices = Utils.find_max_set snd block_list in
    match choices with
    | [] -> failwith ((name_of pdatum) ^ " decided not to vote for anyone?")
    | hd :: tl ->
        if tl = [] then
            fst hd
        else
            (* TODO: Handle ties! *)
            failwith((name_of pdatum)^" cannot make up his mind because of a tie")

(*
 * Naive Vote:
 * Each player votes for eating the person who gives them the longest life.
 * The largest plurality wins. If there is a tie, the smaller person is the
 * victim. If they are the same size, the alphabetically earlier person is
 * the victim.
 *)
let naive_vote players block scenario =
    let assemble_pdata i p = (i, fst p, snd p) in
    let pdata_array = Array.mapi assemble_pdata players in
    let pdata = collect_players scenario (Array.to_list pdata_array) in
    let sliced_block =
        let dim = Array2.dim1 block in
        List.rev_map (fun x -> Array2.slice_left block x) (Utils.ints_below_n dim)
    in
    let ballots = List.map2 make_up_your_mind sliced_block pdata in
    let ballot_boxes = Array.make (List.length ballots) 0 in
    let cast_ballot choice pdatum =
        ballot_boxes.(choice) <- ballot_boxes.(choice) + weight_of pdatum
    in
    List.iter2 cast_ballot ballots pdata;
    let votes = Array.to_list ballot_boxes in
    List.iter2 (fun x (_,_,y) -> print_endline("Votes for "^y^": "^(string_of_int x))) votes pdata;
    let (victims, _) = List.split (Utils.find_max_set snd (List.combine pdata votes)) in
    print_endline((string_of_int(List.length victims))^" victims were found");
    (* TODO: Handle ties! *)
    match victims with
    | hd :: [] -> ix_of hd
    | hd :: tl -> failwith "There were multiple winners of the election. Ties not yet supported"
    | [] -> failwith "Nobody was selected as a victim. How kind. But buggy!"





(*
 * Candorcet Vote:
 * See README for details.
 *)
let candorcet_vote players block scenario =
    failwith "Candorcet voting not yet implemented."
