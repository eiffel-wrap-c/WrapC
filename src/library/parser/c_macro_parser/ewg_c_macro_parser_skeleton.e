note

	description:

		"Abstract skeleton for EWG_C_MACRO_PARSER"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

deferred class EWG_C_MACRO_PARSER_SKELETON

inherit

	EWG_PARSER_SKELETON
		rename
			make as make_ewg_parser
		end

	EWG_C_MACRO_SCANNER
		rename
			make as make_c_scanner
		end

	KL_SHARED_EXCEPTIONS
		export {NONE} all end


feature -- Initialization

	make (a_error_handler: like error_handler)
			-- Create a new parser.
		require
			a_error_handler_not_void: a_error_handler /= Void
		do
			make_c_scanner ("")
		ensure
			error_handler_set: error_handler = a_error_handler
		end

	parse_buffer (a_buffer: KI_CHARACTER_INPUT_STREAM)
		do
			set_input_buffer (new_file_buffer (a_buffer))
			parse
		end

	parse_file (a_file_name: STRING)
			-- Parse the already preprocessed C header file `a_file_name'.
		require
			a_file_name_not_void: a_file_name /= Void
		local
			in_file: KL_TEXT_INPUT_FILE
			total_ticks: INTEGER
		do
			last_header_file_name := a_file_name
			create in_file.make (a_file_name)
			total_ticks := in_file.count
			in_file.open_read
			if in_file.is_open_read then
				parse_buffer (in_file)
				in_file.close
				error_handler.stop_task
				if not syntax_error then
					error_handler.report_parsed_successfuly_message
				else
					Exceptions.die (1)
				end
			else
				error_handler.report_cannot_read_error (a_file_name)
				Exceptions.die (1)
			end
		end


invariant

	error_handler_not_void: error_handler /= Void

end
