note

	description:

		"Abstract base class for C and macro parser"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

deferred class EWG_PARSER_SKELETON

inherit

	YY_PARSER_SKELETON
		rename
			make as make_parser_skeleton
		redefine
			report_error
		end

	EWG_SHARED_C_SYSTEM

feature -- Initialization

	make (a_error_handler: like error_handler)
			-- Create a new parser.
		require
			a_error_handler_not_void: a_error_handler /= Void
		do
			error_handler := a_error_handler
			make_parser_skeleton
		ensure
			error_handler_set: error_handler = a_error_handler
		end

	parse_buffer (a_buffer: KI_CHARACTER_INPUT_STREAM)
		require
			a_buffer_not_void: a_buffer /= Void
			a_buffer_open_read: a_buffer.is_open_read
		deferred
		end


feature

	input_buffer: YY_BUFFER
		deferred
		end

	line: INTEGER
		deferred
		end

feature

	report_line_number_information (number: INTEGER; file_name: STRING)
		do
			print ("line dir: ")
			print (number.out + " " + file_name + "%N")
		end
feature

	error_handler: EWG_ERROR_HANDLER
			-- Error handler

feature

	report_error (a_message: STRING)
			-- Report a syntax error.
		local
			an_error: UT_SYNTAX_ERROR
			file_buffer: YY_FILE_BUFFER
			filename: STRING
		do
			file_buffer ?= input_buffer
			if file_buffer /= Void then
				filename := file_buffer.file.name
			else
				filename := "string"
			end
			create an_error.make (filename, line)
			error_handler.report_error (an_error)
		end

invariant

	error_handler_not_void: error_handler /= Void

end
