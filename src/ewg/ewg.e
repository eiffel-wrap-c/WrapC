note
	description:"[
		Command line tool that parses an (already preprocessed) C header file 
		and generates Eiffel wrappers for it
		]"
	copyright: "Copyright (c) 2004, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"


class EWG

inherit

	ANY

	KL_SHARED_EXCEPTIONS
		export {NONE} all end

	EWG_SHARED_C_SYSTEM
		export {NONE} all end

	EWG_COMMAND_LINE_PARSER
		rename
			make as make_ewg_command_line_parser
		export
			{NONE} all
		end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

	KL_SHARED_OPERATING_SYSTEM
		export {NONE} all end

create

	make

feature

	make
			-- Create new EWG command line tool
		do
			Arguments.set_program_name ("ewg")
			create error_handler.make
			make_ewg_command_line_parser

			process_arguments
			parse_config_file
			run
		end

	parse_config_file
		local
			parser: EWG_CONFIG_PARSER
			file: KL_TEXT_INPUT_FILE
			rule: EWG_CONFIG_RULE
			matching_clause: EWG_CONFIG_MATCHING_CLAUSE
			wrapper_clause: EWG_CONFIG_DEFAULT_WRAPPER_CLAUSE
		do
			if config_file_name /= Void then
				create parser.make (error_handler)
				create file.make (config_file_name)
				file.open_read
				if file.is_open_read then
					parser.parse_file (file, config_system)
					file.close
				else
					error_handler.report_cannot_read_error (config_file_name)
					Exceptions.die (1)
				end
			else
				create matching_clause.make
				create wrapper_clause.make
				create rule.make (matching_clause, wrapper_clause)
				config_system.append_rule (rule)
			end
			if error_handler.has_error then
				error_handler.report_quitting_because_of_config_file_errors_error (config_file_name)
				Exceptions.die (1)
			end
		end

	run
		do
			create c_parser.make (error_handler)
			if is_msc_extension_enabled then
				c_parser.enable_msc_extensions
			end
			create post_parser_processor.make (error_handler)
			create eiffel_wrapper_builder.make (error_handler,
															config_system.directory_structure,
															config_system.header_file_name,
															config_system.eiffel_wrapper_set,
															config_system)
			create ewg_generator.make (config_system.header_file_name,
												error_handler,
												config_system.directory_structure,
												config_system.eiffel_wrapper_set)

			debug ("EWG_EXPENSIVE_PHASE_2_ASSERTIONS")
				error_handler.report_info_message ("expensive phase 2 assertions enabled")
			end

			preprocess_file
				-- parsing (creates C AST)
			c_parser.parse_file (cpp_header_file_name)
			c_parser.print_summary
			c_parser := Void


			-- post process C AST
			post_parser_processor.post_process

			-- build Eiffel AST from post processed C AST
			eiffel_wrapper_builder.build
			print_eiffel_wrapper_summary

			-- generating
			ewg_generator.generate
		end


	preprocess_file
		local
			file: PLAIN_TEXT_FILE
			l_data: STRING
			regex: RX_PCRE_REGULAR_EXPRESSION
			count: INTEGER
		do
			create file.make_open_read_write (cpp_header_file_name)
			if file.exists then
				file.read_stream (file.count)
				l_data := file.last_string
				create regex.make
				regex.compile ("\t*__pragma.*")
				regex.match (l_data)
				count := regex.match_count
				l_data := regex.replace_all ("")
				file.wipe_out
				file.open_write
				file.put_string (l_data)
				file.flush
				file.close
			end
		end

	process_arguments
			-- Process command line arguments passed from the operating system
			-- A simple recursive decendant parser is used (just as in gexace)
		do
			if match_long_option ("version") then
				error_handler.enable_verbose
				error_handler.report_version_message
				error_handler.disable_verbose
				Exceptions.die (0)
			end
			if match_long_option ("verbose") then
				error_handler.enable_verbose
				consume_option
			end

			process_msc_extension_options

			process_other_arguments
		end

	process_msc_extension_options
		do
			if operating_system.is_windows then
				is_msc_extension_enabled := True
			end

			if match_long_option ("msc-extensions") then
				is_msc_extension_enabled := True
				consume_option
				error_handler.report_obsolete_syntax_is_used_message
				error_handler.report_usage_message
			end

			if match_long_option ("enable-msc-extensions") then
				is_msc_extension_enabled := True
				consume_option
			end

			if match_long_option ("disable-msc-extensions") then
				is_msc_extension_enabled := False
				consume_option
			end
		end

	process_other_arguments
			-- Process arguments (using the obsolete syntax)
		local
			header_file_name: STRING
			full_header_file_name: STRING
			output_directory_name: STRING
		do
			if match_long_option ("output-dir") then
				if is_next_option_long_option and then has_next_option_value then
					output_directory_name := next_option_value
					consume_option
				end
			end

			if not match_long_option ("cpp-full-header")  then
				error_handler.report_missing_command_line_parameter_error ("--cpp-full-header=<...>")
				error_handler.report_usage_error
				Exceptions.die (1)
			end

			if not has_next_option_value then
				error_handler.report_missing_command_line_parameter_value_error ("--cpp-full-header=<...>")
				error_handler.report_usage_error
				Exceptions.die (1)
			end

			cpp_header_file_name := next_option_value
			header_file_name := cpp_header_file_name.twin
			consume_option

			if match_long_option ("full-header")  then
				if not has_next_option_value then
					error_handler.report_missing_command_line_parameter_value_error ("--cpp-full-header=<...>")
					error_handler.report_usage_error
					Exceptions.die (1)
				end
				full_header_file_name := next_option_value
				header_file_name := full_header_file_name.twin
				consume_option
			end

			if match_long_option ("include-header") then
				if is_next_option_long_option and then has_next_option_value then
					header_file_name := next_option_value
					consume_option
				else
					error_handler.report_missing_command_line_parameter_value_error ("--include-header=<...>")
					error_handler.report_usage_error
					Exceptions.die (1)
				end
			end

			if match_long_option ("config") then
				if is_next_option_long_option and then has_next_option_value then
					config_file_name := next_option_value
					consume_option
				else
					error_handler.report_missing_command_line_parameter_value_error ("--config=<...>")
					error_handler.report_usage_error
					Exceptions.die (1)
				end
			end


			create config_system.make (header_file_name)

			if output_directory_name /= Void then
				config_system.set_output_directory_name (output_directory_name)
			else
				config_system.set_output_directory_name (config_system.directory_structure.default_output_directory)
			end

		end

	print_eiffel_wrapper_summary
			-- Print summary about Eiffel wrappers.
		local
			eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET
		do
			eiffel_wrapper_set := config_system.eiffel_wrapper_set
			error_handler.report_info_message ("  found:")
			error_handler.report_info_message ("    . " + eiffel_wrapper_set.enum_wrapper_count.out + " enum wrappers")
			error_handler.report_info_message ("    . " + eiffel_wrapper_set.struct_wrapper_count.out + " struct wrappers")
			error_handler.report_info_message ("    . " + eiffel_wrapper_set.union_wrapper_count.out + " union wrappers")
			error_handler.report_info_message ("    . " + eiffel_wrapper_set.function_wrapper_count.out + " function wrappers")
			error_handler.report_info_message ("    . " + eiffel_wrapper_set.callback_wrapper_count.out + " callback wrappers")
		end

feature

	error_handler: EWG_ERROR_HANDLER
			-- Error handler

	c_parser: EWG_C_PARSER
			-- C header parser

	eiffel_wrapper_builder: EWG_EIFFEL_WRAPPER_BUILDER
			-- Builds Eiffel wrappers from C AST

	post_parser_processor: EWG_POST_PARSER_PROCESSOR
			-- Post Parser Processor

	ewg_generator: EWG_GENERATOR
			-- Generator for Eiffel wrappers

	config_system: EWG_CONFIG_SYSTEM

	config_file_name: STRING
			-- EWG configuration file name

	is_msc_extension_enabled: BOOLEAN

	cpp_header_file_name: STRING
			-- Already C preprocessed header file (with full path name);
			-- This is the file ewg will open and parse.  It is a good
			-- idea to preprocess the header with the same (preprocessor)
			-- options you use to compile an application that uses this
			-- header.  Note: "cpp" does not stand for C++, it stands for
			-- "C-Pre-Processed".

end
