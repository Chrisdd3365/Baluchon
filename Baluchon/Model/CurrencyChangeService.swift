//
//  CurrencyChangeService.swift
//  Baluchon
//
//  Created by Christophe DURAND on 15/08/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class CurrencyChangeService {
    
    private static let currencyChangeUrl = URL(string: "http://data.fixer.io/api/latest?access_key=2e4288a2049e923be5767c9bacf7ae2a")!
    
    static func getQuote() {
        let request = createCurrencyChangeRequest()
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data, error == nil {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    if let responseJSON = try? JSONDecoder().decode([String: String].self, from: data),
                        let currencyRates = responseJSON["rates"] {
                        print(currencyRates)
                    }
                }
            }
        }
        task.resume()
    }
    
    
    
   private static func createCurrencyChangeRequest() -> URLRequest {
        var request = URLRequest(url: currencyChangeUrl)
        request.httpMethod = "GET"
        
        let body = "method=getQuote&lang=en&format=json"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
    
    
    
    
    
}
