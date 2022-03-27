#use "../utils.ml"
open Printf;;
module Ints = Set.Make(Int)

(* let part1 input = string_of_int (List.fold_left (+) 0 (List.map (fun x -> int_of_string x) input));; *)
let part1 input = input |> List.map (fun x -> int_of_string x) |> List.fold_left (+) 0 |> string_of_int;;

let part2 input = 
  let numbers = List.map (fun x -> int_of_string x) input in
  let reached_freqs = ref (Ints.of_list []) in
  let pos = ref 0 in
  let curr_freq = ref 0 in
  let found = ref false in
  while not !found do
    let i = List.nth numbers !pos in
    curr_freq := !curr_freq + i;
    if (Ints.mem !curr_freq !reached_freqs) then found := true;
    pos := ((!pos + 1) mod (List.length input));
    reached_freqs := Ints.add !curr_freq !reached_freqs;
  done;  
  string_of_int !curr_freq
;;


let input = read_file "input.txt";;
let test_input = read_file "test_input.txt";;

check "3" (part1 test_input);;
print_string ((part1 input)^"\n");;

check "2" (part2 test_input);;
print_string ((part2 input)^"\n");;