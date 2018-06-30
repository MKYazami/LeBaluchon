//
//  Currency.swift
//  LeBaluchon
//
//  Created by Mehdi on 30/06/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

struct Currency: Decodable {
    let baseCurrency: String?
    let rates: Rate?
    
    private enum CodingKeys: String, CodingKey {
        case baseCurrency = "base"
        case rates
    }
    
    static func calculateCurrency(baseCurrencyRate: Double, rateTarget: Double) -> Double {
        let currency = baseCurrencyRate * rateTarget
        
        return currency
    }
}
