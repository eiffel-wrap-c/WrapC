note

	description:

		"Deferred common base for classes that wrap functions or callbacks"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

class EWG_CALLABLE_WRAPPER

inherit

	EWG_COMPOSITE_WRAPPER

feature

	return_type: EWG_MEMBER_WRAPPER
			-- Wrapper for return type of callable construct.
			-- If the callable construct to wrap has the "void" return
			-- type, then `return_type' will be `Void'

	has_return_type: BOOLEAN
			-- Does `Current' have a return type?
		do
			Result := return_type /= Void
		ensure
			has_return_type_equals_non_void_return_type: Result = (return_type /= Void)
		end

	set_return_type (a_return_type: EWG_MEMBER_WRAPPER) 
			-- Make `a_return_type' the new `return_type' of `Current'.
		require
			a_return_type_not_void: a_return_type /= Void
		do
			return_type := a_return_type
			return_type.set_composite_wrapper (Current)
		ensure
			return_type_set: return_type = a_return_type
			return_type_has_current_as_composite_wrapper: return_type.composite_wrapper = Current
		end

invariant

	has_return_type_implies_return_type_has_current_as_composite_wrapper: has_return_type implies return_type.composite_wrapper = Current

end
