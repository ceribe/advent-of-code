open Printf;;

let read_file filename = 
  let lines = ref [] in
  let chan = open_in filename in
  try
    while true; do
      lines := input_line chan :: !lines
    done; !lines
  with End_of_file ->
    close_in chan;
    List.rev !lines ;;

let check expected actual =
  if expected <> actual then printf "Expected %s, but got %s\n" expected actual;;

(* Converts string to a list of chars *)
let char_list_of_string s = List.init (String.length s) (String.get s)

(* Converts char list to a string *)
let string_of_char_list l = String.of_seq (List.to_seq l)