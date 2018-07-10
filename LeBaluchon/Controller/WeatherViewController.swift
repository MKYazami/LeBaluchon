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
            iconConditions.image = UIImage(imageLiteralResourceName: Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: codeConditions))
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
