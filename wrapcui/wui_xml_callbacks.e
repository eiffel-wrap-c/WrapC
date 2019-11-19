note
	description: "Summary description for {WUI_XML_CALLBACKS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WUI_XML_CALLBACKS

inherit
	XML_CALLBACKS_NULL
		redefine
			default_create,
			on_start_tag,
			on_content
		end

feature {NONE} -- Initialization

	default_create
			--<Precursor>
		do
			Precursor
			create contents.make (10)
		end

feature --

	on_start_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			--<Precursor>
		do
			last_local_part := a_local_part
		end

	last_local_part: STRING_32
		attribute
			create Result.make_empty
		end

	on_content (a_content: READABLE_STRING_32)
			--<Precursor>
		do
			if not (a_content.count = 1 and then a_content [1] = '%N') and then not (a_content.count = 2 and then (a_content [1] = '%N' and a_content [2] = '%T')) and then not a_content.is_empty then
				contents.force ([last_local_part, a_content])
			end
		end

	contents: ARRAYED_LIST [TUPLE [local_part, content: READABLE_STRING_32]]

end
