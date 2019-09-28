note
	description: "Scan C header file for type definitions"
	status: "See notice at end of class"
	author: "Based on http://www.lysator.liu.se/c"
	date: "$Date: 2006/05/30 13:22:26 $"
	revision: "$Revision: 1.9 $"
	info: "Based on: http://www.lysator.liu.se/c"

deferred class EWG_C_SCANNER

inherit

	EWG_C_SCANNER_SKELETON


feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= SC_GCC_ATTRIBUTE)
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
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 37 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 37")
end

				set_start_condition (SC_FILE)
				less (0)
			
when 2 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 48 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 48")
end
 -- GNU CPP style
				set_header_line_number ((text_substring (3, text_count - 2)).to_integer)
				
when 3 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 51 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 51")
end
  -- Visual C++ style
				set_header_line_number ((text_substring (7, text_count - 2)).to_integer)
			
when 4 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 54 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 54")
end
  set_start_condition (INITIAL) 
when 5 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 55 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 55")
end
 set_header_file_name (text) 
when 6 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 56 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 56")
end
set_start_condition (INITIAL) 
when 7 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 59 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 59")
end

					implementation_bracket_counter := implementation_bracket_counter + 1
				
when 8 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 62 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 62")
end

					implementation_bracket_counter := implementation_bracket_counter - 1
					if implementation_bracket_counter = 0 then
						last_token := Right_brace_code
						last_string_value := text
					end
				
when 9 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 70 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 70")
end
 
when 10 then
yy_set_line_column
	yy_position := yy_position + 1
--|#line 72 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 72")
end
 
when 11 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 75 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 75")
end

					check
						msc_declspec_bracket_counter_is_zero: msc_declspec_bracket_counter = 0
					end
					if is_msc_extensions_enabled then
						-- grammar for "__declspec" construct is ambiguos.
						-- we don't need this information -> we ignore it
						-- (now we need to the "(dllimport)" part too)
						set_start_condition (SC_MSC_DECLSPEC)
					else
						report_type_or_identifier (text)
					end
				
when 12 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 88 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 88")
end

				msc_declspec_bracket_counter := msc_declspec_bracket_counter + 1
			
when 13 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 91 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 91")
end

					msc_declspec_bracket_counter := msc_declspec_bracket_counter - 1
					if msc_declspec_bracket_counter = 0 then
						set_start_condition (INITIAL)
					end
			
when 14 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 97 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 97")
end

when 15 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 102 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 102")
end
 last_token := TOK_AUTO; last_string_value := text
when 16 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 103 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 103")
end
 last_token := TOK_BREAK; last_string_value := text 
when 17 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 104 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 104")
end
 last_token := TOK_CASE; last_string_value := text 
when 18 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 105 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 105")
end
 last_token := TOK_CHAR; last_string_value := text 
when 19 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 106 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 106")
end
 last_token := TOK_CONST; last_string_value := text 
when 20 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 107 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 107")
end
 last_token := TOK_CONTINUE; last_string_value := text 
when 21 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 108 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 108")
end
 last_token := TOK_DEFAULT; last_string_value := text 
when 22 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 109 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 109")
end
 last_token := TOK_DO; last_string_value := text 
when 23 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 110 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 110")
end
 last_token := TOK_DOUBLE; last_string_value := text 
when 24 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 111 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 111")
end
 last_token := TOK_ELSE; last_string_value := text 
when 25 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 112 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 112")
end
 last_token := TOK_ENUM; last_string_value := text 
when 26 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 113 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 113")
end
 last_token := TOK_EXTERN; last_string_value := text 
when 27 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 114 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 114")
end
 last_token := TOK_FLOAT; last_string_value := text 
when 28 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 115 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 115")
end
 last_token := TOK_FOR; last_string_value := text 
when 29 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 116 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 116")
end
 last_token := TOK_GOTO; last_string_value := text 
when 30 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 117 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 117")
end
 last_token := TOK_IF; last_string_value := text 
when 31 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 118 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 118")
end
 last_token := TOK_INT; last_string_value := text 
when 32 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 119 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 119")
end
 last_token := TOK_INT; last_string_value := text 
when 33 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 120 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 120")
end
 last_token := TOK_LONG; last_string_value := text 
when 34 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 121 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 121")
end
 last_token := TOK_REGISTER; last_string_value := text 
when 35 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 122 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 122")
end
 last_token := TOK_RETURN; last_string_value := text 
when 36 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 123 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 123")
end
 last_token := TOK_SHORT; last_string_value := text 
when 37 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 124 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 124")
end
 last_token := TOK_SIGNED; last_string_value := text 
when 38 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 125 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 125")
end
 last_token := TOK_SIZEOF; last_string_value := text 
when 39 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 126 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 126")
end
 last_token := TOK_STATIC; last_string_value := text 
when 40 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 127 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 127")
end
 last_token := TOK_INLINE; last_string_value := text 
when 41 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 128 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 128")
end
 last_token := TOK_STRUCT; last_string_value := text 
when 42 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 129 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 129")
end
 last_token := TOK_SWITCH; last_string_value := text 
when 43 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 130 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 130")
end
 last_token := TOK_TYPEDEF; last_string_value := text 
when 44 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 131 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 131")
end
 last_token := TOK_UNION; last_string_value := text 
when 45 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 132 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 132")
end
 last_token := TOK_UNSIGNED; last_string_value := text 
when 46 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 133 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 133")
end
 last_token := TOK_VOID; last_string_value := text 
when 47 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 134 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 134")
end
 last_token := TOK_VOLATILE; last_string_value := text 
when 48 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 135 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 135")
end
 last_token := TOK_WHILE; last_string_value := text 
when 49 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 136 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 136")
end

				-- gcc extension
				last_token := TOK_SIGNED; last_string_value := text 			   
when 50 then
	yy_column := yy_column + 13
	yy_position := yy_position + 13
--|#line 141 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 141")
end
 
when 51 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 144 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 144")
end
 last_token := TOK_CONST; last_string_value := text 
when 52 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 145 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 145")
end
 
when 53 then
	yy_column := yy_column + 13
	yy_position := yy_position + 13
--|#line 147 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 147")
end

				 -- eat, hopefully this thing is not usefull for us
					gcc_attribute_bracket_counter := 0
					set_start_condition (SC_GCC_ATTRIBUTE)
				
when 54 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 153 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 153")
end

				gcc_attribute_bracket_counter := gcc_attribute_bracket_counter + 1
			 
when 55 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 156 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 156")
end

				gcc_attribute_bracket_counter := gcc_attribute_bracket_counter - 1
				if gcc_attribute_bracket_counter = 0 then
					set_start_condition (INITIAL)
				end
			 
when 56 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 162 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 162")
end

when 57 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 164 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 164")
end

when 58 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 166 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 166")
end

when 59 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 169 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 169")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_INT_8
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 60 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 177 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 177")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_INT_16
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 61 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 185 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 185")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_INT_32
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 62 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 193 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 193")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_INT_64
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 63 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 201 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 201")
end

					if is_msc_extensions_enabled then
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
				
when 64 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 208 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 208")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_FASTCALL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 65 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 216 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 216")
end

					if is_msc_extensions_enabled then
						-- last_token := TOK_CL_BASED
						-- last_string_value := text
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
				
when 66 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 225 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 225")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_ASM
						last_string_value := text
					else
						-- This is a gcc extension, we ignore it
						gcc_attribute_bracket_counter := 0
						set_start_condition (SC_GCC_ATTRIBUTE)
					end
				
when 67 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 235 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 235")
end

					if is_msc_extensions_enabled then
						-- ignore, we don't need it, it's a gcc extension
					else
						-- This is a gcc extension, we ignore it
						gcc_attribute_bracket_counter := 0
						set_start_condition (SC_GCC_ATTRIBUTE)
					end
				
when 68 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 244 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 244")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_ASM
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 69 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 252 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 252")
end

					if is_msc_extensions_enabled then
						-- last_token := TOK_CL_INLINE
						-- last_string_value := text
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
				
when 70 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 261 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 261")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_CDECL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 71 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 269 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 269")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_CDECL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 72 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 277 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 277")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_STDCALL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 73 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 285 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 285")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_STDCALL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
					
when 74 then
	yy_column := yy_column + 12
	yy_position := yy_position + 12
--|#line 293 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 293")
end

					if is_msc_extensions_enabled then
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
					
when 75 then
	yy_column := yy_column + 13
	yy_position := yy_position + 13
--|#line 300 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 300")
end

					if is_msc_extensions_enabled then
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
					
when 76 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 308 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 308")
end
 
when 77 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 310 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 310")
end
 report_type_or_identifier (text)	
when 78 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 312 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 312")
end
 last_token := TOK_CONSTANT; last_string_value := text 
when 79 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 313 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 313")
end
 last_token := TOK_CONSTANT; last_string_value := text 
when 80 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 314 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 314")
end
 last_token := TOK_CONSTANT; last_string_value := text 
when 81 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 315 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 315")
end
 last_token := TOK_CONSTANT; last_string_value := text 
when 82 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 317 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 317")
end
 last_token := TOK_CONSTANT; last_string_value := text 
when 83 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 318 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 318")
end
 last_token := TOK_CONSTANT; last_string_value := text 
when 84 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 319 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 319")
end
 last_token := TOK_CONSTANT; last_string_value := text 
when 85 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 321 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 321")
end
 last_token := TOK_STRING_LITERAL; last_string_value := text 
when 86 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 323 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 323")
end
 last_token := TOK_ELLIPSIS; last_string_value := text 
when 87 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 324 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 324")
end
 last_token := TOK_RIGHT_ASSIGN; last_string_value := text 
when 88 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 325 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 325")
end
 last_token := TOK_LEFT_ASSIGN; last_string_value := text 
when 89 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 326 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 326")
end
 last_token := TOK_ADD_ASSIGN; last_string_value := text 
when 90 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 327 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 327")
end
 last_token := TOK_SUB_ASSIGN; last_string_value := text 
when 91 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 328 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 328")
end
 last_token := TOK_MUL_ASSIGN; last_string_value := text 
when 92 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 329 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 329")
end
 last_token := TOK_DIV_ASSIGN; last_string_value := text 
when 93 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 330 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 330")
end
 last_token := TOK_MOD_ASSIGN; last_string_value := text 
when 94 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 331 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 331")
end
 last_token := TOK_AND_ASSIGN; last_string_value := text 
when 95 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 332 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 332")
end
 last_token := TOK_XOR_ASSIGN; last_string_value := text 
when 96 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 333 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 333")
end
 last_token := TOK_OR_ASSIGN; last_string_value := text 
when 97 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 334 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 334")
end
 last_token := TOK_RIGHT_OP; last_string_value := text 
when 98 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 335 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 335")
end
 last_token := TOK_LEFT_OP; last_string_value := text 
when 99 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 336 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 336")
end
 last_token := TOK_INC_OP; last_string_value := text 
when 100 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 337 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 337")
end
 last_token := TOK_DEC_OP; last_string_value := text 
when 101 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 338 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 338")
end
 last_token := TOK_PTR_OP; last_string_value := text 
when 102 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 339 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 339")
end
 last_token := TOK_AND_OP; last_string_value := text 
when 103 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 340 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 340")
end
 last_token := TOK_OR_OP; last_string_value := text 
when 104 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 341 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 341")
end
 last_token := TOK_LE_OP; last_string_value := text 
when 105 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 342 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 342")
end
 last_token := TOK_GE_OP; last_string_value := text 
when 106 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 343 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 343")
end
 last_token := TOK_EQ_OP; last_string_value := text 
when 107 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 344 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 344")
end
 last_token := TOK_NE_OP; last_string_value := text 
when 108 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 346 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 346")
end
 last_token := Semicolon_code; last_string_value := text
when 109 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 347 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 347")
end
 last_token := Left_brace_code; last_string_value := text 
when 110 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 348 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 348")
end
 last_token := Right_brace_code; last_string_value := text 
when 111 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 349 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 349")
end
 last_token := Comma_code; last_string_value := text 
when 112 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 350 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 350")
end
 last_token := Colon_code; last_string_value := text 
when 113 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 351 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 351")
end
 last_token := Equal_code; last_string_value := text 
when 114 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 352 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 352")
end
 last_token := Left_parenthesis_code; last_string_value := text 
when 115 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 353 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 353")
end
 last_token := Right_parenthesis_code; last_string_value := text 
when 116 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 354 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 354")
end
 last_token := Left_bracket_code; last_string_value := text 
when 117 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 355 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 355")
end
 last_token := Right_bracket_code; last_string_value := text 
when 118 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 356 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 356")
end
 last_token := Dot_code; last_string_value := text 
when 119 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 357 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 357")
end
 last_token := 38; last_string_value := text 
when 120 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 358 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 358")
end
 last_token := Exclamation_code; last_string_value := text 
when 121 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 359 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 359")
end
 last_token := 126; last_string_value := text 
when 122 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 360 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 360")
end
 last_token := Minus_code; last_string_value := text 
when 123 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 361 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 361")
end
 last_token := Plus_code; last_string_value := text 
when 124 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 362 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 362")
end
 last_token := Star_code; last_string_value := text 
when 125 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 363 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 363")
end
 last_token := Slash_code; last_string_value := text 
when 126 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 364 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 364")
end
 last_token := 37; last_string_value := text 
when 127 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 365 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 365")
end
 last_token := Less_than_code; last_string_value := text 
when 128 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 366 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 366")
end
 last_token := Greater_than_code; last_string_value := text 
when 129 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 367 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 367")
end
 last_token := Caret_code; last_string_value := text 
when 130 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 368 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 368")
end
 last_token := Bar_code; last_string_value := text 
when 131 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 369 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 369")
end
 last_token := Question_mark_code; last_string_value := text 
when 132 then
yy_set_line_column
	yy_position := yy_position + 1
--|#line 371 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 371")
end
 
when 133 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 372 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 372")
end
 
when 134 then
yy_set_line_column
	yy_position := yy_position + 1
--|#line 0 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 0")
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
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 958)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			yy_nxt_template_4 (an_array)
			yy_nxt_template_5 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			    0,   12,   13,   14,   13,   15,   16,   12,   17,   18,
			   19,   20,   21,   22,   23,   24,   25,   26,   27,   28,
			   29,   29,   29,   29,   29,   29,   29,   30,   31,   32,
			   33,   34,   35,   36,   36,   36,   36,   36,   37,   36,
			   36,   38,   12,   39,   40,   41,   42,   43,   44,   45,
			   46,   47,   48,   36,   49,   36,   50,   36,   36,   36,
			   36,   51,   52,   53,   54,   55,   56,   36,   36,   36,
			   57,   58,   59,   60,   61,  460,   64,   65,   84,   62,
			   66,   67,   64,   65,   65,   93,   66,   67,   70,   70,
			   71,   71,   77,   78,   65,   88,   65,  459,   65,   86,

			   87,   94,   77,   78,   80,   81,   80,   81,   95,  113,
			  114,   72,   72,   83,   85,  108,   89,  116,  458,   68,
			   73,   73,   96,   97,   98,   68,   99,   99,   99,   99,
			   99,   99,   99,   99,  109,  127,  110,  111,  130,  132,
			  135,  133,  128,  136,  138,  150,  428,  131,  129,  429,
			  134,  139,   74,   74,   75,   75,  101,  157,  102,  102,
			  102,  102,  102,  102,  102,  102,  152,  457,  165,   84,
			  118,  153,  163,  461,  103,  142,  143,  104,  104,  105,
			   90,  119,  120,  215,  121,  144,  151,  122,  145,  103,
			  123,  155,  169,  220,  216,  104,  156,  152,  124,  160, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  161,  160,  153,  104,  166,   85,  105,  101,  221,  106,
			  106,  106,  106,  106,  106,  106,  106,  104,  104,  212,
			  218,  226,  224,  227,   91,  103,  213,  155,  104,  104,
			  225,  245,  156,  157,  157,  104,  165,  219,  242,  243,
			  103,  246,  249,  104,  266,  267,  104,  254,  163,  456,
			  160,  161,  160,  162,  104,  250,  255,  163,   99,   99,
			   99,   99,   99,   99,   99,   99,  161,  161,  161,  455,
			  157,  454,  166,  307,  171,  172,  177,  172,  177,  453,
			  308,  178,  178,  178,  178,  178,  178,  178,  178,  171,
			  172,  176,  176,  452,  451,  172,  173,  173,  173,  173,

			  173,  173,  173,  173,  162,  292,  292,  292,  163,  176,
			  450,  449,  174,  175,  233,  175,  233,  176,  448,  234,
			  234,  234,  234,  234,  234,  234,  234,  174,  175,  235,
			  236,  447,  236,  175,  101,  446,  102,  102,  102,  102,
			  102,  102,  102,  102,  235,  236,  379,  380,  379,  445,
			  236,  239,  103,  239,  444,  176,  176,  178,  178,  178,
			  178,  178,  178,  178,  178,  443,  239,  103,  291,  292,
			  291,  239,  339,  176,  240,  240,  292,  292,  292,  442,
			  339,  176,  183,  184,  185,  186,  187,  188,  441,  352,
			  189,  353,  240,  428,  354,  355,  190,  191,  192,  439, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  240,  438,  193,  160,  161,  160,  237,  437,  237,  436,
			  435,  238,  238,  238,  238,  238,  238,  238,  238,  434,
			  229,  229,  229,  229,  229,  229,  229,  229,  291,  292,
			  291,  234,  234,  234,  234,  234,  234,  234,  234,  172,
			  433,  172,  380,  380,  380,  229,  229,  229,  229,  229,
			  229,  229,  229,  432,  172,  295,  431,  295,  430,  172,
			  296,  296,  296,  296,  296,  296,  296,  296,  238,  238,
			  238,  238,  238,  238,  238,  238,  175,  425,  175,  240,
			  240,  296,  296,  296,  296,  296,  296,  296,  296,  230,
			  230,  175,  236,  230,  236,  424,  175,  240,  427,  427,

			  427,  423,  426,  427,  426,  240,  440,  236,  179,  179,
			  179,  422,  236,  379,  380,  379,  427,  427,  427,  421,
			  440,  115,  115,  115,  115,  115,  420,  419,  418,  417,
			  408,  408,  408,  408,  408,  408,  408,  408,  426,  427,
			  426,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,  416,  415,  414,  413,  408,  408,  408,  408,  408,
			  408,  408,  408,   69,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   76,   76,   76,   76,   76,   76,   76,
			   76,   76,   76,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   83,   83,   83,   83,   83,   83,   83, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   83,   83,   83,   90,   90,   90,   90,  412,   90,   90,
			   90,   90,   90,  153,  153,  411,  153,  153,  153,  153,
			  153,  153,  153,  154,  154,  410,  407,  154,  154,  154,
			  154,  154,  154,  158,  158,  158,  158,  158,  158,  158,
			  158,  158,  158,  164,  164,  164,  164,  164,  164,  164,
			  164,  164,  164,  178,  234,  178,  234,  178,  234,  238,
			  296,  238,  296,  238,  296,  409,  409,  406,  405,  409,
			  410,  410,  410,  410,  410,  410,  410,  410,  410,  410,
			  429,  429,  429,  429,  429,  429,  429,  429,  429,  429,
			  404,  403,  402,  401,  400,  399,  398,  397,  396,  395,

			  394,  393,  392,  391,  390,  389,  388,  387,  386,  385,
			  384,  383,  382,  381,  378,  377,  376,  375,  374,  373,
			  372,  371,  370,  369,  368,  367,  366,  365,  364,  363,
			  362,  361,  360,  359,  358,  357,  356,  351,  350,  349,
			  348,  347,  346,  345,  344,  343,  342,  341,  340,  338,
			  337,  336,  335,  334,  333,  332,  331,  330,  329,  328,
			  327,  326,  325,  324,  323,  322,  321,  320,  319,  318,
			  317,  316,  315,  314,  313,  312,  311,  310,  309,  306,
			  305,  304,  303,  302,  301,  300,  299,  298,  297,  294,
			  293,  290,  289,  288,  287,  286,  285,  284,  283,  282, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  281,  280,  279,  278,  277,  276,  275,  274,  273,  272,
			  271,  270,  269,  268,  265,  264,  263,  262,  261,  260,
			  259,  258,  257,  256,  253,  252,  251,  248,  247,  244,
			  241,  461,  232,  231,  159,  228,  223,  222,  217,  214,
			  211,  210,  209,  208,  207,  206,  205,  204,  203,  202,
			  201,  200,  199,  198,  197,  196,  195,  194,  182,   91,
			  181,  180,  170,  461,  164,  168,  167,  159,  149,  148,
			  147,  146,  141,  140,  137,  126,  125,  117,  112,  107,
			  100,   92,   91,   82,  461,   11,  461,  461,  461,  461,
			  461,  461,  461,  461,  461,  461,  461,  461,  461,  461,

			  461,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  461,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  461,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  461,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  461,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  461,  461,  461,  461,  461,  461,  461,  461,  461, yy_Dummy>>,
			1, 159, 800)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 958)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			yy_chk_template_4 (an_array)
			yy_chk_template_5 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    2,  456,    3,    3,   16,    2,
			    3,    3,    4,    4,    7,   23,    4,    4,    5,    6,
			    5,    6,    7,    7,    8,   18,    9,  455,   10,   17,

			   17,   23,    8,    8,    9,    9,   10,   10,   25,   34,
			   34,    5,    6,   37,   16,   32,   18,   37,  454,    3,
			    5,    6,   25,   25,   26,    4,   26,   26,   26,   26,
			   26,   26,   26,   26,   32,   44,   32,   32,   45,   46,
			   47,   46,   44,   47,   49,   58,  410,   45,   44,  410,
			   46,   49,    5,    6,    5,    6,   28,   68,   28,   28,
			   28,   28,   28,   28,   28,   28,   61,  453,   70,   83,
			   41,   61,   68,   91,   28,   52,   52,   28,   28,   28,
			   91,   41,   41,  141,   41,   52,   58,   41,   52,   28,
			   41,   64,   90,  144,  141,   28,   64,  152,   41,   67, yy_Dummy>>,
			1, 200, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   67,   67,  152,   28,   70,   83,   28,   29,  144,   29,
			   29,   29,   29,   29,   29,   29,   29,  104,  104,  139,
			  143,  148,  147,  148,   90,   29,  139,  155,   29,   29,
			  147,  185,  155,  157,   64,  104,  164,  143,  183,  183,
			   29,  185,  188,  104,  203,  203,   29,  192,  157,  452,
			  156,  156,  156,   67,   29,  188,  192,   67,   99,   99,
			   99,   99,   99,   99,   99,   99,  161,  161,  161,  451,
			  155,  450,  164,  251,   99,   99,  103,   99,  103,  449,
			  251,  103,  103,  103,  103,  103,  103,  103,  103,   99,
			   99,  176,  176,  445,  443,   99,  101,  101,  101,  101,

			  101,  101,  101,  101,  156,  230,  230,  230,  156,  176,
			  441,  439,  101,  101,  171,  101,  171,  176,  437,  171,
			  171,  171,  171,  171,  171,  171,  171,  101,  101,  173,
			  173,  436,  173,  101,  102,  435,  102,  102,  102,  102,
			  102,  102,  102,  102,  173,  173,  340,  340,  340,  434,
			  173,  178,  102,  178,  433,  102,  102,  177,  177,  177,
			  177,  177,  177,  177,  177,  432,  178,  102,  291,  291,
			  291,  178,  291,  102,  179,  179,  292,  292,  292,  431,
			  292,  102,  119,  119,  119,  119,  119,  119,  430,  308,
			  119,  308,  179,  429,  308,  308,  119,  119,  119,  420, yy_Dummy>>,
			1, 200, 200)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  179,  419,  119,  160,  160,  160,  174,  418,  174,  417,
			  416,  174,  174,  174,  174,  174,  174,  174,  174,  415,
			  160,  160,  160,  160,  160,  160,  160,  160,  229,  229,
			  229,  233,  233,  233,  233,  233,  233,  233,  233,  234,
			  414,  234,  380,  380,  380,  229,  229,  229,  229,  229,
			  229,  229,  229,  413,  234,  235,  412,  235,  411,  234,
			  235,  235,  235,  235,  235,  235,  235,  235,  237,  237,
			  237,  237,  237,  237,  237,  237,  238,  407,  238,  240,
			  240,  295,  295,  295,  295,  295,  295,  295,  295,  474,
			  474,  238,  296,  474,  296,  406,  238,  240,  409,  409,

			  409,  404,  426,  426,  426,  240,  426,  296,  473,  473,
			  473,  402,  296,  379,  379,  379,  427,  427,  427,  401,
			  427,  468,  468,  468,  468,  468,  399,  398,  397,  396,
			  379,  379,  379,  379,  379,  379,  379,  379,  408,  408,
			  408,  462,  462,  462,  462,  462,  462,  462,  462,  462,
			  462,  391,  390,  389,  388,  408,  408,  408,  408,  408,
			  408,  408,  408,  463,  463,  463,  463,  463,  463,  463,
			  463,  463,  463,  464,  464,  464,  464,  464,  464,  464,
			  464,  464,  464,  465,  465,  465,  465,  465,  465,  465,
			  465,  465,  465,  466,  466,  466,  466,  466,  466,  466, yy_Dummy>>,
			1, 200, 400)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  466,  466,  466,  467,  467,  467,  467,  387,  467,  467,
			  467,  467,  467,  469,  469,  383,  469,  469,  469,  469,
			  469,  469,  469,  470,  470,  381,  378,  470,  470,  470,
			  470,  470,  470,  471,  471,  471,  471,  471,  471,  471,
			  471,  471,  471,  472,  472,  472,  472,  472,  472,  472,
			  472,  472,  472,  475,  476,  475,  476,  475,  476,  477,
			  478,  477,  478,  477,  478,  479,  479,  377,  376,  479,
			  480,  480,  480,  480,  480,  480,  480,  480,  480,  480,
			  481,  481,  481,  481,  481,  481,  481,  481,  481,  481,
			  369,  365,  364,  363,  362,  361,  359,  358,  357,  356,

			  354,  353,  352,  351,  350,  349,  348,  347,  346,  345,
			  344,  343,  342,  341,  337,  336,  334,  333,  332,  331,
			  330,  329,  327,  326,  325,  323,  322,  321,  320,  317,
			  316,  315,  314,  312,  311,  310,  309,  307,  306,  305,
			  304,  303,  302,  301,  300,  299,  298,  294,  293,  290,
			  289,  287,  286,  285,  284,  283,  282,  281,  280,  279,
			  278,  277,  275,  273,  272,  269,  268,  267,  266,  263,
			  261,  260,  259,  258,  256,  255,  254,  253,  252,  250,
			  249,  248,  247,  246,  245,  244,  243,  242,  241,  232,
			  231,  228,  227,  226,  225,  224,  223,  222,  221,  220, yy_Dummy>>,
			1, 200, 600)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  219,  218,  217,  216,  215,  214,  212,  211,  209,  208,
			  207,  206,  205,  204,  202,  201,  200,  199,  198,  197,
			  196,  195,  194,  193,  191,  190,  189,  187,  186,  184,
			  182,  166,  163,  162,  158,  149,  146,  145,  142,  140,
			  137,  136,  135,  134,  133,  132,  131,  130,  129,  128,
			  127,  126,  125,  124,  123,  122,  121,  120,  118,  116,
			  114,  110,   98,   85,   73,   72,   71,   66,   56,   55,
			   54,   53,   51,   50,   48,   43,   42,   40,   33,   30,
			   27,   22,   19,   15,   11,  461,  461,  461,  461,  461,
			  461,  461,  461,  461,  461,  461,  461,  461,  461,  461,

			  461,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  461,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  461,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  461,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  461,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  461,  461,  461,  461,  461,  461,  461,  461,  461, yy_Dummy>>,
			1, 159, 800)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 481)
			yy_base_template_1 (an_array)
			yy_base_template_2 (an_array)
			yy_base_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_base_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,   72,   74,   80,   82,   83,   81,   91,   93,
			   95,  884,  885,  885,  885,  853,   72,   69,   86,  840,
			  885,  885,  851,   71,  885,   92,  107,  850,  139,  190,
			  848,  885,  107,  848,   79,  885,    0,  107,  885,  885,
			  847,  136,  812,  814,   89,   88,   83,   84,  815,   93,
			  814,  822,  122,  803,  812,  810,  815,  885,  115,  885,
			  885,  164,    0,    0,  189,  885,  864,  197,  112,  885,
			  162,  835,  857,  858,  885,  885,  885,  885,  885,  885,
			  885,  885,  885,  163,  885,  860,  885,  885,  885,  885,
			  182,  170,  885,  885,  885,  885,  885,  885,  845,  239,

			  885,  277,  317,  262,  179,    0,    0,  885,  885,  885,
			  831,  885,  885,  885,  830,    0,  817,  885,  799,  336,
			  795,  807,  796,  796,  790,  789,  801,  788,  803,  790,
			  796,  782,  783,  780,  780,  783,  780,  777,    0,  163,
			  781,  131,  779,  168,  147,  783,  776,  168,  167,  781,
			  885,  885,  195,    0,    0,  225,  248,  188,  831,  885,
			  401,  264,  779,  771,  230,  885,  828,  885,  885,  885,
			  885,  300,  885,  294,  392,  885,  253,  338,  315,  336,
			  885,  885,  771,  176,  783,  182,  778,  760,  196,  768,
			  762,  774,  193,  798,  765,  771,  759,  763,  769,  758, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  770,  765,  753,  182,  767,  765,  761,  753,  759,  762,
			    0,  748,  752,    0,  753,  750,  739,  741,  743,  750,
			  736,  734,  734,  746,  736,  740,  744,  746,  735,  426,
			  303,  732,  743,  412,  403,  441,  885,  449,  440,  885,
			  441,  732,  730,  723,  723,  734,  725,  734,  718,  718,
			  718,  217,  717,  715,  724,  726,  751,    0,  725,  724,
			  717,  722,    0,  714,    0,    0,  705,  713,  702,  709,
			    0,    0,  703,  700,    0,  704,    0,  699,  699,  696,
			  708,  698,  702,  707,  706,  704,  694,  699,    0,  687,
			  699,  366,  374,  698,  695,  462,  456,    0,  701,  684,

			  694,  695,  680,  685,  690,  676,  690,  683,  369,  711,
			  672,  676,  685,    0,  676,  681,  672,  683,    0,    0,
			  670,  671,  676,  667,    0,  674,  660,  664,    0,  672,
			  669,  671,  655,  664,  666,    0,  657,  660,    0,  885,
			  344,  656,  667,  657,  661,  653,  645,  645,  648,  657,
			  654,  645,  677,  680,  677,    0,  676,  637,  647,  650,
			    0,  641,  644,  637,  628,  628,    0,    0,    0,  640,
			    0,    0,    0,    0,    0,    0,  617,  617,  570,  511,
			  440,  579,    0,  568,    0,    0,    0,  547,  492,  507,
			  498,  501,    0,    0,    0,    0,  475,  479,  471,  468, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0,  463,  461,    0,  440,    0,  446,  427,  536,  496,
			  143,  394,  406,  399,  384,  361,  365,  361,  362,  345,
			  343,    0,    0,    0,    0,    0,  500,  514,  885,  390,
			  325,  331,  306,  298,  293,  290,  268,  273,    0,  257,
			  885,  260,    0,  236,    0,  239,    0,    0,    0,  221,
			  226,  224,  191,  117,   73,   52,   25,    0,    0,    0,
			    0,  885,  540,  562,  572,  582,  592,  602,  515,  612,
			  622,  632,  642,  502,  487,  647,  648,  653,  654,  663,
			  669,  679, yy_Dummy>>,
			1, 82, 400)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 481)
			yy_def_template_1 (an_array)
			yy_def_template_2 (an_array)
			yy_def_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  461,    1,  462,  462,  463,  463,  464,  464,  465,
			  465,  461,  461,  461,  461,  461,  466,  461,  461,  467,
			  461,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  461,  461,  461,  461,  461,  461,  468,  468,  461,  461,
			  461,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  461,  461,  461,
			  461,  461,  469,  470,  470,  461,  471,  470,  470,  461,
			  472,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  461,  461,  461,  466,  461,  466,  461,  461,  461,  461,
			  467,  467,  461,  461,  461,  461,  461,  461,  461,  461,

			  461,  461,  461,  461,  461,  473,   29,  461,  461,  461,
			  461,  461,  461,  461,  461,  468,  467,  461,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  461,  461,  461,  469,  470,  470,  470,  470,  471,  461,
			  470,  474,  470,  470,  472,  461,  472,  461,  461,  461,
			  461,  461,  461,  101,  461,  461,  461,  461,  475,  473,
			  461,  461,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  468, yy_Dummy>>,
			1, 200, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  470,
			  474,  470,  470,  461,  476,  461,  461,  461,  477,  461,
			  461,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  470,  461,  470,  470,  461,  478,  468,  468,  468,

			  468,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  461,
			  470,  470,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  470,
			  479,  470,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  468, yy_Dummy>>,
			1, 200, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  468,  468,  468,  468,  468,  468,  468,  468,  470,  479,
			  480,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  470,  461,  461,  481,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  461,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,    0,  461,  461,  461,  461,  461,  461,  461,  461,
			  461,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  461,  461, yy_Dummy>>,
			1, 82, 400)
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
			    3,    1,    4,    4,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    5,    6,    7,    1,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,   22,   23,   24,   25,   24,   26,   24,   27,   28,
			   29,   30,   31,   32,    1,   33,   34,   33,   33,   35,
			   36,   37,   37,   37,   37,   37,   38,   37,   37,   37,
			   37,   37,   37,   37,   37,   39,   37,   37,   40,   37,
			   37,   41,   42,   43,   44,   45,    1,   46,   47,   48,

			   49,   50,   51,   52,   53,   54,   37,   55,   56,   57,
			   58,   59,   60,   37,   61,   62,   63,   64,   65,   66,
			   67,   68,   69,   70,   71,   72,   73,    1,    1,    1,
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
			    0,    1,    2,    3,    2,    1,    4,    1,    1,    1,
			    5,    1,    1,    1,    1,    1,    1,    1,    1,    6,
			    6,    6,    6,    6,    6,    6,    6,    1,    1,    1,
			    1,    1,    1,    7,    7,    7,    8,    9,   10,    9,
			    9,    1,    1,    1,    1,    9,    7,    7,    7,    7,
			    7,    8,    9,    9,    9,    9,   10,    9,    9,    9,
			    9,    9,    9,    9,    9,    9,    9,    9,    9,    9,
			    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 461)
			yy_accept_template_1 (an_array)
			yy_accept_template_2 (an_array)
			yy_accept_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_accept_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  135,  133,  132,  132,  120,  133,  126,  119,  133,
			  114,  115,  124,  123,  111,  122,  118,  125,   80,   80,
			  112,  108,  127,  113,  128,  131,   77,   77,  116,  117,
			  129,   77,   77,   77,   77,   77,   77,   77,   77,   77,
			   77,   77,   77,   77,   77,   77,   77,  109,  130,  110,
			  121,  132,    1,    5,    5,  134,  134,    5,    5,   10,
			   10,   10,   10,   10,    7,    8,   14,   12,   13,   56,
			   54,   55,  107,    0,   85,    0,   93,  110,  102,   94,
			    0,    0,   91,   99,   89,  100,   90,  101,    0,   83,

			   92,   84,   79,    0,   80,    0,   80,  117,  109,  116,
			   98,  104,  106,  105,   97,   77,    0,   95,   77,   77,
			   77,   77,   77,   77,   77,   77,   77,   77,   77,   77,
			   77,   22,   77,   77,   77,   77,   77,   77,   30,   77,
			   77,   77,   77,   77,   77,   77,   77,   77,   77,   77,
			   96,  103,    0,    1,    5,    5,    5,    5,    0,    6,
			    5,    0,    5,    5,    0,    9,    0,    8,    7,   81,
			   86,    0,   83,   83,    0,   84,   79,    0,   82,   78,
			   88,   87,   77,   77,   77,   77,   77,   77,   77,   77,
			   77,   77,   77,   77,   77,   77,   77,   77,   77,   77, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			   77,   77,   77,   77,   77,   77,   77,   77,   77,   77,
			   28,   77,   77,   31,   77,   77,   77,   77,   77,   77,
			   77,   77,   77,   77,   77,   77,   77,   77,   77,    5,
			    0,    5,    5,    0,   83,    0,   83,    0,   84,   82,
			   78,   77,   77,   77,   77,   77,   77,   77,   77,   77,
			   77,   77,   77,   77,   77,   77,   77,   68,   77,   77,
			   77,   77,   15,   77,   17,   18,   77,   77,   77,   77,
			   24,   25,   77,   77,   29,   77,   33,   77,   77,   77,
			   77,   77,   77,   77,   77,   77,   77,   77,   46,   77,
			   77,    5,    0,    5,    5,    0,   83,   32,   66,   77,

			   77,   77,   77,   77,   77,   77,   77,   77,   77,   77,
			   77,   77,   77,   76,   77,   77,   77,   77,   16,   19,
			   77,   77,   77,   77,   27,   77,   77,   77,   36,   77,
			   77,   77,   77,   77,   77,   44,   77,   77,   48,    2,
			    5,    5,   77,   77,   77,   77,   77,   77,   77,   77,
			   77,   77,   77,   77,   77,   59,   77,   77,   77,   77,
			   71,   77,   77,   77,   77,   77,   23,   26,   40,   77,
			   35,   37,   38,   39,   41,   42,   77,   77,   77,    5,
			    0,    5,   67,   77,   65,   70,   51,   77,   77,   77,
			   77,   77,   60,   61,   62,   63,   77,   77,   77,   77, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			   69,   77,   77,   21,   77,   43,   77,   77,    5,    0,
			    5,   77,   77,   77,   77,   77,   57,   77,   77,   77,
			   77,   73,   20,   34,   45,   47,    5,    0,    4,    0,
			   77,   77,   77,   77,   77,   77,   77,   77,   72,   77,
			    3,   77,   11,   77,   64,   77,   58,   52,   49,   77,
			   77,   77,   77,   77,   77,   77,   77,   74,   53,   50,
			   75,    0, yy_Dummy>>,
			1, 62, 400)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 885
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 461
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 462
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

	yyNb_rules: INTEGER = 134
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 135
			-- End of buffer rule code

	yyLine_used: BOOLEAN = true
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN = true
			-- Is `position' used?

	INITIAL: INTEGER = 0
	SC_FILE: INTEGER = 1
	SC_IMPL: INTEGER = 2
	SC_MSC_DECLSPEC: INTEGER = 3
	SC_GCC_ATTRIBUTE: INTEGER = 4
			-- Start condition codes

feature -- User-defined features


feature
end
