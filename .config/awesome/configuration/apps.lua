local filesystem = require('gears.filesystem')

local config_dir = filesystem.get_configuration_dir()
local bin_dir = config_dir .. 'binaries/'


return {

	-- The default applications in keybindings and widgets
	default = {
		terminal 										= 'kitty',                                  -- Terminal Emulator
		text_editor 									= 'textadept',                                  -- GUI Text Editor
		web_browser 									= 'opera',                                -- Web browser
		file_manager 									= 'pcmanfm',                                -- GUI File manager
		network_manager 								= 'networkmanager_dmenu -theme wifi',					-- Network manager
		bluetooth_manager 								= 'rofi-bluetooth',						-- Bluetooth manager
		power_manager 									= 'xfce4-power-manager',					-- Power manager
		package_manager 								= 'pamac-manager',							-- GUI Package manager
		lock 											= 'awesome-client "_G.show_lockscreen()"',  -- Lockscreen
		quake 											= 'kitty --name QuakeTerminal',             -- Quake-like Terminal

		rofiglobal										= 'rofi -dpi ' .. screen.primary.dpi .. 
														  ' -show "Global Search" -modi "Global Search":' .. config_dir .. 
														  '/configuration/rofi/sidebar/rofi-spotlight.sh' .. 
														  ' -theme ' .. config_dir ..
														  '/configuration/rofi/sidebar/rofi.rasi', 	-- Rofi Web Search
		

		rofiappmenu 									= 'rofi -show drun -theme apps'   -- Application Menu
		-- You can add more default applications here
	},
	
	-- List of apps to start once on start-up

	run_on_start_up = {

		'picom -b --experimental-backends --dbus --config ' .. 
		config_dir .. '/configuration/picom.conf',   												-- Compositor

		--'blueman-applet',                                                                           -- Bluetooth tray icon
		--'mpd',                                                                                      -- Music Server
		--'xfce4-power-manager',
		'libinput-gestures-setup start',
		'nitrogen --restore',
		'/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1' .. 
		' eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)',                 	-- Credential manager
		
		'xrdb $HOME/.Xresources',                                                                   -- Load X Colors
		--'nm-applet',                                                                                -- NetworkManager Applet
		--'pulseeffects --gapplication-service',                                                      -- Sound Equalizer
		'xmodmap -e "keycode  77 ="',		
		'xidlehook --not-when-fullscreen --not-when-audio --timer 600 '..
		' "awesome-client \'_G.show_lockscreen()\'" ""'  											-- Auto lock timer

		-- You can add more start-up applications here
	},

	-- List of binaries that will execute a certain task

	bins = {
		full_screenshot = bin_dir .. 'snap full',              					                    -- Full Screenshot
		area_screenshot = bin_dir .. 'snap area'			                                        -- Area Selected Screenshot
	}
}
