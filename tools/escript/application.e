note
	description: "escript application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_rename: ESC_RENAME_FEATURES_COMMAND
			l_update: ESC_UPDATE_FEATURES_COMMAND
		do
			project_path := config.project_path (ewg_config_path)

				-- Command: Rename features
			create l_rename
			l_rename.execute ([project_path, config.rename_features (ewg_config_path)])
				-- Command: Update features
			create l_update
			l_update.execute ([project_path, config.update_features (ewg_config_path)])

		end

	project_path: PATH


	ewg_config_path: PATH
			-- EWG Post Configuration file path.
		once
			Result := (create {PATH}.make_current).extended ("esc_configuration.json")
		end

	config: ESC_CONFIGURATION
		do
			create Result
		ensure
			is_class: class
		end
end
