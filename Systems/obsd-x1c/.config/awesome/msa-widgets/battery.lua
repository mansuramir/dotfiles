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


local battery = {}

local function tern_op(pred, true_st, false_st)
    if pred then
        return true_st
    else
        return false_st
    end
end

local function worker(args)
    local args = args or {}

    widgets_table = {}

    -- Settings
    local timeout       = args.timeout or 30
    local font          = args.font or "CaskaydiaCove Nerd Font 7"
    local color         = args.color or mycolor.foreground


    local widget        = args.widget == nil and wibox.layout.fixed.horizontal() or args.widget == false and nil or args.widget

    local battery_text = wibox.widget.textbox()
    battery_text.font = font
    battery_text:set_text("50%")
    
    -- f244 empty, f240 full, f242 half, f243 quarter, f241 3/4 
    local function get_battery_icon2(batt_perc, is_connected)
	local icon
        local batt = {
	        full = "\u{f240} ",
	        three_quarter = "\u{f241} ",
	        half = "\u{f242} ",
	        quarter = "\u{f243} ",
            empty = "\u{f244} "
	    }
	
	    if (batt_perc <= 5) then
            icon = batt.empty
        elseif (batt_perc > 5 and batt_perc <= 35) then
            icon = batt.quarter
        elseif (batt_perc > 35 and batt_perc <= 65) then
            icon = batt.half
        elseif (batt_perc > 65 and batt_perc <= 85) then
            icon = batt.three_quarter
        elseif (batt_perc > 85) then
            icon = batt.full
	    end

        if is_connected then
            return markup(mycolor.bright_green, icon)
        else
            return markup(mycolor.foreground, icon)
        end
    end

 local function get_battery_icon(batt_perc, is_connected)
	local icon
        local batt = {

	        full_conn = "\u{f583}",
		_90 = "\u{f581}",
		_80 = "\u{f580}",
		_70 = "\u{f57f}",
		_60 = "\u{f57e}",
		_50 = "\u{f57d}",
		_40 = "\u{f57c}",
		_30 = "\u{f57b}",
		_20 = "\u{f57a}",
		_10 = "\u{f579}",
		empty = "\u{f58d}",
		full = "\u{f578}"
	    }
	
	if (batt_perc < 5) then
            	icon = batt.empty
        elseif (batt_perc <= 20) then
            	icon = batt._10
        elseif (batt_perc <= 30) then
            	icon = batt._20
	elseif (batt_perc <= 40) then
            	icon = batt._30
        elseif (batt_perc <= 50) then
            	icon = batt._40
	elseif (batt_perc <= 60) then
            	icon = batt._50
        elseif (batt_perc <= 70) then
            	icon = batt._60
	elseif (batt_perc <= 80) then
            	icon = batt._70
        elseif (batt_perc <= 90) then
            	icon = batt._80
        elseif (batt_perc <= 98) then
            	icon = batt._90
	elseif batt_perc > 98 then
	    if is_connected then
		icon = batt.full_conn
	    else
		icon = batt.full
	    end
	end

        if is_connected then
            return markup(mycolor.bright_green, icon)
        else
            return markup(mycolor.foreground, icon)
	end
    end


    local function is_charging()
        local f = io.popen("apm -a")
        local power_status = f:read()
        f:close()
        return power_status == "1"
    end

    local function get_batt_perc()
        local f = io.popen("apm -l")
        local batt_perc = f:read()
        f:close()
        return tonumber(batt_perc)
    end


    local function battery_update()

        local battery_perc = get_batt_perc()
        local power_connected = is_charging()
	local myfg = mycolor.foreground
	if power_connected then
	   myfg = mycolor.bright_green
	end
	
        battery_text:set_markup(get_battery_icon2(battery_perc, power_connected) .. " " .. markup(myfg, battery_perc .. "% "))
    end

    battery_update()
    local timer = gears.timer.start_new( timeout, function () battery_update()
      return true end )

    widgets_table["textbox"] = battery_text
    if widget then
            widget:add(battery_text)
            --prayertime:attach(widget,{onclick = onclick})
    end

    return widget or widgets_table
end

function battery:attach(widget, args)
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

return setmetatable(battery, {__call = function(_,...) return worker(...) end})
