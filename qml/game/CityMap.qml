import VPlay 1.0
import QtQuick 1.1
import "../menu"
Item {
  id: randomCityNameReferator

  property int randomCity: 0
  property int deepCount: 0

  width: displayCityText.width
  height: displayCityText.height

  Component.onCompleted: {
    var tempArray = new Array;
    for(var element in cityMap) {
      tempArray.push(element)
    }
    cityMapArray = tempArray
  }

  Utils {
    id: utils
  }

  TextButton {
    id: displayCityText
    blinkIntervall: 100
    font: fontHUD
    textSize: 25
  }

  Timer {
    id: fadeOutTimer
    interval: 4000
    repeat: false
    onTriggered: {
      displayCityText.opacity = 0
    }
  }

  function enterHitNewCity(playerID) {
    displayCityText.text = "Player "+playerID+" just hit "+randomCityName()
    displayCityText.opacity = 1
    fadeOutTimer.start()
  }

  function randomCityName() {
    randomCity = utils.generateRandomValueBetween(0,149)
    if(cityMapArray[randomCity]) {
      cityMap[cityMapArray[randomCity]] = false
      deepCount = 0
      return cityMapArray[randomCity]
    } else {
      deepCount++
      if(deepCount <= 149) {
        deepCount = 0
        for(var element in cityMap) {
          cityMap[element] = true
        }
      }
      return randomCityName()
    }

  }

  property variant cityMapArray: []

  property variant cityMap: {
	"Tokyo": true,
  "Jakarta": true,
	"New York": true,
	"Seoul": true,
	"Manila": true,
	"Mumbai": true,
	"Sao Paolo": true,
	"Mexico City": true,
	"Delhi": true,
	"Osaka": true,
	"Cairo": true,
	"Calcutta": true,
	"Los Angeles": true,
	"Shanghai": true,
	"Moscow": true,
	"Beijing": true,
	"Buenos Aires": true,
	"Guangzhou": true,
	"Shenzhen": true,
	"Istanbul": true,
	"Rio de Janeiro": true,
	"Paris": true,
	"Chicago": true,
	"Hagenberg": true,
	"Lagos": true,
	"London": true,
	"Bangkok": true,
	"Kinshasa": true,
	"Tehran": true,
	"Lima": true,
	"Bogota": true,
	"Hong Kong": true,
	"Taipei": true,
	"Lahore": true,
	"Bangalore": true,
	"Johannesburg": true,
	"Baghdad": true,
	"Toronto": true,
	"Santiago": true,
	"Kuala Lumpur": true,
	"San Francisco": true,
	"Philadelphia": true,
	"Wuhan": true,
	"Miami": true,
	"Dallas": true,
	"Madrid": true,
	"Boston": true,
	"Belo Horizonte": true,
	"Saint Petersburg": true,
	"Houston": true,
	"Pune": true,
	"Riyadh": true,
	"Singapore": true,
	"Washington D.C.": true,
	"Milan": true,
	"Atlanta": true,
	"Alexandria": true,
	"Nanjing": true,
	"Barcelona": true,
	"Detroit": true,
	"Ankara": true,
	"Athens": true,
	"Berlin": true,
	"Sydney": true,
	"Monterrey": true,
	"Phoenix": true,
	"Porto Alegre": true,
	"Melbourne": true,
	"Algiers": true,
	"Montreal": true,
	"Pyongyang": true,
	"Durban": true,
	"Nairobi": true,
	"Naples": true,
	"Kabul": true,
	"Salvador": true,
	"Casablanca": true,
	"Cape Town": true,
	"San Diego": true,
	"Seattle": true,
	"Rome": true,
	"Caracas": true,
	"Dakar": true,
	"Minneapolis": true,
	"Tel Aviv": true,
	"Kyiv": true,
	"Izmir": true,
	"Lisbon": true,
	"Frankfurt": true,
	"Birmingham": true,
	"Tampa": true,
	"Tunis": true,
	"Manchester": true,
	"Damascus": true,
	"Santo Domingo": true,
	"Havanna": true,
	"Dubai": true,
	"Baltimore": true,
	"Rotterdam": true,
	"Vancouver": true,
	"Preston": true,
	"St. Louis": true,
	"Warsaw": true,
	"Bucharest": true,
	"Yokohama": true,
	"Brasilia": true,
	"Giza": true,
	"Nanhai": true,
	"Stockholm": true,
	"Baku": true,
	"Brisbane": true,
	"Minsk": true,
	"Nanchong": true,
	"Hamburg": true,
	"Budapest": true,
	"Vienna": true,
	"Belgrade": true,
	"Kobe": true,
	"Tripoli": true,
	"Perth": true,
	"Kyoto": true,
	"Santa Cruz": true,
	"Novosibirsk": true,
	"Montevideo": true,
	"Auckland": true,
	"Valencia": true,
	"Adana": true,
	"Prague": true,
	"Ottawa": true,
	"Hiroshima": true,
	"Sofia": true,
	"Omsk": true,
	"Adelaide": true,
	"Kazan": true,
	"Calgary": true,
	"Tbilisi": true,
	"Amsterdam": true,
	"Brussels": true,
	"Donetsk": true,
	"Dublin": true,
	"Cologne": true,
	"San Jose": true,
	"Torino": true,
	"Mombasa": true,
	"La Paz": true,
	"Liverpool": true,
	"Benghazi": true,
	"Merseille": true,
	"Indianapolis": true,
  "Zagreb": true
}
}
