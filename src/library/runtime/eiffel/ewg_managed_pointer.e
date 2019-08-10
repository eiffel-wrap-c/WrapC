note

	description:

		"Wrapps a C pointer in a safe way"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

class EWG_MANAGED_POINTER

inherit

	MEMORY
		redefine
			dispose
		end

	EWG_IMPORTED_EXTERNAL_ROUTINES
		export {NONE} all	end

	EWG_EXTERNAL_MEMORY_ROUTINES
		export {NONE} all end

create

	make_new_unshared,
	make_new_shared,
	make_new_unshared_uninitialized,
	make_new_shared_uninitialized,
	make_unshared,
	make_shared,
	make_default_pointer

feature {NONE} -- Initialisation

	make_new_unshared (a_capacity: INTEGER)
			-- Create a new pointer wrapper to a new memory area where
			-- all bytes have been reset to zero.
			-- Allocates as `a_capacity' bytes of new memory.
			-- 'unshared' means if the Current object
			-- gets collected by the garbage collector,
			-- the allocated memory  will
			-- be freed as well.
		require
			a_capacity_greater_equal_zero: a_capacity >= 0
		do
			item := external_memory.calloc_external (a_capacity, 1)
			capacity := a_capacity
		ensure
			exists: exists
			is_not_shared: not is_shared
			capacity_set: capacity = a_capacity
			initialized_to_zero:
				read_integer_8 (0) = 0 and then
				read_integer_8 (capacity - 1) = 0
		end

	make_new_shared (a_capacity: INTEGER)
			-- Create a new pointer wrapper to a new memory area where
			-- all bytes have been reset to zero.
			-- Allocates as `a_capacity' bytes of new memory.
			-- 'shared' means if the Current object
			-- gets collected by the garbage collector,
			-- the allocated memory will
			-- not be freed as well.
		require
			a_capacity_greater_equal_zero: a_capacity >= 0
		do
			item := external_memory.calloc_external (a_capacity, 1)
			is_shared := True
			capacity := a_capacity
		ensure
			exists: exists
			is_shared: is_shared
			capacity_set: capacity = a_capacity
			initialized_to_zero:
				read_integer_8 (0) = 0 and then
				read_integer_8 (capacity - 1) = 0
		end

	make_new_unshared_uninitialized (a_capacity: INTEGER)
			-- Create a new pointer wrapper to a new memory area. Bytes
			-- have a random value.
			-- Allocates as `a_capacity' bytes of new memory.
			-- 'unshared' means if the Current object
			-- gets collected by the garbage collector,
			-- the allocated memory  will
			-- be freed as well.
		require
			a_capacity_greater_equal_zero: a_capacity >= 0
		do
			item := external_memory.malloc_external (a_capacity)
			capacity := a_capacity
		ensure
			exists: exists
			is_not_shared: not is_shared
			capacity_set: capacity = a_capacity
		end

	make_new_shared_uninitialized (a_capacity: INTEGER)
			-- Create a new pointer wrapper to a new memory area. Bytes
			-- have a random value.
			-- Allocates as `a_capacity' bytes of new memory.
			-- 'shared' means if the Current object
			-- gets collected by the garbage collector,
			-- the allocated memory will
			-- not be freed as well.
		require
			a_capacity_greater_equal_zero: a_capacity >= 0
		do
			item := external_memory.malloc_external (a_capacity)
			is_shared := True
			capacity := a_capacity
		ensure
			exists: exists
			is_shared: is_shared
			capacity_set: capacity = a_capacity
		end

	make_unshared (a_item: POINTER; a_capacity: INTEGER)
			-- Create a new pointer wrapper to an existing memory area.
			-- `a_item' must be the pointer to the memory area to wrap.
			-- `a_capacity' specifies how big the memory area is that
			-- the pointer points to.
			-- 'unshared' means if the Current object
			-- gets collected by the garbage collector,
			-- the allocated memory will
			-- be freed as well.
		require
			a_capacity_greater_equal_zero: a_capacity >= 0
		do
			item := a_item
			capacity := a_capacity
		ensure
			exists: exists
			item_is_a_item: item = a_item
			is_not_shared: not is_shared
			capacity_set: capacity = a_capacity
		end

	make_shared (a_item: POINTER; a_capacity: INTEGER)
			-- Create a new pointer wrapper to an existing memory area.
			-- `a_item' must be the pointer to the memory area to wrap.
			-- `a_capacity' specifies how big the memory area is that
			-- the pointer points to.
			-- 'shared' means if the Current object
			-- gets collected by the garbage collector,
			-- the memory allocated for the struct will
			-- not be freed as well.
		require
			a_capacity_greater_equal_zero: a_capacity >= 0
		do
			item := a_item
			capacity := a_capacity
			is_shared := True
		ensure
			exists: exists
			item_is_a_item: item = a_item
			is_shared: is_shared
			capacity_set: capacity = a_capacity
		end

	make_default_pointer
			-- Create a pointer wrapper for the default pointer (NULL).
		do
		ensure
			not_exists: not exists
		end

feature {ANY} -- Access

	item: POINTER
			-- Wrapped C pointer

	is_shared: BOOLEAN
			-- Is the contents of `item' referenced by other C or Eiffel code?
			-- If `is_shared' is `True' then when the current object will be
			-- collected by the garbage collector, the wrapped memory area will
			-- also be freed.
			-- This is a good idea, only if you can be sure that when the
			-- Eiffel object gets collected, the C side does not have a reference
			-- to the wrapped memory anymore.

	exists: BOOLEAN
			-- Does `item' point to a valid C memory area ?
		do
			Result := item /= default_pointer
		end

	capacity: INTEGER
			-- Size of the memory area that the wrapped
			-- pointer points to.

	read_integer (a_pos: INTEGER): INTEGER
			-- Get the integer at the `a_pos'-th
			-- byte position of the wrapped memory
			-- area.
			-- Reads `sizeof_int' bytes.
		require
			item_exists: exists
			a_pos_greater_equal_zero: a_pos >= 0
			a_pos_small_enough: a_pos < capacity + 1 - sizeof_int
		do
			Result := external_memory.read_integer_external (item, a_pos)
		end

	read_pointer (a_pos: INTEGER): POINTER
			-- Get the pointer at the `a_pos'-th
			-- byte position of the wrapped memory
			-- area.
			-- Reads `sizeof_pointer' bytes.
		require
			item_exists: exists
			a_pos_greater_equal_zero: a_pos >= 0
			a_pos_small_enough: a_pos < capacity + 1 - sizeof_pointer
		do
			Result := external_memory.read_pointer_external (item, a_pos)
		end

	read_integer_8 (a_pos: INTEGER): INTEGER
			-- Get the byte at the `a_pos'-th
			-- byte position of the wrapped memory
			-- area.
			-- Reads 8 bits.
		require
			item_exists: exists
			a_pos_greater_equal_zero: a_pos >= 0
			a_pos_small_enough: a_pos < capacity
		do
			Result := external_memory.read_integer_8_external (item, a_pos)
		ensure
			result_is_byte: Result >= -128 and Result <= 127
		end

	read_integer_16 (a_pos: INTEGER): INTEGER
			-- Get the integer at the `a_pos'-th
			-- byte position of the wrapped memory
			-- area.
			-- Reads 16 bits.
		require
			item_exists: exists
			a_pos_greater_equal_zero: a_pos >= 0
			a_pos_small_enough: a_pos < capacity - 1
		do
			Result := external_memory.read_integer_16_external (item, a_pos)
		ensure
			result_is_int16: Result >= -32768 and Result <= 32767
		end

	read_integer_32 (a_pos: INTEGER): INTEGER
			-- Get the integer at the `a_pos'-th
			-- byte position of the wrapped memory
			-- area.
			-- Reads 32 bits.
		require
			item_exists: exists
			a_pos_greater_equal_zero: a_pos >= 0
			a_pos_small_enough: a_pos < capacity - 3
		do
			Result := external_memory.read_integer_32_external (item, a_pos)
		end

	read_real (a_pos: INTEGER): REAL
			-- Get the real at the `a_pos'-th
			-- byte position of the wrapped memory
			-- area.
			-- Reads `sizeof_real' bytes.
		require
			item_exists: exists
			a_pos_greater_equal_zero: a_pos >= 0
			a_pos_small_enough: a_pos < capacity + 1 - sizeof_real
		do
			Result := external_memory.read_real_external (item, a_pos)
		end

	read_double (a_pos: INTEGER): DOUBLE
			-- Get the double at the `a_pos'-th
			-- byte position of the wrapped memory
			-- area.
			-- Reads `sizeof_double' bytes.
		require
			item_exists: exists
			a_pos_greater_equal_zero: a_pos >= 0
			a_pos_small_enough: a_pos < capacity + 1 - sizeof_double
		do
			Result := external_memory.read_double_external (item, a_pos)
		end

feature {ANY} -- Basic Operations

	put_integer (a_int: INTEGER; a_pos: INTEGER)
			-- Put `a_int' at the `a_pos'-th byte position
			-- of the wrapped memory area.
			-- Writes `sizeof_int' bytes.
		require
			item_exists: exists
			a_pos_greater_equal_zero: a_pos >= 0
			a_pos_small_enough: a_pos < capacity + 1 - sizeof_int
		do
			external_memory.put_integer_external (item, a_int, a_pos)
		ensure
			integer_set: read_integer (a_pos) = a_int
		end

	put_pointer (a_pointer: POINTER; a_pos: INTEGER)
			-- Put `a_pointer' at the `a_pos'-th byte position
			-- of the wrapped memory area.
			-- Writes `sizeof_pointer' bytes.
		require
			item_exists: exists
			a_pos_greater_equal_zero: a_pos >= 0
			a_pos_small_enough: a_pos < capacity + 1 - sizeof_pointer
		do
			external_memory.put_pointer_external (item, a_pointer, a_pos)
		ensure
			pointer_set: read_pointer (a_pos) = a_pointer
		end

	put_integer_8 (a_int: INTEGER; a_pos: INTEGER)
			-- Put `a_int' at the `a_pos'-th byte position
			-- of the wrapped memory area.
			-- Writes 8 bits.
		require
			item_exists: exists
			a_pos_greater_equal_zero: a_pos >= 0
			a_pos_small_enough: a_pos < capacity
			a_int_is_byte: a_int >= -128 and a_int <= 127
		do
			external_memory.put_integer_8_external (item, a_int, a_pos)
		ensure
			integer_8_set: read_integer_8 (a_pos) = a_int
		end

	put_integer_16 (a_int: INTEGER; a_pos: INTEGER)
			-- Put `a_int' at the `a_pos'-th byte position
			-- of the wrapped memory area.
			-- Writes 16 bits.
		require
			item_exists: exists
			a_pos_greater_equal_zero: a_pos >= 0
			a_pos_small_enough: a_pos < capacity - 1
			a_int_is_int16: a_int >= -32768 and a_int <= 32767
		do
			external_memory.put_integer_16_external (item, a_int, a_pos)
		ensure
			integer_16_set: read_integer_16 (a_pos) = a_int
		end

	put_integer_32 (a_int: INTEGER; a_pos: INTEGER)
			-- Put `a_int' at the `a_pos'-th byte position
			-- of the wrapped memory area.
			-- Writes 32 bits.
		require
			item_exists: exists
			a_pos_greater_equal_zero: a_pos >= 0
			a_pos_small_enough: a_pos < capacity - 3
		do
			external_memory.put_integer_32_external (item, a_int, a_pos)
		ensure
			integer_32_set: read_integer_32 (a_pos) = a_int
		end

	put_real (a_real: REAL; a_pos: INTEGER)
			-- Put `a_real' at the `a_pos'-th byte position
			-- of the wrapped memory area.
			-- Writes `sizeof_real' bytes.
		require
			item_exists: exists
			a_pos_greater_equal_zero: a_pos >= 0
			a_pos_small_enough: a_pos < capacity + 1 - sizeof_real
		do
			external_memory.put_real_external (item, a_real, a_pos)
		ensure
			real_set: read_real (a_pos) = a_real
		end

	put_double (a_double: DOUBLE; a_pos: INTEGER)
			-- Put `a_double' at the `a_pos'-th byte position
			-- of the wrapped memory area.
			-- Writes `sizeof_double' bytes.
		require
			item_exists: exists
			a_pos_greater_equal_zero: a_pos >= 0
			a_pos_small_enough: a_pos < capacity + 1 - sizeof_double
		do
			external_memory.put_double_external (item, a_double, a_pos)
		ensure
			double_set: read_double (a_pos) = a_double
		end

feature

	sizeof_pointer: INTEGER
			-- Returns the number of bytes a C pointer is broad
		do
			Result := external_memory.sizeof_pointer_external
		end

	sizeof_int: INTEGER
			-- Returns the number of bytes a C int is broad
		do
			Result := external_memory.sizeof_int_external
		end

	sizeof_real: INTEGER
			-- Returns the number of bytes a C float is broad
		do
			Result := external_memory.sizeof_real_external
		end

	sizeof_double: INTEGER
			-- Returns the number of bytes a C double is broad
		do
			Result := external_memory.sizeof_double_external
		end

feature {NONE} -- Removal

	dispose
			-- If `is_shared' is `False' and the wrapped memory exists
			-- (is not NULL) then free the wrapped memory
		do
			Precursor
			if not is_shared and exists then
				destroy_object
			end
		end

	destroy_object
			-- Free the allocated memory.  This routine may be called
			-- from within `dispose'.  Due to this, we have to use
			-- `free_external' and cannot rely on
			-- `external_memory.free_external'.
		require
			item_is_not_shared: not is_shared
			item_exists: exists
		do
			free_external (item)
			item := default_pointer
		ensure
			item_equals_default_pointer: item = default_pointer
		end

end
