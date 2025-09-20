local wibox         = require("wibox")
local awful         = require("awful")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local gears         = require("gears")
local lain          = require("lain")

local markup        = lain.util.markup

local theme = beautiful.get()

local mycolor = {
        background = "#282828",
        foreground = "#d4be98",
        highlight = "#3c3836",
        black = "#3c3836",
        red = "#ea6962",
        green = "#a9b665",
        bright_green = "#66ff00",
        yellow = "#d8a657",
        blue = "#7daea3",
        magenta = "#d3869b",
        cyan = "#89b482",
        white = "#d4be98",
        gray = '#444444'
}


local cpu_widget = {}

local function tern_op(pred, true_st, false_st)
    if pred then
        return true_st
    else
        return false_st
    end
end

local function worker(args)
    local args = args or {}
    local obsd = require("msa-widgets.obsd-utils")

    widgets_table = {}

    -- Settings
    local timeout       = args.timeout or 10
    local font          = args.font or "CaskaydiaCove Nerd Font 7"
    local icon_font	= "Font Awesome 6 Free"
    local color         = args.color or "#ea6962" --"#89b482" --mycolor.cyan


    local widget        = args.widget == nil and wibox.layout.fixed.horizontal() or args.widget == false and nil or args.widget

    local cpu_text = wibox.widget.textbox()
    cpu_text.font = font
    cpu_text:set_text("400 MHz (48°C)")
   
    --f2db
    local function get_cpu_icon()
       return markup.fontfg(color, icon_font, "\u{f023}")
    end

    local function cpu_update()

        local cpu_speed = obsd.get_cpu_speed()
        local cpu_temp = obsd.get_cpu_temp()

        cpu_text:set_markup(markup("#ea6962", cpu_speed .. "MHz (" .. cpu_temp .. "°C)"))
    end

    cpu_update()
    local timer = gears.timer.start_new( timeout, function () cpu_update()
      return true end )

    widgets_table["textbox"] = cpu_text
    if widget then
            widget:add(cpu_text)
    end

    return widget or widgets_table
end

function cpu_widget:attach(widget, args)
    local args = args or {}
    --local onclick = args.onclick
    -- Bind onclick event function
    --if onclick then
            --widget:buttons(awful.util.table.join(
            --wful.button({}, 1, function() awful.util.spawn(onclick) end)
            --))
    --end
    --widget:connect_signal('mouse::enter', function () prayertime:show(0) end)
    --widget:connect_signal('mouse::leave', function () prayertime:hide() end)
    return widget
end

return setmetatable(cpu_widget, {__call = function(_,...) return worker(...) end})
