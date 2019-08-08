note

	description:

		"Example demonstrating the use of callbacks"

	copyright: "Copyright (c) 2003, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

class CALLBACK_HELLO_WORLD

inherit

	CALLBACK_FUNCTIONS_API
		export {NONE} all end


create

	make

feature

	make 
		local
			function_table: FUNCTION_TABLE_STRUCT_API
			i: INTEGER
		do
				-- Create the callback dispatcher and
				-- tell him to dispatch calls to `agent register_callback'
				-- Note that there must be at most one dispatcher object
				-- per callback type in every system.
				-- It is a good idea to make it a singleton.
			 create dispatcher.make (agent on_callback )
			 create anonymous_dispatcher.make (agent sum)

				-- Trigger a callback event without the dispatcher connected
				-- to the c library. You will notice that `on_callback'
				-- will not be called.
			trigger_event (27)

				-- Now lets register the dispatcher with the c library.
			register_callback (dispatcher.c_dispatcher, Default_pointer)
				-- This time the triggering will yield a call to `on_callback'.
			trigger_event (28)

				-- This demonstrates how to call function pointers as members of structs
				-- Get a struct with a function pointer member
			create function_table.make_by_pointer (get_function_table)
				-- Call it using the appropriate caller

				-- Create
			create anonymous_dispatcher.make (agent sum)
			i := anonymous_dispatcher.call_int_int_int_anonymous_callback (function_table.callme, 7, 10)


				-- The c function we called should have added the integers
			print ("result of callme: " + i.out + "%N")

			function_table.set_callme (anonymous_dispatcher.c_dispatcher)
			i := anonymous_dispatcher.call_int_int_int_anonymous_callback (function_table.callme, 5, 5)
				-- The c function we called should have added the integers
			print ("result of callme: " + i.out + "%N")

		end

	dispatcher: SAMPLE_CALLBACK_TYPE_DISPATCHER
			-- The dispatcher is on the one side connected to a C function,
			-- that can be given to the C library as a callback target
			-- and on the other hand to an Eiffel object with a feature
			-- `on_callback'. Whenn its C function gets called, the dispatcher
			-- calls `on_callback' in the connected Eiffel object

	anonymous_dispatcher: INT_INT_INT_ANONYMOUS_CALLBACK_DISPATCHER
			-- function pointers as members of structs	


	on_callback (a_data: POINTER; a_event_type: INTEGER)
			-- Callback target. This feature gets called
			-- anytime somebody calls `trigger_event_external'
		do
			print ("on_callback has been called with: " + a_data.out + ", " + a_event_type.out + "%N")
		end


	sum (a, b: INTEGER): INTEGER
		do
			Result := a + b
		end

end
