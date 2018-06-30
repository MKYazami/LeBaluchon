//
//  Rate.swift
//  LeBaluchon
//
//  Created by Mehdi on 30/06/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

struct Rate: Decodable {
    let usd: Double
    
    private enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}
