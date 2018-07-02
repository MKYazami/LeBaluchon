//
//  CurrencyServiceTestCase.swift
//  LeBaluchonTests
//
//  Created by Mehdi on 02/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import XCTest
@testable import LeBaluchon

class CurrencyServiceTestCase: XCTestCase {
    
    func testGetCurrencyShouldPostFailedCallBackIfError() {
        // Given
        let currencyService = CurrencyService(currencySession:
            URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.reponseOK, error: FakeResponseData.error))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        currencyService.getCurrency { (success, currency) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetCurrencyShouldPostFailedCallBackIfNoData() {
        // Given
        let currencyService = CurrencyService(currencySession:
            URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        currencyService.getCurrency { (success, currency) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetCurrencyShouldPostFailedCallBackIfIncorrectResponse() {
        // Given
        let currencyService = CurrencyService(currencySession:
            URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.reponseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        currencyService.getCurrency { (success, currency) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetCurrencyShouldPostFailedCallBackIfIncorrectData() {
        // Given
        let currencyService = CurrencyService(currencySession:
            URLSessionFake(data: FakeResponseData.currencyIncorrectData, response: FakeResponseData.reponseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        currencyService.getCurrency { (success, currency) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetCurrencyShouldPostSuccessCallBackIfINoErrorAndCorrectData() {
        // Given
        let currencyService = CurrencyService(currencySession:
            URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.reponseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        currencyService.getCurrency { (success, currency) in
            // Then
            
            // These elements are copied from Currency.json to compare them
            let baseCurrency = "EUR"
            let usdRate: Double = 1.164955
            
            XCTAssertTrue(success)
            XCTAssertNotNil(currency)
            
            XCTAssertEqual(baseCurrency, currency?.baseCurrency)
            XCTAssertEqual(usdRate, currency?.rates?.usd)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
}
