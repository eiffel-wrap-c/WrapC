note

	description:

		"Provides global access to a EWG_TEMPLATE_EXPANDER"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2001, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

class EWG_SHARED_TEMPLATE_EXPANDER

feature -- Access

	template_expander: EWG_TEMPLATE_EXPANDER 
			-- Shared template expander
		once
			create Result.make
		ensure
			template_expander_not_void: Result /= Void
		end

end
