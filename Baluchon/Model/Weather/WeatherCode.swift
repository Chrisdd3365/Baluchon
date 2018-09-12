//
//  WeatherCode.swift
//  Baluchon
//
//  Created by Christophe DURAND on 12/09/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation

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

class WeatherCode {
    
    static let weather: [(Forecast, [String])] = [(.tornado, YahooAPI.YahooCode.tornado),
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
    
    static func convertYahooCodeIntoIconForecast(code: String) -> String? {
        var iconForecast: String?
        for w in weather {
            if w.1.contains(code) {
                iconForecast = w.0.rawValue
            }
        }
        return iconForecast
    }
}
