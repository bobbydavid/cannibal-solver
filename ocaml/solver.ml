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

let analyze_block cnt players outcomes blocks mouths p =
    (* TODO: Use this block to generate new block rows *)
    print_endline("Analyze blocks for iteration" ^ (string_of_int p));
    ()

let update_outcomes cnt players outcomes blocks mouths p =
    (* XXX: Dummy update_outcomes *)
    print_endline("Update outcome #" ^ (string_of_int p));
    let rec dummy_choice x =
        if x mod 2 = 1 then 0 else 1 + dummy_choice (x lsr 1)
    in
    outcomes.(p) <- dummy_choice p

let rec calc_blocks cnt players outcomes blocks mouths p =
    (* Calculate the block for the ix combination of mouths *)
    (* Recursively calculate the next combination *)
    try
        analyze_block cnt players outcomes blocks mouths p;
        update_outcomes cnt players outcomes blocks mouths p;
        calc_blocks cnt players outcomes blocks mouths (Combin.next_combin cnt p)
    with Combin.LastCombinError -> ()

let solve_outcomes cnt players =
    let outcomes = Array.make (1 lsl cnt) (-1) in
    let blocks = generate_initial_blocks cnt in
    for i = 2 to cnt do
        print_endline("Calc blocks of size " ^ (string_of_int i));
        calc_blocks cnt players outcomes blocks i (Combin.first_combin cnt i)
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
