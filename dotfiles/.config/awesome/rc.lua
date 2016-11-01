-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
awful.autofocus = require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local revelation = require("revelation")
local cheeky = require("cheeky")
local lain = require("lain")

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
                         text = err })
        in_error = false
    end)
end
-- }}}

-- Themes define colours, icons, font and wallpapers.
beautiful.init(awful.util.getdir("config") .. "/themes/awesome-solarized/dark/theme.lua")
revelation.init({charorder = "asdfjkl;huiopynmtgvcewqzx1234567890"})

autostartFilepath = os.getenv("HOME") .. "/.autostart"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    --awful.layout.suit.floating,
    awful.layout.suit.max,
    awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.tile.bottom,
    --awful.layout.suit.magnifier
}

-- Define a tag table which hold all screen tags.
tags = {
    names = { "web", "doc", "dev", "chat", "news", "notes", "sys", "misc" },
    layout = { layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[2], layouts[1] },
}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layout)
end

byTagName = {}
for index, tagName in ipairs(tags.names) do
  byTagName[tagName] = index
end

-- https://superuser.com/questions/790732/how-to-manualy-spawn-a-client-in-a-specific-tag-in-awesome
function spawn(command, target, tag, matchRule)
  local matchRule = matchRule or "class"
  local callback
  callback = function(c)
      if matchRule == "class" then
          if c.class == target then
              awful.client.movetotag(tag, c)
              client.disconnect_signal("manage", callback)
          end
      elseif matchRule == "instance" then
          if c.instance == target then
              awful.client.movetotag(tag, c)
              client.disconnect_signal("manage", callback)
          end
      elseif matchRule == "name" then
            if string.match(c.name, target) then
                awful.client.movetotag(tag, c)
              client.disconnect_signal("manage", callback)
            end
      end
  end
  client.connect_signal("manage", callback)
  awful.util.spawn_with_shell(command)
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
                    if (tags[1][byTagName[tagName]] ~= nil) then
                      spawn(shellCommand, target, tags[1][byTagName[tagName]], matchrule)
                    end
                  end
                else
                    awful.util.spawn_with_shell(shellCommand)
                end
            end
        end
    end
end


-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
secureTerminal = terminal .. ' -pe "-default,-keyboard-select,-url-select"'
runCmd = terminal .. " -e "
getEditor = os.getenv("EDITOR") or "nano"

programs = {
  systemTerminal = {
      name = terminal .. " -name systerm",
      windowProperties = { instance = "systerm" },
      rulesProperties = { tag = tags[1][byTagName.sys], switchtotag = true},
      keybinding = { extraModKey = "Shift", key = "Return" }
  },
  bookLibrary = {
      name = "calibre",
      windowProperties = { class = "calibre" },
      rulesProperties = { tag = tags[1][byTagName.doc], switchtotag = true },
      keybinding = { key = "q" },
      isRunOrRaise = true
  },
  qbittorrent = {
      name = "qbittorrent",
      windowProperties = { class = "qBittorrent" },
      rulesProperties = { tag = tags[1][byTagName.misc], switchtotag = true },
      keybinding = { extraModKey = "Shift", key = "q" },
      isRunOrRaise = true
  },
  torrent = {
      name = terminal .. " -name rtorrent -e rtorrent",
      windowProperties = { instance = "rtorrent" },
      rulesProperties = { tag = tags[1][byTagName.misc], switchtotag = true }
  },
  editorAtom = {
      name = "atom",
      windowProperties = { class = "Atom" },
      rulesProperties = { tag = tags[1][byTagName.dev], switchtotag = true },
  },
  editorIdea = {
      name = "idea",
      windowProperties = { class = {"jetbrains-idea-ce", "jetbrains-idea"} },
      ruleType = "rule_any",
      rulesProperties = { tag = tags[1][byTagName.dev] },
      keybinding = { key = "e" },
      isRunOrRaise = true
  },
  editorEclipse = {
      name = "eclipse",
      windowProperties = { class = {"Eclipse"}, instance = {"Eclipse"} },
      ruleType = "rule_any",
      rulesProperties = { tag = tags[1][byTagName.dev] },
      keybinding = { extraModKey = "Shift", key = "e" },
      isRunOrRaise = true
  },
  editorVim = {
      name = terminal .. " -name codeEditor -e " .. getEditor,
      windowProperties = { instance = "codeEditor" },
      rulesProperties = { tag = tags[1][byTagName.dev], switchtotag = true },
      keybinding = { extraModKey = "Ctrl", key = "e" },
      isRunOrRaise = true
  },
  notesZim = {
      name = "zim",
      windowProperties = { class = {"Zim"}, instance = {"zim"} },
      ruleType = "rule_any",
      rulesProperties = { tag = tags[1][byTagName.notes] },
      keybinding = { key = "w" },
      isRunOrRaise = true
  },
  keepassx = {
      name = "keepassx2",
      windowProperties = { class = {"Keepassx2"}, instance = {"keepassx2"} },
      ruleType = "rule_any",
      rulesProperties = { tag = tags[1][byTagName.misc], switchtotag = true },
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
      rulesProperties = { tag = tags[1][byTagName.news], switchtotag = true },
      keybinding = { extraModKey = "Shift", key = "a" },
      isRunOrRaise = true
  },
  -- music = {
  --     name = terminal .. " -name ncmpcpp -e ncmpcpp",
  --     windowProperties = { instance = "ncmpcpp" },
  --     rulesProperties = { tag = tags[1][byTagName.misc], switchtotag = true },
  --     keybinding = { extraModKey = "Shift", key = "a" },
  --     isRunOrRaise = true
  -- },
  video = {
      name = "vlc",
      windowProperties = { class = "Vlc" },
      -- rulesProperties = { tag = tags[1][byTagName.misc], switchtotag = true },
      keybinding = { extraModKey = "Control", key = "a" },
      isRunOrRaise = true
  },
  browserChromium = {
      name = "chromium",
      windowProperties = { class = {"chromium", "Chromium"} },
      ruleType = "rule_any",
      rulesProperties = { tag = tags[1][byTagName.web], switchtotag = true },
      keybinding = { key = "s" },
      isRunOrRaise = true
  },
  emailMutt = {
      name = secureTerminal .. " -name mutt -e mutt",
      windowProperties = { instance = "mutt" },
      rulesProperties = { tag = tags[1][byTagName.news], switchtotag = true }
  },
  emailThunderbird = {
      name = "thunderbird",
      windowProperties = { name = {"Mail"}, class = {"Thunderbird"} },
      --rulesProperties = { tag = tags[1][byTagName.news], switchtotag = true },
      rulesProperties = { tag = tags[1][byTagName.news] },
      ruleType = "rule_any",
      keybinding = { extraModKey = "Shift", key = "s" },
      isRunOrRaise = true
  },
  -- rss = {
  --     name = secureTerminal .. " -name newsbeuter -e newsbeuter",
  --     windowProperties = { instance = "newsbeuter" },
  --     rulesProperties = { tag = tags[1][byTagName.news], switchtotag = true },
  --     keybinding = { extraModKey = "Control", key = "s" },
  --     isRunOrRaise = true
  -- },
  browserGoogle = {
      name = "google-chrome-stable",
      windowProperties = { class = "google-chrome" },
      rulesProperties = { tag = tags[1][byTagName.web], switchtotag = true },
      keybinding = { extraModKey = "Control", key = "s" },
      isRunOrRaise = true
  },
  irc = {
      name = secureTerminal .. " -name weechat -e weechat",
      windowProperties = {instance = "weechat"},
      rulesProperties = { tag = tags[1][byTagName.chat], switchtotag = true },
      keybinding = { key = "d" },
      isRunOrRaise = true
  },
  voipQtox = {
      name = "qtox",
      windowProperties = { class = {"qTox"}, instace = {"qtox"} },
      rulesProperties = { tag = tags[1][byTagName.chat] },
      keybinding = { extraModKey = "Shift", key = "d" },
      ruleType = "rule_any",
      isRunOrRaise = true
  },
  voipJitsi = {
      name = "jitsi",
      windowProperties = { name = {"Jitsi"}, class = {"Jitsi"} },
      rulesProperties = { tag = tags[1][byTagName.chat], switchtotag = true },
      ruleType = "rule_any",
      keybinding = { extraModKey = "Control", key = "d" },
      isRunOrRaise = true
  },
  sound = {
      name = terminal .. " -name alsamixer -e alsamixer",
      windowProperties = { instance = "alsamixer" },
      rulesProperties = { tag = tags[1][byTagName.misc], switchtotag = true },
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

configd = os.getenv("HOME") .. "/.config/awesome/"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "restart", awesome.restart },
   { "quit", awesome.quit }
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

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
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
    awful.key({ modkey,           }, "backslash", awful.tag.history.restore),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "g", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "i", revelation),
    awful.key({ modkey,           }, "/", launch_cheeky),

    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
    awful.key({ "Mod1",           }, "Tab",
        function ()
          awful.client.focus.byidx(1)
          if client.focus then
            client.focus:raise()
          end
        end),
    awful.key({ "Mod1", "Shift"   }, "Tab",
      function ()
        awful.client.focus.byidx(-1)
        if client.focus then
          client.focus:raise()
        end
      end),
    awful.key({ modkey }, "b",
      function ()
        mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
      end),

    -- Standard program

    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Control" }, "z", awesome.quit),

    awful.key({ modkey,           }, "l",      function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",      function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",      function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",      function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",      function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",      function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space",  function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space",  function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",      function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
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
    awful.key({ modkey, "Shift"   }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,          }, "f",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
            if client.focus then
              client.focus:raise()
            end
        end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
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
            size_hints_honor = false,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons
        }
    },
-- NOT PINNING TO TAGS
    {
        rule = { class = "MPlayer" },
        properties = { floating = true }
    },
    {
        rule = { class = "pinentry" },
        properties = { floating = true }
    },
    {
        rule = { class = "gimp" },
        properties = { floating = true }
    },
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
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
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

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
