note
	description: "Escript command interface."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ESC_COMMAND

feature -- Command pattern

	execute (args: TUPLE)
			-- Execute command with `args'.
		deferred
		end


end
