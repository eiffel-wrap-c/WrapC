note

	description:

		"Represents a wrapper clause that will generate callback wrappers"

	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

class EWG_CONFIG_CALLBACK_WRAPPER_CLAUSE

inherit

	EWG_CONFIG_WRAPPER_CLAUSE

	EWG_RENAMER
		export {NONE} all end

	EWG_SHARED_C_SYSTEM

create

	make

feature {ANY} -- Access

	accepts_type (a_type: EWG_C_AST_TYPE): BOOLEAN
		do
			Result := a_type.skip_wrapper_irrelevant_types.is_callback
		end

	accepts_declaration (a_declaration: EWG_C_AST_DECLARATION): BOOLEAN
		do
			Result := False
		end

feature {ANY} -- Basic Routines

	shallow_wrap_type (a_type: EWG_C_AST_TYPE;
							 a_include_header_file_name: STRING;
							 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET) 
		local
			member_list: DS_ARRAYED_LIST [EWG_MEMBER_WRAPPER]
			pointer_type: EWG_C_AST_POINTER_TYPE
			callback_wrapper: EWG_CALLBACK_WRAPPER
		do
			pointer_type ?= a_type.skip_wrapper_irrelevant_types
				check
					pointer_type_not_void: pointer_type /= Void
				end
			create member_list.make_default



			create {EWG_ANSI_C_CALLBACK_WRAPPER} callback_wrapper.make (eiffel_identifier_for_type (pointer_type),
																							a_include_header_file_name,
																							pointer_type,
																							member_list)

			a_eiffel_wrapper_set.add_wrapper (callback_wrapper)
		end

	shallow_wrap_declaration (a_declaration: EWG_C_AST_DECLARATION;
									  a_include_header_file_name: STRING;
									  a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
		do
				check
					dead_end: False
				end
		end

	deep_wrap_type (a_type: EWG_C_AST_TYPE;
						 a_include_header_file_name: STRING;
						 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET;
						 a_config_system: EWG_CONFIG_SYSTEM)
		local
			pointer_type: EWG_C_AST_POINTER_TYPE
			callback_wrapper: EWG_CALLBACK_WRAPPER
			function_type: EWG_C_AST_FUNCTION_TYPE
			cs: DS_BILINEAR_CURSOR [EWG_C_AST_DECLARATION]
			i: INTEGER
		do
			pointer_type ?= a_type.skip_wrapper_irrelevant_types
				check
					pointer_type_not_void: pointer_type /= Void
				end
			-- TODO:
			callback_wrapper := a_eiffel_wrapper_set.callback_wrapper_from_callback (pointer_type)
			function_type := pointer_type.function_type
			from
				cs := function_type.members.new_cursor
				cs.start
			until
				cs.off
			loop
				i := i + 1
				wrap_callback_parameter (callback_wrapper,
												 cs.item,
												 i,
												 a_include_header_file_name,
												 a_eiffel_wrapper_set,
												 a_config_system)
				cs.forth
			end

			if c_system.types.void_type /= function_type.return_type.skip_consts_and_aliases then
				wrap_callback_return_type (callback_wrapper,
													a_include_header_file_name,
													a_eiffel_wrapper_set,
													a_config_system)
			end
			a_config_system.mark_type_completely_wrapped (a_type)
		end

	deep_wrap_declaration (a_declaration: EWG_C_AST_DECLARATION;
								  a_include_header_file_name: STRING;
								  a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET;
								  a_config_system: EWG_CONFIG_SYSTEM)
		do
				check
					dead_end: False
				end
		end

feature {NONE}

	wrap_callback_parameter (a_callback_wrapper: EWG_CALLBACK_WRAPPER;
									 a_parameter: EWG_C_AST_DECLARATION;
									 a_index: INTEGER;
									 a_include_header_file_name: STRING;
									 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET;
									 a_config_system: EWG_CONFIG_SYSTEM)
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
			a_parameter_not_void: a_parameter /= Void
			a_parameter_is_member_of_callback: a_callback_wrapper.c_pointer_type.function_type.members.has (a_parameter)
			a_index_greater_equal_one: a_index >= 1
			a_include_header_file_name_not_void: a_include_header_file_name /= Void
			a_eiffel_wrapper_set_not_void: a_eiffel_wrapper_set /= Void
			a_config_system_not_void: a_config_system /= Void
		local
			mapped_eiffel_name: STRING
			member_wrapper: EWG_MEMBER_WRAPPER
			wrappable_type: EWG_C_AST_TYPE
		do
			if a_parameter.declarator = Void then
				create mapped_eiffel_name.make (("anonymous_").count + 3)
				mapped_eiffel_name.append_string ("anonymous_")
				mapped_eiffel_name.append_string (a_index.out)
			else
				mapped_eiffel_name := eiffel_parameter_name_from_c_parameter_name (a_parameter.declarator)
			end
			wrappable_type := a_parameter.type.skip_wrapper_irrelevant_types
			a_config_system.force_shallow_wrap_type (a_parameter.type,
																  a_include_header_file_name,
																  a_eiffel_wrapper_set)

			create {EWG_NATIVE_MEMBER_WRAPPER} member_wrapper.make (mapped_eiffel_name,
																					  a_include_header_file_name,
																					  a_parameter)
			a_callback_wrapper.add_member (member_wrapper)
		end

	wrap_callback_return_type (a_callback_wrapper: EWG_CALLBACK_WRAPPER;
										a_include_header_file_name: STRING;
										a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET;
										a_config_system: EWG_CONFIG_SYSTEM)
			-- Add wrapper for the return type of callback `a_callback_wrapper.c_pointer_type' to
			-- `a_callback_wrapper'.
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
			callback_has_return_type: c_system.types.void_type /= a_callback_wrapper.c_pointer_type.function_type.return_type.skip_consts_and_aliases
			a_include_header_file_name_not_void: a_include_header_file_name /= Void
			a_eiffel_wrapper_set_not_void: a_eiffel_wrapper_set /= Void
			a_config_system_not_void: a_config_system /= Void
		local
			fake_declaration: EWG_C_AST_DECLARATION
			member_wrapper: EWG_MEMBER_WRAPPER
			return_type: EWG_C_AST_TYPE
			wrappable_type: EWG_C_AST_TYPE
		do
			return_type := a_callback_wrapper.c_pointer_type.function_type.return_type
			wrappable_type := return_type.skip_wrapper_irrelevant_types
			a_config_system.force_shallow_wrap_type (return_type,
																  a_include_header_file_name,
																  a_eiffel_wrapper_set)
			create fake_declaration.make (Void,
													return_type.skip_consts_and_aliases,
													a_callback_wrapper.c_pointer_type.function_type.header_file_name)
			create {EWG_NATIVE_MEMBER_WRAPPER} member_wrapper.make ("not_applicable", -- TODO:
																					  a_include_header_file_name,
																					  fake_declaration)
			a_callback_wrapper.set_return_type (member_wrapper)
		end

	default_eiffel_identifier_for_type (a_type: EWG_C_AST_TYPE): STRING
		local
			pointer_type: EWG_C_AST_POINTER_TYPE
		do
			pointer_type ?= a_type
				check
					is_pointer_type: pointer_type /= Void
				end
			if pointer_type.closest_alias_type /= Void then
				Result := eiffel_feature_name_from_c_function_name (pointer_type.closest_alias_type.name)
			else
				Result := eiffel_feature_name_from_c_function_parameters (pointer_type.function_type)
			end
		end

	default_eiffel_identifier_for_declaration (a_declaration: EWG_C_AST_DECLARATION): STRING
		do
				check
					dead_end: False
				end
		end

end



