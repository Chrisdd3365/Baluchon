//
//  WeatherService.swift
//  Baluchon
//
//  Created by Christophe DURAND on 07/09/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation

class WeatherService {
    
    static let tornado = ["0", "1", "2"]
    static let thunderstorm = ["3", "4", "37", "38", "39", "45"]
    static let snow = ["5", "7", "13", "14", "15", "16", "41", "42", "43", "46", "47"]
    static let sleet = ["6", "18"]
    static let rain = ["8", "9", "10", "11", "12", "35", "40"]
    static let hail = ["17"]
    static let fog = ["19", "20", "21", "22", "23"]
    static let wind = ["24"]
    static let cloudy = ["26", "44"]
    static let partlyCloudyNight = ["27", "29"]
    static let partlyCloudyDay = ["28", "30"]
    static let clearNight = ["31", "33"]
    static let clearDay = ["32", "34", "36"]
    static let error = ["3200"]
    
    let weather: [(String, [String])] = [("tornado", tornado), ("thunderstorm", thunderstorm), ("snow", snow),("sleet", sleet), ("rain", rain), ("hail", hail), ("fog", fog), ("wind", wind), ("cloudy", cloudy), ("partly-cloudy-night", partlyCloudyNight), ("partly-cloudy-day", partlyCloudyDay), ("clear-night", clearNight), ("clear-day", clearDay), ("error", error)]
    
    private static let weatherParisUrl = URL(string: "https://query.yahooapis.com/v1/public/yql?q=select%20item.condition%20from%20weather.forecast%20where%20woeid%20%3D%20615702&u=c&format=json")!
    private static let weatherNewYorkUrl = URL(string: "https://query.yahooapis.com/v1/public/yql?q=select%20item.condition%20from%20weather.forecast%20where%20woeid%20%3D%202459115&format=json")!
    
    var task: URLSessionDataTask?
    
    private var weatherForeignerSession = URLSession(configuration: .default)
    private var weatherLocalSession = URLSession(configuration: .default)
    
    init(weatherForeignerSession: URLSession = URLSession(configuration: .default), weatherLocalSession: URLSession = URLSession(configuration: .default)) {
        self.weatherForeignerSession = weatherForeignerSession
        self.weatherLocalSession = weatherLocalSession
    }
    
    func getForeignerWeather(callback: @escaping (Bool, WeatherStruct?) -> Void) {
        task?.cancel()
        task = weatherForeignerSession.dataTask(with: WeatherService.weatherNewYorkUrl) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let weatherForeignerResponseJSON = try? JSONDecoder().decode(Weather.self, from: data) else {
                    callback(false, nil)
                    return
                }
                let foreignerCode = weatherForeignerResponseJSON.query.results.channel.item.condition.code
                let foreignerTemp = weatherForeignerResponseJSON.query.results.channel.item.condition.temp
    
                self.getLocalWeather(completionHandler: { (success, data) in
                    guard let localWeather = data else {
                        callback(false, nil)
                        return
                    }
                    let localCode = localWeather.query.results.channel.item.condition.code
                    let localTemp = localWeather.query.results.channel.item.condition.temp
                    let weatherJSON = WeatherStruct(newYorkTemp: foreignerTemp, newYorkCode: foreignerCode, parisTemp: localTemp, parisCode: localCode)
                    callback (true, weatherJSON)
                })
            }
        }
        task?.resume()
    }
    
    func getLocalWeather(completionHandler: @escaping ((Bool, Weather?) -> Void)) {
        task?.cancel()
        task = weatherLocalSession.dataTask(with: WeatherService.weatherParisUrl) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(false, nil)
                    return
                }
                guard let weatherLocalResponseJSON = try? JSONDecoder().decode(Weather.self, from: data) else {
                    completionHandler(false, nil)
                    return
                }
                completionHandler(true, weatherLocalResponseJSON)
            }
        }
        task?.resume()
    }
    
    
    
    
    
}
