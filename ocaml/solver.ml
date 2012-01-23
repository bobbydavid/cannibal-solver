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


let solve_outcomes cnt players =
    let outcomes = Array.make (1 lsl cnt) (-1) in
    let blocks = Blocks.initialize_empty_blocks cnt in
    Blocks.calc_blocks cnt players outcomes blocks 1;
    outcomes

let determine_result cnt players outcomes =
    let next_of_choice prev ch =
        let mask = lnot (1 lsl ch) in
        prev land mask
    in
    let rec add_choice day mouths x =
        let winner = outcomes.(x) in
        print_endline ((Utils.string_of_comb cnt x) ^ ": winner " ^ (string_of_int winner));
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
