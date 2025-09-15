--[[

     Multicolor Awesome WM theme 2.0
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}

theme.color = {
  background = "#282828",
  foreground = "#d4be98",
  highlight = "#3c3836",
  black = "#3c3836",
  red = "#ea6962",
  green = "#a9b665",
  yellow = "#d8a657",
  blue = "#7daea3",
  magenta = "#d3869b",
  cyan = "#89b482",
  white = "#d4be98",
  gray = '#444444'
}

theme.confdir                                   = os.getenv("HOME") .. "/.config/awesome/themes/multicolor"
--theme.wallpaper                                 = theme.confdir .. "/wallpaper.jpg"
--theme.wallpaper                                 = os.getenv("HOME") .. "/.local/share/wallpapers/forest-clearing.jpg"
--theme.font                                      = "Noto Sans Regular 7"
theme.font					                    = "CaskaydiaCove Nerd Font 12.5"
theme.hotkeys_font                              = "CaskaydiaCove Nerd Font 12"
theme.hotkeys_description_font                  = "CaskaydiaCove Nerd Font 12"
--theme.hotkeys_bg                                = theme.color.background .. "ee"
--theme.taglist_font                              = "Noto Sans Regular 15"
theme.taglist_font 								= "Font Awesome 6 Free Solid 14"
theme.icon_font					                = "Font Awesome 6 Free"
theme.icon_size					                = dpi(14)
theme.menu_bg_normal                            = "#000000"
theme.menu_bg_focus                             = "#000000"
theme.bg_normal                                 = "#000000"
theme.bg_focus                                  = "#000000"
theme.bg_urgent                                 = "#000000"
theme.fg_normal                                 = "#aaaaaa"
theme.fg_focus                                  = "#ff8c00"
theme.fg_urgent                                 = "#af1d18"
theme.fg_minimize                               = "#ffffff"
theme.border_width                              = dpi(2)
theme.border_normal                             = "#1c2022"
--theme.border_focus                              = "#606060"
theme.border_focus                              = "#f79372"
theme.border_marked                             = "#3ca4d8"
theme.menu_border_width                         = 3 -- 0
theme.menu_height                               = dpi(25) --25 15
theme.menu_width                                = dpi(260) --260 180
theme.menu_submenu_icon                         = theme.confdir .. "/icons/submenu.png"
theme.menu_fg_normal                            = "#aaaaaa"
theme.menu_fg_focus                             = "#ff8c00"
theme.menu_bg_normal                            = "#050505dd"
theme.menu_bg_focus                             = "#050505dd"
theme.taglist_fg_occupied                       = "#a9b665"
--theme.taglist_fg_occupied                       = theme.color.magenta
theme.widget_temp                               = theme.confdir .. "/icons/temp.png"
theme.widget_mosque								      = theme.confdir .. "/icons/mosque.png"
theme.widget_uptime                             = theme.confdir .. "/icons/ac.png"
theme.widget_cpu                                = theme.confdir .. "/icons/cpu.png"
theme.widget_weather                            = theme.confdir .. "/icons/dish.png"
theme.widget_fs                                 = theme.confdir .. "/icons/fs.png"
theme.widget_mem                                = theme.confdir .. "/icons/mem.png"
theme.widget_netdown                            = theme.confdir .. "/icons/net_down.png"
theme.widget_netup                              = theme.confdir .. "/icons/net_up.png"
theme.widget_mail                               = theme.confdir .. "/icons/mail.png"
theme.widget_batt                               = theme.confdir .. "/icons/bat.png"
theme.widget_clock                              = theme.confdir .. "/icons/clock.png"
theme.widget_vol                                = theme.confdir .. "/icons/spkr.png"
theme.widget_music                              = theme.confdir .. "/icons/note.png"
theme.widget_music_on                           = theme.confdir .. "/icons/note.png"
theme.widget_music_pause                        = theme.confdir .. "/icons/pause.png"
theme.widget_music_stop                         = theme.confdir .. "/icons/stop.png"
--theme.taglist_squares_sel                       = theme.confdir .. "/icons/square_a.png"
--theme.taglist_squares_unsel                     = theme.confdir .. "/icons/square_b.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 3 
theme.layout_tile                               = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps                           = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft                           = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.confdir .. "/icons/dwindle.png"
theme.layout_max                                = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.confdir .. "/icons/floating.png"
theme.titlebar_close_button_normal              = theme.confdir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.confdir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.confdir .. "/icons/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"

local markup = lain.util.markup

local function make_icon(ic_font, ic_color, ic_char)
    return (wibox.widget {
	widget = wibox.widget.textbox,
	markup = markup.fontfg(ic_font, ic_color, ic_char) })
end


-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
--local mytextclock = wibox.widget.textclock(markup.bold(markup("#7788af", "%a, %-d %b ") .. markup("#535f7a", ">") .. markup("#de5e1e", " %-I:%M %p ")))
local mytextclock = wibox.widget.textclock(markup.bold(markup("#de5e1e", "\u{f073}  %a, %-d %b") .. markup("#de5e1e", " %-I:%M %p ")))  --f017
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = theme.font, --"CaskaydiaCove Nerd Font 7",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- Weather
--local weathericon = wibox.widget.imagebox(theme.widget_weather)
local cloudicon = wibox.widget {
	widget = wibox.widget.textbox,
	markup = markup.fontfg(theme.icon_font, "#eca4c4", "\u{f6c4} ")
}
theme.weather = lain.widget.weather({
    --city_id = 2803138, -- placeholder (Belgium)
    city_id = 1732903, -- Shah Alam
    notification_preset = { font = theme.font , fg = theme.fg_normal },
    weather_na_markup = markup.fontfg(theme.font, "#eca4c4", "N/A "),
    settings = function()
        descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(markup.fontfg(theme.font, "#eca4c4", descr .. " @ " .. units .. "°C "))
    end
})
--[[
-- / fs
--[[ commented because it needs Gio/Glib >= 2.54
local fsicon = wibox.widget.imagebox(theme.widget_fs)
theme.fs = lain.widget.fs({
    notification_preset = { font = "Noto Sans Mono Medium 10", fg = theme.fg_normal },
    settings  = function()
        widget:set_markup(markup.fontfg(theme.font, "#80d9d8", string.format("%.1f", fs_now["/"].used) .. "% "))
    end
})
-]]

-- Mail IMAP check
--[[commented because it needs to be set before use
local mailicon = wibox.widget.imagebox()
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "mbox.jaring.asia",
    mail     = "mansuramir@pd.jaring.asia",
    password = "Chioques_9@_9@",
    settings = function()
        if mailcount > 0 then
            mailicon:set_image(theme.widget_mail)
            widget:set_markup(markup.fontfg(theme.font, "#cccccc", mailcount .. " "))
        else
            widget:set_text("")
            --mailicon:set_image() -- not working in 4.0
            mailicon._private.image = nil
            mailicon:emit_signal("widget::redraw_needed")
            mailicon:emit_signal("widget::layout_changed")
        end
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#e33a6e", cpu_now.usage .. "% "))
    end
})
--]]
-- Coretemp
--[[
local tempicon = wibox.widget.imagebox(theme.widget_temp)
--[[local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#f1af5f", coretemp_now .. "°C "))
    end
})
--]]
--[[
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        --widget:set_markup(markup.fontfg(theme.font, "#f1af5f", coretemp_now .. "°C "))
        --local obsd_coretemp_now = awful.spawn.with_shell("/home/mansur/.config/awesome/scripts/obsd-coretemp.sh")
        local command = "/home/mansur/.config/awesome/scripts/obsd-coretemp.sh"
        local handle = io.popen(command)
        local obsd_coretemp_now = handle:read("*a")
        handle:close()
        naughty.notify(obsd_coretemp_now)
        widget:set_markup(markup.fontfg(theme.font, "#f1af5f", obsd_coretemp_now .. "°C "))
    end
}) --]]



--[[
-- Battery
local baticon = wibox.widget.imagebox(theme.widget_batt)
local bat = lain.widget.bat({
    settings = function()
        local perc = bat_now.perc ~= "N/A" and bat_/wibnow.perc .. "%" or bat_now.perc

        if bat_now.ac_status == 1 then
            perc = perc .. " plug"
        end

        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, perc .. " "))
    end
})
--]]
-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.sndio({
    settings = function()
        if volume_now.status == "off" then
	   volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup.fontfg(theme.font, "#7493d2", volume_now.level .. "% "))
    end
})
--[[
-- Net
local netdownicon = wibox.widget.imagebox(theme.widget_netdown)
local netdowninfo = wibox.widget.textbox()
local netupicon = wibox.widget.imagebox(theme.widget_netup)
local netupinfo = lain.widget.net({
    settings = function()
        if iface ~= "network off" and
           string.match(theme.weather.widget.text, "N/A")
        then
            theme.weather.update()
        end

        widget:set_markup(markup.fontfg(theme.font, "#e54c62", net_now.sent .. " "))
        netdowninfo:set_markup(markup.fontfg(theme.font, "#87af5f", net_now.received .. " "))
    end
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local memory = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#e0da37", mem_now.used .. "M "))
    end
})

-- MPD
local musicplr = "urxvt -title Music -g 130x34-320+16 -e ncmpcpp"
local mpdicon = wibox.widget.imagebox(theme.widget_music)
mpdicon:buttons(my_table.join(
    awful.button({ modkey }, 1, function () awful.spawn.with_shell(musicplr) end),
    --[[awful.button({ }, 1, function ()
        awful.spawn.with_shell("mpc prev")
        theme.mpd.update()
    end),
    --
    awful.button({ }, 2, function ()
        awful.spawn.with_shell("mpc toggle")
        theme.mpd.update()
    end),
    awful.button({ modkey }, 3, function () awful.spawn.with_shell("pkill ncmpcpp") end),
    awful.button({ }, 3, function ()
        awful.spawn.with_shell("mpc stop")
        theme.mpd.update()
    end)))
theme.mpd = lain.widget.mpd({
    settings = function()
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            mpdicon:set_image(theme.widget_music_on)
            widget:set_markup(markup.font(theme.font, markup("#FFFFFF", artist) .. " " .. title))
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font(theme.font, " mpd paused "))
            mpdicon:set_image(theme.widget_music_pause)
        else
            widget:set_text("")
            mpdicon:set_image(theme.widget_music)
        end
    end
})

-- spotify widget
local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")
-- local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
local volume_widget = require("awesome-wm-widgets.volume-widget.volume")
local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")

-]]

function theme.at_screen_connect(s)
    -- Quake application
   -- s.quake = lain.util.quake({ app = awful.util.terminal })
   s.quake = lain.util.quake({ app = "alacritty", height = 0.50, argname = "--name %s" })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    --s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = awful.util.taglist_buttons,
    style = {
      shape = gears.shape.rectangle
    },
    layout = {
      spacing = 5,
      spacing_widget = {
        color = '#00000000',
        shape = gears.shape.rectangle,
        widget = wibox.widget.separator
      },
      layout = wibox.layout.fixed.horizontal
    },
    widget_template = {
      {
        {
          {
            id = 'text_role',
            forced_width = 25, --20
            valign = 'center',
            halign = 'center',
            widget = wibox.widget.textbox
          },
          left = 5,
          right = 5,
          widget = wibox.container.margin
        },
        id = 'text_margin_role',
        bottom = 2,
        color = theme.fg_focus .. '00',
        widget = wibox.container.margin
      },
      id = 'background_role',
      widget = wibox.container.background,
      -- This callback is used for selected tag bottom border
      create_callback = function(comp, tag, index, tags) --luacheck: no unused args
        -- On create, index 1 has border
        if (index == 1) then
          comp:get_children_by_id('text_margin_role')[1].color = theme.fg_focus
        end

        -- On selected property change, show/hide border
        tag:connect_signal('property::selected', function(t)
          if (t.selected) then
            comp:get_children_by_id('text_margin_role')[1].color = theme.fg_focus
          else
            comp:get_children_by_id('text_margin_role')[1].color = theme.fg_focus .. '00'
          end
        end)
      end
    }
  }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    --- Create Logout Button
    local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
    --local volume_widget = require("awesome-wm-widgets.volume-widget.volume-sndio")
    
    --- MSA own widget
    local mosqueicon = wibox.widget.imagebox(theme.widget_mosque)
    local jakim_widget = require("msa-widgets.jakim-widget")
    local battery_widget = require("msa-widgets.battery")
    local separator = wibox.container.margin(wibox.widget.textbox(markup("#d4be98", " ")), 2, 2)
    local cpu_widget = require("msa-widgets.cpu")
    local cpuicon = wibox.widget {
	widget = wibox.widget.textbox,
	markup = markup.fontfg(theme.icon_font, "#ea6962", "\u{f2db} ")  --f2db
    }
		local volume_widget = require("msa-widgets.volume-obsd")

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(28), bg = theme.bg_normal .. "90", fg = theme.fg_normal })

    --  s.spotify_widget = spotify_widget
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --s.mylayoutbox,
            separator,
            s.mytaglist,
            s.mypromptbox,
        },
        
            --widgets.middle,
            --[[layout = wibox.layout.fixed.horizontal,

                spotify_widget({
                sp_bin="/home/mansur/.local/bin/sp",
                dim_when_paused = true,
                dim_opacity = 0.5,
                max_length = -1,
                show_tooltip = true,
                play_icon = "/usr/share/icons/Papirus-Light/24x24/categories/spotify.svg",
                pause_icon = "/usr/share/icons/Papirus-Light/24x24/categories/spotify-indicators.svg",
                }), --]]
                nil,
        
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            --[[spotify_widget({
                sp_bin="/home/mansur/.local/bin/sp",
                dim_when_paused = true,
                dim_opacity = 0.5,
                max_length = -1,
                show_tooltip = true,
                play_icon = "/usr/share/icons/Papirus-Light/24x24/categories/spotify.svg",
                pause_icon = "/usr/share/icons/Papiru.. "#7493D2i#s-Light/24x24/categories/spotify-indicators.svg",
            }), --]]
            --mpdicon,
            --mailicon,
            --mail.widget,
            --mpdicon,
            --theme.mpd.widget,
            --netdownicon,
            --netdowninfo,
            --netupicon,
            --netupinfo.widget,
            --volicon,
            --theme.volume.widget,
            --memicon,
            --memory.widget,
            --cpuicon,
            --cpu.widget,
            --mosqueicon,
            jakim_widget({ font = theme.font, color = "#a9b665" }),
            separator,
            cpuicon,
            cpu_widget( { font = theme.font }),
            separator,
            --jakim_widget({ font = "Noto Sans Mono Bold 7", color = "#3AAB58" }),
            --weathericon,
            cloudicon,
            theme.weather.widget,
            separator,
            --tempicon,
            --temp,
            --temp.widget,
            --baticon,
            --bat.widget,
            --batteryarc_widget({
                --show_current_level = true,
                --arc_thickness = 2,
            --}),
            --volume_widget{
            --    widget_type = 'arc',
            --},
            volume_widget( { font = theme.font }),
						seperator,
            --theme.volume.widget,
            battery_widget({ font = theme.font }),
            separator,
            --clockicon,
            mytextclock,
            logout_menu_widget{
		    onreboot=function() awful.spawn("doas reboot") end,
		    onsuspend=function() awful.spawn("zzz") end,
		    onpoweroff=function() awful.spawn("doas shutdown -p now") end
          --color = "#c0ffee"
	    },
            --volicon,
            --theme.volume.widget,

            --volume_widget({widget_type='arc'}),
	    wibox.widget.systray(),

        },
    }

    -- Create the bottom wibox
    s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, border_width = 0, height = dpi(28), bg = theme.bg_normal .. "99", fg = theme.fg_normal })

    -- Add widgets to the bottom wibox
    s.mybottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            s.mylayoutbox,
        },
    }
end

return theme
