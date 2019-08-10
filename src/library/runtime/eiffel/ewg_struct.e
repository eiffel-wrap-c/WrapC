note

	description:

		"Abstract ancestor of all struct wrappers"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

deferred class EWG_STRUCT

feature {NONE} -- Initialisation

	make_new_unshared
			-- Create a new pointer wrapper to a new struct.
			-- Allocates as much new memory as the struct needs.
			-- 'unshared' means if the Current object
			-- gets collected by the garbage collector,
			-- the memory allocated for the struct will
			-- be freed as well.
		do
			create managed_data.make_new_unshared (sizeof)
		ensure
			exists: exists
			is_not_shared: not is_shared
		end

	make_new_shared
			-- Create a new pointer wrapper to a new struct.
			-- Allocates as much new memory as the struct needs.
			-- 'shared' means if the Current object
			-- gets collected by the garbage collector,
			-- the memory allocated for the struct will
			-- not be freed as well.
		do
			create managed_data.make_new_shared (sizeof)
		ensure
			exists: exists
			is_shared: is_shared
		end

	make_unshared (a_item: POINTER)
			-- Create a new pointer wrapper to a given struct.
			-- 'unshared' means if the Current object
			-- gets collected by the garbage collector,
			-- the memory allocated for the struct will
			-- be freed as well.
		require
			a_item_not_default_pointer: a_item /= Default_pointer
		do
			create managed_data.make_unshared (a_item, sizeof)
		ensure
			exists: exists
			item_set: item = a_item
			is_not_shared: not is_shared
		end

	make_shared (a_item: POINTER)
			-- Create a new pointer wrapper to a given struct.
			-- 'shared' means if the Current object
			-- gets collected by the garbage collector,
			-- the memory allocated for the struct will
			-- not be freed as well.
		require
			a_item_not_default_pointer: a_item /= Default_pointer
		do
			create managed_data.make_shared (a_item, sizeof)
		ensure
			exists: exists
			item_set: item = a_item
			is_shared: is_shared
		end

feature {ANY} -- Access

	item: POINTER
			-- Pointer to the wrapped struct
		require
			exists: exists
		do
			Result := managed_data.item
		ensure
			item_not_default_pointer: Result /= Default_pointer
		end

	sizeof: INTEGER
			-- Size of the struct in bytes
			-- This needs to be redefined by the
			-- decendant.
		deferred
		ensure
			sizeof_positive: Result > 0
		end

	is_shared: BOOLEAN
			-- Is the contents of `item' referenced by other C or Eiffel code?
			-- If `is_shared' is `True' then when the current object will be
			-- collected by the garbage collector, the wrapped struct will
			-- also be freed.
			-- This is a good idea, only if you can be sure that when the
			-- Eiffel object gets collected, the C side does not have a reference
			-- to the wrapped struct anymore.
		require
			exists: exists
		do
			Result := managed_data.is_shared
		end

	exists: BOOLEAN 
			-- Does `item' point to a valid C struct ?
		do
			Result := managed_data.item /= Default_pointer
		end

feature {NONE}

	managed_data: EWG_MANAGED_POINTER

invariant

	managed_data_not_void: managed_data /= Void
	managed_capacity_equals_sizeof: exists implies managed_data.capacity = sizeof

end
