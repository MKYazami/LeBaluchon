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
    
    // currencySession is in global scope to allows the dependency injection for tests
    private var currencySession = URLSession(configuration: .default)
    
    /// This initializer is used only for testing
    ///
    /// - Parameter currencySession: Inject the URLSessionFake
    init(currencySession: URLSession) {
        self.currencySession = currencySession
    }
    
    // MARK: Method
    
    /// Get currency from remote API
    ///
    /// - Parameter callBack: if any problem in the request callBack = (false, nil) if evrything Ok callBack = (true, currency)
    func getCurrency(callBack: @escaping (Bool, Currency?) -> Void) {
        
        // Set url for Session
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=f6ce7945bcfdbe9f45515b27e53ae84f&symbols=usd")!
        
        var task: URLSessionDataTask?
        
        // Cancel the task before to start new one
        task?.cancel()
        
        task = currencySession.dataTask(with: url) { (data, response, error)  in
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
                guard let currency = try? JSONDecoder().decode(Currency.self, from: data) else {
                        callBack(false, nil)
                        return
                }
                
                // If all checks are okay, we set call back to true with the data
                callBack(true, currency)
                
            }
        }
        
        // Resume the task
        task?.resume()
    }
}
