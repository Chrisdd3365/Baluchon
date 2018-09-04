//
//  WeatherService.swift
//  Baluchon
//
//  Created by Christophe DURAND on 21/08/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class WeatherService {
    
    static var shared = WeatherService()
    private init() {}

    private static let weatherNewYorkUrl = URL(string: "https://query.yahooapis.com/v1/public/yql?q=select%20item.condition%20from%20weather.forecast%20where%20woeid%20%3D%202459115&format=json")!
    private static let weatherParisUrl = URL(string: "https://query.yahooapis.com/v1/public/yql?q=select%20item.condition%20from%20weather.forecast%20where%20woeid%20%3D%20615702&format=json")!

    var task: URLSessionDataTask?
    private var weatherSession = URLSession(configuration: .default)

    init(weatherSession: URLSession) {
        self.weatherSession = weatherSession
    }

    func getWeatherForeignerCountry(callback: @escaping (Bool, Weather?) -> Void) {
        task?.cancel()
        task = weatherSession.dataTask(with: WeatherService.weatherNewYorkUrl) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let weatherResponseJSON = try? JSONDecoder().decode(Weather.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, weatherResponseJSON)
            }
        }
        task?.resume()
    }

    func getWeatherLocalCountry(callback: @escaping (Bool, Weather?) -> Void) {
        task?.cancel()
        task = weatherSession.dataTask(with: WeatherService.weatherParisUrl) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let weatherResponseJSON = try? JSONDecoder().decode(Weather.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, weatherResponseJSON)
            }
        }
        task?.resume()
    }
}
