note

	description:

		"Abstract base for C struct, union and enum types"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

deferred class EWG_C_AST_COMPOSITE_DATA_TYPE

inherit

	EWG_C_AST_COMPOSITE_TYPE
		redefine
			is_composite_data_type
		end

feature

	is_composite_data_type: BOOLEAN 
		do
			Result := True
		end

end
