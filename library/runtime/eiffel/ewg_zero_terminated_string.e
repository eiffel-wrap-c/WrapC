note

	description:

		"Objects that contain C zero terminated strings"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

class EWG_ZERO_TERMINATED_STRING

inherit

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

	EWG_IMPORTED_EXTERNAL_ROUTINES
		export {NONE} all end

create

	make_new_unshared,
	make_new_shared,
	make_unshared,
	make_shared,
	make_unshared_with_capacity,
	make_shared_with_capacity,
	make_unshared_from_string,
	make_shared_from_string

feature {NONE} -- Initialisation

	make_new_unshared (a_capacity: INTEGER)
			-- Create a new c string wrapper to a new memory area.
			-- Allocates as `a_capacity' bytes of new memory.
			-- 'unshared' means if the Current object
			-- gets collected by the garbage collector,
			-- the memory allocated for the string will
			-- be freed as well.
		require
			a_capacity_greater_equal_zero: a_capacity >= 0
		do
			create managed_data.make_new_unshared (a_capacity)
		ensure
			capacity_set: capacity = a_capacity
			item_not_default_pointer: item /= default_pointer
			is_not_shared: not is_shared
		end

	make_new_shared (a_capacity: INTEGER)
			-- Create a new c string wrapper to a new memory area.
			-- Allocates as `a_capacity' bytes of new memory.
			-- 'shared' means if the Current object
			-- gets collected by the garbage collector,
			-- the memory allocated for the string will
			-- not be freed as well.
		require
			a_capacity_greater_equal_zero: a_capacity >= 0
		do
			create managed_data.make_new_shared (a_capacity)
		ensure
			capacity_set: capacity = a_capacity
			item_not_default_pointer: item /= default_pointer
			is_shared: is_shared
		end

	make_unshared (a_item: POINTER)
			-- Create a new c string wrapper to an existing memory area.
			-- `a_item' must be the pointer to the C string to wrap.
			-- The `capacity' is derived from the string length.
			-- 'unshared' means if the Current object
			-- gets collected by the garbage collector,
			-- the memory allocated for the string will
			-- be freed as well.
		require
			a_item_not_default_pointer: a_item /= Default_pointer
		do
			create managed_data.make_unshared (a_item, external_string.strlen_external (a_item))
		ensure
			item_not_default_pointer: item /= Default_pointer
			item_set: item = a_item
			is_not_shared: not is_shared
		end

	make_shared (a_item: POINTER)
			-- Create a new pointer wrapper to an existing memory area.
			-- `a_item' must be the pointer to the C string to wrap.
			-- The `capacity' is derived from the string length.
			-- 'shared' means if the Current object
			-- gets collected by the garbage collector,
			-- the memory allocated for the string will
			-- not be freed as well.
		do
			create managed_data.make_shared (a_item, external_string.strlen_external (a_item))
		ensure
			item_not_default_pointer: item /= Default_pointer
			item_set: item = a_item
			is_shared: is_shared
		end

	make_unshared_with_capacity (a_item: POINTER; a_capacity: INTEGER)
			-- Create a new c string wrapper to an existing memory area.
			-- `a_item' must be the pointer to the memory area to wrap.
			-- `a_capacity' states how much space has been allocated for the
			-- C string.
			-- 'unshared' means if the Current object
			-- gets collected by the garbage collector,
			-- the memory allocated for the string will
			-- be freed as well.
		require
			a_item_not_default_pointer: a_item /= Default_pointer
			a_capacity_greater_equal_zero: a_capacity >= 0
		do
			create managed_data.make_unshared (a_item, a_capacity)
		ensure
			capacity_set: capacity = a_capacity
			item_not_default_pointer: item /= Default_pointer
			item_set: item = a_item
			is_not_shared: not is_shared
		end

	make_shared_with_capacity (a_item: POINTER; a_capacity: INTEGER)
			-- Create a new pointer wrapper to an existing memory area.
			-- `a_item' must be the pointer to the memory area to wrap.
			-- `a_capacity' states how much space has been allocated for the
			-- C string.
			-- 'shared' means if the Current object
			-- gets collected by the garbage collector,
			-- the memory allocated for the string will
			-- not be freed as well.
		require
			a_capacity_greater_equal_zero: a_capacity >= 0
		do
			create managed_data.make_shared (a_item, a_capacity)
		ensure
			capacity_set: capacity = a_capacity
			item_not_default_pointer: item /= Default_pointer
			item_set: item = a_item
			is_shared: is_shared
		end

	make_unshared_from_string (a_string: STRING)
			-- Create a new c string wrapper from existing Eiffel string.
			-- Allocates a new c string and copies the contents of
			-- `a_string' into it.
			-- 'unshared' means if the Current object
			-- gets collected by the garbage collector,
			-- the memory allocated for the string will
			-- be freed as well.
		require
			a_string_not_void: a_string /= Void
		do
			create managed_data.make_new_unshared (a_string.count + 1)
			set_string (a_string)
		ensure
			item_not_default_pointer: item /= default_pointer
			is_not_shared: not is_shared
		end

	make_shared_from_string (a_string: STRING)
			-- Create a new c string wrapper from existing Eiffel string.
			-- Allocates a new c string and copies the contents of
			-- `a_string' into it.
			-- 'shared' means if the Current object
			-- gets collected by the garbage collector,
			-- the memory allocated for the string will
			-- not be freed as well.
		require
			a_string_not_void: a_string /= Void
		do
			create managed_data.make_new_shared (a_string.count + 1)
			set_string (a_string)
		ensure
			item_not_default_pointer: item /= default_pointer
			is_shared: is_shared
		end

feature {ANY} -- Access

	item: POINTER
			-- Pointer to zero terminated string
		do
			Result := managed_data.item
		end

	capacity: INTEGER
			-- Number of characters the wrapped c string has place for
		do
			Result := managed_data.capacity
		end

	count: INTEGER
			-- Number of characters the wrapped c string contains.
			-- Does not include the terminating NULL character.
		do
			Result := external_string.strlen_external (item)
		end

	is_shared: BOOLEAN
			-- Is the contents of `item' referenced by other C or Eiffel code?
			-- If `is_shared' is `True' then when the current object will be
			-- collected by the garbage collector, the wrapped memory area will
			-- also be freed.
			-- This is a good idea, only if you can be sure that when the
			-- Eiffel object gets collected, the C side does not have a reference
			-- to the wrapped memory anymore.
		do
			Result := managed_data.is_shared
		end

	string: STRING
			-- Create a new Eiffel string object and copy the
			-- contents of the wrapped c string into it
		do
			Result := external_string.make_copy_from_c_zero_terminated_string (item)
		end

	substring (a_start_pos, a_end_pos: INTEGER): STRING
			-- Create a new Eiffel string object and copy the
			-- contents of the wrapped c string from including
			-- `a_start_pos' to including `a_end_pos' into it
		do
				check
					TODO: False
				end
		end

feature {ANY} -- Basic Operations

	set_string (a_string: STRING)
			-- Copy content from `a_string' into
			-- wrapped c string.
		require
			a_string_not_void: a_string /= Void
			capacity_big_enough: capacity > a_string.count
		local
			source: POINTER
		do
			source := external_string.string_to_pointer (a_string)
			source := external_memory.memcpy_external (item, source, a_string.count)
			managed_data.put_integer_8 (0, capacity - 1)
		ensure
			string_copied: STRING_.same_string (string, a_string)
		end

feature {NONE} -- Implementation

	managed_data: EWG_MANAGED_POINTER

invariant

	managed_data_not_void: managed_data /= Void
	item_not_null: item /= Default_pointer
	capacity_is_managed_data_capacity: capacity = managed_data.capacity

end
