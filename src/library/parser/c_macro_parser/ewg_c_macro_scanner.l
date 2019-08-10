%{
note
	description: "Scan C header file for macro prototypes"
	status: "See notice at end of class"
	author: "Sam O'Connor and others"
	date: "$Date: 2003/10/25 19:20:25 $"
	revision: "$Revision: 1.1 $"

class EWG_C_MACRO_SCANNER

inherit

	EWG_C_MACRO_SCANNER_SKELETON

%}

--WS    [ \r\f\v\t\n]
WS    [ \t]
ANY   .|\n
ID    [a-zA-Z_][_a-zA-Z0-9]*

%option line

%x SC_DEFINE
%x SC_MACRO
%x SC_MACRO_ARGUMENTS
%x SC_MACRO_DEFINITION
%x SC_FILE

%%
-- NOTE: funcitonal macros must have the '(' immediately after the name (no whitespace in between)

^#define{WS}+				{ set_start_condition (SC_DEFINE) }

<SC_DEFINE>{ID}			{ last_token := TOK_ID;
					  last_value := text;
					  set_start_condition (SC_MACRO_DEFINITION); 
					}
<SC_DEFINE>{ID}/"("			{ last_token := TOK_ID; 
					  last_value := text; 
					  set_start_condition (SC_MACRO_ARGUMENTS); 
					}

<SC_MACRO_ARGUMENTS>{ID}		{ last_token := TOK_ID; last_value := text }
<SC_MACRO_ARGUMENTS>"("		{ last_token := TOK_LPAREN }
<SC_MACRO_ARGUMENTS>")"		{ last_token := TOK_RPAREN; set_start_condition (SC_MACRO_DEFINITION) }
<SC_MACRO_ARGUMENTS>","		{ last_token := TOK_COMMA }
<SC_MACRO_ARGUMENTS>{WS}+		{ } -- eat whitespace
<SC_MACRO_DEFINITION>.*		{ last_token := TOK_DEFINITION; last_value := text }
<SC_MACRO_DEFINITION>\n		{ set_start_condition (INITIAL) } -- eat the newline


{ANY}					{ }


%%
feature
end


