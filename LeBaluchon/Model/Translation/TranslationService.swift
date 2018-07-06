//
//  TranslationService.swift
//  LeBaluchon
//
//  Created by Mehdi on 05/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

class TranslationService {
    static let sharedInstance = TranslationService()
    private init() {}
    
    private var translationSession = URLSession(configuration: .default)
    
    /// This initializer is used only for testing
    ///
    /// - Parameter currencySession: Inject the URLSessionFake
    init(translationSession: URLSession) {
        self.translationSession = translationSession
    }
    
    func getTranslation(textTotranslate: String, languageTranslationPair: String, callBack: @escaping (Bool, TranslatedText?) -> Void) {
        // Set url
        guard let url = getTranslationURL(textToTranslate: textTotranslate, languageTranslationPair: languageTranslationPair) else {
            callBack(false, nil)
            return
        }
        
        var task: URLSessionDataTask?
        
        task?.cancel()
        
        task = translationSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callBack(false, nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callBack(false, nil)
                    return
                }
                
                guard let jsonDecoder = try? JSONDecoder().decode(DataTranslations.self, from: data),
                    let translatedText = jsonDecoder.data.translations?[0] else {
                        callBack(false, nil)
                        return
                }
                
                let translation = TranslatedText(translatedText: translatedText.translatedText)
                callBack(true, translation)
            }
            
        }
        
        task?.resume()
    }
    
    private func getTranslationURL(textToTranslate: String, languageTranslationPair: String) -> URL? {
        // Sample of static URL for understanding purpose
        // https://www.googleapis.com/language/translate/v2?key=AIzaSyCQjn22TDWEKEcyoTHhfb2sGFT3H7Z-cNA&source=fr&target=en&format=text&q=Text_To_Translate
        
        //URL components
        guard let textTotranslateInURL = textToTranslate.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return nil
        }
        
        let souceAndTarget = setSourceAndTargetLanguages(languageTranslationPair: languageTranslationPair)
        let source = souceAndTarget.source
        let target = souceAndTarget.target
        let baseUrl = "https://www.googleapis.com/language/translate/v2?"
        let apiKey = "AIzaSyCQjn22TDWEKEcyoTHhfb2sGFT3H7Z-cNA"
        // This parameter is important to set it at "text" (default is html value)
        // This value avoid to get html entities for some specials characters (as l&#39;API instead of l'API)
        let format = "text"
        
        let urlString = "\(baseUrl)key=\(apiKey)&source=\(source)&target=\(target)&format=\(format)&q=\(textTotranslateInURL)"
        
        let url = URL(string: urlString)
        
        return url
    }
    
    private func setSourceAndTargetLanguages(languageTranslationPair: String) -> (source: String, target: String) {
        switch languageTranslationPair {
        case "Français -> Anglais":
            let source = "fr"
            let target = "en"
            return (source, target)
        default:
            let source = "en"
            let target = "fr"
            return (source, target)
        }
    }
}
