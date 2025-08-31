local wibox         = require("wibox")
local awful         = require("awful")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local gears         = require("gears")
local lain          = require("lain")

local markup        = lain.util.markup

local theme = beautiful.get()

function dbg(message)
    naughty.notify({ preset = naughty.config.presets.normal,
                     title = "debug",
                     text = message })
end


local prayertime = {}

local function worker(args)
    local args = args or {}

    widgets_table = {}

    -- Settings
    --local ICON_DIR      = awful.util.getdir("config").."/"..module_path.."/net_widgets/icons/"
    local timeout       = args.timeout or 30
    local font          = args.font or beautiful.font

    --local popup_signal  = args.popup_signal or false
    local popup_position = args.popup_position or naughty.config.defaults.position
    local onclick       = args.onclick

    local widget        = args.widget == nil and wibox.layout.fixed.horizontal() or args.widget == false and nil or args.widget
    local subuh,syuruk,zohor,asar,maghrib,isyak  -- to save the prayer times for the popup

    local prayertime_text = wibox.widget.textbox()
    prayertime_text.font = font
    prayertime_text:set_text(" Solat Time ")


    local function prayertime_update()
        
        -- my getnextprayertime script will give today's prayer times in comma delimited format like below:
        --                  "next_prayer,subuh,syuruk,zohor,asar,maghrib,isyak"
        -- aStr:match("([^,]+),([^,]+),([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)") is used to seperate them
        
        awful.spawn.easy_async("/home/mansur/.local/bin/getnextprayertime", function(stdout, stderr, reason, exit_code)
           local aStr = stdout
           local next_prayer
           next_prayer,subuh,syuruk,zohor,asar,maghrib,isyak = aStr:match("([^,]+),([^,]+),([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)")
           --prayertime_text:set_text(next_prayer)
           prayertime_text:set_markup(next_prayer)
           
        end)
    end

    prayertime_update()
    local timer = gears.timer.start_new( timeout, function () prayertime_update()
      return true end )

    widgets_table["textbox"]	= prayertime_text
    if widget then
            widget:add(prayertime_text)
            prayertime:attach(widget,{onclick = onclick})
    end

    local function text_grabber()
        local today = os.date("%d %b %Y")
        local msg = " Solat Time: "      .. today   .."\n" ..
                    " Subuh\t   :    "   .. subuh    .. "\n" ..
                    " Syuruk\t   :    "  .. syuruk   .. "\n" ..
                    " Zohor\t   :    "   .. zohor    .. "\n" ..
                    " Asar\t   :    "    .. asar     .. "\n" ..
                    " Maghrib   :    "   .. maghrib  .. "\n" ..
                    " Isyak\t   :    "   .. isyak
        return msg
    end

    local notification = nil
    function prayertime:hide()
            if notification ~= nil then
                    naughty.destroy(notification)
                    notification = nil
            end
    end

    function prayertime:show(t_out)
            prayertime:hide()

            notification = naughty.notify({
                    preset = fs_notification_preset,
                    text = text_grabber(),
                    timeout = t_out,
            screen = mouse.screen,
            position = popup_position
            })
    end
    return widget or widgets_table
end

function prayertime:attach(widget, args)
    local args = args or {}
    local onclick = args.onclick
    -- Bind onclick event function
    if onclick then
            widget:buttons(awful.util.table.join(
            awful.button({}, 1, function() awful.util.spawn(onclick) end)
            ))
    end
    widget:connect_signal('mouse::enter', function () prayertime:show(0) end)
    widget:connect_signal('mouse::leave', function () prayertime:hide() end)
    return widget
end

return setmetatable(prayertime, {__call = function(_,...) return worker(...) end})
