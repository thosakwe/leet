type parameter_list = ParameterList of string list
type function_signature = FunctionSignature of (string * parameter_list);;
type function_declaration = Function of function_signature