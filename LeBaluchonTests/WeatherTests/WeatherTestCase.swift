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
    
    // MARK: Test of convertFromFahrenheitToCelsius
    func testGivenTemperature32Fahrenheit_WhenConvertToCelsius_ThenTemperatureIs0Celsius() {
        let celsiusTemperature = Weather.convertFromFahrenheitToCelsius(fahrenheitTemperature: "32")
        
        XCTAssertEqual(celsiusTemperature, "0.0° C")
    }
    
    func testGivenFahrenheitTemperatureIsNotConvertibleToDoubleType_WhenConvertToCelsius_ThenReturnsNil() {
        let celsiusTemperature = Weather.convertFromFahrenheitToCelsius(fahrenheitTemperature: "0.3.2")
        
        XCTAssertEqual(celsiusTemperature, nil)
    }
    
    // MARK: Test of getIconWeatherNameFromCodeWeatherConditions
    func testGivenNoCodeCondition_WhenCallMethod_ThenIconNameIsEmptyImage() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: nil)
        
        XCTAssertEqual(iconeName, "EmptyImage")
    }
    
    func testGivenBadCodeCondition_WhenCallMethod_ThenIconNameIsEmptyImage() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "9672")
        
        XCTAssertEqual(iconeName, "EmptyImage")
    }
    
    func testGivenNoneIntConvertibleCodeCondition_WhenCallMethod_ThenIconNameIsEmptyImage() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "abcd")
        
        XCTAssertEqual(iconeName, "EmptyImage")
    }
    
    func testGivenCodeConditionIs0_WhenCallMethod_ThenIconNameIsTornado() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "0")
        
        XCTAssertEqual(iconeName, "Tornado")
    }
    
    func testGivenCodeConditionIs1_WhenCallMethod_ThenIconNameIsHurricane() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "1")
        
        XCTAssertEqual(iconeName, "Hurricane")
    }
    
    func testGivenCodeConditionIs3_WhenCallMethod_ThenIconNameIsCloudRainThunder() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "3")
        
        XCTAssertEqual(iconeName, "CloudRainThunder")
    }
    
    func testGivenCodeConditionIs7_WhenCallMethod_ThenIconNameIsModSleet() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "7")
        
        XCTAssertEqual(iconeName, "ModSleet")
    }
    
    func testGivenCodeConditionIs9_WhenCallMethod_ThenIconNameIsDrizzle() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "9")
        
        XCTAssertEqual(iconeName, "Drizzle")
    }
    
    func testGivenCodeConditionIs40_WhenCallMethod_ThenIconNameIsHeavyRain() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "40")
        
        XCTAssertEqual(iconeName, "HeavyRain")
    }
    
    func testGivenCodeConditionIs42_WhenCallMethod_ThenIconNameIsOccLightSnow() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "42")
        
        XCTAssertEqual(iconeName, "OccLightSnow")
    }
    
    func testGivenCodeConditionIs17_WhenCallMethod_ThenIconNameIsSleet() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "17")
        
        XCTAssertEqual(iconeName, "Sleet")
    }
    
    func testGivenCodeConditionIs20_WhenCallMethod_ThenIconNameIsMist() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "20")
        
        XCTAssertEqual(iconeName, "Mist")
    }
    
    func testGivenCodeConditionIs23_WhenCallMethod_ThenIconNameIswind() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "23")
        
        XCTAssertEqual(iconeName, "wind")
    }
    
    func testGivenCodeConditionIs25_WhenCallMethod_ThenIconNameIsCold() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "25")
        
        XCTAssertEqual(iconeName, "Cold")
    }
    
    func testGivenCodeConditionIs26_WhenCallMethod_ThenIconNameIsCloudy() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "26")
        
        XCTAssertEqual(iconeName, "Cloudy")
    }
    
    func testGivenCodeConditionIs27_WhenCallMethod_ThenIconNameIsCloudyNight() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "27")
        
        XCTAssertEqual(iconeName, "CloudyNight")
    }
    
    func testGivenCodeConditionIs28_WhenCallMethod_ThenIconNameIsCloudyDay() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "28")
        
        XCTAssertEqual(iconeName, "CloudyDay")
    }
    
    func testGivenCodeConditionIs33_WhenCallMethod_ThenIconNameIsPartlyCloudyNight() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "33")
        
        XCTAssertEqual(iconeName, "PartlyCloudyNight")
    }
    
    func testGivenCodeConditionIs34_WhenCallMethod_ThenIconNameIsPartlyPartlyCloudyDay() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "34")
        
        XCTAssertEqual(iconeName, "PartlyCloudyDay")
    }
    
    func testGivenCodeConditionIs31_WhenCallMethod_ThenIconNameIsClear() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "31")
        
        XCTAssertEqual(iconeName, "Clear")
    }
    
    func testGivenCodeConditionIs32_WhenCallMethod_ThenIconNameIsSunny() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "32")
        
        XCTAssertEqual(iconeName, "Sunny")
    }
    
    func testGivenCodeConditionIs35_WhenCallMethod_ThenIconNameIsRainHail() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "35")
        
        XCTAssertEqual(iconeName, "RainHail")
    }
    
    func testGivenCodeConditionIs36_WhenCallMethod_ThenIconNameIsHot() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "36")
        
        XCTAssertEqual(iconeName, "Hot")
    }
    
    func testGivenCodeConditionIs3200_WhenCallMethod_ThenIconNameIsEmptyImage() {
        let iconeName = Weather.getIconWeatherNameFromCodeWeatherConditions(codeWeatherConditions: "3200")
        
        XCTAssertEqual(iconeName, "EmptyImage")
    }
}
