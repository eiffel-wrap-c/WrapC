note

	description:

		"Simple example using EWG wrappers"

	copyright: "Copyright (c) 2003, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

class SIMPLE_HELLO_WORLD

inherit

	SIMPLE_HEADER_FUNCTIONS_API

	COLORS_ENUM_API

create

	make

feature

	make
		do
				-- Create a new struct of type 'struct foo'
				-- `unshared' means that when `foo' will get
				-- collected, the struct it wrapps will be
				-- freed.
			create foo.make

				-- Set members `a' and `b'.
				-- Note that `a' and `b' are real
				-- members of struct foo.
			foo.set_a (33)
			foo.set_b (75)

				-- Output the members
			print ("foo.a (33): " + foo.a.out + "%N")
			print ("foo.b (75): " + foo.b.out + "%N")

				-- Create a union of type 'foo1'
			create foo1.make

				-- Set member
			foo1.set_a (42)

				-- Output member
			print ("foo1.a (42): " + foo1.a.out + "%N")

				-- Call external function
			func1 (24, 53)

				-- Call external function with non 'void' return type
			print ("func2 (7): " + func2 (3, 4).out + "%N")

			-- Output enum values
			print ("red: " + red.out + "%N")

			create preferences.make
			preferences.set_a (8)
			preferences.set_food ("Pasta")

			create person.make
			person.set_age (30)
			person.set_name ("Joe")
			person.set_pref (preferences)

			print ("%NPerson Name:" + person.name)
			print ("%NPerson Age:"  + person.age.out)
			print ("%NPerson food preference: " + person.pref.food)
			print ("%NPerson value preference: " + person.pref.a.out)

		end

	foo: FOO_STRUCT_API
			-- Wrapper object for `struct foo'

	foo1: FOO1_UNION_API
			-- Wrapper object for `foo1' (a typedef'd union)


	person: PERSON_STRUCT_API
			-- Wrapper object for person struct

	preferences: PREFERENCES_STRUCT_API
			-- Wrapper object for preference struct		

end
