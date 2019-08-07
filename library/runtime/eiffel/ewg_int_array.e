note

	description:

		"Class for wrapping C int arrays"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-06-09 23:08:09 +0900 (Mon, 09 Jun 2008) $"
	revision: "$Revision: 5 $"

class EWG_INT_ARRAY

inherit

	EWG_ARRAY

create

	make_new_unshared,
	make_new_shared,
	make_unshared,
	make_shared

feature {ANY} -- Access

	item alias "[]" (i: INTEGER): INTEGER assign put
			-- Return the address of the `i'-th item
		require
			exists: exists
			valid_index: is_valid_index (i)
		do
			Result := managed_data.read_integer (i * item_size)
		end

	put (v: INTEGER; i: INTEGER)
			-- Replace `i'-th entry by `v'
		require
			exists: exists
			valid_index: is_valid_index (i)
		do
			managed_data.put_integer (v, i * item_size)
		ensure
			integer_set: item (i) = v
		end

feature {NONE} -- Implementation

	item_size: INTEGER
		once
			Result := external_memory.sizeof_int_external
		end
end
