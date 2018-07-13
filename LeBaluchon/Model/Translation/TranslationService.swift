//
//  TranslationService.swift
//  LeBaluchon
//
//  Created by Mehdi on 05/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

class TranslationService {
    // MARK: Singleton
    static let sharedInstance = TranslationService()
    private init() {}
    
    // translationSession is in global scope to allows the dependency injection for tests
    private var translationSession = URLSession(configuration: .default)
    
    /// This initializer is used only for testing
    ///
    /// - Parameter currencySession: Inject the URLSessionFake
    init(translationSession: URLSession) {
        self.translationSession = translationSession
    }
    
    // MARK: Method
    
    ///
    /// - Parameters:
    ///   - textTotranslate: Text to translate
    ///   - languageTranslationPair: Language pair as French -> English, Dutch -> Spanish…
    ///   - callBack: if any problem in the request callBack = (false, nil) if evrything Ok callBack = (true, currency)
    func getTranslation(textTotranslate: String, languageTranslationPair: String, callBack: @escaping (Bool, TranslatedText?) -> Void) {
        // Set url for Session
        guard let url = getTranslationURL(textToTranslate: textTotranslate, languageTranslationPair: languageTranslationPair) else {
            callBack(false, nil)
            return
        }
        
        var task: URLSessionDataTask?
        
        // Cancel the task before to start new one
        task?.cancel()
        
        task = translationSession.dataTask(with: url) { (data, response, error) in
            // Bring to main thread
            DispatchQueue.main.async {
                // Check data and no error
                guard let data = data, error == nil else {
                    callBack(false, nil)
                    return
                }
                
                // Check Status response code
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callBack(false, nil)
                    return
                }
                
                // Decode the JSON data
                guard let jsonDecoder = try? JSONDecoder().decode(DataTranslations.self, from: data),
                    let translatedText = jsonDecoder.data.translations?[0] else {
                        callBack(false, nil)
                        return
                }
                
                // If all checks are okay, we set call back to true with the data
                callBack(true, translatedText)
            }
            
        }
        
        // Resume the task
        task?.resume()
    }
    
    /// Get translation url for URLSession
    ///
    /// - Parameters:
    ///   - textToTranslate: Text to translate
    ///   - languageTranslationPair: Language pair as French -> English, Dutch -> Spanish…
    /// - Returns: URL for http call
    private func getTranslationURL(textToTranslate: String, languageTranslationPair: String) -> URL? {
        // Sample of static URL for understanding purpose
        // https://www.googleapis.com/language/translate/v2?key=AIzaSyCQjn22TDWEKEcyoTHhfb2sGFT3H7Z-cNA&source=fr&target=en&format=text&q=Text_To_Translate
        
        // URL components
        
        //  Format text to translate into allowed characters in URL (ex: space, special characters)
        guard let textTotranslateInURL = textToTranslate.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return nil
        }
        
        // Set source & target according to language pairs
        let souceAndTarget = setSourceAndTargetLanguages(languageTranslationPair: languageTranslationPair)
        guard let source = souceAndTarget.source, let target = souceAndTarget.target else {
            return nil
        }
        
        typealias GTAPI = Constants.GoogleTranslateAPI
        
        let urlString = GTAPI.baseUrl + GTAPI.keyParameter + GTAPI.apiKey + GTAPI.sourceParameter + source + GTAPI.targetParameter + target + GTAPI.formatParameter + GTAPI.format + GTAPI.textTotranslateParameter + textTotranslateInURL
        
        let url = URL(string: urlString)
        
        return url
    }
    
    /// Set the source & target language depending on language translation pair
    ///
    /// - Parameter languageTranslationPair: Language pair describing in languageTranslationPair array
    /// - Returns: source & target bigram language according to the google translation API
    private func setSourceAndTargetLanguages(languageTranslationPair: String) -> (source: String?, target: String?) {
        switch languageTranslationPair {
        case "Français -> Anglais":
            let source = "fr"
            let target = "en"
            return (source, target)
        case "Anglais -> Français":
            let source = "en"
            let target = "fr"
            return (source, target)
        default:
            let source: String? = nil
            let target: String? = nil
            return (source, target)
        }
    }
}
