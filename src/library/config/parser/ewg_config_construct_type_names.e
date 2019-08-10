note

	description:

		"EWG config construct type names"

	copyright: "Copyright (c) 2004, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"


class EWG_CONFIG_CONSTRUCT_TYPE_NAMES

inherit

	ANY

	EWG_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

feature -- Names

	any_name: STRING = "any"
	none_name: STRING = "none"
	struct_name: STRING = "struct"
	union_name: STRING = "union"
	enum_name: STRING = "enum"
	function_name: STRING = "function"
	callback_name: STRING = "callback"


feature -- Codes

	any_code: INTEGER = unique
	none_code: INTEGER = unique
	struct_code: INTEGER = unique
	union_code: INTEGER = unique
	enum_code: INTEGER = unique
	function_code: INTEGER = unique
	callback_code: INTEGER = unique

feature -- Status

	is_valid_construct_type_name (a_name: STRING): BOOLEAN
			-- Is `a_name' a valid construct type name ?
		require
			a_name_not_void: a_name /= Void
		do
			Result := construct_type_name_table.has (a_name)
		end

	is_valid_construct_type_code (a_code: INTEGER): BOOLEAN
			-- Is `a_code' a valid format code ?
		do
			Result := construct_type_name_table.has_item (a_code)
		end

	construct_type_code_from_name (a_name: STRING): INTEGER
			-- Construct type code from construct type name
		require
			a_name_not_void: a_name /= Void
			a_name_valid_construct_type_name: is_valid_construct_type_name (a_name)
		do
			Result := construct_type_name_table.item (a_name)
		ensure
			valid_construct_type_code: is_valid_construct_type_code (Result)
		end

	construct_type_name_from_code (a_code: INTEGER): STRING
			-- Construct type name from construct type code
		require
			a_code_valid_construct_type_code: is_valid_construct_type_code (a_code)
		local
			cs: DS_HASH_TABLE_CURSOR [INTEGER, STRING]
		do
			from
				cs := construct_type_name_table.new_cursor
				cs.start
			until
				cs.off or Result /= Void
			loop
				if cs.item = a_code then
					Result := cs.key
					cs.go_after
				else
					cs.forth
				end
			end
		ensure
			construct_type_name_not_void: Result /= Void
			construct_type_name_valid: is_valid_construct_type_name (Result)
		end

feature {NONE} -- Implementation

	construct_type_name_table: DS_HASH_TABLE [INTEGER, STRING]
		once
			create Result.make_map (7)
			Result.set_key_equality_tester (string_equality_tester)
			Result.put_new (any_code, any_name)
			Result.put_new (none_code, none_name)
			Result.put_new (struct_code, struct_name)
			Result.put_new (union_code, union_name)
			Result.put_new (enum_code, enum_name)
			Result.put_new (function_code, function_name)
			Result.put_new (callback_code, callback_name)
		ensure
			construct_type_name_table_not_void: Result /= Void
			construct_type_name_table_doesnt_have_void_name: not Result.has (Void)
		end


end
