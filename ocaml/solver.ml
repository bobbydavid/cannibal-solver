(*
 * players: array of player tuples (weight, name)
 * cnt: # of players in the game.
 * outcomes: For every 2^cnt possible set of living players, an integer
 *           representing who gets eaten next (index in 'players' array).
 *           Initialized to -1, meaning unknown.
 *
 * A block is a square matrix of size k where k <= N. The location .(x).(y)
 * represents the number of days that x will remain alive if y is killed.
 *
 *)

open Bigarray

(* TODO: Delete this testing function *)
let dummy_outcomes cnt players outcomes =
    for i = 1 to (1 lsl cnt) - 1 do
        let rec choice x =
            if x mod 2 = 1 then 0 else 1 + choice (x lsr 1)
        in
        outcomes.(i) <- choice i
    done

let generate_initial_blocks cnt =
    (* Generate a list of the # of mouths in each scenario *)
    let counts =
        let rec count_mouths = function
            | 0 -> [ 0; ]
            | x -> Utils.count_bits x :: count_mouths (x - 1)
        in
        List.rev (count_mouths (1 lsl cnt - 1))
    in
    (* Map N mouths -> NxN array for block *)
    let gen_block k =
        Array2.create nativeint c_layout k k
    in
    let blocks = List.map gen_block counts in
    Array.of_list blocks

let rec do_calc_blocks cnt players outcomes blocks mouths ix =
    (* Calculate the block for the ix permutation of mouths *)
    (* Recursively calculate the next permutation *)
    if (ix = mouths) then
        (* TODO: Replace with () once dummy_outcomes is not necessary *)
        dummy_outcomes cnt players outcomes
    else (
        (* TODO: Calculate this block here! *)
        do_calc_blocks cnt players outcomes blocks mouths (ix + 1)
    )

let calc_blocks cnt players outcomes blocks mouths =
    do_calc_blocks cnt players outcomes blocks mouths 0

let solve_outcomes cnt players =
    let outcomes = Array.make (1 lsl cnt) (-1) in
    let blocks = generate_initial_blocks cnt in
    for i = 2 to cnt do
        calc_blocks cnt players outcomes blocks i;
    done;
    outcomes

let determine_result cnt players outcomes =
    let next_of_choice prev ch =
        let mask = lnot (1 lsl ch) in
        prev land mask
    in
    let rec add_choice day mouths x =
        let winner = outcomes.(x) in
        let name = snd players.(winner) in
        let mouths = mouths - 1 in
        match mouths with
        | 0 -> [(day, name); ]
        | mouths -> (
            let food = fst players.(winner) in
            let next_day = day + Utils.divide_round_up food mouths in
            let next_x = next_of_choice x winner in
            (day, name) :: add_choice next_day mouths next_x
        )
    in
    add_choice 1 cnt ((1 lsl cnt) - 1)

let solve players_list =
    let players = Array.of_list players_list in
    let cnt = Array.length players in
    let outcomes = solve_outcomes cnt players in
    determine_result cnt players outcomes
