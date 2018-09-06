//
//  CurrencyChangeService.swift
//  Baluchon
//
//  Created by Christophe DURAND on 15/08/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class CurrencyChangeService {
    
    var currencies = [String]()
    var rate = [Double]()

    private static let currencyChangeUrl = URL(string: "http://data.fixer.io/api/latest?access_key=2e4288a2049e923be5767c9bacf7ae2a")!
    var task: URLSessionDataTask?
    private var currencySession: URLSession
    
    init(currencySession: URLSession = URLSession(configuration: .default)) {
        self.currencySession = currencySession
    }
    
    func getCurrencyChange(callback: @escaping (Bool, Currency?) -> Void) {
        task?.cancel()
        task = currencySession.dataTask(with: CurrencyChangeService.currencyChangeUrl) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Currency.self, from: data) else {
                    callback(false, nil)
                    return
                }
                for (key, value) in Array(responseJSON.rates.sorted(by: {$0.0 < $1.0})) {
                    self.currencies.append(key)
                    self.rate.append(value)
                }
                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}



    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


