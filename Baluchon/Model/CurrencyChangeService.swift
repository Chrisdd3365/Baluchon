//
//  CurrencyChangeService.swift
//  Baluchon
//
//  Created by Christophe DURAND on 15/08/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class CurrencyChangeService {
    
    var myCurrency:[String] = []
    var myValues:[Double] = []
    
    let currencyChangeUrl = URL(string: "http://data.fixer.io/api/latest?access_key=2e4288a2049e923be5767c9bacf7ae2a&callback=getCurrencyChange")!
    
    func getCurrencyChange() {
        let task = URLSession.shared.dataTask(with: currencyChangeUrl) { (data, response, error) in
            
            if error != nil
            {
                print ("ERROR")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let rates = myJson["rates"] as? NSDictionary
                        {
                            for (key, value) in rates
                            {
                                self.myCurrency.append((key as? String)!)
                                self.myValues.append((value as? Double)!)
                            }
                        }
                    }
                    catch
                    {
                        
                    }
                }
            }
        }
        task.resume()
        
    }
    
    
    
    
    
}
