//
//  Globals.swift
//  Weather
//
//  Created by Personal on 9/29/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation


enum Constants {
    
    static let weatherAPI = "http://api.openweathermap.org/data/2.5/weather?q="
    static let appID = "c6c8b277cfa776e9fb2257a24e344ffb"
    static let forecastAPI = "http://api.openweathermap.org/data/2.5/forecast?id="
    
}

class Globals {

    static let sharedInstance = Globals()
    
    // MARK: - Variables
    let defaults = UserDefaults()
    var searchedCity: String?
    
    // Functions to Get/Set Last City
    func setSearchCity(city: String) {
        defaults.set(city, forKey: "city")
    }
    
    func getSearchCity() {
        
        searchedCity = defaults.object(forKey: "city") as? String
    }
   
    // Setup Defaults for Last Search
    //http://api.openweathermap.org/data/2.5/weather?q=LosA,US&APPID=c6c8b277cfa776e9fb2257a24e344ffb
    
}
