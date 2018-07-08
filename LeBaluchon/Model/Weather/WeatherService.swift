//
//  WeatherService.swift
//  LeBaluchon
//
//  Created by Mehdi on 08/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

class WeatherService {
    static let sharedInstance = WeatherService()
    private init() {}
    
    // Set URLSession
    private var weatherSession = URLSession(configuration: .default)
    
    /// This initializer is used only for testing
    ///
    /// - Parameter currencySession: Inject the URLSessionFake
    init(weatherSession: URLSession) {
        self.weatherSession = weatherSession
    }
    
    func getWeather(codeLocation: String, callBack: @escaping (Bool, Condition?) -> Void) {
        
        guard let url = getWeatherURL(codeLocation: codeLocation) else {
            //            print("URL not available")
            callBack(false, nil)
            return
        }
        
        var task: URLSessionDataTask?
        
        task?.cancel()
        
        task = weatherSession.dataTask(with: url, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    //                    print("Data missing")
                    callBack(false, nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    //                    print("Incorrect response")
                    callBack(false, nil)
                    return
                }
                
                guard let jsonDecoder = try? JSONDecoder().decode(DataWeather.self, from: data),
                    let codeWeatherConditions = jsonDecoder.query.results.channel.item.condition.code,
                    let fahrenheitemperature = jsonDecoder.query.results.channel.item.condition.temp else {
                        //                    print("JSON Decoder Error")
                        callBack(false, nil)
                        return
                }
                
                //Convert temperature to ° Celsius
//                let celsiusTemperature = Weather.convertFromFahrenheitToCelsius(fahrenheitTemperature: fahrenheitemperature)
                
                let conditions = Condition(code: codeWeatherConditions, temp: fahrenheitemperature, text: nil)
                callBack(true, conditions)
                
            }
        })
        
        task?.resume()
    }
    
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
