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

	SHARED_PROCESS_MISC

create

	make

feature

	make
			-- Create new EWG command line tool
		do
			Arguments.set_program_name ("wrap_c")
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

			if attached cpp_header_file_name then
				preprocess_file
					-- parsing (creates C AST)
				c_parser.parse_file (cpp_header_file_name)
				c_parser.print_summary
				c_parser := Void

					-- parsing C macro header
				create c_macro_parser.make (create {PATH}.make_from_string (cpp_header_file_name))
				c_macro_parser.parse_macro

					-- post process C AST
				post_parser_processor.post_process

					-- build Eiffel AST from post processed C AST
				eiffel_wrapper_builder.build
				print_eiffel_wrapper_summary


				eiffel_wrapper_builder.build_macros (c_macro_parser.constants)


					-- generating
				ewg_generator.generate

					-- Post processing
				execute_post_process
			end
		end


	preprocess_file
		local
			file: PLAIN_TEXT_FILE
			l_data: STRING
			regex: RX_PCRE_REGULAR_EXPRESSION
			count: INTEGER
		do
			if cpp_header_file_name /= Void then
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

			process_c_compiler_options

			process_extension_scripts_options

			process_other_arguments

			execute_pre_process

			preprocess_c_header
		end

	process_msc_extension_options
		do
			if operating_system.is_windows and then attached {EXECUTION_ENVIRONMENT}.item ("ISE_C_COMPILER") as l_compiler
				and then l_compiler.has_substring ("msc")
			then
				is_msc_extension_enabled := True
			end
		end

	process_c_compiler_options
		do
			if match_long_option ("c_compile_options") then
				if is_next_option_long_option and then has_next_option_value then
					compiler_options := next_option_value
					consume_option
					from

					until
						 match_long_option ("script_pre_process") or  match_long_option ("script_post_process") or match_long_option ("output-dir") or  match_long_option ("full-header") or not has_next_option
					loop
						compiler_options.append (" ")
						compiler_options.append (next_option_value)
						consume_option
					end
				else
					error_handler.report_missing_command_line_parameter_value_error ("--c_compile_options=<...>")
					error_handler.report_usage_error
					Exceptions.die (1)
				end
			end
		end

	process_extension_scripts_options
		do
			if match_long_option ("script_pre_process") then
				if is_next_option_long_option and then has_next_option_value then
					script_pre_process := next_option_value
					consume_option
				else
					error_handler.report_missing_command_line_parameter_value_error ("--script_pre_process=<...>")
					error_handler.report_usage_error
					Exceptions.die (1)
				end
			end
			if match_long_option ("script_post_process") then
				if is_next_option_long_option and then has_next_option_value then
					script_post_process := next_option_value
					consume_option
				else
					error_handler.report_missing_command_line_parameter_value_error ("--script_post_process=<...>")
					error_handler.report_usage_error
					Exceptions.die (1)
				end
			end
		end

	process_other_arguments
			-- Process arguments (using the obsolete syntax)
		local
			header_file_name: STRING
			l_path: PATH
		do
			if match_long_option ("output-dir") then
				if is_next_option_long_option and then has_next_option_value then
					output_directory_name := next_option_value
					consume_option
				end
			end

			if not match_long_option ("full-header")  then
				error_handler.report_missing_command_line_parameter_error ("--full-header=<...>")
				error_handler.report_usage_error
				Exceptions.die (1)
			end

			if not has_next_option_value then
				error_handler.report_missing_command_line_parameter_value_error ("--full-header=<...>")
				error_handler.report_usage_error
				Exceptions.die (1)
			end

			full_header_file_name := next_option_value
			header_file_name := full_header_file_name.twin
			consume_option

			if match_long_option ("full-header")  then
				if not has_next_option_value then
					error_handler.report_missing_command_line_parameter_value_error ("--full-header=<...>")
					error_handler.report_usage_error
					Exceptions.die (1)
				end
				full_header_file_name := next_option_value
				header_file_name := full_header_file_name.twin
				consume_option
			end

			create l_path.make_from_string (header_file_name)
			header_file_name := l_path.entry.out


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
		end

	preprocess_c_header
	    local
	    	l_cmd: STRING
	    	l_path: PATH
	    	l_name,
	    	l_error_message: STRING
	    	l_index: INTEGER
	    	l_file: RAW_FILE
	    	l_directory_name: STRING
	    	l_directory: DIRECTORY
	    	l_env: EXECUTION_ENVIRONMENT
		do
			if attached full_header_file_name as l_full_header_file_name  then
				-- gcc -E ${wrap_c.c_compile.options.default} ${wrap_c.c_compile.options} ${wrap_c.full_header_name} &gt; ${wrap_c.cpp_header_name}
				-- cl /nologo /E ${wrap_c.c_compile.options.default} ${wrap_c.c_compile.options} ${wrap_c.full_header_name} &gt; ${wrap_c.cpp_header_name}
				if output_directory_name /= Void then
					l_directory_name := output_directory_name
					config_system.set_output_directory_name (output_directory_name)
				else
					l_directory_name := config_system.directory_structure.default_output_directory
					config_system.set_output_directory_name (config_system.directory_structure.default_output_directory)
				end

				create l_directory.make_with_name (config_system.output_directory_name)
				if not l_directory.exists then
					l_directory.create_dir
				end

				create l_path.make_from_string (l_directory_name)
				if {PLATFORM}.is_windows and then attached {EXECUTION_ENVIRONMENT}.item ("ISE_C_COMPILER") as l_platform and then
					l_platform.has_substring ("msc")
				then
					create l_cmd.make_from_string ("cl /nologo /E ")
				else
					create l_cmd.make_from_string ("gcc -E ")
				end
				l_cmd.append (" ")
				if attached compiler_options as l_compiler_options then
					l_cmd.append_string (l_compiler_options)
				end
				l_cmd.append (" ")
				l_cmd.append_string (l_full_header_file_name)

				if {PLATFORM}.is_windows then
					if attached process_misc.output_of_command (l_cmd, l_path) as l_result then
						if l_result.exit_code = 0 then
							error_handler.report_info_message ("[Preprocess C header]")
							error_handler.report_info_message (l_cmd)
								-- To be updated.
							l_index := l_result.error_output.index_of ('.', 1) - 1
							l_name := l_result.error_output.substring (1, l_index)
							l_name.append_string ("_cpp.h")
							cpp_header_file_name := l_name.twin
							create l_file.make_create_read_write (l_name)
							l_file.put_string (l_result.output)
							l_file.flush
							l_file.close
						else
								-- Error
							l_error_message := l_result.error_output.out
							l_error_message.replace_substring_all ("%N", "")
							l_error_message.replace_substring_all ("%B", "")
							error_handler.report_info_message (l_error_message)
						end
					else
						error_handler.report_info_message ("Command not found " + l_cmd )
					end
				else
						-- Linux workaround Base Process doesn't work as expected
					create l_env
					l_env.change_working_path (l_path.parent)
					l_index := config_system.header_file_name.index_of ('.', 1) - 1
					l_name := config_system.header_file_name.substring (1, l_index)
					l_name.append_string ("_cpp.h")
					cpp_header_file_name := l_name.twin
					l_env.system (l_cmd + " > " + cpp_header_file_name)
				end
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



feature -- Execute Plugin scripts

	execute_pre_process
			-- Execute pre process script, if any.
		do
			if attached script_pre_process as l_script then
				if attached process_misc.output_of_command (l_script, Void) as l_result then
					if l_result.exit_code = 0 then
						error_handler.report_info_message ("[Execute pre process script]")
					else
						-- Error
						error_handler.report_info_message (l_result.error_output)
					end
				else
					error_handler.report_info_message ("Script not found " + l_script )
				end
			end
		end

	execute_post_process
			-- Execute post process script, if any.
		do
			if attached script_post_process as l_script then
				if attached process_misc.output_of_command (l_script, Void) as l_result then
					if l_result.exit_code = 0 then
						error_handler.report_info_message ("[Execute post process script]")
					else
						-- Error
						error_handler.report_info_message (l_result.error_output)
					end
				else
					error_handler.report_info_message ("Script not found " + l_script )
				end
			end
		end

feature {NONE} -- Implementation

	script_pre_process: STRING

	script_post_process: STRING

feature -- Access

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

	full_header_file_name: STRING
			-- C header file (with full path name)
			-- This is the file that will be preprocessed and
			-- saved as `cpp_header_file_name`.


	compiler_options: STRING
			-- Optional compiler options to apply during C headerp
			-- preprocessing.


	output_directory_name: STRING


	c_macro_parser: WRAPC_MACRO_PARSER
			-- C header macro parser



feature -- Platform directory Separator.

	unix_separator: CHARACTER = '/'
	windows_separator: CHARACTER = '\'
			-- Platform specific directory separator.

	directory_separator: CHARACTER
			-- Default directory separator for the current platform.
		do
			if {PLATFORM}.is_windows then
				Result := windows_separator
			else
				Result := unix_separator
			end
		end


end
