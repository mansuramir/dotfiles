--[[

     Licensed under GNU General Public License v2
      * (c) 2013, Luca CPZ
      * (c) 2010, Adrian C. <anrxc@sysphere.org>

--]]

local helpers = require("lain.helpers")
local shell   = require("awful.util").shell
local wibox   = require("wibox")
local string  = string

-- OpenBSD volume widget
-- lain.widget.sndio

local function factory(args)
    local sndio    = { widget = wibox.widget.textbox() }
    local args     = args or {}
    local timeout  = args.timeout or 5
    local settings = args.settings or function() end

    sndio.cmd           = args.cmd or "sdioctl"
    sndio.channel       = args.channel or "output.level"
    sndio.togglechannel = args.togglechannel

    local format_cmd = string.format("%s -n %s", sndio.cmd, sndio.channel)

    --if sndio.togglechannel then
      --  format_cmd = { shell, "-c", string.format("%s get %s; %s get %s",
       -- sndio.cmd, sndio.channel, sndio.cmd, sndio.togglechannel) }
    --end

    sndio.last = {}

    function sndio.update()
        helpers.async(format_cmd, function(mixer)
            local l = string.match(mixer, "%d+")
            local math=require("math")
            l = math.floor(l*100)
            --l = 50
            if sndio.last.level ~= l  then
                volume_now = { level = l }
                widget = sndio.widget
                settings()
                sndio.last = volume_now
            end
        end)
    end

    helpers.newtimer(string.format("sndio-%s-%s", sndio.cmd, sndio.channel), timeout, sndio.update)

    return sndio 
end

return factory
