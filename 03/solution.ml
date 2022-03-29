#use "../utils.ml"
open Printf;;
#load "str.cma";;
module SSet = Set.Make(String)
module SMap = Map.Make(String)

(* Parses given line by returning list of 5 ints *)
let parse_line line = line 
  |> Str.global_replace (Str.regexp "[#@,:x]") " " 
  |> Str.split (Str.regexp " +") 
  |> List.map int_of_string

(* Returns a string containing given x and y *)
let string_of_coordinates x y = 
  Printf.sprintf "%d %d" x y

(* Returns how many square inches of given claim were aleady in claims_set *)
let add_claim_to_duplicate_set claims_set claim duplicate_set = 
  let [id;x;y;w;h] = parse_line claim in 
  List.init w (fun a -> List.init h (fun b -> (a + x, b + y)))
    |> List.concat
    |> List.map (fun (x, y) -> string_of_coordinates x y) 
    |> List.filter (fun point -> SSet.mem point claims_set)
    |> SSet.of_list
    |> SSet.union duplicate_set

(* Adds one line/claim to claims set and returns the set *)
let add_line_to_claim_set claims_set claim = 
  let [id;x;y;w;h] = parse_line claim in 
  let points = List.init w (fun a -> List.init h (fun b -> (a + x, b + y))) |> List.concat in
  let rec add_points_to_claim_set claims_set points = 
    match points with
    | [] -> claims_set
    | (x, y)::tail -> 
      let point = string_of_coordinates x y in
      add_points_to_claim_set (SSet.add point claims_set) tail
  in
  add_points_to_claim_set claims_set points

let part1 input = 
  let rec apply_line lines duplicate_set claims_set =
    match lines with
    | [] -> duplicate_set |> SSet.elements |> List.length 
    | line::tail -> 
      let new_duplicate_set = add_claim_to_duplicate_set claims_set line duplicate_set in
      apply_line tail new_duplicate_set (add_line_to_claim_set claims_set line)
  in
  apply_line input SSet.empty SSet.empty |> string_of_int;;
;; 

let part2 input = "";;
(* I give up on this language. The syntax is unpleasant, execution speed is bad and to do even a simple thing
I have to write a lot of code. The fact that I cannot even create a Map where key is a String and value is an Int was just too much. *)

let input = read_file "input.txt";;
let test_input = read_file "test_input.txt";;

check "4" (part1 test_input);;
print_string ((part1 input)^"\n");;

check "3" (part2 test_input);;
print_string ((part2 input)^"\n");;

