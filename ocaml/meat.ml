open Bigarray

let initialize_empty_blocks cnt =
    let blocks = Array.make (1 lsl cnt) 0 in
    let gen_block k _ =
        let bits = Utils.count_bits k in
        let matrix = Array2.create int c_layout bits bits in
        Array2.fill matrix 0;
        matrix
    in
    Array.mapi gen_block blocks

(*       Old block, [0,2,5,6,9]   New block, [0,2,5,6,7,9]
 *
 *         w                              v
 *       # # # # #                # # # # * #
 *       # # # # #                # # # # * #
 *       # # # # #                # # # # * #
 *       # # # # #                # # # # * #
 *       # # # # #                # # # # 0 #
 *                                # # # # * #
 *
 * Given the old block representing the scenario [0,2,5,6,9], we can determine
 * the * locations in the scenario [0,2,5,6,7,9], which correspond to the
 * number of days each person will live if player 7 is killed.
 *
 * w is old_victim, the predetermined 'victim' for the old_block scenario.
 * v is new_victim, the current hypothetical victim in the new_block scenario.
 * new_scenario - Player v = old_scenario.
 * old_block.{ ,w} are the lives for each player if w is killed.
 * new_Block.{ ,v} are the lives for each player if v is killed.
 *)
let calc_column old_scenario old_block old_victim new_block ancestor days =
    let new_scenario = old_scenario lor (1 lsl ancestor) in
    let new_victim = Utils.count_bits(new_scenario land ((1 lsl ancestor)-1)) in
    (* print_endline("\tIf player " ^ (string_of_int ancestor) ^ " just died...");
    Utils.print_matrix old_block; *)
    let new_cnt = Utils.count_bits new_scenario in
    (* print_endline("\t["^(Utils.string_of_comb 6 old_scenario)^" <- "^(Utils.string_of_comb 6 new_scenario)^"]");
    print_endline("\told_victim: "^(string_of_int old_victim)^"; new_victim: "^(string_of_int new_victim)^"; days: "^(string_of_int days)); *)
    let rec fill_in_column y =
        if y = 0 then
            ()
        else let _ =
            match compare y new_victim with
            | -1 -> new_block.{y, new_victim} <- old_block.{y, old_victim} + days
            |  0 -> new_block.{y, new_victim} <- 0
            |  1 -> new_block.{y, new_victim} <- old_block.{y - 1, old_victim} + days
            |  n -> failwith("Unexpected result from compare: " ^ (string_of_int n))
        in
        fill_in_column (y - 1)
    in
    fill_in_column (new_cnt - 1)
    (* Utils.print_matrix new_block *)




let rec enumerate_possible_ancestors ancestors cnt scenario = match cnt with
    | 0 -> ancestors
    | n ->
        let n = n - 1 in
        let mask = 1 lsl n in
        let new_ancestors =
            if mask land scenario = 0 then n :: ancestors else ancestors
        in
        enumerate_possible_ancestors new_ancestors n scenario

let rec analyze_block_columns players blocks outcomes scenario ancestors =
    let mouths = Utils.count_bits scenario in
    match ancestors with
    | ancestor :: tl ->
        (
            let days = Utils.divide_round_up (fst players.(ancestor)) mouths in
            let old_victim = Utils.find_nth_bit scenario outcomes.(scenario) in
            let old_block = blocks.(scenario) in
            let new_scenario = scenario lor (1 lsl ancestor) in
            let new_block = blocks.(new_scenario) in
            calc_column scenario old_block old_victim new_block ancestor days;
            analyze_block_columns players blocks outcomes scenario tl
        )
    | [] -> ()

let rec analyze_all_blocks players blocks outcomes n last_k =
    let k = Combin.succ_combination n last_k in
    let cnt = Array.length players in
    let possible_ancestors = enumerate_possible_ancestors [] cnt k in
    analyze_block_columns players blocks outcomes k possible_ancestors;
    analyze_all_blocks players blocks outcomes n k

let rec calc_blocks players blocks outcomes mouths =
    if mouths = 1 then
        ()
    else (
        (* 1. Recursively do smaller blocks *)
        let mouths = mouths - 1 in
        calc_blocks players blocks outcomes mouths;
        (* print_endline("Analyzing blocks for " ^ (string_of_int cnt) ^ "-choose-" ^ (string_of_int mouths)); *)
        (* 2. Analyze each of the blocks *)
        try
            analyze_all_blocks players blocks outcomes mouths 0
        with Combin.FinalSuccessor -> ()
        (*
        let combins = Combin.get_all_combinations cnt mouths in
        List.iter (analyze_block players blocks outcomes) combins
        *)
    );
    (* 3. Update the outcomes for each block *)
    try
        let rec do_updates last_k =
            let k = Combin.succ_combination mouths last_k in
            outcomes.(k) <- Vote.naive_vote players blocks.(k) k;
            do_updates k
        in
        do_updates 0
    with Combin.FinalSuccessor -> ()

let solve_outcomes players =
    let cnt = Array.length players in
    let blocks = initialize_empty_blocks cnt in
    let num_scenarios = 1 lsl cnt in
    let outcomes = Array.make num_scenarios (-1) in
    let _ = calc_blocks players blocks outcomes cnt in
    (* Array.iter Utils.print_matrix blocks; *)
    outcomes

