note
	description: "Summary description for {ESC_RENAME_FEATURES_COMMAND}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESC_RENAME_FEATURES_COMMAND

inherit

	ESC_COMMAND

feature -- execute

	execute (args: TUPLE)
			-- Execute command with `args'.
		do

			if attached {PATH} args.at (1) as l_path and then attached {ARRAYED_LIST [TUPLE [class_name: READABLE_STRING_GENERAL; search_for: READABLE_STRING_GENERAL; replace_with: READABLE_STRING_GENERAL; exclude: LIST [READABLE_STRING_GENERAL] ]]} args.at (2) as l_list then
				across l_list as ic
				loop
					replace (ic.item, l_path)
				end
			end
		end

	replace (a_tuple:TUPLE [class_name: READABLE_STRING_GENERAL; search_for: READABLE_STRING_GENERAL; replace_with: READABLE_STRING_GENERAL; exclude: LIST [READABLE_STRING_GENERAL]]; a_path: PATH)
		local
			l_file_path: PATH
			l_file: RAW_FILE
			l_tmp: RAW_FILE
			l_content: STRING
			l_string: STRING
		do
			print ("%N" + generator +  " updating class [ " + a_tuple.class_name + "]" )
			print ("%N --------------------------------------------------------------" )
			print ("%N Replacing string :"  + a_tuple.search_for.as_string_8 + " with: " + a_tuple.replace_with.as_string_8)
			l_file_path := a_path.extended (a_tuple.class_name).appended_with_extension ("e")
			create l_file.make_with_path (l_file_path)
			create l_tmp.make_open_temporary
			if l_file.exists then
				l_file.open_read
				from
				until
					l_file.end_of_file
				loop
					l_file.read_line
					l_string := l_file.last_string
					if has_excluded_name (l_string, a_tuple.exclude)  then
						l_tmp.put_string (l_string)
					else
						l_string.replace_substring_all (a_tuple.search_for.as_string_8, a_tuple.replace_with.as_string_8)
						l_tmp.put_string (l_string)
					end
					l_tmp.put_string ("%N")
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
			end
			print ("%N --------------------------------------------------------------" )

		end

	has_excluded_name (a_line: READABLE_STRING_GENERAL; exclude: LIST [READABLE_STRING_GENERAL]): BOOLEAN
		do
			from
				exclude.start
			until
				exclude.after or Result
			loop
				if a_line.has_substring (exclude.item_for_iteration) then
					Result := True
				end
				exclude.forth
			end
		end
end
