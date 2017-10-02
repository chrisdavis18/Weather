//
//  GetWeather.swift
//  Weather
//
//  Created by Personal on 9/29/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation

protocol WeatherProtocol: class {
    
    func fiveDayForecast(status: Bool, forecasts: [FiveDayForecast]?)
    
}


class GetWeather {
    
    
    weak var delegate: WeatherProtocol?
    
    // API Call to search for weather
    func getCurrentWeather(_ city: String, completion: @escaping (_ success: Bool, _ forecast: CurrentForecast?) -> Void) {
        
        let requestString = Constants.weatherAPI + city + ",US&APPID=" + Constants.appID
        
        
        // Create Request -> Make sure no failures on URL
        let url = URL(string: requestString)

        // Mark Sure URL Was Created
        if(url != nil) {

            let request = URLRequest(url: url!)
            // Perform Request
            URLSession.shared.dataTask(with: request, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in

                // Check for Data
                guard let data = data else {
                    completion(false, nil)
                    return
                }

                // Serialize JSON Data
                var dict = NSDictionary()
                do {
                    dict = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                } catch let error as NSError {

                    print("Error Serializing: \(error.localizedDescription)")
                    completion(false, nil)

                }
                
                // Try to Init CurrentForecast
                guard let forecast = CurrentForecast.init(json: dict as! [String: Any]) else {
                    completion(false, nil)
                    return
                }
                
                // Return Initialized Forecast
                completion(true, forecast)

            }).resume()

        } else {
            // Error Creating URL
            completion(false, nil)

        }
        
    }
    
    // API Call to Get 5 Day for Cast - Available from Public API
    func getFutureForecast(_ cityID: String) {
        
        let requestString = Constants.forecastAPI + cityID + "&APPID=" + Constants.appID
        print(requestString)
        
        // Create Request -> Make sure no failures on URL
        let url = URL(string: requestString)
        
        // Mark Sure URL Was Created
        if(url != nil) {
            
            let request = URLRequest(url: url!)
            // Perform Request
            URLSession.shared.dataTask(with: request, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in
                
                // Check for Data
                guard let data = data else {
                    self.delegate?.fiveDayForecast(status: false, forecasts: nil)
                    return
                }
                
                // Serialize JSON Data
                var dict = NSDictionary()
                do {
                    dict = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                } catch let error as NSError {
                    
                    print("Error Serializing: \(error.localizedDescription)")
                    self.delegate?.fiveDayForecast(status: false, forecasts: nil)
                    
                }
                
                // Check for List of Forecast
                var futureForecasts = [FiveDayForecast]()
                guard let forecasts = dict.object(forKey: "list") as? NSArray else {
                    self.delegate?.fiveDayForecast(status: false, forecasts: nil)
                    return
                }
                
                
                // Init. 5 Day Forecast Items, and Update VC
                for i in 0..<forecasts.count {
                    let forecast = FiveDayForecast.init(json: forecasts[i] as! [String: Any])
                    if(forecast != nil) {
                        futureForecasts.append(forecast!)
                    }
                }
                self.delegate?.fiveDayForecast(status: true, forecasts: futureForecasts)
                
               
            }).resume()
            
        } else {
            // Error Creating URL
            self.delegate?.fiveDayForecast(status: false, forecasts: nil)
            
        }
        
    }
    
    
    
    
    
}
