//
//  CurrencyService.swift
//  LeBaluchon
//
//  Created by Mehdi on 30/06/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

class CurrencyService {
    // MARK: Singleton
    static let sharedInstance = CurrencyService()
    private init() {}
    
    // MARK: URL Session & Task properties
    private let url = URL(string: "http://data.fixer.io/api/latest?access_key=f6ce7945bcfdbe9f45515b27e53ae84f&symbols=usd")!
    
    private var session = URLSession(configuration: .default)
    
    private var task: URLSessionDataTask?
    
    // MARK: Method
    
    /// Get currency from remote API
    func getCurrency(callBack: @escaping (Bool, Currency?) -> Void) {
        
        //Cancel the task before to start new one
        task?.cancel()
        
        task = session.dataTask(with: url) { (data, response, error)  in
            //Bring to main thread
            DispatchQueue.main.async {
                //Check data and no error
                guard let data = data, error == nil else {
                    callBack(false, nil)
                    return
                }
                
                //Check Status response code
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callBack(false, nil)
                    return
                }
                
                //Decode the JSON data
                guard let reponseJSON = try? JSONDecoder().decode(Currency.self, from: data),
                    let base = reponseJSON.baseCurrency,
                    let rate = reponseJSON.rates else {
                        callBack(false, nil)
                        return
                }
                
                //If all checks are okay, we set call back to true with the data
                let currency = Currency(baseCurrency: base, rates: rate)
                callBack(true, currency)
                
            }
        }
        
        //Resume the task
        task?.resume()
    }
}
