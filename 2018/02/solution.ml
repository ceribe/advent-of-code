#use "../utils.ml"
open Printf;;

(* Returns true if inp contains two of the same letter *)
let has_double_letter inp = 
  let l = List.map (fun x -> (x, List.length (List.filter (fun y -> x = y) inp))) inp
  in List.exists (fun (x, y) -> y = 2) l

(* Returns true if inp contains three of the same letter *)
let has_triple_letter inp = 
  let l = List.map (fun x -> (x, List.length (List.filter (fun y -> x = y) inp))) inp
  in List.exists (fun (x, y) -> y = 3) l

let part1 input = 
  let processed_input = List.map char_list_of_string input in
  let doubles = List.filter has_double_letter processed_input in
  let triples = List.filter has_triple_letter processed_input in
  List.length doubles * List.length triples |> string_of_int 

(* Generates a list of all possible pair combinations *)
let generate_pairs l = 
  let pairs = List.map (fun x -> List.map (fun y -> (x, y)) l) l in
  List.concat pairs

(* Returns true if s1 and s2 are different only by 1 letter *)
let is_one_off s1 s2 = 
  let l1 = char_list_of_string s1 in
  let l2 = char_list_of_string s2 in
  let rec go curr_idx diff = 
    if curr_idx >= List.length l1 then
      diff = 1
    else 
      if List.nth l1 curr_idx <> List.nth l2 curr_idx then
        go (curr_idx + 1) (diff + 1)
      else
        go (curr_idx + 1) diff
  in
  go 0 0

(* Returns string of common letters between s1 and s2 *)
let common_letters s1 s2 = 
  let l1 = char_list_of_string s1 in
  let l2 = char_list_of_string s2 in
  let common = List.filter (fun x -> List.exists (fun y -> x = y) l2) l1 in
  string_of_char_list common

let part2 input = 
  let all_pairs = generate_pairs input in
  let rec search pairs = 
    match pairs with
    | [] -> ""
    | pair::tail -> 
      let (s1, s2) = pair in
      if is_one_off s1 s2 then
        common_letters s1 s2
      else
        search tail
  in
  search all_pairs

let input = read_file "input.txt";;
let test_input = read_file "test_input.txt";;
let test_input_2 = read_file "test_input_2.txt";;

check "12" (part1 test_input);;
print_string ((part1 input)^"\n");;

check "fgij" (part2 test_input_2);;
print_string ((part2 input)^"\n");;