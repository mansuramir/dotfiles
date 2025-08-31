package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"time"
	"encoding/json"
	"strconv"
	"strings"
	"errors"
)

const fileName = "/home/mansur/.config/prayertime/jakim_json.txt"

type JakimResponse struct {
    Zone    string    `json:"zone"`
    Period	string	  `json:"periodType"`
    Bearing	string	  `json:"bearing"`
    PrayerTable []DailyPrayerTime `json:"prayerTime"`
}

type DailyPrayerTime struct {
    Date string     `json:"date"`
    Syuruk string   `json:"syuruk"`
    Subuh string	`json:"fajr"`
    Zohor string	`json:"dhuhr"`
    Asar string		`json:"asr"`
    Maghrib string	`json:"maghrib"`
    Isyak string	`json:"isha"`
}

func GetJakimPrayerTime(period string) []byte {
	
	var httpClient = &http.Client{
		Timeout: time.Second * 10,
	}

	response, err := httpClient.Get("https://www.e-solat.gov.my/index.php?r=esolatApi/TakwimSolat&zone=SGR01&period="+period)
	if err != nil {
		//fmt.Printf("%s", err)
		os.Exit(1)
	}

	responseData, err := ioutil.ReadAll(response.Body)
    if err != nil {
        //fmt.Printf("%s", err)
			os.Exit(1)
    }

    return responseData
}

func GetDateInJakimFormat(date time.Time) string {
	
	y, m, d := date.Date()
	ret := fmt.Sprintf("%02d", d) + "-" + m.String()[:3] + "-" + fmt.Sprintf("%02d", y)
	
	return ret

}

func Write2File(filename string, data []byte) {
	err := os.WriteFile(filename, data, 0644)
	if err != nil {
        panic(err)
    }
}

func ReadFromFile(filename string) []byte {
	data, err := os.ReadFile(filename)
	if err != nil {
        panic(err)
    }
    return data
}


func Ternary (expr bool, trueVal string, falseVal string) string {
	if expr {
    	return trueVal
	} else {
    	return falseVal
	}
}


func Time2JakimString(tNow time.Time) string {
    t := tNow.Hour()
    tNowHour := Ternary(t < 10, "0"+strconv.Itoa(t),strconv.Itoa(t))
	t = tNow.Minute()
    tNowMin := Ternary(t < 10, "0"+strconv.Itoa(t),strconv.Itoa(t))
    return (tNowHour+":"+tNowMin+":00")
}


func JakimTime2String(timeStr string) string {
	AMPM := "AM"
	hourStr := Ternary( timeStr[0] == '0', timeStr[1:2], timeStr[0:2] )
	//if hourStr[0] == '0' {
		//hourStr = hourStr[1:2]
	//}
	
	hourInt, _ := strconv.Atoi(hourStr)
	if hourInt > 12 {
		hourStr = strconv.Itoa(hourInt - 12)
		//fmt.Println(hourStr)
		AMPM = "PM"
	}

	ret := hourStr + timeStr[2:5] + AMPM
	return ret
}

func WhichPrayerSlot(pToday, pTomorrow DailyPrayerTime, compareTime string) string {
	var prayerTimeArray = []string{ pToday.Subuh, pToday.Syuruk, pToday.Zohor, pToday.Asar, pToday.Maghrib, pToday.Isyak}
	var prayerTomorrow = []string{ pTomorrow.Subuh, pTomorrow.Syuruk, pTomorrow.Zohor, pTomorrow.Asar, pTomorrow.Maghrib, pTomorrow.Isyak}
	var prayerSolatArray = []string{"Sbh: ", "Srk: ", "Zhr: ", "Asr: ", "Mgb: ", "Isy: "}
	var ret string

	for i := 0 ; i < 5; i++ {
		if (strings.Compare(compareTime, prayerTimeArray[i]) == -1) {
			ret = prayerSolatArray[i] + JakimTime2String(prayerTimeArray[i])
			return ret
		} else {
			ret = prayerSolatArray[0] + JakimTime2String(prayerTomorrow[0])
		}

	}

	return ret
}

// Return the list of prayertimes for the day in one comma delimited sentence
// in this format: Subuh,Zohor,Asar,Maghrin,Isyak
func PrayerTimeTodayList(pToday DailyPrayerTime) string {
	var prayerTimeArray = []string{ pToday.Subuh, pToday.Syuruk, pToday.Zohor, pToday.Asar, pToday.Maghrib, pToday.Isyak }
	var retStr string = ""

	for i := 0; i < len(prayerTimeArray); i++ {
		retStr = retStr + "," + JakimTime2String(prayerTimeArray[i])
	}

	return retStr
}


func main() {

	var responseObject JakimResponse
	var jakimJson []byte
	var pToday, pTomorrow DailyPrayerTime


	// First Check if File Exist and date of data is the same as today
	if _, err := os.Stat(fileName); errors.Is(err, os.ErrNotExist) {
  		jakimJson = GetJakimPrayerTime("week")
  		Write2File(fileName, jakimJson)
	} else {
		
		// If file exists, read data from the file first, do not go online
		jakimJson = ReadFromFile(fileName)
		json.Unmarshal(jakimJson, &responseObject)
		pToday = responseObject.PrayerTable[0]
		

		// But if data in the file is not for today's date, go online and get the new data
		if pToday.Date != GetDateInJakimFormat(time.Now()) {
			jakimJson = GetJakimPrayerTime("week")
  			Write2File(fileName, jakimJson)
		}

	}

    json.Unmarshal(jakimJson, &responseObject)
    pToday = responseObject.PrayerTable[0]
    pTomorrow = responseObject.PrayerTable[1]

    //fmt.Println(GetDateInJakimFormat(time.Now()))
    
    fmt.Println(WhichPrayerSlot(pToday, pTomorrow, Time2JakimString(time.Now())) + PrayerTimeTodayList(pToday))
    //fmt.Println(WhichPrayerSlot(pToday, "21:00:00"))
}