//
//  CurrencyService.swift
//  LeBaluchon
//
//  Created by Mehdi on 30/06/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

class CurrencyService {
    static let sharedInstance = CurrencyService()
    private init() {}
    
    private let url = URL(string: "http://data.fixer.io/api/latest?access_key=f6ce7945bcfdbe9f45515b27e53ae84f&symbols=usd")!
    
    private var session = URLSession(configuration: .default)
    
    private var task: URLSessionDataTask?
    
    func getCurrency(callBack: @escaping (Bool, Currency?) -> Void) {
        task?.cancel()
        
        task = session.dataTask(with: url) { (data, response, error)  in
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
                
                guard let reponseJSON = try? JSONDecoder().decode(Currency.self, from: data),
                    let base = reponseJSON.baseCurrency,
                    let rate = reponseJSON.rates else {
                        callBack(false, nil)
                        return
                }
                
                let currency = Currency(baseCurrency: base, rates: rate)
                callBack(true, currency)
                
            }
        }
        
        task?.resume()
    }
}
