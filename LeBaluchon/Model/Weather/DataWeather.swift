//
//  DataWeather.swift
//  LeBaluchon
//
//  Created by Mehdi on 08/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

struct DataWeather: Decodable {
    let query: Query
}

struct Query: Decodable {
    let results: Results
}

struct Results: Decodable {
    let channel: Channel
}

struct Channel: Decodable {
    let item: Item
}

struct Item: Decodable {
    let condition: Condition
}

struct Condition: Decodable {
    let code: String?
    let temp: String?
    let text: String?
}

/// Allows to know city location according to the Yahoo API data
struct CodeLocation {
    static let paris = "615702"
    static let newyork = "2459115"
}
