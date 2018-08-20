//
//  CurrencyChangeService.swift
//  Baluchon
//
//  Created by Christophe DURAND on 15/08/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

protocol CurrencyChangeDelegate {
    func alertShow(title: String, message: String)
}


class CurrencyChangeService {
    
    var currencies: [String] = []
    var values: [Double] = []
    var currencyChangeDelegate: CurrencyChangeDelegate?
    
    let currencyChangeUrl = URL(string: "http://data.fixer.io/api/latest?access_key=2e4288a2049e923be5767c9bacf7ae2a")!
    
    func getCurrencyChange() {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: currencyChangeUrl) { (data, response, error) in
            if let data = data, error == nil {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    do {
                        let responseJSON = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let rates = responseJSON["rates"] as? NSDictionary {
                            for (key, value) in rates {
                                self.currencies.append((key as? String)!)
                                self.values.append((value as? Double)!)
                            }
                        }
                    }
                    catch {
                        self.currencyChangeDelegate?.alertShow(title: "Error", message: "Currencies download failed! Try again!")
                    }
                }
            }
            
        }
        task.resume()
    }
}

