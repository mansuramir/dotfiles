-------------------------------------------------
-- Jakim Prayertime widget
-------------------------------------------------

local wibox = require("wibox")  -- Provides the widgets
local watch = require("awful.widget.watch") -- For periodic command execution
local beautiful = require("beautiful")
local theme = beautiful.get()

-- Create the text widget
local prayer_text = wibox.widget{
    font = "CaskaydiaCove Nerd Font 13",
    widget = wibox.widget.textbox,
}

-- Create the background widget
local prayer_widget = wibox.widget.background()
prayer_widget:set_widget(prayer_text)

-- Set the base colors (will be immediately replaced)
--prayer_widget:set_bg("#008800")  -- Green background
--prayer_widget:set_fg("#ffffff")  -- White text

watch(
  "/home/mansur/.local/bin/getnextprayertime", 10,
  function(_, stdout, stderr, exitreason, exitcode)

    -- Set that as text (not just the raw command)
    prayer_text:set_text(stdout)
    --widget:set_text(stdout)

    -- Set colors depending on the temperature
    [[--if (temp < 70) then
      temp_widget:set_bg("#008800")
      temp_widget:set_fg("#ffffff")
    elseif (temp < 80) then
      temp_widget:set_bg("#AB7300")
      temp_widget:set_fg("#ffffff")
      was_down = true
    else
      temp_widget:set_bg("#880000")
      temp_widget:set_fg("#ffffff")
      was_down = true
    end --]]

    -- Launch the garbage collector, this only has to be on one
    -- widget (no problem if there's more though).
    -- See: https://github.com/awesomeWM/awesome/issues/2858#issuecomment-980489840
    collectgarbage()

  end,
  prayer_widget
)

prayer_text:set_text("???")

-- Export the widget
return prayer_widget