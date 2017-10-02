//
//  Extensions.swift
//  Weather
//
//  Created by Personal on 9/29/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation


extension Double {
    
    // Default Temperatures are return in Kelvins,
    // This function converts them to Farenheit for display
    // Since this is for US Cities Only
    func convertToFarenheit() -> Double {
        
         // The temperature T in degrees Fahrenheit (°F) is equal to the temperature T in Kelvin (K) times 9/5, minus 459.67
        return self * (9/5) - 459.67
    }
    
    
}
