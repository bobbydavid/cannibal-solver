           (* ix, weight, name, votes *)
type pdata_t = int * int * string * int
exception NoClearWinner of pdata_t list


let rec collect_players scenario players =
    match players with
    | [] -> []
    | hd :: tl ->
        if scenario land 1 = 1 then
            (hd :: collect_players (scenario lsr 1) tl)
        else
            (collect_players (scenario lsr 1) tl)

let rec do_votes block pdata =
    pdata

let find_most_votes pdata =
    raise(NoClearWinner(pdata))

let break_tie pdata =
    let (ix, _, _, _) = (List.hd (List.rev pdata)) in
    ix

(*
 * Naive Vote:
 * Each player votes for eating the person who gives them the longest life.
 * The largest plurality wins. If there is a tie, the smaller person is the
 * victim. If they are the same size, the alphabetically earlier person is
 * the victim.
 *)
let naive_vote players block scenario =
    let assemble_pdata i p = (i, fst p, snd p, 0) in
    let pdata_array = Array.mapi assemble_pdata players in
    let pdata = collect_players scenario (Array.to_list pdata_array) in
    let pdata = do_votes block pdata in
    try
        find_most_votes pdata
    with NoClearWinner(pdata) ->
        break_tie pdata





(*
 * Candorcet Vote:
 * See README for details.
 *)
let candorcet_vote players block scenario =
    (* TODO: Implement this *)
    failwith "Candorcet voting not yet implemented."
