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
        
        return String(format: "%.1f", celsiusTemperature)
    }
    
    
}
