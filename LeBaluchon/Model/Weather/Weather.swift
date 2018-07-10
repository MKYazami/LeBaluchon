//
//  Weather.swift
//  LeBaluchon
//
//  Created by Mehdi on 08/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

class Weather {
    
    // MARK: Methods
    
    /// Convert temperature in ° fahrenheit to ° celsius
    ///
    /// - Parameter fahrenheitTemperature: temperature in ° fahrenheit under form of string
    /// - Returns: optional string of temperatur in ° celsius with a precision of 1 decimal number
    static func convertFromFahrenheitToCelsius(fahrenheitTemperature: String) -> String? {
        guard let fahrenheitTemperature = Double(fahrenheitTemperature) else {
            return nil
        }
        
        // Converting to temperature in Kelvin which is the base unit
        let kelvinTemperature = UnitTemperature.fahrenheit.converter.baseUnitValue(fromValue: fahrenheitTemperature)
        
        // Converting from base unit Kelvin to °C for final conversion
        let celsiusTemperature = UnitTemperature.celsius.converter.value(fromBaseUnitValue: kelvinTemperature)
        
        return String(format: "%.1f", celsiusTemperature) + "° C"
    }
    
    /// Get icon weather name depending of code weather conditions from API. If no code available, an EmptyImage name is returned
    ///
    /// - Parameter codeWeatherConditions: Code from API
    /// - Returns: Icon weather name
    static func getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: String?) -> String {
        guard let codeWeatherConditions = codeWeatherConditions, let codeWeatherCondition = Int(codeWeatherConditions) else { return "EmptyImage" }
        switch codeWeatherCondition {
        case 0:
            return "Tornado"
        case 1...2:
            return "Hurricane"
        case 3...4, 37...39, 45, 47 :
            return "CloudRainThunder"
        case 5...7, 10:
            return "ModSleet"
        case 8...9:
            return "Drizzle"
        case 11...12, 40:
            return "HeavyRain"
        case 13...16, 41...43, 46:
            return "OccLightSnow"
        case 17...18:
            return "Sleet"
        case 19...22:
            return "Mist"
        case 23...24:
            return "wind"
        case 25:
            return "Cold"
        case 26:
            return "Cloudy"
        case 27:
            return "CloudyNight"
        case 28:
            return "CloudyDay"
        case 29, 33:
            return "PartlyCloudyNight"
        case 30, 34, 44:
            return "PartlyCloudyDay"
        case 31:
            return "Clear"
        case 32:
            return "Sunny"
        case 35:
            return "RainHail"
        case 36:
            return "Hot"
        case 3200:
            return "EmptyImage"
        default:
            return "EmptyImage"
        }
    }
    
}
