//
//  CurrencyTestCase.swift
//  LeBaluchonTests
//
//  Created by Mehdi on 02/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import XCTest
@testable import LeBaluchon

class CurrencyTestCase: XCTestCase {
    
    func testGivenBaseCurrencyIs5_WhenRateTargetIs1Decimal16_ThenCurrencyShouldBe5Decimal8() {
        let currency = Currency.calculateCurrency(baseCurrency: 5.0, rateTarget: 1.16)
        
        XCTAssertEqual(currency, 5.8)
    }
    
}
