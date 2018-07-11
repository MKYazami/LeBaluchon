//
//  FakeResponseData.swift
//  LeBaluchonTests
//
//  Created by Mehdi on 02/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

class FakeResponseData {
    // MARK: Fake Data
    static var currencyCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Currency", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var translationCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "DataTranslation", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "DataWeather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let incorrectData = "incorrectData".data(using: .utf8)
    
    // MARK: Fake Responses
    static let reponseOK = HTTPURLResponse(url: URL(string: "https://www.google.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let reponseKO = HTTPURLResponse(url: URL(string: "https://www.google.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // MARK: Fake Error
    class FakeError: Error {}
    static let error = FakeError()
    
}
