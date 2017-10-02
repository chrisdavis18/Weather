//
//  CurrentForecast.swift
//  Weather
//
//  Created by Personal on 9/29/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation
import MapKit


struct CurrentForecast {
    
    // Properties
    let location: CLLocationCoordinate2D
    let id: Int
    let name: String
    let weather: MainWeather
    let description: WeatherDescription
    let extras: ForecastExtras
    
    
}

extension CurrentForecast {
    
    init?(json: [String: Any]) {
        
        // Get Location Dictionary
        guard let locDict = json["coord"] as? NSDictionary else {
            return nil
        }
        // Weather Array
        guard let weatherArray = json["weather"] as? NSArray else {
            return nil
        }
        
        // Properties for Current Forecast
        guard let name = json["name"] as? String,
            let lat = locDict["lat"] as? Double,
            let long = locDict["lon"] as? Double,
            let id = json["id"] as? Int,
            let weather = MainWeather.init(json: json["main"] as! [String:Any]),
            let extras = ForecastExtras.init(json: json),
            let description = WeatherDescription.init(json: weatherArray[0] as! [String:Any]) else {
            
            return nil
        }
        
        self.name = name
        self.id = id
        self.location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.weather = weather
        self.extras = extras
        self.description = description

    }
}

// JSON Response from API
//{
//    "coord": {
//        "lon": -118.24,
//        "lat": 34.05
//    },
//    "weather": [
//    {
//    "id": 721,
//    "main": "Haze",
//    "description": "haze",
//    "icon": "50n"
//    }
//    ],
//    "base": "stations",
//    "main": {
//        "temp": 296.38,
//        "pressure": 1011,
//        "humidity": 64,
//        "temp_min": 293.15,
//        "temp_max": 300.15
//    },
//    "visibility": 16093,
//    "wind": {
//        "speed": 0.72,
//        "deg": 292.506
//    },
//    "clouds": {
//        "all": 1
//    },
//    "dt": 1506657480,
//    "sys": {
//        "type": 1,
//        "id": 416,
//        "message": 0.0052,
//        "country": "US",
//        "sunrise": 1506692784,
//        "sunset": 1506735551
//    },
//    "id": 5368361,
//    "name": "Los Angeles",
//    "cod": 200
//}

