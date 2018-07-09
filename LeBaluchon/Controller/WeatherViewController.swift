//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by Mehdi on 27/06/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var newyorkTemperatureLabel: UILabel!
    @IBOutlet weak var parisTemperatureLabel: UILabel!
    
    @IBOutlet weak var newyorkWeatherConditionsIcon: UIImageView!
    @IBOutlet weak var parisWeatherConditionsIcon: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getNewYorkWeather()
        getParisWeather()
    }
    
    private func getNewYorkWeather() {
        WeatherService.sharedInstance.getWeather(codeLocation: CodeLocation.newyork) { (success, conditions) in
            if success, let conditions = conditions {
                self.updateDisplay(temperature: conditions.temp, codeConditions: conditions.code, temperatureLabel: self.newyorkTemperatureLabel, iconConditions: self.newyorkWeatherConditionsIcon)
            } else {
                self.alertMessage(title: HelperData.httpErrorRequestAlertTitle, message: HelperData.httpErrorRequestAlertTitle)
            }
        }
    }
    
    private func getParisWeather() {
        WeatherService.sharedInstance.getWeather(codeLocation: CodeLocation.paris) { (success, conditions) in
            self.activityIndicator.isHidden = true
            if success, let conditions = conditions {
                self.updateDisplay(temperature: conditions.temp, codeConditions: conditions.code, temperatureLabel: self.parisTemperatureLabel, iconConditions: self.parisWeatherConditionsIcon)
            } else {
                self.alertMessage(title: HelperData.httpErrorRequestAlertTitle, message: HelperData.httpErrorRequestAlertMessage)
            }
        }
    }

    private func updateDisplay(temperature: String?, codeConditions: String?, temperatureLabel: UILabel, iconConditions: UIImageView) {
        
        // Upadate display temperature
        if let temperature = temperature {
            // Convert temperature to ° Celsius
            let celsiusTemperature = Weather.convertFromFahrenheitToCelsius(fahrenheitTemperature: temperature)
            
            temperatureLabel.text = celsiusTemperature
        } else {
            temperatureLabel.text = "Temperature unavailable!"
        }
        
        // Upadate display conditions icons
        if let codeConditions = codeConditions {
            iconConditions.image = getIconWeatherFromCodeWeatherConditions(codeWeatherConditions: codeConditions)
        } else {
            iconConditions.image = #imageLiteral(resourceName: "EmptyImage")
        }
        
    }
    
    /// Display pop up to warn the user
    ///
    /// - Parameters:
    ///   - title: Alert title
    ///   - message: Message title
    private func alertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}

// MARK: Weather conditions icons handler
extension WeatherViewController {
    func getIconWeatherFromCodeWeatherConditions(codeWeatherConditions: String?) -> UIImage? {
        guard let codeWeatherConditions = codeWeatherConditions, let codeWeatherCondition = Int(codeWeatherConditions) else { return nil }
        switch codeWeatherCondition {
        case 0:
            // Tornado
            return #imageLiteral(resourceName: "Tornado")
        case 1...2:
            // Hurricane
            return #imageLiteral(resourceName: "Hurricane")
        case 3...4, 37...39, 45, 47 :
            // CloudRainThunder
            return #imageLiteral(resourceName: "CloudRainThunder")
        case 5...7, 10:
            // ModSleet
            return #imageLiteral(resourceName: "ModSleet")
        case 8...9:
            // Drizzle
            return #imageLiteral(resourceName: "Drizzle")
        case 11...12, 40:
            // HeavyRain
            return #imageLiteral(resourceName: "HeavyRain")
        case 13...16, 41...43, 46:
            // DecLightSnow
            return #imageLiteral(resourceName: "OccLightSnow")
        case 17...18:
            // Sleet
            return #imageLiteral(resourceName: "Sleet")
        case 19...22:
            // Mist
            return #imageLiteral(resourceName: "Mist")
        case 23...24:
            // Wind
            return #imageLiteral(resourceName: "wind")
        case 25:
            // Cold
            return #imageLiteral(resourceName: "Cold")
        case 26:
            // Cloudy
            return #imageLiteral(resourceName: "Cloudy")
        case 27:
            // CloudyNight
            return #imageLiteral(resourceName: "CloudyNight")
        case 28:
            // CloudyDay
            return #imageLiteral(resourceName: "CloudyDay")
        case 29, 33:
            // PartlyCloudyNight
            return #imageLiteral(resourceName: "PartlyCloudyNight")
        case 30, 34, 44:
            // PartlyCloudyDay
            return #imageLiteral(resourceName: "PartlyCloudyDay")
        case 31:
            // Clear
            return #imageLiteral(resourceName: "Clear")
        case 32:
            // Sunny
            return #imageLiteral(resourceName: "Sunny")
        case 35:
            // RainHail
            return #imageLiteral(resourceName: "RainHail")
        case 36:
            // Hot
            return #imageLiteral(resourceName: "Hot")
        case 3200:
            return nil
        default:
            return nil
        }
    }
}
