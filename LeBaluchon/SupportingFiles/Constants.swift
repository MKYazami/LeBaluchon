//
//  Constants.swift
//  LeBaluchon
//
//  Created by Mehdi on 13/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

struct Constants {
    
    /// Constants Fixer API for currency
    struct FixerAPI {
        // MARK: Base URL & URL parameters keys
        static let baseURL = "http://data.fixer.io/api/latest?"
        static let apiKey = "f6ce7945bcfdbe9f45515b27e53ae84f"
        
        // MARK: URL parameters values
        static let accessKeyParameter = "access_key="
        static let symbolsParameter = "&symbols="

    }
    
    /// Constants API for translation
    struct GoogleTranslateAPI {
        // MARK: Base URL & URL parameters keys
        static let baseUrl = "https://www.googleapis.com/language/translate/v2?"
        static let apiKey = "AIzaSyCQjn22TDWEKEcyoTHhfb2sGFT3H7Z-cNA"
        static let format = "text"
        
        // MARK: URL parameters values
        static let keyParameter = "key="
        static let sourceParameter = "&source="
        static let targetParameter = "&target="
        
        /// This parameter is important to set it at "text" (default is html value). This value avoid to get html entities for some specials characters (as l&#39;API instead of l'API)
        static let formatParameter = "&format="
        static let textTotranslateParameter = "&q="
    }
    
    struct YahooWeatherAPI {
        // MARK: Base URL & URL parameters keys
        static let baseURL = "https://query.yahooapis.com/v1/public/yql?q="
        static let formatParameter = "&format="
        
        // MARK: URL parameters values
        /// Add codeLocation after yql
        static let yql = "select item.condition from weather.forecast where woeid ="
        static let format = "json"
    }
    
    /// Contains some constants to handle general errors
    struct ErrorHandler {
        // MARK: Network errors
        /// Contains the title to present to user in case of any http request error
        static let httpErrorRequestAlertTitle = "Probléme réseau !"
        
        /// Contains the message to present to user in case of any http request error
        static let httpErrorRequestAlertMessage = "Veuilliez vérifier votre connexion ou réessayer ultérieurement"

    }
    
}
