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
    
}

extension Currency {
    
    /// Calcul the currency from base currency & rate target
    ///
    /// - Parameters:
    ///   - baseCurrency: Base currency
    ///   - rateTarget: The rate that allows us to calculate the currency
    /// - Returns: Calculated currency
    static func calculateCurrency(baseCurrency: Double, rateTarget: Double) -> Double {
        let currency = baseCurrency * rateTarget
        
        return currency
    }
}

struct Rate: Decodable {
    let usd: Double
    
    private enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}
