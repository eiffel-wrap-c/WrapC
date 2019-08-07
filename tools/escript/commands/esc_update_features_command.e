note
	description: "Summary description for {ES_UPDATE_FEATURES_COMMAND}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESC_UPDATE_FEATURES_COMMAND

inherit

	ESC_COMMAND

feature -- execute

	execute (args: TUPLE)
			-- Execute command with `args'.
		do

			if attached {PATH} args.at (1) as l_path and then attached {ARRAYED_LIST [TUPLE [class_name: READABLE_STRING_GENERAL; features: LIST [TUPLE [name: READABLE_STRING_GENERAL; at_line: INTEGER; lines: INTEGER; action: READABLE_STRING_GENERAL; update: READABLE_STRING_GENERAL]]]]} args.at (2) as l_list then
				across l_list as ic
				loop
					update_features (ic.item, l_path)
				end
			end
		end

	update_features (a_tuple: TUPLE [class_name: READABLE_STRING_GENERAL; a_features: LIST [TUPLE [name: READABLE_STRING_GENERAL; at_line: INTEGER; lines: INTEGER; action: READABLE_STRING_GENERAL; update: READABLE_STRING_GENERAL]]]; a_path: PATH)
			-- updates features of `class_name`.
		local
			l_file_path: PATH
			l_file: RAW_FILE
			l_tmp: RAW_FILE
			l_content, l_feature: STRING
			i,j: INTEGER
		do
			print ("%N" + generator + " Updating class [ " + a_tuple.class_name + "]" )
			print ("%N --------------------------------------------------------------" )

			l_file_path := a_path.extended (a_tuple.class_name).appended_with_extension ("e")
			create l_file.make_with_path (l_file_path)
			create l_tmp.make_open_temporary
			if l_file.exists and then l_file.is_readable then
				l_file.open_read
				from
					j := 1
				until
					l_file.end_of_file
				loop
					l_file.read_line
					l_feature := l_file.last_string.twin
					if attached has_feature_name (l_feature, j,  a_tuple.a_features) as l_tuple then
						from
							i := 1
						until
							l_file.end_of_file or i > l_tuple.lines
						loop
							l_file.read_line
							i := i + 1
							j := j + 1
						end
						if l_tuple.action.same_string ("delete") then
							l_tmp.put_string ("%N")
							print ("%N Removing feature [ " + l_feature + "]" )
						else
							l_tmp.put_string (l_tuple.update.to_string_8)
							l_tmp.put_string ("%N")
							l_tmp.put_string ("%N")
						end
					else
						l_tmp.put_string (l_file.last_string)
						l_tmp.put_string ("%N")
					end
					j := j + 1
				end
				l_file.close
				l_tmp.close
				l_file.wipe_out
				l_file.open_read_write
				l_tmp.open_read
				l_tmp.read_stream (l_tmp.count)
				l_file.put_string (l_tmp.last_string)
				l_file.flush
				l_file.close
				l_tmp.close
				l_tmp.delete
				print ("%N --------------------------------------------------------------" )
			end
		end


	has_feature_name (a_line: READABLE_STRING_GENERAL; a_current_line: INTEGER; a_feature_list: LIST [TUPLE [name: READABLE_STRING_GENERAL; at_line: INTEGER; lines: INTEGER; action: READABLE_STRING_GENERAL; update: READABLE_STRING_GENERAL]]): detachable TUPLE [name: READABLE_STRING_GENERAL; at_line: INTEGER; lines: INTEGER; action: READABLE_STRING_GENERAL; update: READABLE_STRING_GENERAL]
		local
			l_line: STRING
			c: CHARACTER_32
			l_item: TUPLE [name: READABLE_STRING_GENERAL; at_line: INTEGER; lines: INTEGER; action: READABLE_STRING_GENERAL; update: READABLE_STRING_GENERAL]
		do
			from
				a_feature_list.start
			until
				a_feature_list.after or attached Result
			loop
				l_item := a_feature_list.item
				if a_line.has_substring (l_item.name) and then a_current_line = l_item.at_line then
							-- remove the leading spaces
						l_line := a_line.as_string_8.twin
						l_line.adjust
						c:= l_line [a_feature_list.item_for_iteration.name.count + 1]
						-- If the next character is not space, colon or open parenthesis then
					if
						l_line.substring (1, a_feature_list.item_for_iteration.name.count).same_string_general (a_feature_list.item_for_iteration.name) and then
						c = ' ' or  c = ':' or c = '(' or c = '%T' or c = '%R' or c= '%N'
					then
						Result := a_feature_list.item_for_iteration
					end

				end
				a_feature_list.forth
			end
		end

end


