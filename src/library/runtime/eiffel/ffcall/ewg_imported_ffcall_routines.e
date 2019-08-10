note

	description:

		"Imported ffcall routines"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

class EWG_IMPORTED_FFCALL_ROUTINES

feature {ANY} -- Access

	FFCALL_: EWG_EXTERNAL_FFCALL_ROUTINES 
			-- FFCALL external routines
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

end
