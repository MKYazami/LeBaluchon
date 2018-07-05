//
//  DataTranslations.swift
//  LeBaluchon
//
//  Created by Mehdi on 05/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

struct DataTranslations: Decodable {
    var data: Translations
    
}

struct Translations: Decodable {
    let translations: [TranslatedText]?
}

struct TranslatedText: Decodable {
    let translatedText: String?
}

/// This array allow to display the pair language in the UIPickerView and determine which one is used
let languageTranslationPair = [
    "Français -> Anglais",
    "Anglais -> Français"
]
