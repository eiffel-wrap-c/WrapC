note

	description:

		"Represents a wrapper clause that will generate function wrappers"

	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

class EWG_CONFIG_FUNCTION_WRAPPER_CLAUSE

inherit

	EWG_CONFIG_WRAPPER_CLAUSE
		redefine
			make
		end

	EWG_RENAMER
		export {NONE} all end

	EWG_SHARED_C_SYSTEM

create

	make

feature {NONE} -- Initialization

	make
		do
			Precursor
		end

feature {ANY} -- Access

	class_name: STRING

	accepts_type (a_type: EWG_C_AST_TYPE): BOOLEAN
		do
			Result := False
		end

	accepts_declaration (a_declaration: EWG_C_AST_DECLARATION): BOOLEAN
		local
			function_declaration: EWG_C_AST_FUNCTION_DECLARATION
		do
			function_declaration ?= a_declaration
			Result := function_declaration /= Void
		end

feature {ANY} -- Setting

	set_class_name (a_class_name: STRING)
		require
			a_class_name_not_void: a_class_name /= Void
			a_class_name_not_empty: a_class_name.count > 0
		do
			class_name := a_class_name
		ensure
			class_name_set: class_name = a_class_name
		end

feature {ANY} -- Basic Routines

	shallow_wrap_type (a_type: EWG_C_AST_TYPE;
							 a_include_header_file_name: STRING;
							 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
		do
				check
					dead_end: False
				end
		end

	shallow_wrap_declaration (a_declaration: EWG_C_AST_DECLARATION;
									  a_include_header_file_name: STRING;
									  a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
		local
			member_list: DS_ARRAYED_LIST [EWG_MEMBER_WRAPPER]
			function_wrapper: EWG_FUNCTION_WRAPPER
			function_declaration: EWG_C_AST_FUNCTION_DECLARATION
			actual_class_name: STRING
		do
			function_declaration ?= a_declaration
				check
					is_function_declaration: function_declaration /= Void
				end
			create member_list.make_default
			if class_name /= Void then
				actual_class_name := class_name
			else
				actual_class_name := c_header_file_name_to_eiffel_class_name (a_declaration.header_file_name) + "_FUNCTIONS"
			end

			create function_wrapper.make (eiffel_identifier_for_declaration (a_declaration),
													a_include_header_file_name,
													function_declaration,
													member_list,
													actual_class_name)

			a_eiffel_wrapper_set.add_wrapper (function_wrapper)
		end

	deep_wrap_type (a_type: EWG_C_AST_TYPE;
						 a_include_header_file_name: STRING;
						 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET;
						 a_config_system: EWG_CONFIG_SYSTEM)
		do
				check
					dead_end: False
				end
		end

	deep_wrap_declaration (a_declaration: EWG_C_AST_DECLARATION;
								  a_include_header_file_name: STRING;
								  a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET;
								  a_config_system: EWG_CONFIG_SYSTEM)
		local
			cs: DS_BILINEAR_CURSOR [EWG_C_AST_DECLARATION]
			function_wrapper: EWG_FUNCTION_WRAPPER
			i: INTEGER
			function_declaration: EWG_C_AST_FUNCTION_DECLARATION
		do
			function_declaration ?= a_declaration
				check
					is_function_declaration: function_declaration /= Void
				end
			function_wrapper := a_eiffel_wrapper_set.function_wrapper_from_function_declaration (function_declaration)
			from
				cs := function_declaration.function_type.members.new_cursor
				cs.start
			until
				cs.off
			loop
				i := i + 1
				wrap_function_parameter (function_wrapper,
												 cs.item,
												 i,
												 a_include_header_file_name,
												 a_eiffel_wrapper_set,
												 a_config_system)
				cs.forth
			end

			if c_system.types.void_type /= function_declaration.function_type.return_type.skip_consts_and_aliases then
				wrap_function_return_type (function_wrapper,
													a_include_header_file_name,
													a_eiffel_wrapper_set,
													a_config_system)
			end
		end

feature {NONE}


	wrap_function_parameter (a_function_wrapper: EWG_FUNCTION_WRAPPER;
									 a_parameter: EWG_C_AST_DECLARATION;
									 a_index: INTEGER;
									 a_include_header_file_name: STRING;
									 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET;
									 a_config_system: EWG_CONFIG_SYSTEM)
			-- Add wrapper for `a_parameter' to `a_function_wrapper'.
			-- `a_parameter' is supposed to be the `a_index'-th parameter in `a_function_declaration'.
		require
			a_function_wrapper_not_void: a_function_wrapper /= Void
			a_parameter_not_void: a_parameter /= Void
			a_parameter_is_parameter_of_a_function_declaration: a_function_wrapper.function_declaration.function_type.members.has (a_parameter)
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
			if wrappable_type.can_be_wrapped then
				a_config_system.force_shallow_wrap_type (a_parameter.type,
																	  a_include_header_file_name,
																	  a_eiffel_wrapper_set)
			end
			if a_parameter.type.is_char_pointer_type then
				create {EWG_ZERO_TERMINATED_STRING_MEMBER_WRAPPER} member_wrapper.make (mapped_eiffel_name,
																												a_include_header_file_name,
																												a_parameter)
				a_function_wrapper.add_member (member_wrapper)
			else
				create {EWG_NATIVE_MEMBER_WRAPPER} member_wrapper.make (mapped_eiffel_name,
																						  a_include_header_file_name,
																						  a_parameter)
				a_function_wrapper.add_member (member_wrapper)
			end
	end

	wrap_function_return_type (a_function_wrapper: EWG_FUNCTION_WRAPPER;
										a_include_header_file_name: STRING;
										a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET;
										a_config_system: EWG_CONFIG_SYSTEM)
			-- Add wrapper for the return type of `a_function_wrapper.function_declaration' to
			-- `a_function_wrapper'.
		require
			a_function_wrapper_not_void: a_function_wrapper /= Void
			a_function_wrapper_has_return_type: c_system.types.void_type /= a_function_wrapper.function_declaration.function_type.return_type.skip_consts_and_aliases
			a_include_header_file_name_not_void: a_include_header_file_name /= Void
			a_eiffel_wrapper_set_not_void: a_eiffel_wrapper_set /= Void
			a_config_system_not_void: a_config_system /= Void
		local
			fake_declaration: EWG_C_AST_DECLARATION
			member_wrapper: EWG_MEMBER_WRAPPER
			return_type: EWG_C_AST_TYPE
		do
			return_type := a_function_wrapper.function_declaration.function_type.return_type
			a_config_system.force_shallow_wrap_type (return_type,
																  a_include_header_file_name,
																  a_eiffel_wrapper_set)
			create fake_declaration.make (Void,
													return_type.skip_consts_and_aliases,
													a_function_wrapper.function_declaration.function_type.header_file_name)
			create {EWG_NATIVE_MEMBER_WRAPPER} member_wrapper.make ("not_applicable", -- TODO:
																					  a_include_header_file_name,
																					  fake_declaration)
			a_function_wrapper.set_return_type (member_wrapper)
		end

	default_eiffel_identifier_for_type (a_type: EWG_C_AST_TYPE): STRING
		do
				check
					dead_end: False
				end
		end

	default_eiffel_identifier_for_declaration (a_declaration: EWG_C_AST_DECLARATION): STRING 
		local
			function_declaration: EWG_C_AST_FUNCTION_DECLARATION
		do
			function_declaration ?= a_declaration
				check
					is_function_declaration: function_declaration /= Void
				end
			Result := eiffel_feature_name_from_c_function (function_declaration)
		end

invariant

	class_name_not_void_implies_not_empty: class_name /= Void implies class_name.count > 0

end
