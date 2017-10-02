//
//  ForecastExtras.swift
//  Weather
//
//  Created by Personal on 9/29/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation

struct ForecastExtras {
    
    // Properties
    let windDeg: Double
    let windSpeed: Double
    let clouds: Double
    let sunrise: Double
    let sunset: Double
    
    
}

extension ForecastExtras {
    
    // Main Dictionary from Response
    // Will Need to Get Other Objects from this
    init?(json: [String: Any]) {
        
        // Get All Dictionaries from JSON
        guard let cloudDict = json["clouds"] as? NSDictionary,
            let sysDict = json["sys"] as? NSDictionary,
            let windDict = json["wind"] as? NSDictionary else {
            return nil
        }
        
        // Get All Values
        guard let clouds = cloudDict.object(forKey: "all") as? Double,
            let sunrise = sysDict.object(forKey: "sunrise") as? Double,
            let sunset = sysDict.object(forKey: "sunset") as? Double,
            let windDeg = windDict.object(forKey: "deg") as? Double,
            let windSpeed = windDict.object(forKey: "speed") as? Double else {
            return nil
        }
        
        // Init Object
        self.clouds = clouds
        self.sunrise = sunrise
        self.sunset = sunset
        self.windDeg = windDeg
        self.windSpeed = windSpeed
    
    }
}
