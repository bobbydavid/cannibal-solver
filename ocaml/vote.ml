
open Bigarray

type preference_t = Heavier | Lighter
type pdatum_t = int * int * string
exception NoClearWinner of preference_t * pdatum_t list

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

let break_tie pref pdata =
    (* TODO: Heavier -> heaviest wins, Lighter -> lightest wins *)
    (* TODO: a tie -> alphabetical *)
    (* XXX: Currently selects from head of list *)
    ix_of (List.hd pdata)

let make_up_your_mind block_slice pdatum =
    let rec zip block_slice ix =
        if (ix = Array1.dim block_slice) then
            []
        else
            (ix, block_slice.{ix}) :: zip block_slice (ix + 1)
    in
    let block_list = zip block_slice 0 in
    let choices = Utils.find_max_set snd block_list in
    match choices with
    | [] -> failwith ((name_of pdatum) ^ " decided not to vote for anyone?")
    | hd :: tl ->
        if tl = [] then
            fst hd
        else
            (* TODO: Handle ties! *)
            fst hd

(*
let pick_victims (lst, max_votes) pdatum vote_count =
    match lst with
    | []  -> ([ pdatum; ], vote_count)
    | lst -> (
        match compare vote_count max_votes with
        | -1 -> (lst, max_votes)
        |  0 -> (pdatum :: lst, max_votes)
        |  1 -> ([ pdatum; ], vote_count)
        |  n -> failwith "Unexpected result from compare"
    )
*)

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
    List.iter2 (fun x (_,_,y) -> print_endline(y^" vote: "^(string_of_int x))) votes pdata;
    let (victims, _) = List.split (Utils.find_max_set snd (List.combine pdata votes)) in
    print_endline((string_of_int(List.length victims))^" victims were found");
    match victims with
    | hd :: [] -> ix_of hd
    | hd :: tl -> break_tie Lighter (hd :: tl)
    | [] -> failwith "Nobody was selected as a victim. How kind. But buggy!"





(*
 * Candorcet Vote:
 * See README for details.
 *)
let candorcet_vote players block scenario =
    (* TODO: Implement this *)
    failwith "Candorcet voting not yet implemented."
