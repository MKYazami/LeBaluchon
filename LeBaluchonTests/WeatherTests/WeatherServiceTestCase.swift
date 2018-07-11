//
//  WeatherServiceTestCase.swift
//  LeBaluchonTests
//
//  Created by Mehdi on 09/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import XCTest
@testable import LeBaluchon

class WeatherServiceTestCase: XCTestCase {
    
    func testGetWeatherShouldPostFailedCallBackIfError() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: FakeResponseData.weatherCorrectData, response: FakeResponseData.reponseOK, error: FakeResponseData.error))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        //When
        weatherService.getWeather(codeLocation: CodeLocation.paris) { (success, dataWeather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(dataWeather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallBackIncorrectData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: FakeResponseData.incorrectData, response: FakeResponseData.reponseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        //When
        weatherService.getWeather(codeLocation: CodeLocation.paris) { (success, dataWeather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(dataWeather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallBackIfNoData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        //When
        weatherService.getWeather(codeLocation: CodeLocation.paris) { (success, dataWeather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(dataWeather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallBackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: FakeResponseData.weatherCorrectData, response: FakeResponseData.reponseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        //When
        weatherService.getWeather(codeLocation: CodeLocation.paris) { (success, dataWeather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(dataWeather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
//    func testGetWeatherShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
//        // Given
//        let weatherService = WeatherService(weatherSession: URLSessionFake(
//            data: FakeResponseData.weatherCorrectData, response: FakeResponseData.reponseOK, error: nil))
//
//        let expectation = XCTestExpectation(description: "Wait for queue change")
//        //When
//        weatherService.getWeather(codeLocation: CodeLocation.paris) { (success, dataWeather) in
//            // Then
//            // These elements are copied from "Weather.json" to compare them
//            let temperature = "81"
//            let codeConditions = "26"
//
//            XCTAssertTrue(success)
//            XCTAssertNotNil(dataWeather)
//
//            XCTAssertEqual(dataWeather?.query.results.channel.item.condition.temp, temperature)
//            XCTAssertEqual(dataWeather?.query.results.channel.item.condition.code, codeConditions)
//
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
    
//    func testGetWeatherShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
//        let expectation = XCTestExpectation(description: "Wait")
//        WeatherService.sharedInstance.getWeather(codeLocation: CodeLocation.paris) { (success, dataWeather) in
//
//            XCTAssertTrue(success)
//            XCTAssertNotNil(dataWeather)
//            
//            let code = "28"
//            let temp = "70"
//            
//            XCTAssertEqual(code, dataWeather?.query.results.channel.item.condition.code)
//            XCTAssertEqual(temp, dataWeather?.query.results.channel.item.condition.temp)
//            
//            expectation.fulfill()
//        }
//        
//        wait(for: [expectation], timeout: 10.0)
//    }
    
}
