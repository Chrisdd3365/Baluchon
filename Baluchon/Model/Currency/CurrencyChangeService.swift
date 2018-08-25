//
//  CurrencyChangeService.swift
//  Baluchon
//
//  Created by Christophe DURAND on 15/08/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class CurrencyChangeService {
    
    var currencies = ["AED","AFN","ALL","AMD","ANG","AOA","ARS","AUD","AWG","AZN","BAM","BBD","BDT","BGN","BHD","BIF","BMD", "BND","BOB","BRL","BSD","BTC","BTN","BWP","BYN","BYR","BZD","CAD","CDF","CHF","CLF","CLP","CNY","COP", "CRC","CUC","CUP","CVE","CZK","DJF","DKK","DOP","DZD","EGP","ERN","ETB","EUR","FJD","FKP","GBP","GEL", "GGP","GHS","GIP","GMD","GNF","GTQ","GYD","HKD","HNL","HRK","HTG","HUF","IDR","ILS","IMP","INR","IQD", "IRR","ISK","JEP","JMD","JOD","JPY","KES","KGS","KHR","KMF","KPW","KRW","KWD","KYD","KZT","LAK","LBP", "LKR","LRD","LSL","LTL","LVL","LYD","MAD","MDL","MGA","MKD","MMK","MNT","MOP","MRO","MUR","MVR","MWK", "MXN","MYR","MZN","NAD","NGN","NIO","NOK","NPR","NZD","OMR","PAB","PEN","PGK","PHP","PKR","PLN","PYG", "QAR","RON","RSD","RUB","RWF","SAR","SBD","SCR","SDG","SEK","SGD","SHP","SLL","SOS","SRD","STD","SVC", "SYP","SZL","THB","TJS","TMT","TND","TOP","TRY","TTD","TWD","TZS","UAH","UGX","USD","UYU","UZS","VEF", "VND","VUV","WST", "XAF","XAG","XAU","XCD","XDR","XOF","XPF","YER","ZAR","ZMK","ZMW","ZWL"]
    static var shared = CurrencyChangeService()
    private init() {}
    
    private static let currencyChangeUrl = URL(string: "http://data.fixer.io/api/latest?access_key=2e4288a2049e923be5767c9bacf7ae2a")!
    var task: URLSessionDataTask?
    private var currencySession = URLSession(configuration: .default)
    
    init(currencySession: URLSession) {
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
            callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


