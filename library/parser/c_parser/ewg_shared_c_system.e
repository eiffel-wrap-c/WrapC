note

	description:

		"Singleton access for EWG_C_SYSTEM"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

class EWG_SHARED_C_SYSTEM
feature

	c_system: EWG_C_SYSTEM 
		once
			create Result.make
		end

end
