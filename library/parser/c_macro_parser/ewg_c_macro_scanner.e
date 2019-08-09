note
	description: "Scan C header file for macro prototypes"
	status: "See notice at end of class"
	author: "Sam O'Connor and others"
	date: "$Date: 2003/10/25 19:20:25 $"
	revision: "$Revision: 1.1 $"

class EWG_C_MACRO_SCANNER

inherit

	EWG_C_MACRO_SCANNER_SKELETON


feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= SC_FILE)
		end

feature {NONE} -- Implementation

	yy_build_tables
			-- Build scanner tables.
		do
			yy_nxt := yy_nxt_template
			yy_chk := yy_chk_template
			yy_base := yy_base_template
			yy_def := yy_def_template
			yy_ec := yy_ec_template
			yy_meta := yy_meta_template
			yy_accept := yy_accept_template
		end

	yy_execute_action (yy_act: INTEGER)
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 33 "ewg_c_macro_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_macro_scanner.l' at line 33")
end
 set_start_condition (SC_DEFINE) 
when 2 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 35 "ewg_c_macro_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_macro_scanner.l' at line 35")
end
 last_token := TOK_ID;
					  last_value := text;
					  set_start_condition (SC_MACRO_DEFINITION); 
					
when 3 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 39 "ewg_c_macro_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_macro_scanner.l' at line 39")
end
 last_token := TOK_ID; 
					  last_value := text; 
					  set_start_condition (SC_MACRO_ARGUMENTS); 
					
when 4 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 44 "ewg_c_macro_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_macro_scanner.l' at line 44")
end
 last_token := TOK_ID; last_value := text 
when 5 then
	yy_column := yy_column + 1
--|#line 45 "ewg_c_macro_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_macro_scanner.l' at line 45")
end
 last_token := TOK_LPAREN 
when 6 then
	yy_column := yy_column + 1
--|#line 46 "ewg_c_macro_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_macro_scanner.l' at line 46")
end
 last_token := TOK_RPAREN; set_start_condition (SC_MACRO_DEFINITION) 
when 7 then
	yy_column := yy_column + 1
--|#line 47 "ewg_c_macro_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_macro_scanner.l' at line 47")
end
 last_token := TOK_COMMA 
when 8 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 48 "ewg_c_macro_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_macro_scanner.l' at line 48")
end
 
when 9 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 49 "ewg_c_macro_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_macro_scanner.l' at line 49")
end
 last_token := TOK_DEFINITION; last_value := text 
when 10 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 50 "ewg_c_macro_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_macro_scanner.l' at line 50")
end
 set_start_condition (INITIAL) 
when 11 then
yy_set_line_column
--|#line 53 "ewg_c_macro_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_macro_scanner.l' at line 53")
end
 
when 12 then
yy_set_line_column
--|#line 0 "ewg_c_macro_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_macro_scanner.l' at line 0")
end
default_action
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
			yy_set_beginning_of_line
		end

	yy_execute_eof_action (yy_sc: INTEGER)
			-- Execute EOF semantic action.
		do
			terminate
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER]
			-- Template for `yy_nxt'
		once
			Result := yy_fixed_array (<<
			    0,   16,   16,   16,   16,   16,   16,   16,   16,   17,
			   17,   17,   17,   17,   17,   16,   16,   16,   16,   16,
			   16,   16,   18,   16,   16,   19,   20,   21,   16,   22,
			   22,   22,   22,   22,   22,   14,   14,   14,   14,   23,
			   23,   23,   23,   27,   27,   30,   29,   30,   30,   36,
			   36,   35,   34,   33,   32,   28,   26,   31,   28,   26,
			   25,   37,   24,   24,   15,   13,   37,   37,   37,   37,
			   37,   37,   37,   37,   37,   37,   37,   37,   37,   37, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		once
			Result := yy_fixed_array (<<
			    0,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    5,    5,    5,    5,    5,
			    5,    7,    7,    7,    7,    7,    7,    7,    7,    7,
			    7,    7,    7,    7,    7,   38,   38,   38,   38,   39,
			   39,   39,   39,   40,   40,   42,   41,   42,   42,   36,
			   35,   34,   33,   32,   31,   28,   27,   25,   18,   17,
			   15,   13,   10,    9,    2,   37,   37,   37,   37,   37,
			   37,   37,   37,   37,   37,   37,   37,   37,   37,   37, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		once
			Result := yy_fixed_array (<<
			    0,    0,   60,    0,    0,    6,    0,   20,    0,   60,
			   59,    0,    0,   61,   65,   50,   65,   54,   56,   65,
			   65,   65,    0,    0,   65,   46,   65,   51,   53,    0,
			    0,   42,   40,   38,   40,   48,   47,   65,   34,   38,
			   40,   42,   44, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		once
			Result := yy_fixed_array (<<
			    0,   38,   38,   37,    3,    3,    5,   37,    7,   39,
			   39,    5,    5,   37,   37,   37,   37,   40,   37,   37,
			   37,   37,   41,   42,   37,   37,   37,   40,   37,   41,
			   42,   37,   37,   37,   37,   37,   37,    0,   37,   37,
			   37,   37,   37, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER]
			-- Template for `yy_ec'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 256)
			yy_ec_template_1 (an_array)
			yy_ec_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_ec_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    1,    1,    4,    1,    1,    1,    1,
			    5,    6,    1,    1,    7,    1,    1,    1,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    8,    1,    1,
			    1,    1,    1,    1,    1,    9,    9,    9,    9,    9,
			    9,    9,    9,    9,    9,    9,    9,    9,    9,    9,
			    9,    9,    9,    9,    9,    9,    9,    9,    9,    9,
			    9,    1,    1,    1,    1,    9,    1,    9,    9,    9,

			   10,   11,   12,    9,    9,   13,    9,    9,    9,    9,
			   14,    9,    9,    9,    9,    9,    9,    9,    9,    9,
			    9,    9,    9,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>,
			1, 200, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>,
			1, 57, 200)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    2,    1,    3,    1,    1,    4,    4,
			    4,    4,    4,    4,    4, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    9,
			    9,    0,    0,   13,   11,   11,   12,    2,    8,    5,
			    6,    7,    4,    9,   10,    0,    3,    2,    8,    4,
			    9,    0,    0,    0,    0,    0,    1,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 65
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 37
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 38
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN = false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN = false
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN = false
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER = 12
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 13
			-- End of buffer rule code

	yyLine_used: BOOLEAN = true
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN = false
			-- Is `position' used?

	INITIAL: INTEGER = 0
	SC_DEFINE: INTEGER = 1
	SC_MACRO: INTEGER = 2
	SC_MACRO_ARGUMENTS: INTEGER = 3
	SC_MACRO_DEFINITION: INTEGER = 4
	SC_FILE: INTEGER = 5
			-- Start condition codes

feature -- User-defined features


feature
end


