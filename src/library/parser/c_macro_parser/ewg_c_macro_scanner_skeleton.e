note

	description:

		"Abstract skeleton for EWG_C_MACRO_SCANNER"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

deferred class EWG_C_MACRO_SCANNER_SKELETON

inherit

	EWG_C_MACRO_TOKENS

	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton
		redefine
			print_last_token
		end

	UT_CHARACTER_CODES

feature

	make (a_header_file_name: STRING)
			-- Create a new scanner.
			-- `a_header_file_name' will only be used until
			-- the first header file name directive has been found.
			-- This is usually the first line.
			-- This parameter is thus only useful for very simple
			-- header files, that do not need preprocessing.
			-- Because in this case, no header file name directives
			-- can be found.
		require
			a_header_file_name_not_void: a_header_file_name /= Void
		do
			make_compressed_scanner_skeleton
			last_header_file_name := a_header_file_name
		end

feature -- Access

	last_value: ANY

	print_last_token 
			-- Print to standard error debug information
			-- about the last token read. Can be redefined
			-- in descendant classes to print more information.
			-- (Called at the end of `read_token' when compiled
			-- with 'debug ("GELEX")' enabled).
		do
			std.error.put_string ("Last token code: ")
			std.error.put_integer (last_token)
			std.error.put_string (" / ")
			std.error.put_string (token_name (last_token))
			std.error.put_string (" / ")

			inspect last_token
			when yyEOF_token then
				std.error.put_string ("EOF token")
			when yyError_token then
				std.error.put_string ("Error token")
			when yyUnknown_token then
					-- Should never happen.
				std.error.put_string ("Unknown token")
			else
				std.error.put_character ('%"')
				std.error.put_string (text)
				std.error.put_string ("%"")
			end
			if yyLine_used then
					-- Line and column numbers are used.
				std.error.put_string (" [")
				std.error.put_integer (line)
				std.error.put_string (",")
				std.error.put_integer (column)
				std.error.put_string ("]")
			end
			std.error.put_string ("%N")
		end

	set_header_line_number (a_line_number: INTEGER)
		require
			a_line_number_greater_zero: a_line_number > 0
		do
			last_header_line_numer := a_line_number
		end

	set_header_file_name (a_file_name: STRING)
		require
			a_file_name_not_void: a_file_name /= Void
		do
			last_header_file_name := a_file_name
		end

feature

	last_header_line_numer: INTEGER

	last_header_file_name: STRING

invariant

	last_header_file_name_not_void: last_header_file_name /= Void

end
