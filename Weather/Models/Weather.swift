//
//  Weather.swift
//  Weather
//
//  Created by Personal on 9/29/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation


struct MainWeather {
    
    // Properties
    let temp: Double
    let pressure: Double
    let humidity: Double
    let minTemp: Double
    let maxTemp: Double
    
    
}

extension MainWeather {
    
        init?(json: [String: Any]) {
            guard let temp = json["temp"] as? Double,
                let pressure = json["pressure"] as? Double,
                let humidity = json["humidity"] as? Double,
                let minTemp = json["temp_min"] as? Double,
                let maxTemp = json["temp_max"] as? Double else {
                    return nil
            }
            self.temp = temp
            self.pressure = pressure
            self.humidity = humidity
            self.minTemp = minTemp
            self.maxTemp = maxTemp
        }
}

// JSON Response from API
//"main": {
//    "temp": 296.38,
//    "pressure": 1011,
//    "humidity": 64,
//    "temp_min": 293.15,
//    "temp_max": 300.15
//},

