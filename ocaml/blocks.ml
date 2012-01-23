
open Bigarray


let initialize_empty_blocks cnt =
    (* Generate a list of the # of mouths in each scenario *)
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
    (* N mouths -> NxN block *)
    let blocks = List.map gen_block counts in
    Array.of_list blocks

let analyze_block cnt players outcomes blocks mouths p =
    (* TODO: Use this block to generate new block rows *)
    print_endline("Analyze blocks for iteration " ^ (Utils.string_of_comb mouths p));
    ()

let update_outcomes cnt players outcomes blocks mouths c =
    (* XXX: Dummy update_outcomes *)
    print_endline("Update outcome " ^ (Utils.string_of_comb mouths c));
    let rec dummy_choice x =
        if x mod 2 = 1 then 0 else 1 + dummy_choice (x lsr 1)
    in
    outcomes.(c) <- dummy_choice c

let rec calc_blocks cnt players outcomes blocks k =
    print_endline("Calculating blocks for " ^ (string_of_int cnt) ^ "-choose-" ^ (string_of_int k));
    let combins = Combin.get_all_combinations cnt k in
    let _ = List.iter (fun c ->
        analyze_block cnt players outcomes blocks k c;
        update_outcomes cnt players outcomes blocks k c
    ) combins in
    if k = cnt then () else calc_blocks cnt players outcomes blocks (k + 1)

