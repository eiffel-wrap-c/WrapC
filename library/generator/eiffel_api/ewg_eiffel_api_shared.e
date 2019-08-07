note
	description: "Summary description for {EWG_EIFFEL_API_SHARED}."
	date: "$Date$"
	revision: "$Revision$"

class
	EWG_EIFFEL_API_SHARED


feature -- Status Report.

	is_char_pointer_type (a_declarator: EWG_C_AST_DECLARATION): BOOLEAN
		do
			if a_declarator.type.is_char_pointer_type then
				Result := True
			elseif attached {EWG_C_AST_ALIAS_TYPE} a_declarator.type as l_type then
				if attached {EWG_C_AST_POINTER_TYPE} l_type.base as l_pointer_type then
					if attached {EWG_C_AST_PRIMITIVE_TYPE} l_pointer_type.skip_wrapper_irrelevant_types as l_primitive_type then
						Result := l_primitive_type.is_char_type
					end
				end
			end
		end

	is_unicode_char_pointer_type (a_declarator: EWG_C_AST_DECLARATION): BOOLEAN
		do
			if a_declarator.type.is_unicode_char_pointer_type then
				Result := True
			elseif attached {EWG_C_AST_ALIAS_TYPE} a_declarator.type as l_type then
				if attached {EWG_C_AST_POINTER_TYPE} l_type.base as l_pointer_type then
					-- To be checked.
				end
			end
		end

end
