note
	description: "Tests of {WRAPCUI}."
	testing: "type/manual"

class
	WRAPCUI_TEST_SET

inherit
	EQA_TEST_SET
		rename
			assert as assert_old
		end

	EQA_COMMONLY_USED_ASSERTIONS
		undefine
			default_create
		end

	TEST_SET_BRIDGE
		undefine
			default_create
		end

feature -- Test routines

	wrapcui_tests
			-- `wrapcui_tests'
		do
			do_nothing -- yet ...
		end

end
