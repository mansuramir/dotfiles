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
        gray = '#444444',
				bright_blue ='#59b9f2',
				purple = '#9933ff'
}


local volume_widget = {}
local muted = false

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
    local timeout       =  5 --args.timeout or 10
    local font          = args.font or "CaskaydiaCove Nerd Font 7"
    --local icon_font	= "Font Awesome 6 Free Solid"
    local icon_font 	= "Material-Design-Iconic-Font"
    local color         = args.color or "#ea6962" --"#89b482" --mycolor.cyan


    local widget        = args.widget == nil and wibox.layout.fixed.horizontal() or args.widget == false and nil or args.widget

    local volume_text = wibox.widget.textbox()
    volume_text.font = font
    volume_text:set_text(utf8.char(0xf028) .. " " .. obsd.get_volume_level() .. "  ")
   
    --f2db
    local function get_icon(chr, colour)
       return markup.fontfg(colour, icon_font, utf8.char(chr))
    end
		
    local function volume_update()

        local volume_level = obsd.get_volume_level()
				local vol_full_icon = utf8.char(0xf057e) -- f023  f0f3 f1f6 f0f3
				local vol_mute_icon = utf8.char(0xf0581) --(0x1f507) 0xf026 f6ad
				local vol_low_icon = utf8.char(0xf0580)  -- f027
				local vol_zero_icon = utf8.char(0xf057f)
				muted = obsd.is_volume_mute()

				local awesome_volume_mute = get_icon(0xf6a9, mycolor.purple)

				if muted then
					volume_text:set_markup(markup(mycolor.purple, vol_mute_icon .. " " .. volume_level  .. "%  "))
				else
					if tonumber(volume_level) < 50 then
						if (tonumber(volume_level) - 0) <= 5 then
							volume_text:set_markup(markup(mycolor.bright_blue, vol_zero_icon .. " " .. volume_level  .. "%  "))
						else
							volume_text:set_markup(markup(mycolor.bright_blue, vol_low_icon .. " " .. volume_level  .. "%  "))
						end
					else
						volume_text:set_markup(markup(mycolor.bright_blue, vol_full_icon .. " " .. volume_level  .. "%  "))
					end
				end
    end

    volume_update()

		function volume_widget:inc(s)
			if muted then
				obsd.set_volume_unmute()
				muted = false
			end
			obsd.inc_volume(s)
			volume_update()
		end

		function volume_widget:dec(s)
			if muted then 
				obsd.set_volume_unmute()
				muted = false
			end
			obsd.dec_volume(s)
			volume_update()
		end

		function volume_widget:toggle()
			muted = not muted--obsd.toggle_volume_mute()
			volume_update()
		end

		function volume_widget:volume_max()
			obsd.set_volume_max()
			volume_update()
		end

		function volume_widget:volume_zero()
			obsd.set_volume_zero()
			volume_update()
		end

		function volume_widget:volume_half()
			obsd.set_volume_level(50)
			volume_update()
		end

    local timer = gears.timer.start_new(timeout, function () volume_update()
      return true end )

    widgets_table["textbox"] = volume_text
    if widget then
            widget:add(volume_text)
    end

    return widget or widgets_table
end
--[[
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
end --]]

return setmetatable(volume_widget, {__call = function(_,...) return worker(...) end})
