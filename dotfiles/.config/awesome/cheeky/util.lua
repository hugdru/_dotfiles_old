local awful   = require("awful")
local wibox   = require("wibox")
local naughty = require("naughty")

local string = string
local client = client
local pairs  = pairs
local table  = table

module("cheeky.util")

local matcher_str = ""
local client_menu = nil

local options = {
  -- coords are handled by Awesome --
  notification_hide     = false,
  notification_text     = "No matches. Resetting.",
  notification_timeout  = 1,
  menu_theme            = { },
  show_tag              = false,
  show_screen           = false,
  quit_key              = nil,
  select_key            = nil
}

function no_case(str)
  return string.gsub(str,
                     "%a",
                     function(s)
                       return string.format("[%s%s]",
                                            string.lower(s),
                                            string.upper(s)) end)
end

function draw_menu(list)
  if client_menu then client_menu:hide() end

  client_menu = awful.menu.new({ items = list,
                                 theme = options.menu_theme })
  client_menu:item_enter(1)
  client_menu:show(options)
end

function match_clients(str)
  local low_str = no_case(str)
  local clients = {}

  for i, c in pairs(client.get()) do
    if awful.rules.match(c, { name = low_str })
      or awful.rules.match(c, { class = low_str })

    then
      local tag = c.tags(c)[1]
      local screen = c.screen
      local menu_entry = ""

      if options.show_tag then
        menu_entry = menu_entry .. "[" .. tag.name .. "] "
      end

      if options.show_screen then
        menu_entry = menu_entry .. "(" .. string.match(screen, "%d") .. ") "
      end

      menu_entry = menu_entry .. c.name
      table.insert(clients, { menu_entry, function()
                                client.focus = c
                                c:raise()
                                awful.client.jumpto(c) end,
                              c.icon }) end
  end

  return clients
end

function rerun(str)
  local client_list = match_clients(str)

  if #client_list == 0 then
    if not options.notification_hide then
      naughty.notify({ text    = options.notification_text,
                       timeout = options.notification_timeout })
    end

    close()

    rerun("")

  else
    draw_menu(match_clients(str))
    awful.keygrabber.run(grabber)

  end
end

function append_rerun(key)
  matcher_str = matcher_str .. key

  rerun(matcher_str)
end

function grabber(mod, key, event)
  local sel = client_menu.sel or 0

  if event == "release" then return end

  if key == 'Down' or key == 'Tab' then
    local sel_new = (sel + 1) > #client_menu.items and 1 or (sel + 1)
    client_menu:item_enter(sel_new)

  elseif key == 'Up' or key == 'ISO_Left_Tab' then
    local sel_new = (sel - 1) < 1 and #client_menu.items or (sel - 1)
    client_menu:item_enter(sel_new)

  elseif string.match(key, "[1-9]") then
    client_menu:exec(key + 0, { exec = true })
    close()

  elseif key == '0' then
    client_menu:exec(10, { exec = true })
    close()

  elseif sel > 0 and (key == 'Return' or key == options.select_key) then
    client_menu:exec(sel, { exec = true })
    close()

  elseif key == 'ISO_Level3_Shift'
    or key == 'Shift_L'
    or key == 'Shift_R'
    or key == 'Control_L'
    or key == 'Control_R'
    or key == 'Alt_L'
    or key == 'Super_L'
    or key == 'Super_R' then return

  elseif key == 'Escape' or key == options.quit_key then
    close()

  elseif key == "BackSpace" then
    rerun("")

  else
    append_rerun(key)

  end
end

function close()
  awful.keygrabber.stop(grabber)
  client_menu:hide()

  matcher_str = ""
end

function switcher(opts)
  if opts and (not opts.hide_notification == nil) then
    naughty.notify({ text    = "cheeky: 'hide_notification' is deprecated, use 'notification_hide'.",
                     timeout = 5 })
  end

  if client.instances() < 1 then
    naughty.notify({ text    = "No clients. Exiting.",
                     timeout = options.notification_timeout })
    return false
  end

  if opts then
    for k,v in pairs(opts) do options[k] = v end
  end

  awful.keygrabber.stop(grabber)

  draw_menu(match_clients(""))

  awful.keygrabber.run(grabber)
end
