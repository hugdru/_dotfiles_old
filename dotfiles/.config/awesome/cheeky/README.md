# cheeky

A cheeky window switcher for Awesome WM

## Description

It pops up a menu with all your clients. As you type, it
case-insensitively filters the clients that match with the
name or class. Scroll through the list of clients with Down/Up
or Tab/Shift-Tab. Press Enter to switch to the selected client.

It's cheeky. If no clients match your filter, it resets to the complete list
of clients... and it tells you about it.

It was inspired by the oh-so-great:

- https://github.com/seanpringle/xowl
- https://github.com/seanpringle/simpleswitcher

## Installation


Clone this repository into your Awesome configuration directory:

```
  git clone https://github.com/svexican/cheeky ~/.config/awesome
```

## Usage

Include the module in your `rc.lua` file:

```lua
  require("cheeky")
```

and assign a shortcut in your `root.keys` table. For example:

```lua
  modkey = "Mod4"

  root.keys(awful.util.table.join(
    -- lots of your shortcuts

      awful.key({ modkey }, "/", function() cheeky.util.switcher() end),

    -- lots of more shortcuts
  ))
```

#### Setting the coordinates

You can set the coordinates at which you want the menu to appear like so

```lua
awful.key({ modkey }, "/", function()
  cheeky.util.switcher({ coords = { x = 200, y = 200 } })
end),
```

**TIP:** If you'd like the menu to appear on the screen with the
currently focused client:

```lua
function launch_cheeky()
  local offset = { x = 0, y = 0 }

  if client.focus then
    offset = screen[client.focus.screen].workarea
  end

  cheeky.util.switcher({ coords = { x = offset.x + 200,
                                    y = offset.y + 200 } })
end

...

awful.key({ modkey }, "/", launch_cheeky)
```

#### Other options

The full table you can pass to the `switcher` function:

```lua
{
  notification_hide = true,    -- default: false
  notification_text = "NOPE",  -- default: "No matches. Resetting"
  notification_timeout = 5,    -- default: 1
  show_tag = true,             -- default: false
  show_screen = true,          -- default: false
  quit_key = '\',           --'-- default: nil (and Escape)
  select_key = '`',            -- default: nil (and Enter)
  coords = {
    x = 300,
    y = 100
  },                           -- default: the mouse's coordinates (see above example)
  menu_theme = {
    height = 20,
    width = 400
  },                           -- default: { }, see https://awesomewm.org/doc/api/modules/awful.menu.html#new
}
```

Type away!

## TODO

- Reduce the flickering (it's not too bad)
