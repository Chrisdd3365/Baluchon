//
//  CurrencyChangeService.swift
//  Baluchon
//
//  Created by Christophe DURAND on 15/08/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class CurrencyChangeService {
    
    //MARK: - Properties
    //To retrieve the key part of rates (dictionnary from Currency.swift file)
    var currencies = [String]()
    //To retrieve the value part of rates (dictionnary from Currency.swift file)
    var rate = [Double]()
    var task: URLSessionDataTask?
    private var currencySession: URLSession
    
    init(currencySession: URLSession = URLSession(configuration: .default)) {
        self.currencySession = currencySession
    }
    
    //MARK: - Methods
    //Method to get the currency from the Fixer API with a GET request
    func getCurrencyChange(callback: @escaping (Bool, Currency?) -> Void) {
        let fixerUrlString = FixerAPI.baseURL + FixerAPI.key
        guard let url = URL(string: fixerUrlString) else { return }
        
        task?.cancel()
        task = currencySession.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let currencyResponseJSON = try? JSONDecoder().decode(Currency.self, from: data) else {
                    callback(false, nil)
                    return
                }
                for (key, value) in Array(currencyResponseJSON.rates.sorted(by: {$0.0 < $1.0})) {
                    self.currencies.append(key)
                    self.rate.append(value)
                }
                callback(true, currencyResponseJSON)
            }
        }
        task?.resume()
    }
}



    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


