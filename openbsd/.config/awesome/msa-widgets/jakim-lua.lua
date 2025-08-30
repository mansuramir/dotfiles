local jakim = {}

local json = require("msa-widgets.json")

local jakim_json = [[{"prayerTime":[{"hijri":"1444-03-28","date":"25-Oct-2022","day":"Tuesday","imsak":"05:39:00","fajr":"05:49:00","syuruk":"06:56:00","dhuhr":"13:00:00","asr":"16:19:00","maghrib":"18:59:00","isha":"20:10:00"},{"hijri":"1444-03-29","date":"26-Oct-2022","day":"Wednesday","imsak":"05:38:00","fajr":"05:48:00","syuruk":"06:56:00","dhuhr":"13:00:00","asr":"16:19:00","maghrib":"18:59:00","isha":"20:09:00"},{"hijri":"1444-04-01","date":"27-Oct-2022","day":"Thursday","imsak":"05:38:00","fajr":"05:48:00","syuruk":"06:56:00","dhuhr":"13:00:00","asr":"16:19:00","maghrib":"18:59:00","isha":"20:09:00"},{"hijri":"1444-04-02","date":"28-Oct-2022","day":"Friday","imsak":"05:38:00","fajr":"05:48:00","syuruk":"06:56:00","dhuhr":"13:00:00","asr":"16:19:00","maghrib":"18:59:00","isha":"20:09:00"},{"hijri":"1444-04-03","date":"29-Oct-2022","day":"Saturday","imsak":"05:38:00","fajr":"05:48:00","syuruk":"06:56:00","dhuhr":"13:00:00","asr":"16:19:00","maghrib":"18:59:00","isha":"20:09:00"},{"hijri":"1444-04-04","date":"30-Oct-2022","day":"Sunday","imsak":"05:38:00","fajr":"05:48:00","syuruk":"06:56:00","dhuhr":"13:00:00","asr":"16:19:00","maghrib":"18:59:00","isha":"20:09:00"},{"hijri":"1444-04-05","date":"31-Oct-2022","day":"Monday","imsak":"05:38:00","fajr":"05:48:00","syuruk":"06:56:00","dhuhr":"13:00:00","asr":"16:19:00","maghrib":"18:58:00","isha":"20:09:00"},{"hijri":"1444-04-06","date":"01-Nov-2022","day":"Tuesday","imsak":"05:38:00","fajr":"05:48:00","syuruk":"06:56:00","dhuhr":"13:00:00","asr":"16:20:00","maghrib":"18:58:00","isha":"20:09:00"}],"status":"OK!","serverTime":"2022-10-25 09:57:10","periodType":"week","lang":"ms_my","zone":"SGR01","bearing":"291&#176; 7&#8242; 23&#8243;"}]]
local jakim_prayer_table = {}

local function execr(cmd)
    local fh = assert(io.popen(cmd))
    local data = fh:read('*a')
    fh:close()
    return data
end

local function save_to_file(filename, data)
	local filewrite = io.open(filename, "w")
	filewrite:write(data)
	filewrite:close()
end

local function read_from_file(filename)
	local data
	local fileread = io.open(filename, "r")
	data = fileread:read()
	fileread:close()
	return data
end

local function file_exist(filename)
	local f_handle = io.open(filename,"r")
	if f_handle ~= nil then 
		io.close(f_handle) 
		return true 
	else
		return false
	end
end

local function data_current(filename)
	-- assume file exists
	local today_prayertime_table = {}
	today_prayertime_table = json.decode(read_from_file(filename)).prayerTime[1]
	date_today = os.date("%d-%b-%Y")
	
	if today_prayertime_table.date ~= date_today then 
		return false 
	else
		return true
	end
end

local function file_to_jakim_table(filename)
	local data = read_from_file(filename)
	return (json.decode(data))
end

local function get_jakim_data_online(location_code, period)
	local url = "https://www.e-solat.gov.my/index.php?r=esolatApi/TakwimSolat&zone=" .. location_code .. "&period=" .. period
	local curl_cmd = 'curl -s --show-error -X GET ' .. '"' .. url .. '"'
	return ( execr(curl_cmd) )
end

local function jakim_time_to_ampm(jakim_time)
	local ampm = "AM"
	local hour_str = string.sub(jakim_time,1,2)
	if string.sub(hour_str,1,1) == '0' then hour_str = string.sub(hour_str,2,2) end
	
	if (tonumber(hour_str)) >= 12 then
		ampm = "PM"
		hour_str = tostring(tonumber(hour_str) - 12)
	end
	
	return hour_str .. string.sub(jakim_time, 3,5) .. ampm
end

local function find_next_prayertime(jakim_prayer_table)
	-- get current time in Jakim format
	local current_time = os.date("%H:%M:00")
	local prayer_names = { "Subuh: ", "Syuruk: ", "Zohor: ", "Asar: ", "Maghrib: ", "Isyak: "}
	local t = jakim_prayer_table.prayerTime[1]
	local tmrw = jakim_prayer_table.prayerTime[2]
	local prayertimes_today = { t.fajr, t.syuruk, t.dhuhr, t.asr, t.maghrib, t.isha }
	local retStr
	
	for i = 1, 6 do
		if current_time < prayertimes_today[i] then
			retStr = prayer_names[i] .. jakim_time_to_ampm(prayertimes_today[i])
			break
		end
		if i == 6 then
			retStr =  prayer_names[1] .. jakim_time_to_ampm(tmrw.fajr)
		end
	end
	
	return retStr
end

local function today_prayertimes(jakim_prayer_table)
	t = jakim_prayer_table.prayerTime[1]
	--prayer_table_tomorrow = jakim_prayer_table.prayerTime[2]
	prayertimes = jakim_time_to_ampm(t.fajr) .. "," .. jakim_time_to_ampm(t.syuruk) .. "," .. jakim_time_to_ampm(t.dhuhr) 
		.. "," .. jakim_time_to_ampm(t.asr) .. "," .. jakim_time_to_ampm(t.maghrib) .. "," .. jakim_time_to_ampm(t.isha)
	return prayertimes
end


-- Start of Main Program
--test_table = { date = "25-Oct-2022" }
--print(check_if_data_current(test_table))
-- Get online and save Jakim json data to file
function jakim.prayertimes(jakim_location, filename) --, filename)
	local location = jakim_location or "SGR01"
	local datafile = filename or (os.getenv("HOME") .. "/.config/prayertime/jakim_data.json")
	local jakim_period = "week"

	if not (file_exist(datafile) and data_current(datafile)) then
		jakim_raw_json = get_jakim_data_online(location, jakim_period)
		save_to_file(datafile, jakim_raw_json)
	end

-- Read Jakim json data from file and use
	jakim_prayer_table = file_to_jakim_table(datafile)
	ret_string = find_next_prayertime(jakim_prayer_table) .. "," .. today_prayertimes(jakim_prayer_table)
	return ret_string
end

return jakim
