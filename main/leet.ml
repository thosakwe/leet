open Lexer
open Lexing
open Printf

let input_filename () =
    if (Array.length Sys.argv) < 2
    then
        raise Not_found
    else
        Array.get Sys.argv 1

let print_position outx lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf outx "%s:%d:%d" pos.pos_fname
    pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let main () =
    let print_usage () =
        prerr_endline "usage: leet <filename>\n";
        exit 1
    in

    let rec read_file file =
        let line = input_line file in
        try
            line ^ read_file file
        with
            End_of_file -> (close_in file); line
    in

    let parse_buf lexbuf =
        try
            let result = Parser.function_decl Lexer.read lexbuf in
            match result with
                Ast.Function signature  -> prerr_endline "aa"
        with
            SyntaxError msg -> fprintf stderr "%a: %s\n" print_position lexbuf msg;
            | Parser.Error -> fprintf stderr "%a: syntax error\n" print_position lexbuf
    in

    try
        let filename = input_filename () in
        let input = if filename = "-" then stdin else open_in filename in
        let contents = read_file input in
        let lexbuf = Lexing.from_string contents in
        parse_buf lexbuf
    with
        Not_found -> print_usage ()

let () = main ()
    