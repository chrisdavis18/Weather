//
//  ViewController.swift
//  Weather
//
//  Created by Personal on 9/28/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate, UISearchBarDelegate, WeatherProtocol {
    
    // MARK: - Outlets
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Variables
    var forecast: CurrentForecast?
    var futureForecasts = [FiveDayForecast]()
    
    
    // MARK: - Protocol Implementations
    func fiveDayForecast(status: Bool, forecasts: [FiveDayForecast]?) {
        
        // If Success, Update Forecasts
        if(status) {
            
            futureForecasts = forecasts!
            DispatchQueue.main.async {
                self.weatherTableView.reloadData()
            }
            
        }
        
    }
    

    // MARK: - View Controller Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // Check for Last Searched City
        // If City, Update Weather Data
        Globals.sharedInstance.getSearchCity()
        if(Globals.sharedInstance.searchedCity != nil) {
            
            let weather = GetWeather()
            DispatchQueue.main.async {
              self.searchBar.text = Globals.sharedInstance.searchedCity!
            }
            weather.getCurrentWeather(Globals.sharedInstance.searchedCity!, completion: { success, forecast in
                
                if(success) {
                    
                    // Set Forecast & Reload Table View
                    self.forecast = forecast!
                    DispatchQueue.main.async {
                        self.weatherTableView.reloadData()
                    }
                    
                    // Get 5 Day Forecast
                    weather.delegate = self
                    weather.getFutureForecast("\(forecast!.id)")
                    
                } else {
                    
                    // Error Getting Forecast
                    let alert = UIAlertController(title: "Error", message: "Something went wrong trying to find the weather!", preferredStyle: .alert)
                    let gotIt = UIAlertAction(title: "Got It!", style: .default, handler: nil)
                    alert.addAction(gotIt)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
                
            })
            
            
        }
        

        
    }

    
    // MARK: - TableView Delegate & DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Current & Future Forecasts
        if(forecast != nil) {
            
            if(futureForecasts.count > 0) {
                return 2
            } else {
                return 1
            }
        
        } else { // No Forecasts Available Yet
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 250
        } else {
            return 60
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath) as! ForecastTableViewCell
            
            cell.currentlyInLabel.text = "Currently In \(forecast!.name)"
            cell.weatherIconImageView.contentMode = .scaleAspectFit
            cell.weatherIconImageView.image = UIImage(named: "\(forecast!.description.icon)")
            cell.weatherDescriptionLabel.text = forecast!.description.description
            let temp = Int(forecast!.weather.temp.convertToFarenheit())
            let highTemp = Int(forecast!.weather.maxTemp.convertToFarenheit())
            let lowTemp = Int(forecast!.weather.minTemp.convertToFarenheit())
            
            cell.tempLabel.text = "\(temp)℉"
            cell.highTempLabel.text = "\(highTemp)℉"
            cell.lowTempLabel.text = "\(lowTemp)℉"
            cell.layer.backgroundColor = UIColor.clear.cgColor
            
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "fiveDayCell", for: indexPath) as! FiveDayTableViewCell
            cell.layer.backgroundColor = UIColor.clear.cgColor
            
            return cell
            
            
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 1) {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "fiveDayViewController") as! FiveDayViewController
            vc.forecasts = futureForecasts
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    // MARK: - SearchBar Delegate
    // Show Cancel Button
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    // Cancel Button Shows when searchBar is editing
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    // Search Clicked - Resign Keyboard and Perform API Call with City
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        
        // API Call if there is searchText
        let weather = GetWeather()
        if(searchBar.text != "") {
            weather.getCurrentWeather(searchBar.text!, completion: { success, forecast in
                
                if(success) {
                
                    // Set Forecast & Reload Table View
                    self.forecast = forecast!
                    Globals.sharedInstance.setSearchCity(city: searchBar.text!)
                    DispatchQueue.main.async {
                        self.weatherTableView.reloadData()
                    }
                    
                    // Get 5 Day Forecast
                    weather.delegate = self
                    weather.getFutureForecast("\(forecast!.id)")
                    
                    
                } else {
                    
                    // Error Getting Forecast
                    let alert = UIAlertController(title: "Error", message: "Something went wrong trying to find the weather!", preferredStyle: .alert)
                    let gotIt = UIAlertAction(title: "Got It!", style: .default, handler: nil)
                    alert.addAction(gotIt)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
                
            })
        }
        
    }
    
    // Resign First Repsonse
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.resignFirstResponder()
        return true
    }
    
    
    
    


}

