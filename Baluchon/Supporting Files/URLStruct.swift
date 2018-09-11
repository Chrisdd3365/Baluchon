//
//  URLStruct.swift
//  Baluchon
//
//  Created by Christophe DURAND on 11/09/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation

struct FixerAPI {
    static let baseURL = "http://data.fixer.io/api/latest?access_key="
    static let key = "2e4288a2049e923be5767c9bacf7ae2a"
}

struct YahooAPI {
    static let baseURL = "https://query.yahooapis.com/v1/public/yql?q="
    static let query = "select item.condition from weather.forecast where woeid in (select woeid from geo.places(1) where text='"
    static let endQuery = "') and u='c'"
    static let format = "&format=json"
}

    
    
    
    
    
    
    
    
