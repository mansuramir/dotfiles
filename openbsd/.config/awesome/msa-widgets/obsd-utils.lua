local io = require("io")
local math = require("math")

local obsd = { }

local function run_cmd(cmd)
	local fh = io.popen(cmd)
	local ret = fh:read()
	fh:close()
	return ret
end

-- return number in % of battery level
function obsd.get_battery_level()
	return tonumber(run_cmd("apm -l"))
end

-- return boolean value whether power is connected
function obsd.is_power_connected()
	return run_cmd("sysctl hw.sensors.acpiac0.indicator0 | grep -c On") == "1"
end

-- return free memory as a string, eg "12G"
function obsd.get_free_memory()
	return run_cmd([[top -n | grep Memory | awk {'print $6'}]])
end

-- return the name of the wifi ssid we are conencted to
function obsd.get_wifi_ssid()
	return run_cmd([[ifconfig | grep join | sed -e 's/.*join\(.*\)chan.*/\1/']])
end

-- return name of the wifi device, eg "iwm0"
function obsd.get_wifi_device()
	return run_cmd([[route -n show | grep default | awk '{print $8}']])
end

-- return local IP address string for the computer
function obsd.get_local_ipaddress()
	local cmd_string = "ifconfig " .. obsd.get_wifi_device() .. " | grep inet | awk '{print $2}'"
	return run_cmd(cmd_string)
end

-- return the open internet IP address of the computer
function obsd.get_internet_ipaddress()
	return run_cmd([[dig +short myip.opendns.com @resolver1.opendns.com | awk {'printf $1'}]])
end

-- return the percentage in number for the volume level
function obsd.get_volume_level()
	return math.floor(run_cmd("sndioctl -n output.level")*100)
end

-- return in boolean value whether speaker is muted
function obsd.is_volume_mute()
	return run_cmd("sndioctl -n output.mute") == "1"
end

-- muting the volume
function obsd.set_volume_mute()
	run_cmd("sndioctl -n output.mute=1")
end

function obsd.set_volume_unmute()
	run_cmd("sndioctl -n output.mute=0")
end

-- toggle muting the speaker
function obsd.toggle_volume_mute()
	run_cmd("sndioctl output.mute=!")
end

-- increase the volume by the % given by "perc" argument in integer
function obsd.inc_volume(perc)
	local inc_level = tostring(perc/100)
	run_cmd("sndioctl -n output.level=+" .. inc_level)
end

-- decrease the volume by the % given by "perc" argument in integer
function obsd.dec_volume(perc)
	local dec_level = tostring(perc/100)
	run_cmd("sndioctl -n output.level=-" .. dec_level)
end

function obsd.set_volume_level(vol_level)
	run_cmd("sndioctl -n output.level=" .. tostring(vol_level/100))
end

function obsd.set_volume_max()
	obsd.set_volume_level(100)
end

function obsd.set_volume_zero()
	obsd.set_volume_level(0)
end

-- return the CPU temperature in degree Celcius as integer number
function obsd.get_cpu_temp()
	return tonumber(run_cmd([[sysctl hw.sensors.acpithinkpad0.temp0 | cut -d "=" -f 2 | cut -d "." -f 1]]))
end

-- return the CPU speed in MHz as an integer number
function obsd.get_cpu_speed()
	return tonumber(run_cmd([[sysctl hw.cpuspeed | cut -d "=" -f 2 | cut -d "." -f 1]]) )
end

return obsd
