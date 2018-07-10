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
        let weatherService = WeatherService.init(weatherSession: URLSessionFake(
        data: FakeResponseData.weatherCorrectData, response: FakeResponseData.reponseOK, error: FakeResponseData.error))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        //When
        weatherService.getWeather(codeLocation: CodeLocation.paris) { (success, conditions) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(conditions)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallBackIncorrectData() {
        // Given
        let weatherService = WeatherService.init(weatherSession: URLSessionFake(
            data: FakeResponseData.incorrectData, response: FakeResponseData.reponseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        //When
        weatherService.getWeather(codeLocation: CodeLocation.paris) { (success, conditions) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(conditions)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallBackIfNoData() {
        // Given
        let weatherService = WeatherService.init(weatherSession: URLSessionFake(
            data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        //When
        weatherService.getWeather(codeLocation: CodeLocation.paris) { (success, conditions) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(conditions)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallBackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService.init(weatherSession: URLSessionFake(
            data: FakeResponseData.weatherCorrectData, response: FakeResponseData.reponseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        //When
        weatherService.getWeather(codeLocation: CodeLocation.paris) { (success, conditions) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(conditions)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
//    func testGetWeatherShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
//        // Given
//        let weatherService = WeatherService.init(weatherSession: URLSessionFake(
//            data: FakeResponseData.weatherCorrectData, response: FakeResponseData.reponseOK, error: nil))
//        
//        let expectation = XCTestExpectation(description: "Wait for queue change")
//        //When
//        weatherService.getWeather(codeLocation: CodeLocation.paris) { (success, conditions) in
//            // Then
//            let temperature = "81"
//            let codeConditions = "26"
//            
//            XCTAssertTrue(success)
//            XCTAssertNotNil(conditions)
//            
//            XCTAssertEqual(conditions?.temp, temperature)
//            XCTAssertEqual(conditions?.code, codeConditions)
//            
//            expectation.fulfill()
//        }
//        
//        wait(for: [expectation], timeout: 0.01)
//    }
    
}
