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

struct GoogleAPI {
    static let baseURL = "https://translation.googleapis.com/language/translate/v2?key="
    static let key = "AIzaSyA_lOrCvc-Fb7qO5Nes2cgLz2wxgOqfWms"
    static let query = "&q="
}

struct YahooAPI {
    static let baseURL = "https://query.yahooapis.com/v1/public/yql?q="
    static let query = "select item.condition from weather.forecast where woeid in (select woeid from geo.places(1) where text='"
    static let endQuery = "') and u='c'"
    static let format = "&format=json"
    
    struct YahooCode {
        static let tornado = ["0", "1", "2"]
        static let thunderstorm = ["3", "4", "37", "38", "39", "45"]
        static let snow = ["5", "7", "13", "14", "15", "16", "41", "42", "43", "46", "47"]
        static let sleet = ["6", "18"]
        static let rain = ["8", "9", "10", "11", "12", "35", "40"]
        static let hail = ["17"]
        static let fog = ["19", "20", "21", "22", "23"]
        static let wind = ["24"]
        static let cold = ["25"]
        static let cloudy = ["26", "44"]
        static let partlyCloudyNight = ["27", "29"]
        static let partlyCloudyDay = ["28", "30"]
        static let clearNight = ["31", "33"]
        static let clearDay = ["32", "34", "36"]
        static let error = ["3200"]
    }
}




    
    
    
    
    
    
