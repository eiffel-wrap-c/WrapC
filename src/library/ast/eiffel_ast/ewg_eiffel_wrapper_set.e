note

	description:

		"Represents a set of Eiffel Wrappers. Wrappers are decendants of EWG_ABSTRACT_WRAPPER"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

class EWG_EIFFEL_WRAPPER_SET

inherit

	EWG_RENAMER
		export {NONE} all end

	EWG_C_AST_SHARED_TYPE_EQUALITY_TESTER
		export {NONE} all end

	EWG_C_AST_SHARED_DECLARATION_EQUALITY_TESTER
		export {NONE} all end

create

	make

feature {NONE}

	make
			-- Create new Eiffel wrapper set.
		do
			create enum_wrapper_table.make_map (Initial_enum_wrapper_table_size)
			enum_wrapper_table.set_key_equality_tester (enum_equality_tester)
			create union_wrapper_table.make_map (Initial_union_wrapper_table_size)
			union_wrapper_table.set_key_equality_tester (union_equality_tester)
			create struct_wrapper_table.make_map (Initial_struct_wrapper_table_size)
			struct_wrapper_table.set_key_equality_tester (struct_equality_tester)
			create function_wrapper_table.make_map (Initial_function_wrapper_table_size)
			function_wrapper_table.set_key_equality_tester (function_declaration_equality_tester)
			create callback_wrapper_table.make_map (Initial_callback_wrapper_table_size)
			callback_wrapper_table.set_key_equality_tester (pointer_equality_tester)
			create function_wrapper_groups.make_map (Initial_function_wrapper_groups_size)
			function_wrapper_groups.set_key_equality_tester (string_equality_tester)
			create callback_wrapper_groups.make_map (Initial_callback_wrapper_groups_size)
			callback_wrapper_groups.set_key_equality_tester (string_equality_tester)


			create macro_wrapper_table.make_map (initial_macro_wrapper_table_size)
			macro_wrapper_table.set_key_equality_tester (string_equality_tester)
			create macro_wrapper_groups.make_map (initial_macro_wrapper_groups_size)
			macro_wrapper_groups.set_key_equality_tester (string_equality_tester)

		end

feature {ANY}

	is_ffcall_needed: BOOLEAN
			-- Returns true if at least one callback wrapper
			-- should be generated using ffcall support
		local
			cs: DS_BILINEAR_CURSOR [EWG_CALLBACK_WRAPPER]
			ffcall_wrapper: EWG_FFCALL_CALLBACK_WRAPPER
		do
			from
				cs := callback_wrapper_table.new_cursor
				cs.start
			until
				cs.off
			loop
				ffcall_wrapper ?= cs.item
				if ffcall_wrapper /= Void then
					Result := True
					cs.go_after
				end
				cs.forth
			end
		end

feature {ANY} -- Statistical Queries

	enum_wrapper_count: INTEGER
			-- Number of enum wrappers in this set
		do
			Result := enum_wrapper_table.count
		ensure
			count_greater_equal_zero: Result >= 0
		end

	struct_wrapper_count: INTEGER
			-- Number of struct wrappers in this set
		do
			Result := struct_wrapper_table.count
		ensure
			count_greater_equal_zero: Result >= 0
		end

	union_wrapper_count: INTEGER
			-- Number of union wrappers in this set
		do
			Result := union_wrapper_table.count
		ensure
			count_greater_equal_zero: Result >= 0
		end

	function_wrapper_count: INTEGER
			-- Number of function wrappers in this set
		do
			Result := function_wrapper_table.count
		ensure
			count_greater_equal_zero: Result >= 0
		end

	callback_wrapper_count: INTEGER
			-- Number of callback wrappers in this set
		do
			Result := callback_wrapper_table.count
		ensure
			count_greater_equal_zero: Result >= 0
		end

	type_wrapper_count: INTEGER
		do
			Result := enum_wrapper_count + struct_wrapper_count + union_wrapper_count + callback_wrapper_count
		ensure
			count_positive: Result >= 0
		end

	function_wrapper_group_count: INTEGER
			-- Number of function wrapper groups in this set
		do
			Result := function_wrapper_groups.count
		ensure
			count_greater_equal_zero: Result >= 0
		end

	callback_wrapper_group_count: INTEGER
			-- Number of callback wrapper groups in this set
		do
			Result := callback_wrapper_groups.count
		ensure
			count_greater_equal_zero: Result >= 0
		end


	macro_wrapper_group_count: INTEGER
			-- Number of macro wrapper groups in this set
		do
			Result := macro_wrapper_groups.count
		ensure
			count_greater_equal_zero: Result >= 0
		end


feature {ANY} -- Get cursors for wrappers

	new_enum_wrapper_cursor: DS_BILINEAR_CURSOR [EWG_ENUM_WRAPPER]
		do
			Result := enum_wrapper_table.new_cursor
		end

	new_struct_wrapper_cursor: DS_BILINEAR_CURSOR [EWG_STRUCT_WRAPPER]
		do
			Result := struct_wrapper_table.new_cursor
		end

	new_union_wrapper_cursor: DS_BILINEAR_CURSOR [EWG_UNION_WRAPPER]
		do
			Result := union_wrapper_table.new_cursor
		end

	new_function_wrapper_cursor: DS_BILINEAR_CURSOR [EWG_FUNCTION_WRAPPER]
		do
			Result := function_wrapper_table.new_cursor
		end

	new_macro_wrapper_cursor: DS_BILINEAR_CURSOR [EWG_MACRO_WRAPPER]
		do
			Result := macro_wrapper_table.new_cursor
		end

	new_callback_wrapper_cursor: DS_BILINEAR_CURSOR [EWG_CALLBACK_WRAPPER]
		do
			Result := callback_wrapper_table.new_cursor
		end

	new_function_wrapper_groups_cursor: DS_HASH_TABLE_CURSOR [DS_LINKED_LIST [EWG_FUNCTION_WRAPPER], STRING]
		do
			Result := function_wrapper_groups.new_cursor
		end

	new_callback_wrapper_groups_cursor: DS_HASH_TABLE_CURSOR [DS_LINKED_LIST [EWG_CALLBACK_WRAPPER], STRING]
		do
			Result := callback_wrapper_groups.new_cursor
		end

	new_macro_wrapper_groups_cursor: DS_HASH_TABLE_CURSOR [DS_LINKED_LIST [EWG_MACRO_WRAPPER], STRING]
		do
			Result := macro_wrapper_groups.new_cursor
		end


feature {ANY} -- Latest wrappers

	last_enum_wrapper: EWG_ENUM_WRAPPER
			-- Last enum wrapper added to `enum_wrapper_table'

	last_struct_wrapper: EWG_STRUCT_WRAPPER
			-- Last struct wrapper added to `struct_wrapper_table'

	last_union_wrapper: EWG_UNION_WRAPPER
			-- Last union wrapper added to `union_wrapper_table'

	last_function_wrapper: EWG_FUNCTION_WRAPPER
			-- Last function wrapper added to `function_wrapper_table'

	last_callback_wrapper: EWG_CALLBACK_WRAPPER
			-- Last callback wrapper added to `callback_wrapper_table'

	last_macro_wrapper: EWG_MACRO_WRAPPER
			-- Last macro wrapper added to `macro_wrapper_table'

feature {ANY} -- Helper queries

	has_wrapper_for_type (a_type: EWG_C_AST_TYPE): BOOLEAN
			-- Does `Current' contain a wrapper for `a_type'?
		require
			a_type_not_void: a_type /= Void
		local
			enum_type: EWG_C_AST_ENUM_TYPE
			struct_type: EWG_C_AST_STRUCT_TYPE
			union_type: EWG_C_AST_UNION_TYPE
			pointer_type: EWG_C_AST_POINTER_TYPE
		do
			enum_type ?= a_type
			struct_type ?= a_type
			union_type ?= a_type

			if a_type.is_callback then
				pointer_type ?= a_type.skip_consts_and_aliases
			end

			if enum_type /= Void then
				Result := enum_wrapper_table.has (enum_type)
			elseif struct_type /= Void then
				Result := struct_wrapper_table.has (struct_type)
			elseif union_type /= Void then
				Result := union_wrapper_table.has (union_type)
			elseif pointer_type /= Void then
				Result := callback_wrapper_table.has (pointer_type)
			else
				Result := False
			end
		end

	has_wrapper_for_declaration (a_declaration: EWG_C_AST_DECLARATION): BOOLEAN
			-- Has `Current' a wrapper for `a_declaration'?
		require
			a_declaration_not_void: a_declaration /= Void
		local
			function_declaration: EWG_C_AST_FUNCTION_DECLARATION
		do
			function_declaration ?= a_declaration
				check
					no_other_declaration_wrappable_yet: function_declaration /= Void
				end
			Result := function_wrapper_table.has (function_declaration)
		end

	has_wrapper_for_macro (a_macro: STRING): BOOLEAN
			-- Has `Current' a wrapper for `a_macro'?
		require
			a_macro_not_void: a_macro /= Void
		do
			Result := macro_wrapper_table.has (a_macro)
		end

	has_wrapper (a_wrapper: EWG_ABSTRACT_WRAPPER): BOOLEAN
			-- Does this set already contain a wrapper for the type that `a_wrapper' wraps?
		require
			a_wrapper_not_void: a_wrapper /= Void
		local
			type_wrapper: EWG_ABSTRACT_TYPE_WRAPPER
			declaration_wrapper: EWG_ABSTRACT_DECLARATION_WRAPPER
		do
			if attached {EWG_MACRO_WRAPPER} a_wrapper as l_wrapper then
				Result := has_wrapper_for_macro (l_wrapper.constant_name)
			else
				type_wrapper ?= a_wrapper
				declaration_wrapper ?= a_wrapper
					check
						exactly_one_not_void: (type_wrapper = Void) xor (declaration_wrapper = Void)
					end
				if type_wrapper /= Void then
					Result := has_wrapper_for_type (type_wrapper.type)
				else
					Result := has_wrapper_for_declaration (declaration_wrapper.declaration)
				end
			end
		end

feature {ANY} -- Query existing wrappers

	function_wrapper_from_function_declaration (a_function_declaration: EWG_C_AST_FUNCTION_DECLARATION): EWG_FUNCTION_WRAPPER
			-- Function wrapper for a given function declaration
		require
			has_wrapper_for_declaration (a_function_declaration)
		do
			Result := function_wrapper_table.item (a_function_declaration)
		ensure
			result_not_void: Result /= Void
			function_wrapper_has_function_declaration: Result.function_declaration = a_function_declaration
		end

	wrapper_from_type (a_type: EWG_C_AST_TYPE): EWG_ABSTRACT_WRAPPER
		require
			a_type_not_void: a_type /= Void
			has_wrapper_for_a_type: has_wrapper_for_type (a_type)
		local
			enum_type: EWG_C_AST_ENUM_TYPE
			struct_type: EWG_C_AST_STRUCT_TYPE
			union_type: EWG_C_AST_UNION_TYPE
			pointer_type: EWG_C_AST_POINTER_TYPE
		do
			enum_type ?= a_type
			struct_type ?= a_type
			union_type ?= a_type
			pointer_type ?= a_type

				check
					pointer_type_not_void_implies_is_callback: pointer_type /= Void implies pointer_type.is_callback
				end

			if enum_type /= Void then
				Result := enum_wrapper_table.item (enum_type)
			elseif struct_type /= Void then
				Result := struct_wrapper_table.item (struct_type)
			elseif union_type /= Void then
				Result := union_wrapper_table.item (union_type)
			elseif pointer_type /= Void then
				Result := callback_wrapper_table.item (pointer_type)
			else
					check
						dead_end: False
					end
			end
		ensure
			result_not_void: Result /= Void
		end

	composite_data_wrapper_from_composite_data_type (a_composite_data_type: EWG_C_AST_COMPOSITE_DATA_TYPE): EWG_COMPOSITE_DATA_WRAPPER
		require
			a_composite_data_type_not_void: a_composite_data_type /= Void
			has_wrapper_for_a_composite_type: has_wrapper_for_type (a_composite_data_type)
		local
			enum_type: EWG_C_AST_ENUM_TYPE
			struct_type: EWG_C_AST_STRUCT_TYPE
			union_type: EWG_C_AST_UNION_TYPE
		do
			enum_type ?= a_composite_data_type
			struct_type ?= a_composite_data_type
			union_type ?= a_composite_data_type

			if enum_type /= Void then
				Result := enum_wrapper_table.item (enum_type)
			elseif struct_type /= Void then
				Result := struct_wrapper_table.item (struct_type)
			elseif union_type /= Void then
				Result := union_wrapper_table.item (union_type)
			else
					check
						dead_end: False
					end
			end
		ensure
			result_not_void: Result /= Void
		end

	callback_wrapper_from_callback (a_pointer_type: EWG_C_AST_POINTER_TYPE): EWG_CALLBACK_WRAPPER
		require
			a_pointer_type_not_void: a_pointer_type /= Void
				a_pointer_type_is_callback: a_pointer_type.is_callback
			has_wrapper_for_a_pointer_type: has_wrapper_for_type (a_pointer_type)
		do
			Result := callback_wrapper_table.item (a_pointer_type)
		ensure
			result_not_void: Result /= Void
		end

	struct_wrapper_from_struct_type (a_struct_type: EWG_C_AST_STRUCT_TYPE): EWG_STRUCT_WRAPPER
		require
			a_struct_type_not_void: a_struct_type /= Void
			has_wrapper_for_a_struct_type: has_wrapper_for_type (a_struct_type)
		do
			Result := struct_wrapper_table.item (a_struct_type)
		ensure
			result_not_void: Result /= Void
		end

	union_wrapper_from_union_type (a_union_type: EWG_C_AST_UNION_TYPE): EWG_UNION_WRAPPER
		require
			a_union_type_not_void: a_union_type /= Void
			has_wrapper_for_a_union_type: has_wrapper_for_type (a_union_type)
		do
			Result := union_wrapper_table.item (a_union_type)
		ensure
			result_not_void: Result /= Void
		end

feature {ANY} -- Add new wrappers to set

	add_wrapper (a_wrapper: EWG_ABSTRACT_WRAPPER)
		require
			a_wrapper_not_void: a_wrapper /= Void
			has_a_wrapper: not has_wrapper (a_wrapper)
		local
			enum_wrapper: EWG_ENUM_WRAPPER
			struct_wrapper: EWG_STRUCT_WRAPPER
			union_wrapper: EWG_UNION_WRAPPER
			function_wrapper: EWG_FUNCTION_WRAPPER
			callback_wrapper: EWG_CALLBACK_WRAPPER
			function_wrapper_list: DS_LINKED_LIST [EWG_FUNCTION_WRAPPER]
			callback_wrapper_list: DS_LINKED_LIST [EWG_CALLBACK_WRAPPER]
			macro_wrapper_list: DS_LINKED_LIST [EWG_MACRO_WRAPPER]
			macro_wrapper: EWG_MACRO_WRAPPER
		do
			enum_wrapper ?= a_wrapper
			struct_wrapper ?= a_wrapper
			union_wrapper ?= a_wrapper
			function_wrapper ?= a_wrapper
			callback_wrapper ?= a_wrapper
			macro_wrapper ?= a_wrapper

			if enum_wrapper /= Void then
				enum_wrapper_table.force_new (enum_wrapper, enum_wrapper.c_enum_type)
				last_enum_wrapper := enum_wrapper
			elseif struct_wrapper /= Void then
				struct_wrapper_table.force_new (struct_wrapper, struct_wrapper.c_struct_type)
				last_struct_wrapper := struct_wrapper
			elseif union_wrapper /= Void then
				union_wrapper_table.force_new (union_wrapper, union_wrapper.c_union_type)
				last_union_wrapper := union_wrapper
			elseif function_wrapper /= Void then
				function_wrapper_table.force_new (function_wrapper, function_wrapper.function_declaration)
				last_function_wrapper := function_wrapper

				if function_wrapper_groups.has (function_wrapper.class_name) then
					function_wrapper_list := function_wrapper_groups.item (function_wrapper.class_name)
				else
					create function_wrapper_list.make
					function_wrapper_groups.force (function_wrapper_list, function_wrapper.class_name)
				end
				function_wrapper_list.put_last (function_wrapper)
			elseif callback_wrapper /= Void then
				callback_wrapper_table.force_new (callback_wrapper, callback_wrapper.c_pointer_type)
				last_callback_wrapper := callback_wrapper

				if callback_wrapper_groups.has (callback_wrapper.c_pointer_type.header_file_name) then
					callback_wrapper_list := callback_wrapper_groups.item (callback_wrapper.c_pointer_type.header_file_name)
				else
					create callback_wrapper_list.make
					callback_wrapper_groups.force (callback_wrapper_list, callback_wrapper.c_pointer_type.header_file_name)
				end
				callback_wrapper_list.put_last (callback_wrapper)
			elseif macro_wrapper /= Void then
				macro_wrapper_table.force_new (macro_wrapper, macro_wrapper.constant_name)
				last_macro_wrapper := macro_wrapper

				if macro_wrapper_groups.has (macro_wrapper.class_name) then
					macro_wrapper_list := macro_wrapper_groups.item (macro_wrapper.class_name)
				else
					create macro_wrapper_list.make
					macro_wrapper_groups.force (macro_wrapper_list, macro_wrapper.class_name)
				end
				macro_wrapper_list.put_last (macro_wrapper)
			else
				check
					dead_end: False
				end
			end
		ensure
			has_a_wrapper: has_wrapper (a_wrapper)
		end

feature {ANY} -- Resolve Name clashes

	resolve_function_wrapper_name_clashes
			-- Resolve any function wrapper name clashes.
		do
			rename_wrapper_names_in_group (new_function_wrapper_cursor)
		end

	resolve_callback_wrapper_name_clashes
			-- Resolve any callback wrapper name clashes.
		do
			rename_wrapper_names_in_group (new_callback_wrapper_cursor)
		end

	resolve_macro_wrapper_name_clashes
			-- Resolve any macro wrapper name clashes.
		do
			rename_wrapper_names_in_group (new_macro_wrapper_cursor)
		end

feature {NONE} -- Function declaration name clash resolving implementation
	-- TODO: refactore into separate class

	last_wrapper_clash_table: DS_HASH_TABLE [DS_LINKED_LIST [EWG_ABSTRACT_WRAPPER], STRING]

	build_clash_table_for_wrapper_group (a_cs: DS_LINEAR_CURSOR [EWG_ABSTRACT_WRAPPER])
		require
			a_cs_not_void: a_cs /= Void
		local
			clash_list: DS_LINKED_LIST [EWG_ABSTRACT_WRAPPER]
			ct_cs: DS_HASH_TABLE_CURSOR [DS_LINKED_LIST [EWG_ABSTRACT_WRAPPER], STRING]
		do
			from
				a_cs.start
				create last_wrapper_clash_table.make_map (Initial_wrapper_clash_table_size)
				last_wrapper_clash_table.set_key_equality_tester (string_equality_tester)
			until
				a_cs.off
			loop
				if last_wrapper_clash_table.has (a_cs.item.mapped_eiffel_name) then
					clash_list := last_wrapper_clash_table.item (a_cs.item.mapped_eiffel_name)
				else
					create clash_list.make
					last_wrapper_clash_table.force (clash_list, a_cs.item.mapped_eiffel_name)
				end
				clash_list.put_last (a_cs.item)
				a_cs.forth
			end

			-- Remove all lists which only contain 1 element.
			-- (Only lists with more than one element indicate a clash)

			from
				ct_cs := last_wrapper_clash_table.new_cursor
				ct_cs.start
			until
				ct_cs.off
			loop
				if ct_cs.item.count < 2 then
					last_wrapper_clash_table.remove (ct_cs.key)
					-- moves cursor forth automaticaly
				else
					ct_cs.forth
				end
			end
		ensure
			last_wrapper_clash_table_not_void: last_wrapper_clash_table /= Void
		end

	rename_wrapper_clashes
		require
			last_wrapper_clash_table_not_void: last_wrapper_clash_table /= Void
		local
			ct_cs: DS_HASH_TABLE_CURSOR [DS_LINKED_LIST [EWG_ABSTRACT_WRAPPER], STRING]
		do
			from
				ct_cs := last_wrapper_clash_table.new_cursor
				ct_cs.start
			until
				ct_cs.off
			loop
					check
						clash_means_at_least_two_features: ct_cs.item.count > 1
					end
				ct_cs.item.first.rename_mapped_eiffel_name
				ct_cs.forth
			end
		end

	rename_wrapper_names_in_group (a_cs: DS_LINEAR_CURSOR [EWG_ABSTRACT_WRAPPER])
		require
			a_cs_not_void: a_cs /= Void
		do
			from
				build_clash_table_for_wrapper_group (a_cs)
			until
				last_wrapper_clash_table.count = 0
			loop
				rename_wrapper_clashes
				build_clash_table_for_wrapper_group (a_cs)
			end
		end

feature {NONE} -- Tables that map C AST to wrapper

	enum_wrapper_table: DS_HASH_TABLE [EWG_ENUM_WRAPPER, EWG_C_AST_ENUM_TYPE]
			-- Table containing enum wrappers.
			-- Maps C enums to its wrappers.

	struct_wrapper_table: DS_HASH_TABLE [EWG_STRUCT_WRAPPER, EWG_C_AST_STRUCT_TYPE]
			-- Table containing struct wrappers.
			-- Maps the C struct to its wrapper.

	union_wrapper_table: DS_HASH_TABLE [EWG_UNION_WRAPPER, EWG_C_AST_UNION_TYPE]
			-- Table containing union wrappers.
			-- Maps C unions to its wrappers.

	function_wrapper_table: DS_HASH_TABLE [EWG_FUNCTION_WRAPPER, EWG_C_AST_FUNCTION_DECLARATION]
			-- Table containing function wrappers.
			-- Maps C function declarations to its wrappers.

	macro_wrapper_table: DS_HASH_TABLE [EWG_MACRO_WRAPPER, STRING]
			-- Table containing function wrappers.
			-- Maps C header declarations to its wrappers.		

	callback_wrapper_table: DS_HASH_TABLE [EWG_CALLBACK_WRAPPER, EWG_C_AST_POINTER_TYPE]
			-- Table containing callback wrappers.
			-- Maps C function callbacks to its wrappers.

feature {NONE} -- Grouping of function and callbacks by header file name

	function_wrapper_groups: DS_HASH_TABLE [DS_LINKED_LIST [EWG_FUNCTION_WRAPPER], STRING]
			-- Table that groups function wrappers by the class name they will be part of.

	callback_wrapper_groups: DS_HASH_TABLE [DS_LINKED_LIST [EWG_CALLBACK_WRAPPER], STRING]
			-- Table that groups callback wrappers by the header file name they were declared in.

	macro_wrapper_groups: DS_HASH_TABLE [DS_LINKED_LIST [EWG_MACRO_WRAPPER], STRING]
			-- Table that groups macro wrappers by the class name they will be part of.


feature {NONE} -- Implementation Constants

	Initial_enum_wrapper_table_size: INTEGER = 1000
	Initial_struct_wrapper_table_size: INTEGER = 1000
	Initial_union_wrapper_table_size: INTEGER = 1000
	Initial_function_wrapper_table_size: INTEGER = 1000
	Initial_callback_wrapper_table_size: INTEGER = 1000
	Initial_callback_wrapper_groups_size: INTEGER = 800
	Initial_function_wrapper_groups_size: INTEGER = 800
	Initial_wrapper_clash_table_size: INTEGER = 80
	Initial_array_wrapper_table_size: INTEGER = 1000

	Initial_macro_wrapper_table_size: INTEGER = 1000
	Initial_macro_wrapper_groups_size: INTEGER = 800

invariant

	enum_wrapper_table_not_void: enum_wrapper_table /= Void
	enum_wrapper_table_does_not_contain_void: not enum_wrapper_table.has (Void)
	struct_wrapper_table_not_void: struct_wrapper_table /= Void
	struct_wrapper_table_does_not_contain_void: not struct_wrapper_table.has (Void)
	union_wrapper_table_not_void: union_wrapper_table /= Void
	union_wrapper_table_does_not_contain_void: not union_wrapper_table.has (Void)
	function_wrapper_groups_not_void: function_wrapper_groups /= Void
	callback_wrapper_groups_not_void: callback_wrapper_groups /= Void

	macro_wrapper_groups_not_void: macro_wrapper_groups /= Void


end
