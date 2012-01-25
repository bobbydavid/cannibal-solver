
(* Naive Vote:
 * Each player votes for eating the person who gives them the longest life.
 * The largest plurality wins. If there is a tie, the smaller person is the
 * victim. If they are the same size, the alphabetically earlier person is
 * the victim.
 *)
let naive_vote players block scenario =
    (* XXX: Dummy update_outcomes *)
    let rec dummy_choice n =
        let next_n = n lsr 1 in
        if next_n = 0 then 0 else 1 + dummy_choice next_n
    in
    dummy_choice scenario


