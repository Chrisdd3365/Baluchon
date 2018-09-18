//
//  WeatherCode.swift
//  Baluchon
//
//  Created by Christophe DURAND on 12/09/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation

//Enumeration named Forecast
enum Forecast: String {
    case tornado
    case thunderstorm
    case snow
    case sleet
    case rain
    case hail
    case fog
    case wind
    case cold
    case cloudy
    case partlyCloudyNight
    case partlyCloudyDay
    case clearNight
    case clearDay
    case error
}

//Class named WeatherCode to compare the code retrieved from Yahoo Weather and the forecast's icon
class WeatherCode {
    //Array of tuples
    static let weathers: [(Forecast, [String])] = [(.tornado, YahooAPI.YahooCode.tornado),
                                                  (.thunderstorm, YahooAPI.YahooCode.thunderstorm),
                                                  (.snow, YahooAPI.YahooCode.snow),
                                                  (.sleet, YahooAPI.YahooCode.sleet),
                                                  (.rain, YahooAPI.YahooCode.rain),
                                                  (.hail, YahooAPI.YahooCode.hail),
                                                  (.fog, YahooAPI.YahooCode.fog),
                                                  (.wind, YahooAPI.YahooCode.wind),
                                                  (.cold, YahooAPI.YahooCode.cold),
                                                  (.cloudy, YahooAPI.YahooCode.cloudy),
                                                  (.partlyCloudyNight, YahooAPI.YahooCode.partlyCloudyNight),
                                                  (.partlyCloudyDay, YahooAPI.YahooCode.partlyCloudyDay),
                                                  (.clearNight, YahooAPI.YahooCode.clearNight),
                                                  (.clearDay, YahooAPI.YahooCode.clearDay),
                                                  (.error, YahooAPI.YahooCode.error)]
    
    //Method to convert Yahoo Weather's code into a forecast's icon
    static func convertYahooCodeIntoIconForecast(code: String) -> String? {
        var iconForecast: String?
        for weather in weathers {
            if weather.1.contains(code) {
                iconForecast = weather.0.rawValue
            }
        }
        return iconForecast
    }
}
