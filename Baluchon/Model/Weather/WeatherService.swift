//
//  WeatherService.swift
//  Baluchon
//
//  Created by Christophe DURAND on 07/09/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation

enum City: String {
    case newYork
    case paris
}

class WeatherService {
    
    var task: URLSessionDataTask?
    
    private var weatherForeignerSession: URLSession
    private var weatherLocalSession: URLSession
    
    init(weatherForeignerSession: URLSession = URLSession(configuration: .default), weatherLocalSession: URLSession = URLSession(configuration: .default)) {
        self.weatherForeignerSession = weatherForeignerSession
        self.weatherLocalSession = weatherLocalSession
    }
    
    func urlWeather(city: City) -> String {
        let weatherURL = YahooAPI.query + city.rawValue + YahooAPI.endQuery
        guard let weatherURLconverted = weatherURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return "" }
        let urlWeather = YahooAPI.baseURL + weatherURLconverted + YahooAPI.format
        return urlWeather
    }
    
    func getForeignerWeather(city: City, callback: @escaping (Bool, WeatherCodeAndTemp?) -> Void) {
        guard let url = URL(string: urlWeather(city: city)) else { return }
        task?.cancel()
        task = weatherForeignerSession.dataTask(with: url) { data, response, error in
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
                
                self.getLocalWeather(city: city, completionHandler: { (success, data) in
                    guard let localWeather = data else {
                        callback(false, nil)
                        return
                    }
                    let localCode = localWeather.query.results.channel.item.condition.code
                    let localTemp = localWeather.query.results.channel.item.condition.temp
                    let weatherJSON = WeatherCodeAndTemp(newYorkTemp: foreignerTemp, newYorkCode: foreignerCode, parisTemp: localTemp, parisCode: localCode)
                    callback (true, weatherJSON)
                })
            }
        }
        task?.resume()
    }
    
    func getLocalWeather(city: City, completionHandler: @escaping ((Bool, Weather?) -> Void)) {
        guard let url = URL(string: urlWeather(city: .paris)) else { return }
        task?.cancel()
        task = weatherLocalSession.dataTask(with: url) { data, response, error in
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
