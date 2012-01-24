open Bigarray

let initialize_empty_blocks cnt =
    let counts =
        let rec count_mouths = function
            | 0 -> [ 0; ]
            | x -> Utils.count_bits x :: count_mouths (x - 1)
        in
        List.rev (count_mouths (1 lsl cnt - 1))
    in
    let gen_block k =
        Array2.create nativeint c_layout k k
    in
    let blocks = List.map gen_block counts in
    Array.of_list blocks

let update_outcomes players blocks outcomes scenario =
    (* XXX: Dummy update_outcomes *)
    let cnt = Array.length players in
    let rec dummy_choice scenario =
        if scenario mod 2 = 1 then 0 else 1 + dummy_choice (scenario lsr 1)
    in
    print_endline(
        "Update outcome " ^ (Utils.string_of_comb cnt scenario) ^
        " -> " ^ (string_of_int(dummy_choice scenario))
    );
    outcomes.(scenario) <- dummy_choice scenario

let calc_column old_scenario old_block old_victim new_block new_victim days =
    (* let new_scenario = old_scenario land (1 lsl victim) in *)
    (* XXX: Calc column from old column *)
    print_endline("\tCalc: If " ^ (string_of_int new_victim) ^ " dies...")

let rec analyze_block_columns players blocks outcomes scenario ancestors =
    let cnt = Array.length players in
    let mouths = Utils.count_bits scenario in
    match ancestors with
    | hd :: tl ->
        (
            let days = Utils.divide_round_up (fst players.(hd)) mouths in
            let old_victim = outcomes.(scenario) in
            let old_block = blocks.(scenario) in
            let new_scenario = scenario land (1 lsl hd) in
            let new_block = blocks.(new_scenario) in
                print_endline("Analyze column for ancestor " ^
                (string_of_int hd) ^
                " of scenario " ^
                (Utils.string_of_comb cnt scenario));
            calc_column scenario old_block old_victim new_block hd days;
            analyze_block_columns players blocks outcomes scenario tl
        )
    | [] -> ()

let analyze_block players blocks outcomes scenario =
    let cnt = Array.length players in
    print_endline("Analyzing block " ^ (Utils.string_of_comb cnt scenario) ^ ":");
    let ancestors = Combin.ancestors_of_scenario cnt scenario in
    analyze_block_columns players blocks outcomes scenario ancestors

let rec calc_blocks players blocks outcomes mouths =
    let cnt = Array.length players in
    if mouths = 1 then
        ()
    else (
        (* 1. Recursively do smaller blocks *)
        let mouths = mouths - 1 in
        calc_blocks players blocks outcomes mouths;
        print_endline("Analyzing blocks for " ^ (string_of_int cnt) ^ "-choose-" ^ (string_of_int mouths));
        (* 2. Analyze each of the blocks *)
        let combins = Combin.get_all_combinations cnt mouths in
        let _ = List.map (analyze_block players blocks outcomes) combins in
        ()
    );
    (* 3. Update the outcomes for each block *)
    let combins = Combin.get_all_combinations cnt mouths in
    let _ = List.map (update_outcomes players blocks outcomes) combins in
    ()

let solve_outcomes players =
    let cnt = Array.length players in
    let blocks = initialize_empty_blocks cnt in
    let num_scenarios = 1 lsl cnt in
    let outcomes = Array.make num_scenarios (-1) in
    let _ = calc_blocks players blocks outcomes cnt in
    outcomes

