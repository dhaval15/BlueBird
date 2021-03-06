local awful = require('awful')
local beautiful = require('beautiful')

local wibox = require("wibox")
local gears = require("gears")
require('awful.autofocus')

local hotkeys_popup = require('awful.hotkeys_popup').widget

local modkey = require('configuration.keys.mod').modKey
local altkey = require('configuration.keys.mod').altKey
local shiftkey = require('configuration.keys.mod').shiftKey
local altkey = require('configuration.keys.mod').altKey
local apps = require('configuration.apps')

local modalbind = require("modal")
modalbind.init()
modalbind.set_location("top")

local ftenmap = {
    { 
        "7",
        function() 
            awful.spawn("rofi -show drun -theme apps")
        end,
        "Apps",
        "7",
    },
    {
        "0",
        function()
            awful.spawn("rofi  -show Find -theme finder -modi Find:~/.user_scripts/finder.sh")
        end,
        "Finder",
        "0",
    },
    {
        "/",
        function()
		local c = awful.client.focus
  		local grabber
  		grabber = awful.keygrabber.run(
		function(mod, key, event)
    			if event == "release" then return end
    			if     key == 'Up'    then c:relative_move(0, 0, 0, 5)
    			elseif key == 'Down'  then c:relative_move(0, 0, 0, -5)
    			elseif key == 'Right' then c:relative_move(0, 0, 5, 0)
    			elseif key == 'Left'  then c:relative_move(0, 0, -5, 0)
    			else   awful.keygrabber.stop(grabber) end
        
		end)
	end,
        "Dmenu",
        "/",
    },
}

-- Vim Like Bindingsi

local map, actions = {
    verbs = {
        m = 'move' , f = 'focus' , d = 'delete' , a = 'append',
        w = 'swap' , p = 'print' , n = 'new'    ,
    },
    adjectives = { h = 'left'  , j = 'down' , k = 'up'    , l = 'right' , },
    nouns      = { c = 'client', t = 'tag'  , s = 'screen', y = 'layout', },
}, {}

function actions.client(action, adj) print('IN CLIENT!') end --luacheck: no unused args
function actions.tag   (action, adj) print('IN TAG!'   ) end --luacheck: no unused args
function actions.screen(action, adj) print('IN SCREEN!') end --luacheck: no unused args
function actions.layout(action, adj) print('IN LAYOUT!') end --luacheck: no unused args

local function parse(_, stop_key, _, sequence)
    local parsed, count = { verbs = '', adjectives = '', nouns = '', }, ''
    sequence = sequence..stop_key

    for i=1, #sequence do
        local char = sequence:sub(i,i)
        if char >= '0' and char <= '9' then
            count = count .. char
        else
            for kind in pairs(parsed) do
                parsed[kind] = map[kind][char] or parsed[kind]
            end
        end
    end

    if parsed.nouns == '' then return end
    for _=1, count == '' and 1 or tonumber(count) do
        actions[parsed.nouns](parsed.verbs, parsed.adjectives)
    end
end

awful.keygrabber {
    stop_callback = parse,
    stop_key   = gears.table.keys(map.verbs),
    root_keybingins = {
        {{'Mod4'}, 'v'}
    },
}

-- Key bindings
local globalKeys = awful.util.table.join(

    -- Hotkeys
    awful.key(
        {modkey}, 
        'h', 
        hotkeys_popup.show_help, 
        {description = 'show help', group = 'Awesome'}
    ),
    awful.key({modkey, shiftkey}, 
        'r', 
        awesome.restart, 
        {description = 'reload awesome', group = 'Awesome'}
    ),
    awful.key(
        {altkey, 'Shift'},
        'l',
        function()
            awful.tag.incmwfact(0.05)
        end,
        {description = 'increase master width factor', group = 'layout'}
    ),
    awful.key(
        {altkey, 'Shift'},
        'h',
        function()
            awful.tag.incmwfact(-0.05)
        end,
        {description = 'decrease master width factor', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'h',
        function()
            awful.tag.incnmaster(1, nil, true)
        end,
        {description = 'increase the number of master clients', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'l',
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = 'decrease the number of master clients', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Control'},
        'h',
        function()
            awful.tag.incncol(1, nil, true)
        end,
        {description = 'increase the number of columns', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Control'},
        'l',
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {description = 'decrease the number of columns', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'space',
        function()
            awful.layout.inc(-1)
        end,
        {description = 'select previous layout', group = 'layout'}
    ),
    awful.key(
        {modkey}, 
        'Left', 
        awful.tag.viewprev, 
        {description = 'view previous tag', group = 'tag'}
    ),
    
    awful.key(
        {modkey}, 
        'Right', 
        awful.tag.viewnext, 
        {description = 'view next tag', group = 'tag'}
    ),
    awful.key(
		{modkey},
		'Tab',
		function()
			awful.spawn("rofi -show window -theme window")
		end,
		{description = 'Rofi Windows', group = 'Launcher'}
    ),
    awful.key({ }, "F10",
      function ()
        awful.spawn("rofi  -show Find -theme finder -modi Find:~/.user_scripts/finder.sh")
      end,
      {description = "Rofi Finder", group = "launcher"}
    ),
    awful.key({ }, "#77",
        function ()
            modalbind.grab{keymap=ftenmap, name="Shortcuts", stay_in_mode=false}
        end,
        {description = "Modal", group = "launcher"}
    ),
    awful.key(
        {modkey}, 
        'Escape', 
        function()
            awful.spawn("/home/dhaval/.user_scripts/exit.sh")
        end,
        {description = 'Show exit screen', group = 'Awesome'}
    ),
    awful.key({ modkey, "Control" }, 
        "w",
        function ()
            -- tag_view_nonempty(-1)
            local focused = awful.screen.focused()
            for i = 1, #focused.tags do
                awful.tag.viewidx(-1, focused)
                if #focused.clients > 0 then
                    return
                end
            end
        end, 
        {description = "view previous non-empty tag", group = "tag"}
    ),
    awful.key({ modkey, "Control" }, 
        "s",
        function ()
            -- tag_view_nonempty(1)
            local focused =  awful.screen.focused()
            for i = 1, #focused.tags do
                awful.tag.viewidx(1, focused)
                if #focused.clients > 0 then
                    return
                end
            end
        end, 
        {description = "view next non-empty tag", group = "tag"}
    ),
    awful.key(
        {modkey, 'Shift'}, 
        "F1",  
        function() 
            awful.screen.focus_relative(-1) 
        end,
        { description = "focus the previous screen", group = "screen"}
    ),
    awful.key(
        {modkey, 'Shift'}, 
        "F2", 
        function()
            awful.screen.focus_relative(1)
        end,
        { description = "focus the next screen", group = "screen"}
    ),
    awful.key(
        {modkey, 'Control'},
        'n',
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description = 'restore minimized', group = 'screen'}
    ),
    awful.key(
        {},
        'XF86MonBrightnessUp',
        function()
            awful.spawn('xbacklight -inc 10', false)
            awesome.emit_signal('module::brightness_osd:show', true)
            awesome.emit_signal('widget::brightness')
        end,
        {description = 'increase brightness by 10%', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86MonBrightnessDown',
        function()
            awful.spawn('xbacklight -dec 10', false)
            awesome.emit_signal('module::brightness_osd:show', true)
            awesome.emit_signal('widget::brightness')
        end,
        {description = 'decrease brightness by 10%', group = 'hotkeys'}
    ),
    -- ALSA volume control
    awful.key(
        {},
        'XF86AudioRaiseVolume',
        function()
            awful.spawn('pamixer -i 5', false)
            awesome.emit_signal('widget::volume')
            awesome.emit_signal('module::volume_osd:show', true)
        end,
        {description = 'increase volume up by 5%', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86AudioLowerVolume',
        function()
            awful.spawn('pamixer -d 5', false)
            awesome.emit_signal('widget::volume')
            awesome.emit_signal('module::volume_osd:show', true)
        end,
        {description = 'decrease volume up by 5%', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86AudioMute',
        function()
            awful.spawn('amixer -D pulse set Master 1+ toggle', false)
        end,
        {description = 'toggle mute', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86AudioNext',
        function()
            awful.spawn('mpc next', false)
        end,
        {description = 'next music', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86AudioPrev',
        function()
            awful.spawn('mpc prev', false)
        end,
        {description = 'previous music', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86AudioPlay',
        function()
            awful.spawn('mpc toggle', false)
        end,
        {description = 'play/pause music', group = 'hotkeys'}

    ),
    awful.key(
        {},
        'XF86AudioMicMute',
        function()
            awful.spawn('amixer set Capture toggle', false)
        end,
        {description = 'mute microphone', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86PowerDown',
        function()
            awful.spawn("/home/dhaval/.user_scripts/exit.sh")
        end,
        {description = 'shutdown skynet', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86PowerOff',
        function()
            awful.spawn("/home/dhaval/.user_scripts/exit.sh")
        end,
        {description = 'toggle exit screen', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86Display',
        function()
            awful.spawn.single_instance('arandr', false)
        end,
        {description = 'arandr', group = 'hotkeys'}
    ),
    awful.key(
        {modkey},
        '`',
        function()
            _G.toggle_quake()
        end,
        {description = 'dropdown application', group = 'launcher'}
    ),
    awful.key(
        { }, 
        "Print",
        function ()
            awful.spawn.easy_async_with_shell(apps.bins.full_screenshot,function() end)
        end,
        {description = "fullscreen screenshot", group = 'Utility'}
    ),
    awful.key(
        {modkey, "Shift"}, 
        's',
        function ()
            awful.spawn.easy_async_with_shell(apps.bins.area_screenshot,function() end)
        end,
        {description = "area/selected screenshot", group = 'Utility'}
    ),
    awful.key(
        {modkey},
        'x',
        function()
            awesome.emit_signal("widget::blur:toggle")
        end,
        {description = "toggle blur effects", group = 'Utility'}
    ),
    awful.key(
        {modkey},
        ']',
        function()
            awesome.emit_signal("widget::blur:increase")
        end,
        {description = "increase blur effect by 10%", group = 'Utility'}
    ),
    awful.key(
        {modkey},
        '[',
        function()
            awesome.emit_signal("widget::blur:decrease")
        end,
        {description = "decrease blur effect by 10%", group = 'Utility'}
    ),
    awful.key(
        {modkey},
        't',
        function() 
            awesome.emit_signal("widget::blue_light:toggle")
        end,
        {description = "toggle redshift filter", group = 'Utility'}
    ),
    awful.key(
        { 'Control' }, 
        'Escape', 
        function ()
            if screen.primary.systray then
                if not screen.primary.tray_toggler then
                    local systray = screen.primary.systray
                    systray.visible = not systray.visible
                else
                    awesome.emit_signal("widget::systray:toggle")
                end
            end
        end, 
        {description = "toggle systray visibility", group = 'Utility'}
    ),
    awful.key(
        {modkey},
        'l',
        function()
            awful.spawn(apps.default.lock, false)
        end,
        {description = "lock the screen", group = 'Utility'}
    ),
    awful.key(
        {modkey}, 
        'Return',
        function()
            awful.spawn(apps.default.terminal)
        end,
        {description = "open default terminal", group = 'launcher'}
    ),
    awful.key(
        {modkey}, 
        'e',
        function()
            awful.spawn("rofi -show file-browser -theme files -file-browser-icon-theme 'Surfn-Luv-Red' -file-browser-open-custom-key 'kb-custom-1' -file-browser-oc-cmd 'kitty -c /home/dhaval/.config/kitty/vim.conf vim;name: Open in Vim;icon:vim' -file-browser-oc-cmd 'nemo;name: Open in File Manager;icon:system-file-manager' -file-browser-show-hidden -file-browser-oc-cmd 'code;name: Open With Visual Studio Code;icon:code' -file-browser-oc-cmd 'kitty;name: Open in Terminal;icon:kitty' -file-browser-show-hidden -file-browser-oc-cmd 'idea;name: Open With Intellij Idea;icon:idea' -file-browser-show-hidden ")
        end,
        {description = "open default file manager", group = 'launcher'}
    ),
    awful.key(
        {modkey, "Shift"}, 
        'f',
        function()
            awful.spawn(apps.default.web_browser)
        end,
        {description = "open default web browser", group = 'launcher'}
    ),
    awful.key(
        {"Control", "Shift"}, 
        'Escape',
        function()
            awful.spawn(apps.default.terminal .. ' ' .. 'htop')
        end,
        {description = "open system monitor", group = 'launcher'}
    ),
    awful.key(
        {modkey}, 
        'space',
        function()
            awful.util.spawn(apps.default.rofiappmenu)
        end,
        {description = "open application drawer", group = 'launcher'}
    ),
    awful.key(
        {modkey},
        'r',
        function()
            local focused = awful.screen.focused()

            if focused.right_panel and focused.right_panel.visible then
                focused.right_panel.visible = false
            end
            screen.primary.left_panel:toggle()
        end,
        {description = 'open sidebar', group = 'launcher'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'r',
        function()
            local focused = awful.screen.focused()

            if focused.right_panel and focused.right_panel.visible then
                focused.right_panel.visible = false
            end
            screen.primary.left_panel:toggle(true)
        end,
        {description = 'open sidebar and global search', group = 'launcher'}
    ),
    awful.key(
        {modkey}, 
        'F2',
        function()
            local focused = awful.screen.focused()

            if focused.left_panel and focused.left_panel.opened then
                focused.left_panel:toggle()
            end

            if focused.right_panel then
                if _G.right_panel_mode == 'today_mode' or not focused.right_panel.visible then
                    focused.right_panel:toggle()
                    switch_rdb_pane('today_mode')
                else
                    switch_rdb_pane('today_mode')
                end

                _G.right_panel_mode = 'today_mode'
            end
        end,
        {description = "open notification center", group = 'launcher'}
    ),
    awful.key(
        {modkey}, 
        'F3',
        function()
            local focused = awful.screen.focused()

            if focused.left_panel and focused.left_panel.opened then
                focused.left_panel:toggle()
            end

            if focused.right_panel then
                if _G.right_panel_mode == 'notif_mode' or not focused.right_panel.visible then
                    focused.right_panel:toggle()
                    switch_rdb_pane('notif_mode')
                else
                    switch_rdb_pane('notif_mode')
                end

                _G.right_panel_mode = 'notif_mode'
            end
        end,
        {description = "open today pane", group = 'launcher'}
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = 'view tag #', group = 'tag'}
        descr_toggle = {description = 'toggle tag #', group = 'tag'}
        descr_move = {description = 'move focused client to tag #', group = 'tag'}
        descr_toggle_focus = {description = 'toggle focused client on tag #', group = 'tag'}
    end
    globalKeys =
        awful.util.table.join(
        globalKeys,
        -- View tag only.
        awful.key(
            {modkey},
            '#' .. i + 9,
            function()
                local focused = awful.screen.focused()
                local tag = focused.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            descr_view
        ),
        -- Toggle tag display.
        awful.key(
            {modkey, 'Control'},
            '#' .. i + 9,
            function()
                local focused = awful.screen.focused()
                local tag = focused.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            descr_toggle
        ),
        -- Move client to tag.
        awful.key(
            {modkey, shiftkey},
            '#' .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            descr_move
        ),
        -- Toggle tag on focused client.
        awful.key(
            {modkey, 'Control', 'Shift'},
            '#' .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            descr_toggle_focus
        )
    )
end

return globalKeys
