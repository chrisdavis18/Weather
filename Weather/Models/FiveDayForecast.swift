//
//  FiveDayForecast.swift
//  Weather
//
//  Created by Personal on 10/1/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation

struct FiveDayForecast {
    
    // Properties
    let dateTime: Int
    let dateText: String
    let weather: MainWeather
    let description: WeatherDescription

    
    
}

extension FiveDayForecast {
    
    init?(json: [String: Any]) {
        
        guard let weatherArray = json["weather"] as? NSArray else {
            return nil
        }
        
        // Properties for Five Day Forecast Item
        guard let dateText = json["dt_txt"] as? String,
        let dateTime = json["dt"] as? Int,
        let weather = MainWeather.init(json: json["main"] as! [String:Any]),
        let description = WeatherDescription.init(json: weatherArray[0] as! [String:Any]) else {
            return nil
        }
        

        // Set Properties
        self.dateText = dateText
        self.dateTime = dateTime
        self.weather = weather
        self.description = description
        
    }
}


//{
//    "dt": 1506924000,
//    "main": {
//        "temp": 282.63,
//        "temp_min": 282.63,
//        "temp_max": 282.948,
//        "pressure": 1035.29,
//        "sea_level": 1042.05,
//        "grnd_level": 1035.29,
//        "humidity": 100,
//        "temp_kf": -0.31
//    },
//    "weather": [
//    {
//    "id": 800,
//    "main": "Clear",
//    "description": "clear sky",
//    "icon": "01n"
//    }
//    ],
//    "clouds": {
//        "all": 0
//    },
//    "wind": {
//        "speed": 0.96,
//        "deg": 162.509
//    },
//    "sys": {
//        "pod": "n"
//    },
//    "dt_txt": "2017-10-02 06:00:00"
//},

