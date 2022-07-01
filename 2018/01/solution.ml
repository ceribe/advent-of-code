#use "../utils.ml"
open Printf;;
module Ints = Set.Make(Int)

let part1 input = input 
  |> List.map int_of_string
  |> List.fold_left (+) 0 
  |> string_of_int;;

let part2 input =
  let all_freqs = List.map int_of_string input in
  let rec check_next seen_freqs curr_sum freqs = 
    match freqs with
    | [] -> check_next seen_freqs curr_sum all_freqs
    | freq::tail -> 
      let new_sum = curr_sum + freq in
      if Ints.mem new_sum seen_freqs then new_sum
      else check_next (Ints.add new_sum seen_freqs) new_sum tail
    in
  check_next (Ints.of_list []) 0 all_freqs |> string_of_int;;


let input = read_file "input.txt";;
let test_input = read_file "test_input.txt";;

check "3" (part1 test_input);;
print_string ((part1 input)^"\n");;

check "2" (part2 test_input);;
print_string ((part2 input)^"\n");;