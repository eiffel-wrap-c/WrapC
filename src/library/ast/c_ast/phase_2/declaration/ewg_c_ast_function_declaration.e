note

	description:

		"Phase 2 AST element, which represents a function declaration"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

class EWG_C_AST_FUNCTION_DECLARATION

inherit

	EWG_C_AST_DECLARATION
		rename
			make as make_declaration
		redefine
			is_same_declaration,
			is_function_declaration
		end

create

	make

feature {NONE} -- Initialisation

	make (a_declarator: STRING; a_function_type: EWG_C_AST_FUNCTION_TYPE; a_header_file_name: STRING)
			-- Create a new function declaration with the
			-- declarator `a_declarator' and the type resp. signature
			-- `a_type'
		require
			a_declarator_not_void: a_declarator /= Void
			a_declarator_not_empty: not a_declarator.is_empty
			a_header_file_name_not_void: a_header_file_name /= Void
			a_header_file_name_not_empty: a_header_file_name.count > 0
		do
			make_declaration (a_declarator, a_function_type, a_header_file_name)
			internal_type := a_function_type
		ensure
			a_declarator_set: declarator = a_declarator
			a_function_type_set: function_type = a_function_type
			header_file_name_set: header_file_name = a_header_file_name
		end

feature {ANY} -- Basic Access

	function_type: EWG_C_AST_FUNCTION_TYPE
			-- function type
		do
			Result := internal_type
		ensure
			function_type_not_void: Result /= Void
			function_type_is_type: function_type = internal_type
		end

feature  {NONE}-- Access

		internal_type: EWG_C_AST_FUNCTION_TYPE
				-- Workaround
				-- using anchoring type cause a Cat-Call.
feature {ANY}

	is_function_declaration: BOOLEAN
		do
			Result := True
		end

feature {ANY} -- Comparsion

	is_same_declaration  (other: EWG_C_AST_DECLARATION): BOOLEAN
			-- Two function declarations are considered equal if their name is
			-- equal. This simplification can be made, because there is no
			-- function overloading in C.
		do
			if attached {EWG_C_AST_FUNCTION_DECLARATION} other as other_function_declaration then
				Result := string_equality_tester.test (declarator, other_function_declaration.declarator)
			end
		end

invariant

	declarator_not_void: not is_anonymous
			-- Function declarations are always named

end
