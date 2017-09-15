-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- {{{ External Plugins
-- https://github.com/svexican/cheeky
local cheeky = require("cheeky")
-- https://awesomewm.org/recipes/xrandr/
local xrandr = require("xrandr")
-- }}}

-- {{{ cheeky
function launch_cheeky()
  local workarea = screen[mouse.screen].workarea

  local cheeky_menu = { width = 400, height = 45 }

  local cheeky_options = {
    show_tag = false,             -- default: false
    show_screen = false,          -- default: false
    quit_key = '/',              -- default: nil (and Escape)
    coords = {
      x = (workarea.width - cheeky_menu.width) / 2,
      y = 0
    },
    menu_theme = {
      height = cheeky_menu.height,
      width = cheeky_menu.width
    }
  }

  if client.focus then
    offset = screen[client.focus.screen].workarea
  end

  cheeky.util.switcher(cheeky_options)
end
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey = "Mod4"
local altkey = "Mod1"
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(awful.util.get_themes_dir() .. "default/theme.lua")
beautiful.init(awful.util.getdir("config") .. "/themes/awesome-solarized/dark/theme.lua")
local autostartFilepath = os.getenv("HOME") .. "/.autostart"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.max,
    awful.layout.suit.tile,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.floating,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- -- awful.layout.suit.corner.ne,
    -- -- awful.layout.suit.corner.sw,
    -- -- awful.layout.suit.corner.se,
}

-- Define a tag table which hold all screen tags.
tags = {
    names = { "web", "dev", "doc", "chat", "news", "notes", "sys", "misc" },
    layouts = { awful.layout.layouts[1], awful.layout.layouts[1], awful.layout.layouts[1], awful.layout.layouts[1], awful.layout.layouts[1], awful.layout.layouts[1], awful.layout.layouts[2], awful.layout.layouts[1] },
}

-- This is used later as the default terminal and editor to run.
local terminal = "urxvt"
local secureTerminal = terminal .. ' -pe "-default,-keyboard-select,-url-select"'
local runCmd = terminal .. " -e "
local editor = os.getenv("EDITOR") or "nano"
local editor_cmd = terminal .. " -e " .. editor

programs = {
  systemTerminal = {
      name = terminal .. " -name systerm",
      windowProperties = { instance = "systerm" },
      rulesProperties = { tag = "sys", switchtotag = true},
      keybinding = { extraModKey = "Shift", key = "Return" }
  },
  bookLibrary = {
      name = "calibre",
      windowProperties = { class = "calibre" },
      rulesProperties = { tag = "doc", switchtotag = true },
      keybinding = { key = "q" },
      isRunOrRaise = true
  },
  qbittorrent = {
      name = "qbittorrent",
      windowProperties = { class = "qBittorrent" },
      rulesProperties = { tag = "misc", switchtotag = true },
      keybinding = { extraModKey = "Shift", key = "q" },
      isRunOrRaise = true
  },
  torrent = {
      name = terminal .. " -name rtorrent -e rtorrent",
      windowProperties = { instance = "rtorrent" },
      rulesProperties = { tag = "misc", switchtotag = true }
  },
  editorAtom = {
      name = "atom",
      windowProperties = { class = "Atom" },
      rulesProperties = { tag = "dev", switchtotag = true },
  },
  editorIdea = {
      name = "idea",
      windowProperties = { class = {"jetbrains-idea-ce", "jetbrains-idea", "jetbrains-webstorm", "jetbrains-studio", "jetbrains-pycharm", "jetbrains-clion" } },
      ruleType = "rule_any",
      rulesProperties = { tag = "dev" },
      keybinding = { key = "e" },
      isRunOrRaise = true
  },
  editorSlack = {
      name = "slack",
      windowProperties = { class = "Slack" },
      rulesProperties = { tag = "chat", switchtotag = true },
      keybinding = { extraModKey = "Shift", key = "e" },
      isRunOrRaise = true
  },
  editorMonodevelop = {
      name = "MonoDevelop",
      windowProperties = { class = "MonoDevelop" },
      rulesProperties = { tag = "dev" },
  },
  editorPapyrus = {
      name = "Papyrus",
      windowProperties = { class = "Papyrus" },
      rulesProperties = { tag = "dev" },
  },
  -- editorEclipse = {
  --     name = "eclipse",
  --     windowProperties = { class = {"Eclipse"}, instance = {"Eclipse"} },
  --     ruleType = "rule_any",
  --     rulesProperties = { tag = "dev" },
  --     keybinding = { extraModKey = "Shift", key = "e" },
  --     isRunOrRaise = true
  -- },
  -- editorVim = {
  --     name = terminal .. " -name codeEditor -e " .. editor,
  --     windowProperties = { instance = "codeEditor" },
  --     rulesProperties = { tag = "dev", switchtotag = true },
  --     keybinding = { extraModKey = "Ctrl", key = "e" },
  --     isRunOrRaise = true
  -- },
  notesZim = {
      name = "zim",
      windowProperties = { class = {"Zim"}, instance = {"zim"} },
      ruleType = "rule_any",
      rulesProperties = { tag = "notes" },
      keybinding = { key = "w" },
      isRunOrRaise = true
  },
  keepassx = {
      name = "keepassxc",
      windowProperties = { class = {"Keepassxc"}, instance = {"keepassxc"} },
      ruleType = "rule_any",
      rulesProperties = { tag = "misc", switchtotag = true },
      keybinding = { extraModKey = "Shift", key = "w" },
      isRunOrRaise = true
  },
  fileManager = {
      name = terminal .. " -name vifm -e vifm",
      windowProperties = { instance = "vifm" },
      keybinding = { key = "v" }
  },
  fileManagerGui = {
      name = "pcmanfm",
      keybinding = { key = "a" }
  },
  radio = {
      name = "gradio",
      windowProperties = { class = "Gradio" },
      rulesProperties = { tag = "news", switchtotag = true },
      keybinding = { extraModKey = "Shift", key = "a" },
      isRunOrRaise = true
  },
  -- music = {
  --     name = terminal .. " -name ncmpcpp -e ncmpcpp",
  --     windowProperties = { instance = "ncmpcpp" },
  --     rulesProperties = { tag = "misc", switchtotag = true },
  --     keybinding = { extraModKey = "Shift", key = "a" },
  --     isRunOrRaise = true
  -- },
  -- video = {
  --     name = "vlc",
  --     windowProperties = { class = "Vlc" },
  --     -- rulesProperties = { tag = "misc", switchtotag = true },
  --     keybinding = { extraModKey = "Control", key = "a" },
  --     isRunOrRaise = true
  -- },
  video = {
      name = "vlc",
      windowProperties = { class = "smplayer" },
      -- rulesProperties = { tag = "misc", switchtotag = true },
      keybinding = { extraModKey = "Control", key = "a" },
      isRunOrRaise = true
  },
  browserChromium = {
      name = "chromium",
      windowProperties = { class = {"chromium", "Chromium"} },
      ruleType = "rule_any",
      rulesProperties = { tag = "web", switchtotag = true },
      keybinding = { key = "s" },
      isRunOrRaise = true
  },
  emailMutt = {
      name = secureTerminal .. " -name mutt -e mutt",
      windowProperties = { instance = "mutt" },
      rulesProperties = { tag = "news", switchtotag = true }
  },
  emailThunderbird = {
      name = "thunderbird",
      windowProperties = { name = {"Mail"}, class = {"Thunderbird"} },
      --rulesProperties = { tag = "news", switchtotag = true },
      rulesProperties = { tag = "news" },
      ruleType = "rule_any",
      keybinding = { extraModKey = "Shift", key = "s" },
      isRunOrRaise = true
  },
  -- rss = {
  --     name = secureTerminal .. " -name newsbeuter -e newsbeuter",
  --     windowProperties = { instance = "newsbeuter" },
  --     rulesProperties = { tag = "news", switchtotag = true },
  --     keybinding = { extraModKey = "Control", key = "s" },
  --     isRunOrRaise = true
  -- },
  browserGoogle = {
      name = "google-chrome-stable",
      windowProperties = { class = {"google-chrome", "Google-chrome"} },
      rulesProperties = { tag = "web", switchtotag = true },
      keybinding = { extraModKey = "Control", key = "s" },
      ruleType = "rule_any",
      isRunOrRaise = true
  },
  irc = {
      name = secureTerminal .. " -name weechat -e weechat",
      windowProperties = {instance = "weechat"},
      rulesProperties = { tag = "chat", switchtotag = true },
      keybinding = { key = "d" },
      isRunOrRaise = true
  },
  voipQtox = {
      name = "qtox",
      windowProperties = { class = {"qTox"}, instace = {"qtox"} },
      rulesProperties = { tag = "chat" },
      keybinding = { extraModKey = "Shift", key = "d" },
      ruleType = "rule_any",
      isRunOrRaise = true
  },
  voipJitsi = {
      name = "jitsi",
      windowProperties = { name = {"Jitsi"}, class = {"Jitsi"} },
      rulesProperties = { tag = "chat", switchtotag = true },
      ruleType = "rule_any",
      keybinding = { extraModKey = "Control", key = "d" },
      isRunOrRaise = true
  },
  sound = {
      name = terminal .. " -name alsamixer -e alsamixer",
      windowProperties = { instance = "alsamixer" },
      rulesProperties = { tag = "misc", switchtotag = true },
      keybinding = { extraModKey = "Shift", key = "x" },
      isRunOrRaise = true
  },
  calculator = {
      name = "speedcrunch",
      windowProperties = { class = "Speedcrunch" },
      keybinding = { key = "c" },
      isRunOrRaise = true
  },
  suspend = {
    name = "systemctl suspend",
    keybinding = { extraModKey = "Control", key = "c" }
  }
}

-- }}}

-- {{{
-- https://superuser.com/questions/790732/how-to-manualy-spawn-a-client-in-a-specific-tag-in-awesome
function spawn_with_shell_and_rules(command, target, tag, matchRule)
  local callback
  callback = function(c)
    if c[matchRule] == target then
        awful.client.movetotag(tag, c)
        client.disconnect_signal("manage", callback)
    end
  end
  client.connect_signal("manage", callback)
  awful.spawn.with_shell(command)
end


fh, err = io.open(autostartFilepath)
if (fh ~= nill) then
    while true do
        local programLine = fh:read()
        if (programLine == nil) then break end
        if (programLine:sub(1,1) ~= "#") then
            local _, _, programName, arguments, rules = string.find(programLine, "^%s*([^%s]*)([^#]*)#?%s*([^%s]*)%s*$")
            if (programName ~= nil) then
                local fullCommand = programName .. arguments
                local shellCommand = "pgrep -u $USER -x \".*(..|.)?" .. programName .. "(-wrapp(ed)?)?.*\" || (" .. fullCommand .. ")"
                if (rules ~= nil and rules ~= '') then
                  local startIndex, endIndex, target, tagName, matchrule = string.find(rules, "^([^%s]+),([^%s]+),([^%s]+)$")
                  if (startIndex ~= nil) then
                    spawn_with_shell_and_rules(shellCommand, target, tagName, matchrule)
                  end
                else
                    awful.spawn.with_shell(shellCommand)
                end
            end
        end
    end
end
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag(tags.names, s, tags.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Keybindings
globalkeys = awful.util.table.join(
    -- {{{ Plugins
    awful.key({ modkey,           }, "/", launch_cheeky,
              {description = "cheeky", group = "plugins"}),
    awful.key({ modkey,           }, "=", function() xrandr.xrandr() end,
              {description = "xrandr", group = "plugins"}),
    -- }}}

    awful.key({ modkey,           }, "`",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    awful.key({ modkey,           }, "backslash", awful.tag.history.restore,
              {description = "go back", group = "tag"}
    ),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ altkey,           }, "Tab",
        function ()
          awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ altkey, "Shift"   }, "Tab",
        function ()
          awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "g", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    awful.key({ modkey }, "b",
      function ()
        mouse.screen.mywibox.visible = not mouse.screen.mywibox.visible
      end, {description = "hide mywibox", group = "screen"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Control"   }, "z", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),
    awful.key({ modkey, "Control" }, "n",
              function ()
                for _, tag in ipairs(awful.screen.focused().selected_tags) do
                  for _, client in ipairs(tag:clients()) do
                    client.minimized = false
                  end
                end
              end,
              {description = "restored all minimized", group = "tag"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

-- Add my Program keys
function callFactory(isRunOrRaise, name, windowProperties, is_rule_any)
  if (isRunOrRaise) then
    return function()
      local matcher = function (client)
        if (is_rule_any) then
          return awful.rules.match_any(client, windowProperties)
        else
          return awful.rules.match(client, windowProperties)
        end
      end
      awful.client.run_or_raise(name, matcher)
    end
  else
    return function()
      awful.util.spawn(name)
    end
  end
end
for _, program in pairs(programs) do
  if (program.keybinding) then
    globalkeys = awful.util.table.join(globalkeys, awful.key({modkey, program.keybinding.extraModKey}, program.keybinding.key, callFactory(program.isRunOrRaise, program.name, program.windowProperties, program.ruleType == "rule_any")))
  end
end

clientkeys = awful.util.table.join(
    awful.key({ modkey, "Shift"   }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "f",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen,
            -- placement = awful.placement.under_mouse+awful.placement.no_overlap+awful.placement.no_offscreen,
            size_hints_honor = false,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons
        }
    },
    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},
}
-- Add my Program rules
for _, program in pairs(programs) do
  if (program.windowProperties and program.rulesProperties) then
    local ruleType = program["ruleType"];
    if (ruleType) then
      local tempTable
      tempTable = {}
      tempTable[ruleType] = program.windowProperties
      tempTable.properties = program.rulesProperties
      table.insert(awful.rules.rules, tempTable)
    else
      table.insert(awful.rules.rules, {rule = program.windowProperties, properties = program.rulesProperties})
    end
  end
end
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    awful.client.movetoscreen(c, mouse.screen)
    -- awful.client.movetoscreen(c, client.focus.screen)

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
