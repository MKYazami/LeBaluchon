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
        WeatherService.sharedInstance.getWeather(codeLocation: CodeLocation.newyork) { (success, dataWeather) in
            if success, let dataWeather = dataWeather {
                self.updateDisplay(temperature: dataWeather.query.results.channel.item.condition.temp, codeConditions: dataWeather.query.results.channel.item.condition.code, temperatureLabel: self.newyorkTemperatureLabel, imageViewIconConditions: self.newyorkWeatherConditionsIcon)
            } else {
                self.alertMessage(title: HelperData.httpErrorRequestAlertTitle, message: HelperData.httpErrorRequestAlertTitle)
            }
        }
    }
    
    private func getParisWeather() {
        WeatherService.sharedInstance.getWeather(codeLocation: CodeLocation.paris) { (success, dataWeather) in
            self.activityIndicator.isHidden = true
            if success, let dataWeather = dataWeather {
                self.updateDisplay(temperature: dataWeather.query.results.channel.item.condition.temp, codeConditions: dataWeather.query.results.channel.item.condition.code, temperatureLabel: self.parisTemperatureLabel, imageViewIconConditions: self.parisWeatherConditionsIcon)
            } else {
                self.alertMessage(title: HelperData.httpErrorRequestAlertTitle, message: HelperData.httpErrorRequestAlertMessage)
            }
        }
    }

    /// Update display
    ///
    /// - Parameters:
    ///   - temperature: Temparature
    ///   - codeConditions: Code weather conditions
    ///   - temperatureLabel: Label where to display the temperature
    ///   - iconConditions: The UIImageView to display the icon weather conditions
    private func updateDisplay(temperature: String?, codeConditions: String?, temperatureLabel: UILabel, imageViewIconConditions: UIImageView) {
        
        // Upadate display temperature
        if let temperature = temperature {
            // Convert temperature to ° Celsius
            let celsiusTemperature = Weather.convertFromFahrenheitToCelsius(fahrenheitTemperature: temperature)
            
            temperatureLabel.text = celsiusTemperature
        } else {
            temperatureLabel.text = "Temperature unavailable!"
        }
        
        // Update display conditions icons
        if let codeConditions = codeConditions {
            imageViewIconConditions.image = UIImage(imageLiteralResourceName: Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: codeConditions))
        } else {
            imageViewIconConditions.image = #imageLiteral(resourceName: "EmptyImage")
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
