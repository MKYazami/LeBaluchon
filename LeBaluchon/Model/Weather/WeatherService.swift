//
//  WeatherService.swift
//  LeBaluchon
//
//  Created by Mehdi on 08/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

class WeatherService {
    // MARK: Singleton
    static let sharedInstance = WeatherService()
    private init() {}
    
    // weatherSession is in global scope to allows the dependency injection for tests
    private var weatherSession = URLSession(configuration: .default)
    
    /// This initializer is used only for testing
    ///
    /// - Parameter currencySession: Inject the URLSessionFake
    init(weatherSession: URLSession) {
        self.weatherSession = weatherSession
    }
    
    // MARK: Method
    
    /// Get weather information from Yahoo weather API
    ///
    /// - Parameters:
    ///   - codeLocation: Code allows to determine which city is concerned
    ///   - callBack: if any problem in the request callBack = (false, nil) if evrything Ok callBack = (true, currency)
    func getWeather(codeLocation: String, callBack: @escaping (Bool, DataWeather?) -> Void) {
        
        // Set url for Session
        guard let url = getWeatherURL(codeLocation: codeLocation) else {
            //            print("URL not available")
            callBack(false, nil)
            return
        }
        
        var task: URLSessionDataTask?
        
        // Cancel the task before to start new one
        task?.cancel()
        
        task = weatherSession.dataTask(with: url, completionHandler: { (data, response, error) in
            //Bring to main thread
            DispatchQueue.main.async {
                //Check data and no error
                guard let data = data, error == nil else {
                    //                    print("Data missing")
                    callBack(false, nil)
                    return
                }
                
                //Check Status response code
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    //                    print("Incorrect response")
                    callBack(false, nil)
                    return
                }
                
                //Decode the JSON data
                guard let dataWeather = try? JSONDecoder().decode(DataWeather.self, from: data) else {
                        //                    print("JSON Decoder Error")
                        callBack(false, nil)
                        return
                }
                
                callBack(true, dataWeather)
                
            }
        })
        
        // Resume the task
        task?.resume()
    }
    
    /// Get url allows to get weather informations from API
    ///
    /// - Parameter codeLocation: Code location determined from API doctumentation & are stored in CodeLocation struct in this Project
    /// - Returns: Return URL with parameters ready for request
    private func getWeatherURL(codeLocation: String) -> URL? {
        let baseURL = "https://query.yahooapis.com/v1/public/yql?q="
        guard let yql = "select item.condition from weather.forecast where woeid = \(codeLocation)&format=json".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return nil
        }
        
        let urlString = baseURL + yql
        
        let url = URL(string: urlString)
        
        return url
    }
}
