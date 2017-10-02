//
//  WeatherDescription.swift
//  Weather
//
//  Created by Personal on 9/29/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation


struct WeatherDescription {
    
    // Properties
    let id: Double
    let main: String
    let description: String
    let icon: String
    
    
}

extension WeatherDescription {
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Double,
            let main = json["main"] as? String,
            let description = json["description"] as? String,
            let icon = json["icon"] as? String else {
                return nil
        }
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}
