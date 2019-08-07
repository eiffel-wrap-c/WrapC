note

	description:

		"Class which runs various generators (objects which produce wrapper code)"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

class EWG_GENERATOR

inherit

	EWG_RENAMER
		export {NONE} all end

	EWG_SHARED_EIFFEL_COMPILER_NAMES
		export {NONE} all end

create

	make

feature

	make (a_raw_header_file_name: STRING;
			a_error_handler: like error_handler;
			a_directory_structure: EWG_DIRECTORY_STRUCTURE;
			a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
			-- Create new EWG_GENERATOR object
		require
			a_raw_header_file_name_not_void: a_raw_header_file_name /= Void
			a_error_handler_not_void: a_error_handler /= Void
			a_directory_structure_not_void: a_directory_structure /= Void
			a_eiffel_wrapper_set_not_void: a_eiffel_wrapper_set /= Void
		do
			raw_header_file_name := a_raw_header_file_name
			error_handler := a_error_handler
			directory_structure := a_directory_structure
			eiffel_wrapper_set := a_eiffel_wrapper_set
		ensure
			raw_header_file_name_set: raw_header_file_name = a_raw_header_file_name
			error_handler_set: error_handler = a_error_handler
			directory_structure_set: directory_structure = a_directory_structure
			eiffel_wrapper_set: eiffel_wrapper_set = a_eiffel_wrapper_set
		end

feature {ANY}

	generate
		do
			if eiffel_wrapper_set.enum_wrapper_count > 0 then
				error_handler.start_task ("phase 4: generating enum wrappers")
				error_handler.set_current_task_total_ticks (eiffel_wrapper_set.enum_wrapper_count * 4)
				generate_enum_wrappers
				error_handler.stop_task
			end
			if eiffel_wrapper_set.struct_wrapper_count > 0 then
				error_handler.start_task ("phase 4: generating struct wrappers")
				error_handler.set_current_task_total_ticks (eiffel_wrapper_set.struct_wrapper_count * 6)
				generate_struct_wrappers
				error_handler.stop_task
			end
			if eiffel_wrapper_set.union_wrapper_count > 0 then
				error_handler.start_task ("phase 4: generating union wrappers")
				generate_union_wrappers
				error_handler.stop_task
			end
			if eiffel_wrapper_set.function_wrapper_count > 0 then
				error_handler.start_task ("phase 4: generating function wrappers")
				error_handler.set_current_task_total_ticks (eiffel_wrapper_set.function_wrapper_count * 12)
				generate_function_wrappers
				error_handler.stop_task
			end
			if eiffel_wrapper_set.callback_wrapper_count > 0 then
				error_handler.start_task ("phase 4: generating function callback wrappers")
				error_handler.set_current_task_total_ticks (eiffel_wrapper_set.callback_wrapper_count * 9)
				generate_callback_wrappers
				error_handler.stop_task
			end
		end

feature {NONE} -- Implementation

	generate_enum_wrappers
		local
			eiffel_api_generator: EWG_EIFFEL_API_ENUM_WRAPPER_GENERATOR
		do
			create eiffel_api_generator.make (error_handler, directory_structure)
			eiffel_api_generator.generate_for_all_compilers (eiffel_wrapper_set)
		end

	generate_struct_wrappers
		local
			eiffel_api_generator: EWG_EIFFEL_API_STRUCT_WRAPPER_GENERATOR
		do
			create eiffel_api_generator.make (error_handler, directory_structure)
			eiffel_api_generator.generate (eiffel_wrapper_set)
		end

	generate_union_wrappers
		local
			eiffel_api_generator: EWG_EIFFEL_API_UNION_WRAPPER_GENERATOR
		do
			create eiffel_api_generator.make (error_handler, directory_structure)
			eiffel_api_generator.generate (eiffel_wrapper_set)
		end

	generate_function_wrappers
		local
			eiffel_api_generator: EWG_EIFFEL_API_FUNCTION_WRAPPER_GENERATOR
		do
			create eiffel_api_generator.make (error_handler, directory_structure)
			eiffel_api_generator.generate (eiffel_wrapper_set)
		end

	generate_callback_wrappers
		local
			c_glue_code_generator: EWG_C_GLUE_CODE_ANSI_C_CALLBACK_WRAPPER_GENERATOR
			c_glue_header_generator: EWG_C_GLUE_HEADER_ANSI_C_CALLBACK_WRAPPER_GENERATOR
			eiffel_abstraction_ansi_wrapper_generator: EWG_EIFFEL_ABSTRACTION_ANSI_C_CALLBACK_WRAPPER_GENERATOR
			eiffel_abstraction_ffcall_wrapper_generator: EWG_EIFFEL_ABSTRACTION_FFCALL_CALLBACK_WRAPPER_GENERATOR
			eiffel_abstraction_dispatcher_generator: EWG_EIFFEL_ABSTRACTION_ANSI_C_CALLBACK_DISPATCHER_GENERATOR
		do
			create c_glue_code_generator.make (error_handler, directory_structure)
			c_glue_code_generator.generate_for_all_compilers (eiffel_wrapper_set)

			create c_glue_header_generator.make (error_handler, directory_structure)
			c_glue_header_generator.generate_for_all_compilers (eiffel_wrapper_set)

--			create eiffel_abstraction_ansi_wrapper_generator.make (error_handler, directory_structure)
--			eiffel_abstraction_ansi_wrapper_generator.generate (eiffel_wrapper_set)

			create eiffel_abstraction_ffcall_wrapper_generator.make (error_handler, directory_structure)
			eiffel_abstraction_ffcall_wrapper_generator.generate (eiffel_wrapper_set)

			create eiffel_abstraction_dispatcher_generator.make (error_handler, directory_structure)
			eiffel_abstraction_dispatcher_generator.generate (eiffel_wrapper_set)
		end

feature {NONE} -- Implementation

	raw_header_file_name: STRING
			-- Name of the raw header file name

	error_handler: EWG_ERROR_HANDLER
			-- Error handler

	directory_structure: EWG_DIRECTORY_STRUCTURE
			-- Directory structure

	eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET
			-- Wrapper set

invariant

	error_handler_not_void: error_handler /= Void
	raw_header_file_name_not_void: raw_header_file_name /= Void
	directory_structure_not_void: directory_structure /= Void
	eiffel_wrapper_set_not_void: eiffel_wrapper_set /= Void

end
