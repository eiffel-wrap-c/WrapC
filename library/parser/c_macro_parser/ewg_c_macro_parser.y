%{

note
	description: "Parse macros from a C header file"
	status: "See notice at end of class"
	author: "Sam O'Connor"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

class EWG_C_MACRO_PARSER

inherit

	EWG_C_MACRO_PARSER_SKELETON

create

	make

%}

%token <STRING> TOK_ID
%token <STRING> TOK_DEFINITION
%token TOK_LPAREN
%token TOK_RPAREN
%token TOK_COMMA

%type <EWG_C_PHASE_1_MACRO> macro
%type <DS_LINKED_LIST [STRING]> arguments

%%

input
	:	-- empty
	| input macro
		{
			c_system.add_macro ($2)
		};

macro
	: TOK_ID  
		{
			create $$.make ($1)		   
		}
	| TOK_ID  TOK_DEFINITION
		{
			create $$.make_with_definition ($1, $2)		   
		}
	| TOK_ID TOK_LPAREN arguments TOK_RPAREN
		{
			create $$.make_with_arguments ($1, $3)
		}
	| TOK_ID TOK_LPAREN arguments TOK_RPAREN TOK_DEFINITION
		{
			create $$.make_with_arguments_and_definition ($1, $3, $5)
		};

arguments
	: TOK_ID  
		{
			create $$.make
			$$.put_last ($1)
		}
	| arguments TOK_COMMA TOK_ID 
		{
			$$ := $1
			$$.put_last ($3)
		};


%%

end
