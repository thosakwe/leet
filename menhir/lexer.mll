{
open Lexing
open Parser

exception SyntaxError of string

let get = Lexing.lexeme

let next_line lexbuf =
  let pos = lexbuf.lex_curr_p in
  lexbuf.lex_curr_p <-
    { pos with pos_bol = lexbuf.lex_curr_pos;
               pos_lnum = pos.pos_lnum + 1
    }
}

let white = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n"

let id_start = ['A' - 'Z']+
let id_part = (['0' - '9']) | id_start
let id = id_start id_part*
let hex_abc = ['A' - 'F']
let hex_num = ['0'-'9']
let hex_part = hex_abc | hex_num
let hex = "0x" hex_part+

rule read =
    parse
    | white { read lexbuf }
    | newline { next_line lexbuf; read lexbuf }
    | ':' { COLON }
    | '!' { EXCLAMATION }
    | "??" { QUESTION }
    | '[' { L_BRACKET }
    | ']' { R_BRACKET }
    | '{' { L_CURLY }
    | '}' { R_CURLY }
    | '(' { L_PAREN }
    | ')' { R_PAREN }
    | hex as lxm { HEX (int_of_string lxm) }
    | id as lxm { ID (lxm) }
    | _ {raise (SyntaxError ("Unexpected input: " ^ get lexbuf)) }
    | eof { EOF }