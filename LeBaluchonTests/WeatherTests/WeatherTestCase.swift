//
//  WeatherTestCase.swift
//  LeBaluchonTests
//
//  Created by Mehdi on 09/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import XCTest
@testable import LeBaluchon

class WeatherTestCase: XCTestCase {
    
    func testGivenTemperature32Fahrenheit_WhenConvertToCelsius_ThenTemperatureIs0Celsius() {
        let celsiusTemperature = Weather.convertFromFahrenheitToCelsius(fahrenheitTemperature: "32")
        
        XCTAssertEqual(celsiusTemperature, "0.0° C")
    }
    
    func testGivenFahrenheitTemperatureIsNotConvertibleToDoubleType_WhenConvertToCelsius_ThenReturnsNil() {
        let celsiusTemperature = Weather.convertFromFahrenheitToCelsius(fahrenheitTemperature: "0.3.2")
        
        XCTAssertEqual(celsiusTemperature, nil)
    }
}
