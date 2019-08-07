note

	description:

		"Abstract base class for function and composite data types"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

deferred class EWG_C_AST_COMPOSITE_TYPE

inherit

	EWG_C_AST_TYPE
		rename
			make as make_type
		redefine
			is_composite_type
		end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

feature

	make (a_name: STRING; a_header_file_name: STRING; a_members: like members)
		do
			make_type (a_name, a_header_file_name)
			members := a_members
		ensure
			name_set: name = a_name
			header_file_name_set: header_file_name = a_header_file_name
			members_set: members = a_members
		end

feature

	set_members (a_members: like members)
		do
			members := a_members
		ensure
			members_set: members = a_members
		end

feature

	members: DS_ARRAYED_LIST [EWG_C_AST_DECLARATION]

	append_members_hash_code_to_string (a_string: STRING)
		require
			members_not_void: members /= Void
			a_string_not_void: a_string /= Void
		local
			cs: DS_BILINEAR_CURSOR [EWG_C_AST_DECLARATION]
		do
			a_string.append_string ("?members?")
			from
				cs := members.new_cursor
			until
				cs.off
			loop
				cs.item.type.append_hash_string_to_string (a_string)
				if not cs.item.is_anonymous then
					a_string.append_character ('?')
					a_string.append_string (cs.item.declarator)
				end
				a_string.append_character ('?')
				cs.forth
			end
		end

	append_anonymous_hash_string_to_string (a_string: STRING)
		do
			append_members_hash_code_to_string (a_string)
		end


feature

	is_complete: BOOLEAN
			-- Has the type been defined with a body?
			-- An incomplete type looks like this:
			-- struct foo;
		do
			Result := members /= Void and then members.count > 0
		end

	is_same_composite_type (other: EWG_C_AST_COMPOSITE_TYPE): BOOLEAN
		require
			other_not_void: other /= Void
		do
			if is_anonymous then
				Result := other.is_anonymous and is_members_equal (other)
			else
				Result := string_equality_tester.test (name, other.name)
			end
		end

	is_members_equal (other: EWG_C_AST_COMPOSITE_TYPE): BOOLEAN
		require
			other_not_void: other /= Void
			other_not_current: other /= Current
			other_members_not_members: other.members /= members
		local
			i: INTEGER
		do
			if members = Void then
				Result := other.members = Void
			elseif other.members = Void then
				Result := False
			elseif members.count = other.members.count then
				Result := True
				from
					i := 1
				until
					i > members.count or Result = False
				loop
					if not members.item (i).is_same_declaration (other.members.item (i)) then
						Result := False
					else
						i := i + 1
					end
				end
			end
		end

	directly_nested_types: DS_LINKED_LIST [EWG_C_AST_TYPE]
		local
			a_cs: DS_BILINEAR_CURSOR [EWG_C_AST_DECLARATION]
		do
			create Result.make
			if members /= Void then
				from
					a_cs := members.new_cursor
					a_cs.start
				until
					a_cs.off
				loop
					Result.put_last (a_cs.item.type)
					a_cs.forth
				end
			end
		end

	is_composite_type: BOOLEAN 
		do
			Result := True
		end

invariant

	members_has_no_void: members /= Void implies not members.has (Void)

end
