note

	description:

		"Generates Eiffel dispatcher class for C callbacks"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-14 22:48:16 +0900 (Wed, 14 May 2008) $"
	revision: "$Revision: 3 $"

class EWG_EIFFEL_ABSTRACTION_ANSI_C_CALLBACK_DISPATCHER_GENERATOR

inherit

	EWG_ABSTRACT_GENERATOR

	EWG_EIFFEL_ABSTRACTION_ANSI_C_CALLBACK_SIGNATURE_GENERATOR
		export {NONE} all end

	EWG_SHARED_TEMPLATE_EXPANDER
		export {NONE} all end

	EWG_RENAMER
		export {NONE} all end

create

	make

feature -- Generation

	generate (a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
		local
			cs: DS_BILINEAR_CURSOR [EWG_CALLBACK_WRAPPER]
			file_name: STRING
			file: KL_TEXT_OUTPUT_FILE
		do
			from
				cs := a_eiffel_wrapper_set.new_callback_wrapper_cursor
				cs.start
			until
				cs.off
			loop
				if cs.item /= Void then

					file_name := file_system.pathname (directory_structure.eiffel_directory_name, (eiffel_class_name_from_c_callback_name (cs.item.mapped_eiffel_name) + "_DISPATCHER").as_lower + ".e")

					create file.make (file_name)
					file.recursive_open_write

					if not file.is_open_write then
						error_handler.report_cannot_write_error (file_name)
					else
						file.put_line (Generated_file_warning_eiffel_comment)
						file.put_new_line
						output_stream := file
						generate_callback_wrapper (cs.item)
						file.close
					end
				end
				cs.forth
				error_handler.tick
			end
		end

feature {NONE} -- Implementation

	generate_callback_wrapper (a_callback_wrapper: EWG_CALLBACK_WRAPPER)
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		local
			class_name: STRING
			upper_name: STRING
			ext_class_name: STRING
		do
			class_name := eiffel_class_name_from_c_callback_name (a_callback_wrapper.mapped_eiffel_name) + "_DISPATCHER"
			upper_name := eiffel_class_name_from_c_callback_name (a_callback_wrapper.mapped_eiffel_name)

			ext_class_name := c_header_file_name_to_eiffel_class_name (directory_structure.relative_callback_c_glue_header_file_name)
			ext_class_name.append_string ("_FUNCTIONS_API")

			if attached a_callback_wrapper.set_entry_struct as l_set_entry_struct and then
				attached a_callback_wrapper.get_stub as l_get_stub
			then
				template_expander.expand_into_stream_from_array (output_stream,
																	dispatcher_class_template,
																			<<upper_name,
																				l_set_entry_struct.mapped_eiffel_name,
																				l_get_stub.mapped_eiffel_name,
																				ext_class_name,
																				on_callback_agent (a_callback_wrapper),
																				on_callback_signature (a_callback_wrapper, "on_callback"),
																				routine_call (a_callback_wrapper)>>
																					)
			end
		end



	routine_call (a_callback_wrapper: EWG_CALLBACK_WRAPPER): STRING
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		local
			cs: DS_BILINEAR_CURSOR [EWG_MEMBER_WRAPPER]
		do
			create Result.make (50)
			if a_callback_wrapper.return_type /= Void then
				Result.append("Result := ")
			end
			Result.append ("routine (")
			if a_callback_wrapper.members.count > 0 then
				from
					cs := a_callback_wrapper.members.new_cursor
					cs.start
				until
					cs.off
				loop
					if attached {EWG_NATIVE_MEMBER_WRAPPER} cs.item as native_member_wrapper then
						Result.append_string ("a_")
						Result.append_string(native_member_wrapper.mapped_eiffel_name)

						if not cs.is_last then
							Result.append_string (", ")
						end
					end
					cs.forth
				end
			else
			  Result.append ("[]")
			end
			Result.append (")")

		end

feature {NONE} -- Templates

	dispatcher_class_template: STRING
			-- $1 ... callback name in upper case
			-- $2 ... "set_entry_*_struct" function name
			-- $3 ... "get_*_stub" function name
			-- $4 ... class name of external function wrapper for callback glue
			-- $5 ... routine definition PROCEDURE | FUNCTION
			-- $6 ... on_callback signature
			-- $7 ... agent call
		once
			Result := "class $1_DISPATCHER%N" +
				"%N"+
				"inherit%N" +
				"%N"+
				"%T$4%N" +
				"%T%Texport {NONE} all end"+
				"%N" +
				"create" +
				"%N" +
				"%Tmake" +
				"%N" +
				"%N" +
				"feature -- Initialization%N" +
				"%N" +
				"%Tmake (a_routine: like routine) %N" +
				"%T%T%T%T-- Dispatcher initialization%N" +
				"%T%Tdo%N" +
				"%T%T%Troutine := a_routine%N" +
				"%T%T%T$2 (Current, $on_callback)%N" +
				"%T%Tend%N" +
				"%N" +
				"feature --Access: Routine %N" +
				"%N" +
				"%Troutine: $5 %N" +
				"%T%T%T--Eiffel routine to be call on callback." +
				"%N" +
				"%N" +
				"feature --Access: Dispatcher%N" +
				"%N" +
				"%Tc_dispatcher: POINTER %N" +
				"%T%Tdo%N" +
				"%T%T%TResult := $3%N" +
				"%T%Tend%N" +
				"%N" +
				"feature --Access: Callback%N" +
				"%N" +
				"%T$6%N"+
				"%T%Tdo%N"+
				"%T%T%T$7%N"+
				"%T%Tend%N"+
				"%N" +
				"end%N"
			end

end
