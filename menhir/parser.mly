%token COLON
%token COMMA
%token EXCLAMATION
%token QUESTION
%token L_BRACKET
%token R_BRACKET
%token L_CURLY
%token R_CURLY
%token L_PAREN
%token R_PAREN
%token <string> STRING
%token <int>HEX
%token <string>ID
%token EOF
%type <Ast.function_declaration> function_decl

%start function_decl

%%

function_decl: s = signature { Ast.Function s } ;

signature: QUESTION i = ID L_PAREN p = parameter_list R_PAREN { Ast.FunctionSignature(i, p) } ;

parameter_list: p = separated_list(COMMA, parameter) { Ast.ParameterList p } ;

parameter: i = ID { i } ;

expr
    : h = HEX { h }
    | i = ID { i }
;