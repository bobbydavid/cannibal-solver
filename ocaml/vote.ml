
let rec collect_players scenario players =
    match players with
    | [] -> []
    | hd :: tl ->
        if scenario land 1 = 1 then
            (hd :: collect_players (scenario lsr 1) tl)
        else
            (collect_players (scenario lsr 1) tl)


(*
 * Naive Vote:
 * Each player votes for eating the person who gives them the longest life.
 * The largest plurality wins. If there is a tie, the smaller person is the
 * victim. If they are the same size, the alphabetically earlier person is
 * the victim.
 *)
let naive_vote players block scenario =
    (* XXX: Dummy update_outcomes *)
    let players = Array.mapi (fun i p -> (i, p)) players in
    let players = collect_players scenario (Array.to_list players) in
    let (i, p) = List.hd (List.rev players) in
    i






(*
 * Candorcet Vote:
 * See README for details.
 *)
let candorcet_vote players block scenario =
    (* TODO: Implement this *)
    failwith "Candorcet voting not yet implemented."
