-------------------------------------------------
-- The Ultimate Volume Widget for Awesome Window Manager
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/volume-widget

-- @author Pavel Makhov
-- @copyright 2020 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local spawn = require("awful.spawn")
local gears = require("gears")
local beautiful = require("beautiful")
local watch = require("awful.widget.watch")
local utils = require("awesome-wm-widgets.volume-widget.utils")


--local LIST_DEVICES_CMD = [[sh -c "pacmd list-sinks; pacmd list-sources"]]
local muted = false
local function GET_VOLUME_CMD() return 'sndioctl -n output.level' end
local function INC_VOLUME_CMD(step) return 'sndioctl -n output.level=+0.05' end
local function DEC_VOLUME_CMD(step) return 'sndioctl -n output.level=-0.05' end
local function TOG_VOLUME_CMD() 
    --muted = not muted
    return 'sndioctl -n output.mute=!' 
end


local widget_types = {
    icon_and_text = require("awesome-wm-widgets.volume-widget.widgets.icon-and-text-widget"),
    --icon = require("awesome-wm-widgets.volume-widget.widgets.icon-widget"),
    --arc = require("awesome-wm-widgets.volume-widget.widgets.arc-widget"),
    --horizontal_bar = require("awesome-wm-widgets.volume-widget.widgets.horizontal-bar-widget"),
    --vertical_bar = require("awesome-wm-widgets.volume-widget.widgets.vertical-bar-widget")
}
local volume = {}

local function worker(user_args)

    local args = user_args or {}

    local mixer_cmd = args.mixer_cmd or 'pavucontrol'
    local widget_type = args.widget_type
    local refresh_rate = args.refresh_rate or 1
    local step = args.step or 0.05
    local device = args.device or 'pulse'

    if widget_types[widget_type] == nil then
        volume.widget = widget_types['icon_and_text'].get_widget(args.icon_and_text_args)
    else
        volume.widget = widget_types[widget_type].get_widget(args)
    end


    local function is_line_muted()
        spawn.easy_async("sndioctl -n output.mute", function(stdout)
            muted = stdout == "1"
            return muted
        end)
    end


    local function update_graphic(widget, stdout)
         --string.match(stdout, "%[(o%D%D?)%]")   -- \[(o\D\D?)\] - [on] or [off]
        if awful.spawn("sndioctl -n output.mute") == "1" then widget:mute()
	else widget:unmute()
	end
        
	--local volume_level = string.match(stdout, "%d") -- (\d?\d?\d)\%)
        local volume_level = tonumber(stdout)*100
        volume_level = string.format("% 3d", volume_level)
        widget:set_volume_level(volume_level)
    end

    function volume:inc(s)
        spawn.easy_async(INC_VOLUME_CMD(s or step), function(stdout) update_graphic(volume.widget, stdout) end)
    end

    function volume:dec(s)
        spawn.easy_async(DEC_VOLUME_CMD(s or step), function(stdout) update_graphic(volume.widget, stdout) end)
    end

    function volume:mute_pressed()
        if is_muted_button_red() then
            --
            muted = true
        else
            --
            muted = false
        end

        spawn.easy_async("sndioctl -n output.level", function(stdout)
            update_graphic(volume.widget, stdout) end)
    end

    function volume:toggle()
        --[[if muted then
            awful.spawn("doas sysctl dev.ibm_acpi.0.mute=0")
            muted = false
        else
            awful.spawn("doas sysctl dev.ibm_acpi.0.mute=1")
            muted = true
         --]]

        spawn.easy_async("sndioctl -n output.mute=!", function(stdout)
            update_graphic(volume.widget, stdout) end)
        
        --[[if muted then
            --spawn.easy_async("doas sysctl -n dev.acpi_ibm.0.mute=0", 
            function(stdout)
                update_graphic(volume.widget, stdout)
            end)
        else
            --spawn.easy_async("doas sysctl -n dev.acpi_ibm.0.mute=1", 
            function(stdout)
                update_graphic(volume.widget, stdout)
            end)
        end -]]


    end
        --if is_muted_button_red() then
            
            --awful.spawn("doas sysctl -n dev.acpi_ibm.0.mute=0")
        --else
            --awful.spawn("doas sysctl -n dev.acpi_ibm.0.mute=1")
        --end
        --spawn.easy_async(TOG_VOLUME_CMD(), 
            --function(stdout)
                --update_graphic(volume.widget, stdout)
            --end)
    --end

    --[[function volume:mixer()
        if mixer_cmd then
            spawn.easy_async(mixer_cmd)
        end
    end --]]

    volume.widget:buttons(
            awful.util.table.join(
                    --[[awful.button({}, 3, function()
                        if popup.visible then
                            popup.visible = not popup.visible
                        else
                            rebuild_popup()
                            popup:move_next_to(mouse.current_widget_geometry)
                        end
                    end),--]]
                    awful.button({}, 4, function() volume:inc() end),
                    awful.button({}, 5, function() volume:dec() end)
                    --awful.button({}, 2, function() volume:mixer() end),
                    --[[awful.button({}, 1, function() 
                    if not muted then
                            awful.spawn("doas sysctl dev.acpi_ibm.0.mute=1")
                            muted = true
                        else
                            awful.spawn("doas sysctl dev.acpi_ibm.0.mute=0")
                            muted = false
                        end
                        volume:toggle()
                        muted = not muted
                    end) --]]
            )
    )

    watch(GET_VOLUME_CMD(), refresh_rate, update_graphic, volume.widget)

    return volume.widget
end

return setmetatable(volume, { __call = function(_, ...) return worker(...) end })
