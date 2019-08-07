note
	description: "Provide access to json configuration"
	date: "$Date$"
	revision: "$Revision$"

class
	ESC_CONFIGURATION

inherit

	JSON_PARSER_ACCESS

feature -- Application Configuration

	project_path (a_path: PATH): PATH
			-- Build a
		local
			l_parser: JSON_PARSER
		do
			create Result.make_current
			if attached json_file_from (a_path) as json_file then
			 	l_parser := new_json_parser (json_file)
				if  attached {JSON_OBJECT} l_parser.next_parsed_json_value as jv and then l_parser.is_valid and then
			 	    attached {JSON_STRING} jv.item ("path") as l_path then
			    	 create Result.make_from_string (l_path.item)
				end
			end
		end

	rename_features (a_path: PATH): LIST [TUPLE [class_name: READABLE_STRING_GENERAL; search_for: READABLE_STRING_GENERAL; replace_with: READABLE_STRING_GENERAL; exclude: LIST [READABLE_STRING_GENERAL]]]
		local
			l_parser: JSON_PARSER
			l_excludes: LIST [READABLE_STRING_GENERAL]
		do
			create {ARRAYED_LIST [TUPLE [class_name: READABLE_STRING_GENERAL; search_for: READABLE_STRING_GENERAL; replace_with: READABLE_STRING_GENERAL; exclude: LIST [READABLE_STRING_GENERAL]]]} Result.make (10)
			if
				attached json_file_from (a_path) as json_file
			then
				 l_parser := new_json_parser (json_file)
			 	if
			 		attached {JSON_OBJECT} l_parser.next_parsed_json_value as jv and then l_parser.is_valid and then
			     	attached {JSON_ARRAY} jv.item ("rename_features") as l_features
			    then
					across l_features as c loop
						if attached {JSON_OBJECT} c.item as l_item and then
							attached {JSON_STRING} l_item.item ("class") as l_class and then
							attached {JSON_STRING} l_item.item ("search_for") as l_search_for and then
							attached {JSON_STRING} l_item.item ("replace_with") as l_replace_with
						then
							create {ARRAYED_LIST [READABLE_STRING_GENERAL]} l_excludes.make (10)
							if attached {JSON_ARRAY} l_item.item ("exclude") as ll_excludes  then
								across ll_excludes as ic  loop
									if attached {JSON_STRING} ic.item as l_elm then
										l_excludes.force (l_elm.item)
									end

								end
							end
							Result.force ([l_class.item, l_search_for.item, l_replace_with.item, l_excludes])
						end
					end
			 	end
			end
		end

	update_features (a_path: PATH): LIST [TUPLE [class_name: READABLE_STRING_GENERAL; features: LIST [TUPLE [name: READABLE_STRING_GENERAL; at_line: INTEGER; lines: INTEGER; action: READABLE_STRING_GENERAL; update: READABLE_STRING_GENERAL]]]]
		local
			l_parser: JSON_PARSER
			l_updates: LIST [TUPLE [name: READABLE_STRING_GENERAL; at_line: INTEGER; lines: INTEGER; action: READABLE_STRING_GENERAL; update: READABLE_STRING_GENERAL]]
		do
			create {ARRAYED_LIST [TUPLE [class_name: READABLE_STRING_GENERAL; features: LIST [TUPLE [name: READABLE_STRING_GENERAL; at_line: INTEGER; lines: INTEGER; action: READABLE_STRING_GENERAL; update: READABLE_STRING_GENERAL]]]]} Result.make (10)
			if
				attached json_file_from (a_path) as json_file
			then
				 l_parser := new_json_parser (json_file)
			 	if
			 		attached {JSON_OBJECT} l_parser.next_parsed_json_value as jv and then l_parser.is_valid and then
			     	attached {JSON_ARRAY} jv.item ("update_features") as l_features
			    then
					across l_features as c loop
						if attached {JSON_OBJECT} c.item as l_item and then
							attached {JSON_STRING} l_item.item ("class") as l_class and then
							attached {JSON_ARRAY} l_item.item ("features") as l_features_class
						then
							create {ARRAYED_LIST [TUPLE [name: READABLE_STRING_GENERAL; at_line: INTEGER; lines: INTEGER; action: READABLE_STRING_GENERAL; update: READABLE_STRING_GENERAL]]} l_updates.make (10)
							across l_features_class as i loop
								if attached {JSON_OBJECT} i.item as l_item_class and then
									attached {JSON_STRING} l_item_class.item ("name") as l_name and then
									attached {JSON_NUMBER} l_item_class.item ("lines") as l_lines and then
									attached {JSON_NUMBER} l_item_class.item ("at_line") as l_at_line and then
									attached {JSON_STRING} l_item_class.item ("action") as l_action and then
									attached {JSON_STRING} l_item_class.item ("update") as l_code
								then
									l_updates.force ([l_name.item, l_at_line.integer_64_item.to_integer, l_lines.integer_64_item.to_integer, l_action.item, l_code.unescaped_string_8])
								end
							end
							Result.force ([l_class.item, l_updates])
						end
					end
			 	end
			end
		end

feature {NONE} -- JSON

	json_file_from (a_fn: PATH): detachable STRING
		do
			Result := (create {JSON_FILE_READER}).read_json_from (a_fn.name.out)
		end

	new_json_parser (a_string: STRING): JSON_PARSER
		do
			create Result.make_with_string (a_string)
		end

end

