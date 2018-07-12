//
//  TranslationServiceTestCase.swift
//  LeBaluchonTests
//
//  Created by Mehdi on 06/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import XCTest
@testable import LeBaluchon

class TranslationServiceTestCase: XCTestCase {
    
    func testGetTranslationShoulPostdFailedCallBackIfError() {
        // Given
        let translationService = TranslationService(translationSession: URLSessionFake(
            data: FakeResponseData.translationCorrectData, response: FakeResponseData.reponseOK, error: FakeResponseData.error))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        translationService.getTranslation(textTotranslate: "une traduction", languageTranslationPair: "Français -> Anglais") { (success, translatedText) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText?.translatedText)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShoulPostdFailedCallBackIfIncorrectData() {
        // Given
        let translationService = TranslationService(translationSession: URLSessionFake(
            data: FakeResponseData.incorrectData, response: FakeResponseData.reponseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When

        translationService.getTranslation(textTotranslate: "une traduction", languageTranslationPair: "Français -> Anglais") { (success, translatedText) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText?.translatedText)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShoulPostdFailedCallBackIfNoData() {
        // Given
        let translationService = TranslationService(translationSession: URLSessionFake(
            data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        
        translationService.getTranslation(textTotranslate: "une traduction", languageTranslationPair: "Français -> Anglais") { (success, translatedText) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText?.translatedText)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShoulPostdFailedCallBackIfIncorrectResponse() {
        // Given
        let translationService = TranslationService(translationSession: URLSessionFake(
            data: FakeResponseData.translationCorrectData, response: FakeResponseData.reponseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        translationService.getTranslation(textTotranslate: "a translation", languageTranslationPair: "Anglais -> Français") { (success, translatedText) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText?.translatedText)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShoulPostdFailedCallBackIfIncorrectLanguageTranslationPair() {
        // Given
        let translationService = TranslationService(translationSession: URLSessionFake(
            data: FakeResponseData.translationCorrectData, response: FakeResponseData.reponseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        translationService.getTranslation(textTotranslate: "a translation", languageTranslationPair: "Anglais -> Allemand") { (success, translatedText) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText?.translatedText)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShoulPostdSuccessCallBackIfNoErrorAndCorrectData() {
        // Given
        let translationService = TranslationService(translationSession: URLSessionFake(
            data: FakeResponseData.translationCorrectData, response: FakeResponseData.reponseOK, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        translationService.getTranslation(textTotranslate: "une traduction", languageTranslationPair: "Français -> Anglais") { (success, translatedText) in
            //Then
            let translatedTextToCompare = "a translation"
            XCTAssertTrue(success)
            XCTAssertNotNil(translatedText?.translatedText)

            XCTAssertEqual(translatedTextToCompare, translatedText?.translatedText)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
}
