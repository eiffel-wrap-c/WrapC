note
	description: "WrapC UI Application"

class
	WUI_APP

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			--<Precursor>
		do
			create application
			create main_window.make_with_title ("WrapC")

			main_window.set_size (800, 600)

			main_window.close_request_actions.force (agent application.destroy)
			application.post_launch_actions.force (agent main_window.show)

			application.launch
		end

feature {NONE} -- Application

	application: EV_APPLICATION

	main_window: WUI_MAIN_WINDOW

	ewg: detachable EWG

end
