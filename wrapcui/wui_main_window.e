note
	description: "WrapC UI Application Main Window"
	purpose: "[
		This is the primary window of a one-window application.
		The window provides the user with the capacity to set up the 
		same options as what one finds in the WrapC command line options.
		For example: Instead of typing out the full-path to the
		`*.h' header file (i.e. --full-header=?), the user may click
		the ellipses button (i.e. "...") and select the directory
		from a directory selection dialog, thereby filling in the
		full-header field in the UI.
		]"

class
	WUI_MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			create_interface_objects,
			initialize
		end

create
	make_with_title

feature {NONE} -- Initialization

	create_interface_objects
			--<Precursor>
		do
			Precursor
			create main_box

			create full_header_box
			create full_header_textbox
			create full_header_label.make_with_text ("--full_header=<...>")
			create full_header_button.make_with_text_and_action ("...", agent on_full_header_click)
			full_header_textbox.focus_out_actions.force (agent on_full_header_textbox_focus_out)

			create output_dir_box
			create output_dir_textbox
			create output_dir_label.make_with_text ("--output-dir=<...>")
			create output_dir_button.make_with_text_and_action ("...", agent on_output_dir_click)
			output_dir_textbox.focus_out_actions.force (agent on_output_dir_textbox_focus_out)

			create cmd_box
			create run_wrapc_cmd_button.make_with_text_and_action ("Run", agent on_run_wrapc_cmd_button_click)

			create c_compile_box
			create c_compile_textbox
			create c_compile_label.make_with_text ("C-compile Options: ")

			create script_pre_box
			create script_pre_textbox
			create script_pre_label.make_with_text ("Script pre-process Options: ")

			create script_post_box
			create script_post_textbox
			create script_post_label.make_with_text ("Script post-process Options: ")

			create config_file_box
			create config_file_textbox
			create config_file_label.make_with_text ("Config file: ")
			create config_file_button.make_with_text_and_action ("...", agent on_config_file_click)

			create output_box
			create output_text
		end

	initialize
			--<Precursor>
		do
			Precursor

				-- full-header
			main_box.extend (full_header_box)
			full_header_box.extend (full_header_label)
			full_header_box.extend (full_header_textbox)
			full_header_box.extend (full_header_button)
			full_header_box.disable_item_expand (full_header_label)
			full_header_box.disable_item_expand (full_header_button)
			full_header_box.set_border_width (3)
			full_header_box.set_padding_width (3)
			main_box.disable_item_expand (full_header_box)

				-- output-dir
			main_box.extend (output_dir_box)
			output_dir_box.extend (output_dir_label)
			output_dir_box.extend (output_dir_textbox)
			output_dir_box.extend (output_dir_button)
			output_dir_box.disable_item_expand (output_dir_label)
			output_dir_box.disable_item_expand (output_dir_button)
			output_dir_box.set_border_width (3)
			output_dir_box.set_padding_width (3)
			main_box.disable_item_expand (output_dir_box)

				-- Options: C-compile
			main_box.extend (c_compile_box)
			c_compile_box.extend (c_compile_label)
			c_compile_box.extend (c_compile_textbox)
			c_compile_box.disable_item_expand (c_compile_label)
			c_compile_box.set_border_width (3)
			c_compile_box.set_padding_width (3)
			main_box.disable_item_expand (c_compile_box)

				-- Options: Script-pre-process
			main_box.extend (script_pre_box)
			script_pre_box.extend (script_pre_label)
			script_pre_box.extend (script_pre_textbox)
			script_pre_box.disable_item_expand (script_pre_label)
			script_pre_box.set_border_width (3)
			script_pre_box.set_padding_width (3)
			main_box.disable_item_expand (script_pre_box)

				-- Options: Script-post-process
			main_box.extend (script_post_box)
			script_post_box.extend (script_post_label)
			script_post_box.extend (script_post_textbox)
			script_post_box.disable_item_expand (script_post_label)
			script_post_box.set_border_width (3)
			script_post_box.set_padding_width (3)
			main_box.disable_item_expand (script_post_box)

				-- Options: Config file
			main_box.extend (config_file_box)
			config_file_box.extend (config_file_label)
			config_file_box.extend (config_file_textbox)
			config_file_box.extend (config_file_button)
			config_file_box.disable_item_expand (config_file_label)
			config_file_box.disable_item_expand (config_file_button)
			config_file_box.set_border_width (3)
			config_file_box.set_padding_width (3)
			main_box.disable_item_expand (config_file_box)

				-- Output
			main_box.extend (output_box)
			output_box.extend (output_text)

				-- Run Cmd
			main_box.extend (cmd_box)
			cmd_box.extend (create {EV_CELL})
			cmd_box.extend (run_wrapc_cmd_button)
			run_wrapc_cmd_button.disable_sensitive
			cmd_box.extend (create {EV_CELL})
			cmd_box.disable_item_expand (run_wrapc_cmd_button)
			cmd_box.set_border_width (3)
			cmd_box.set_padding_width (3)
			main_box.disable_item_expand (cmd_box)

			extend (main_box)
		end

feature {NONE} -- Implementation: Basic Operations

	fully_formed_cmd: STRING_32
			-- What is the `fully_formed_cmd' based on user settings?
		do
			create Result.make_empty
			Result.append_string_general ("D:\Users\LJR19\Documents\GitHub\WrapC_ljr\wrapcui\wrap_c.exe ")

				-- output-dir [optional]
			if not output_dir_textbox.text.is_empty then
				Result.append_string_general (" --output-dir=" + output_dir_textbox.text + " ")
			end

				-- full-header
			Result.append_string_general (" --full-header=" + full_header_textbox.text + " ")
		end

feature {WUI_EWG} -- Implementation: Output

	add_output (a_string: STRING)
			--
		do
			output_text.append_text (a_string)
			if output_text.text.count > 0 then
				output_text.set_caret_position (output_text.text.count)
			end
		end

feature {NONE} -- GUI Actions

	on_full_header_click
			-- What happens when user clicks `full_header_button'
		local
			l_file_open: EV_FILE_OPEN_DIALOG
			l_dir: DIRECTORY
		do
			create l_file_open.make_with_title ("Locate header file ...")
			l_file_open.show_modal_to_window (Current)

			full_header_textbox.set_text (l_file_open.file_name)
			on_full_header_textbox_focus_out
		end

	on_output_dir_click
			-- What happens when user clicks `output_dir_button'
		local
			l_dir: EV_DIRECTORY_DIALOG
		do
			create l_dir.make_with_title ("Locate output directory ...")
			l_dir.show_modal_to_window (Current)

			output_dir_textbox.set_text (l_dir.directory)
			on_output_dir_textbox_focus_out
		end

	on_config_file_click
			-- What happens whenuser clicks "..." for config file?
		local
			l_file_open: EV_FILE_OPEN_DIALOG
		do
			create l_file_open.make_with_title ("Locate config file ...")
			l_file_open.show_modal_to_window (Current)

			config_file_textbox.set_text (l_file_open.file_name)
		end


	on_run_wrapc_cmd_button_click
			-- What happens when user clicks `run_wrapc_cmd'.
			-- `run' is in the `make' from `make_with_window'
		local
			l_ewg: WUI_EWG
		do
			create l_ewg.make_with_window (Current)
		end

	on_full_header_textbox_focus_out
			-- What happens on focus-out of `full_header_textbox'?
		note
			design: "[
				There are reasons for allowing the user to access or
				not access clicking the Run button. This routine helps
				resolve that question.
				]"
		do
			if full_header_textbox.text.is_empty then
				run_wrapc_cmd_button.disable_sensitive
			else
				enable_disable_sensitive_on_run_wrapc_cmd_button
			end
		end

	on_output_dir_textbox_focus_out
			-- What happend on focus-out of `output_dir_textbox'?
		note
			design: "[
				There are reasons for allowing the user to access or
				not access clicking the Run button. This routine helps
				resolve that question.
				]"
		local
			l_dir: DIRECTORY
		do
			create l_dir.make (output_dir_textbox.text)
			if l_dir.exists then
				run_wrapc_cmd_button.enable_sensitive
			else
				run_wrapc_cmd_button.disable_sensitive
			end
		end

feature {NONE} -- GUI Actions Support

	enable_disable_sensitive_on_run_wrapc_cmd_button
			-- Determine if Run button is sensitive or not.
		note
			design: "[
				There are reasons for allowing the user to access or
				not access clicking the Run button. This routine helps
				resolve that question.
				]"
		do
			if dir_has_full_header_file then
				run_wrapc_cmd_button.enable_sensitive
			else
				run_wrapc_cmd_button.disable_sensitive
			end
		end

	dir_has_full_header_file: BOOLEAN
			-- Does `full_header_textbox' text directory exist and have file?
		note
			design: "[
				There are reasons for allowing the user to access or
				not access clicking the Run button. This routine helps
				resolve that question.
				]"
		local
			l_dir: DIRECTORY
			l_path_string: STRING
			l_list: LIST [STRING]
		do
			l_path_string := full_header_textbox.text.twin
			l_list := l_path_string.split ({OPERATING_ENVIRONMENT}.Directory_separator)
			l_path_string.remove_tail (l_list [l_list.count].count + 1)
			create l_dir.make (l_path_string)
			Result := l_dir.exists and then l_dir.has_entry (l_list [l_list.count])
		end

feature {WUI_EWG} -- GUI Components

	main_box: EV_VERTICAL_BOX

	full_header_box: EV_HORIZONTAL_BOX
	full_header_textbox: EV_TEXT_FIELD
	full_header_label: EV_LABEL
	full_header_button: EV_BUTTON

	output_dir_box: EV_HORIZONTAL_BOX
	output_dir_textbox: EV_TEXT_FIELD
	output_dir_label: EV_LABEL
	output_dir_button: EV_BUTTON

	cmd_box: EV_HORIZONTAL_BOX
	run_wrapc_cmd_button: EV_BUTTON

	c_compile_box: EV_HORIZONTAL_BOX
	c_compile_textbox: EV_TEXT_FIELD
	c_compile_label: EV_LABEL

	script_pre_box: EV_HORIZONTAL_BOX
	script_pre_textbox: EV_TEXT_FIELD
	script_pre_label: EV_LABEL

	script_post_box: EV_HORIZONTAL_BOX
	script_post_textbox: EV_TEXT_FIELD
	script_post_label: EV_LABEL

	config_file_box: EV_HORIZONTAL_BOX
	config_file_textbox: EV_TEXT_FIELD
	config_file_label: EV_LABEL
	config_file_button: EV_BUTTON

	output_box: EV_VERTICAL_BOX
	output_text: EV_RICH_TEXT

;note
	command_line_help_example: "[
		wrap_c --help
		wrap_c: You must specify '--full-header=<...>'
		usage: wrap_c   [--version] [--verbose]
		                [--c_compile_options=<...>] [--script_pre_process=<...>] [--script_post_process=<...>]
		                [--output-dir=<...>] --full-header=<...>
		                [--config=<...>]
		]"
	online_description: "[
		options:
			--version ... Output WrapC (EWG) version number.
			--verbose ... Output progress information on STDOUT
			--c_compile_options: Optional c compile options
			--script_pre_process: Optional pre-processing script, to be executed before C header preprocessing
			--scrtip_post_process: Optional post-processing script, to be executed after Eiffel code wrapping.

		arguments:
			--output-dir  ... Directory where generated files will be placed
			--full-header ... Filename (including pathname) to the C header to be preprocessed,
				          and name of header file, that should be used in eiffel external clauses
			--config      ... Name of config file to use. A config file allows to customize the wrapping process
		]"
	EIS: "name=readme_md", "src=https://github.com/eiffel-wrap-c/WrapC/blob/master/doc/Readme.md"
	corresponding_ui_elements: "[
		REQUIRED:
		--full-header=<...>				... Filename (including pathname) to the C header to be preprocessed,
				          					and name of header file, that should be used in eiffel external clauses
		
		OPTIONAL:
		[--output-dir=<...>]			... Directory where generated files will be placed.
		[--c_compile_options=<...>]		... Optional c compile options.
		[--script_pre_process=<...>]	... Optional pre-processing script, to be executed before C header preprocessing.
		[--script_post_process=<...>]	... Optional post-processing script, to be executed after Eiffel code wrapping.
		[--config=<...>]				... Name of config file to use. A config file allows to customize the wrapping process.
		]"

end
