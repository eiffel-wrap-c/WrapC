note

	description:

		"Base class for C struct array wrappers."

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

deferred class EWG_STRUCT_ARRAY [G -> EWG_STRUCT]

inherit

	EWG_ARRAY

feature {ANY} -- Access

	item (i: INTEGER): G
			-- Address of the `i'-th item
		require
			exists: exists
			valid_index: is_valid_index (i)
		do
			Result := new_shared_struct_wrapper_from_pointer (array_address + (i * item_size))
		ensure
			item_address_not_default_pointer: Result /= Void
		end


feature {NONE} -- Implementation


	new_shared_struct_wrapper_from_pointer (a_pointer: POINTER): G 
			-- Define this routine in your concrete struct array wrapper
			-- Use the `make_shared' create routine to create the struct.
		require
			a_pointer_not_default_pointer: a_pointer /= Default_pointer
		deferred
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
			result_wrapper_a_pointer: Result.item = a_pointer
		end

end
