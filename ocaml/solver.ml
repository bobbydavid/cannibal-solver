
(* Given a scenario and a victim number, return the next scenario with that
 * victim no longer alive *)
let update_scenario scenario victim =
    let mask = lnot (1 lsl victim) in
        scenario land mask

(* Given the 'outcomes' array and the current day, recursively
 * build a list of events *)
let rec add_choices players outcomes mouths day scenario =
    let victim = outcomes.(scenario) in
    print_endline ((Utils.string_of_comb (Array.length players) scenario) ^ ": victim " ^ (string_of_int victim));
    let name = snd players.(victim) in
    let mouths = mouths - 1 in
    match mouths with
    | 0 -> [(day, name); ]
    | mouths -> (
        let food = fst players.(victim) in
        let next_day = day + Utils.divide_round_up food mouths in
        let next_scenario = update_scenario scenario victim in
        (day, name) :: add_choices players outcomes mouths next_day next_scenario
    )

(* Given a list of players, respond with a list of events (who dies when) *)
let solve players_list =
    let players = Array.of_list players_list in
    let cnt = Array.length players in
    let outcomes = Meat.solve_outcomes players in
    let first_scenario = (1 lsl cnt) - 1 in
    let first_day = 1 in
    add_choices players outcomes cnt first_day first_scenario

