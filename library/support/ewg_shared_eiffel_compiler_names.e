note

	description:

		"Shared access to EWG_EIFFEL_COMPILER_NAMES"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

class EWG_SHARED_EIFFEL_COMPILER_NAMES

feature -- Singleton access

	eiffel_compiler_names: EWG_EIFFEL_COMPILER_NAMES 
		once
			create Result.make
		end

end
