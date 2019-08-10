note

	description:

		"Shared access to EWG_STRUCT_FEATURE_NAMES"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

class EWG_SHARED_STRUCT_FEATURE_NAMES

feature -- Singleton access

	struct_feature_names: EWG_STRUCT_FEATURE_NAMES 
			-- Singleton access to EWG_STRUCT_FEATURE_NAMES
		once
			create Result.make
		ensure
			names_not_void: Result /= Void
		end

end
